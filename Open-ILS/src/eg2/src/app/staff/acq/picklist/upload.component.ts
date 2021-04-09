import {Component, OnInit, AfterViewInit, Input,
    ViewChild, OnDestroy} from '@angular/core';
import {Subject} from 'rxjs';
import {tap} from 'rxjs/operators';
import {IdlObject} from '@eg/core/idl.service';
import {NetService} from '@eg/core/net.service';
import {EventService} from '@eg/core/event.service';
import {OrgService} from '@eg/core/org.service';
import {AuthService} from '@eg/core/auth.service';
import {ToastService} from '@eg/share/toast/toast.service';
import {ComboboxComponent,
    ComboboxEntry} from '@eg/share/combobox/combobox.component';
import {VandelayImportSelection,
  VANDELAY_UPLOAD_PATH} from '@eg/staff/cat/vandelay/vandelay.service';
import {HttpClient, HttpRequest, HttpEventType} from '@angular/common/http';
import {HttpResponse, HttpErrorResponse} from '@angular/common/http';
import {ProgressInlineComponent} from '@eg/share/dialog/progress-inline.component';
import {AlertDialogComponent} from '@eg/share/dialog/alert.component';
import {ServerStoreService} from '@eg/core/server-store.service';
import {PicklistUploadService} from './upload.service';
import {OrgSelectComponent} from '@eg/share/org-select/org-select.component'


const TEMPLATE_SETTING_NAME = 'eg.acq.picklist.upload.templates';

const TEMPLATE_ATTRS = [
    'createPurchaseOrder',
    'activatePurchaseOrder',
    'orderingAgency',
    'selectedFiscalYear',
    'loadItems',
    'selectedBibSource',
    'selectedMatchSet',
    'mergeOnExact',
    'importNonMatching',
    'mergeOnBestMatch',
    'mergeOnSingleMatch',
    'selectedMergeProfile',
    'selectedFallThruMergeProfile',
    'minQualityRatio'
];

interface ImportOptions {
    session_key: string;
    overlay_map?: {[qrId: number]: /* breId */ number};
    import_no_match?: boolean;
    auto_overlay_exact?: boolean;
    auto_overlay_best_match?: boolean;
    auto_overlay_1match?: boolean;
    merge_profile?: any;
    fall_through_merge_profile?: any;
    match_quality_ratio: number;
    create_po?: boolean;
    activate_po?: boolean;
    ordering_agency?: IdlObject;
    fiscal_year?: any;
    selectionLists?: any;
    exit_early: boolean;
}

@Component({
  templateUrl: './upload.component.html'
})
export class UploadComponent implements OnInit, AfterViewInit, OnDestroy {

    recordType: string;
    selectedQueue: ComboboxEntry; // freetext enabled

    // used for applying a default queue ID value when we have
    // a load-time queue before the queue combobox entries exist.
    startQueueId: number;

    activeQueueId: number;
    orderingAgency: IdlObject;
    selectedFiscalYear: number;
    selectedSelectionList: number;
    selectedBibSource: number;
    selectedProvider: number;
    selectedMatchSet: number;
    importDefId: number;
    selectedMergeProfile: number;
    selectedFallThruMergeProfile: number;
    selectedFile: File;

    defaultMatchSet: string;

    createPurchaseOrder: boolean;
    activatePurchaseOrder: boolean;

    importNonMatching: boolean;
    mergeOnExact: boolean;
    mergeOnSingleMatch: boolean;
    mergeOnBestMatch: boolean;
    minQualityRatio: number;

    // True after the first upload, then remains true.
    showProgress: boolean;

    // Upload in progress.
    isUploading: boolean;

    // True only after successful upload
    uploadComplete: boolean;

    // Upload / processsing session key
    // Generated by the server
    sessionKey: string;

    // Optional enqueue/import tracker session name.
    sessionName: string;

    selectedTemplate: string;
    formTemplates: {[name: string]: any};
    newTemplateName: string;

    @ViewChild('fileSelector', { static: false }) private fileSelector;
    @ViewChild('uploadProgress', { static: true })
        private uploadProgress: ProgressInlineComponent;
    @ViewChild('enqueueProgress', { static: true })
        private enqueueProgress: ProgressInlineComponent;
    @ViewChild('importProgress', { static: true })
        private importProgress: ProgressInlineComponent;

    // Need these refs so values can be applied via external stimuli
    @ViewChild('formTemplateSelector', { static: true })
        private formTemplateSelector: ComboboxComponent;
    @ViewChild('bibSourceSelector', { static: true })
        private bibSourceSelector: ComboboxComponent;
    @ViewChild('providerSelector', {static: true})
        private providerSelector: ComboboxComponent;
    @ViewChild('fiscalYearSelector', { static: true })
        private fiscalYearSelector: ComboboxComponent;
    @ViewChild('selectionListSelector', { static: true })
        private selectionListSelector: ComboboxComponent;    
    @ViewChild('matchSetSelector', { static: true })
        private matchSetSelector: ComboboxComponent;
    @ViewChild('mergeProfileSelector', { static: true })
        private mergeProfileSelector: ComboboxComponent;
    @ViewChild('fallThruMergeProfileSelector', { static: true })
        private fallThruMergeProfileSelector: ComboboxComponent;
    @ViewChild('dupeQueueAlert', { static: true })
        private dupeQueueAlert: AlertDialogComponent;

    constructor(
        private http: HttpClient,
        private toast: ToastService,
        private evt: EventService,
        private net: NetService,
        private auth: AuthService,
        private org: OrgService,
        private store: ServerStoreService,
        private vlagent: PicklistUploadService
    ) {
        this.applyDefaults();
    }

    applyDefaults() {
        this.minQualityRatio = 0;
        this.selectedBibSource = 1; // default to system local
        this.recordType = 'acq';
        this.formTemplates = {};
        this.orderingAgency = this.org.get(this.auth.user().ws_ou());
//To-do add default for fiscal year
        if (this.vlagent.importSelection) {

            if (!this.vlagent.importSelection.queue) {
                // Incomplete import selection, clear it.
                this.vlagent.importSelection = null;
                return;
            }

            const queue = this.vlagent.importSelection.queue;
            this.recordType = queue.queue_type();
            this.selectedMatchSet = queue.match_set();

            // This will be propagated to selectedQueue as a combobox
            // entry via the combobox
            this.startQueueId = queue.id();

        
        }
    }

    ngOnInit() {}

    ngAfterViewInit() {
        this.loadStartupData();
    }

    ngOnDestroy() {
        // Always clear the import selection when navigating away from
        // the import page.
        this.clearSelection();
    }

    importSelection(): VandelayImportSelection {
        return this.vlagent.importSelection;
    }

    loadStartupData(): Promise<any> {
        // Note displaying and manipulating a progress dialog inside
        // the AfterViewInit cycle leads to errors because the child
        // component is modifed after dirty checking.

        const promises = [
            this.vlagent.getMergeProfiles(),
            this.vlagent.getAllQueues('acq'),
            this.vlagent.getMatchSets('bib'),
            this.vlagent.getBibSources(),
            this.vlagent.getFiscalYears(),
            this.vlagent.getProvidersList(),
            this.vlagent.getSelectionLists(),
            this.vlagent.getItemImportDefs(),
            this.org.settings(['vandelay.default_match_set']).then(
                s => this.defaultMatchSet = s['vandelay.default_match_set']),
            this.loadTemplates()
        ];

        return Promise.all(promises);
    }

    orgOnChange(org: IdlObject) {
        this.orderingAgency = org;
    }


    loadTemplates() {
        this.store.getItem(TEMPLATE_SETTING_NAME).then(
            templates => {
                this.formTemplates = templates || {};

                Object.keys(this.formTemplates).forEach(name => {
                    if (this.formTemplates[name].default) {
                        this.selectedTemplate = name;
                    }
                });
            }
        );
    }

    formatTemplateEntries(): ComboboxEntry[] {
        const entries = [];

        Object.keys(this.formTemplates || {}).forEach(
            name => entries.push({id: name, label: name}));

        return entries;
    }

    // Format typeahead data sets
    formatEntries(etype: string): ComboboxEntry[] {
        const rtype = this.recordType;
        let list;

        switch (etype) {
            case 'bibSources':
                return (this.vlagent.bibSources || []).map(
                    s => {
                        return {id: s.id(), label: s.source()};
                    });
            
            case 'providersList':
                return (this.vlagent.providersList || []).map(
                    p => {
                        return {id: p.id(), label: p.code()};
                    });
                    
            case 'fiscalYears':
                return (this.vlagent.fiscalYears || []).map(
                    fy => {
                        return {id: fy.id(), label: fy.year()};
                       });
                break;

            case 'selectionLists':
                 list = this.vlagent.selectionLists;
                 break;

            case 'activeQueues':
                list = (this.vlagent.allQueues[rtype] || [])
                        .filter(q => q.complete() === 'f');
                break;

            case 'matchSets':
                list = this.vlagent.matchSets['bib'];
                break;
            

            case 'importItemDefs':
                list = this.vlagent.importItemAttrDefs;
                break;

            case 'mergeProfiles':
                list = this.vlagent.mergeProfiles;
                break;
        }

        return (list || []).map(item => {
            return {id: item.id(), label: item.name()};
        });
    }

    selectEntry($event: ComboboxEntry, etype: string) {
        const id = $event ? $event.id : null;

        switch (etype) {
            case 'recordType':
                this.recordType = id;
                break;

            case 'providersList':
                this.selectedProvider = id;
                break;

            case 'bibSources':
                this.selectedBibSource = id;
                break;

            case 'fiscalYears':
                this.selectedFiscalYear = id;
                break;

            case 'selectionLists':
                this.selectedSelectionList = id;
                break;

            case 'matchSets':
                this.selectedMatchSet = id;
                break;


            case 'mergeProfiles':
                this.selectedMergeProfile = id;
                break;

            case 'FallThruMergeProfile':
                this.selectedFallThruMergeProfile = id;
                break;
        }
    }
            
    fileSelected($event) {
       this.selectedFile = $event.target.files[0];
    }

    // Required form data varies depending on context.
    hasNeededData(): boolean {
        if (this.vlagent.importSelection) {
            return this.importActionSelected();
        } else {
            return this.selectedQueue &&
                Boolean(this.recordType) && Boolean(this.selectedFile);
        }
    }

    importActionSelected(): boolean {
        return this.importNonMatching
            || this.mergeOnExact
            || this.mergeOnSingleMatch
            || this.mergeOnBestMatch;
    }

    // 1. create queue if necessary
    // 2. upload MARC file
    // 3. Enqueue MARC records
    // 4. Import records
    upload() {
        this.sessionKey = null;
        this.showProgress = true;
        this.isUploading = true;
        this.uploadComplete = false;
        this.resetProgressBars();

        this.resolveQueue()
        .then(
            queueId => {
                this.activeQueueId = queueId;
                return this.uploadFile();
            },
            err => Promise.reject('queue create failed')
        ).then(
            ok => this.processSpool(),
            err => Promise.reject('process spool failed')
        ).then(
            ok => this.importRecords(),
            err => Promise.reject('import records failed')
        ).then(
            ok => {
                this.isUploading = false;
                this.uploadComplete = true;
            },
            err => {
                console.log('file upload failed: ', err);
                this.isUploading = false;
                this.resetProgressBars();

            }
        );
    }

    resetProgressBars() {
        this.uploadProgress.update({value: 0, max: 1});
        this.enqueueProgress.update({value: 0, max: 1});
        this.importProgress.update({value: 0, max: 1});
    }

    // Extract selected queue ID or create a new queue when requested.
    resolveQueue(): Promise<number> {

        if (this.selectedQueue.freetext) {
            // Free text queue selector means create a new entry.
            // TODO: first check for name dupes

            return this.vlagent.createQueue(
                this.selectedQueue.label,
                this.recordType,
                this.importDefId,
                this.selectedMatchSet,
            ).then(
                id => id,
                err => {
                    const evt = this.evt.parse(err);
                    if (evt) {
                        if (evt.textcode.match(/QUEUE_EXISTS/)) {
                            this.dupeQueueAlert.open();
                        } else {
                            alert(evt); // server error
                        }
                    }

                    return Promise.reject('Queue Create Failed');
                }
            );
        } else {
            return Promise.resolve(this.selectedQueue.id);
        }
    }

    uploadFile(): Promise<any> {

        if (this.vlagent.importSelection) {
            // Nothing to upload when processing pre-queued records.
            return Promise.resolve();
        }

        const formData: FormData = new FormData();

        formData.append('ses', this.auth.token());
        formData.append('marc_upload',
            this.selectedFile, this.selectedFile.name);

        if (this.selectedBibSource) {
            formData.append('bib_source', '' + this.selectedBibSource);
        }

        const req = new HttpRequest('POST', VANDELAY_UPLOAD_PATH, formData,
            {reportProgress: true, responseType: 'text'});

        return this.http.request(req).pipe(tap(
            evt => {
                if (evt.type === HttpEventType.UploadProgress) {
                    this.uploadProgress.update(
                        {value: evt.loaded, max: evt.total});

                } else if (evt instanceof HttpResponse) {
                    this.sessionKey = evt.body as string;
                    console.log(
                        'vlagent file uploaded OK with key ' + this.sessionKey);
                }
            },

            (err: HttpErrorResponse) => {
                console.error(err);
                this.toast.danger(err.error);
            }
        )).toPromise();
    }

    processSpool():  Promise<any> {

        if (this.vlagent.importSelection) {
            // Nothing to enqueue when processing pre-queued records
            return Promise.resolve();
        }

        let spoolType = this.recordType;
        

        const method = `open-ils.vlagent.${spoolType}.process_spool`;

        return new Promise((resolve, reject) => {
            this.net.request(
                'open-ils.vlagent', method,
                this.auth.token(), this.sessionKey, this.activeQueueId,
                null, null, this.selectedBibSource,
                (this.sessionName || null), true
            ).subscribe(
                tracker => {
                    const e = this.evt.parse(tracker);
                    if (e) { console.error(e); return reject(); }

                    // Spooling is in progress, track the results.
                    this.vlagent.pollSessionTracker(tracker.id())
                    .subscribe(
                        trkr => {
                            this.enqueueProgress.update({
                                // enqueue API only tracks actions performed
                                max: null,
                                value: trkr.actions_performed()
                            });
                        },
                        err => { console.log(err); reject(); },
                        () => {
                            this.enqueueProgress.update({max: 1, value: 1});
                            resolve();
                        }
                    );
                }
            );
        });
    }

    importRecords(): Promise<any> {

        if (!this.importActionSelected()) {
            return Promise.resolve();
        }

        const selection = this.vlagent.importSelection;

        if (selection && !selection.importQueue) {
            return this.importRecordQueue(selection.recordIds);
        } else {
            return this.importRecordQueue();
        }
    }

    importRecordQueue(recIds?: number[]): Promise<any> {
        const rtype = this.recordType === 'acq';

        let method = `open-ils.acq.process_upload_records`;
        const options: ImportOptions = this.compileImportOptions();

        let target: number | number[] = this.activeQueueId;
        if (recIds && recIds.length) {
            method = `open-ils.vlagent.${rtype}_record.list.import`;
            target = recIds;
        }

        return new Promise((resolve, reject) => {
            this.net.request('open-ils.vlagent',
                method, this.auth.token(), target, options)
            .subscribe(
                tracker => {
                    const e = this.evt.parse(tracker);
                    if (e) { console.error(e); return reject(); }

                    // Spooling is in progress, track the results.
                    this.vlagent.pollSessionTracker(tracker.id())
                    .subscribe(
                        trkr => {
                            this.importProgress.update({
                                max: trkr.total_actions(),
                                value: trkr.actions_performed()
                            });
                        },
                        err => { console.log(err); reject(); },
                        () => {
                            this.importProgress.update({max: 1, value: 1});
                            resolve();
                        }
                    );
                }
            );
        });
    }

    compileImportOptions(): ImportOptions {

        const options: ImportOptions = {
            session_key: this.sessionKey,
            import_no_match: this.importNonMatching,
            auto_overlay_exact: this.mergeOnExact,
            auto_overlay_best_match: this.mergeOnBestMatch,
            auto_overlay_1match: this.mergeOnSingleMatch,
            merge_profile: this.selectedMergeProfile,
            fall_through_merge_profile: this.selectedFallThruMergeProfile,
            match_quality_ratio: this.minQualityRatio,
            create_po: this.createPurchaseOrder,
            activate_po: this.activatePurchaseOrder,
            ordering_agency: this.orderingAgency,
            fiscal_year: this.selectedFiscalYear,
            exit_early: true
        };

        if (this.vlagent.importSelection) {
            options.overlay_map = this.vlagent.importSelection.overlayMap;
        }

        return options;
    }

    clearSelection() {
        this.vlagent.importSelection = null;
        this.startQueueId = null;
    }

    openQueue() {
        console.log('opening queue ' + this.activeQueueId);
    }

    saveTemplate() {

        const template = {};
        TEMPLATE_ATTRS.forEach(key => template[key] = this[key]);

        console.debug('Saving import profile', template);

        this.formTemplates[this.selectedTemplate] = template;
        return this.store.setItem(TEMPLATE_SETTING_NAME, this.formTemplates);
    }

    markTemplateDefault() {

        Object.keys(this.formTemplates).forEach(
            name => delete this.formTemplates.default
        );

        this.formTemplates[this.selectedTemplate].default = true;

        return this.store.setItem(TEMPLATE_SETTING_NAME, this.formTemplates);
    }

    templateSelectorChange(entry: ComboboxEntry) {

        if (!entry) {
            this.selectedTemplate = '';
            return;
        }

        this.selectedTemplate = entry.label; // label == name

        if (entry.freetext) {
            // User is entering a new template name.
            // Nothing to apply.
            return;
        }

        // User selected an existing template, apply it to the form.

        const template = this.formTemplates[entry.id];

        // Copy the template values into "this"
        TEMPLATE_ATTRS.forEach(key => this[key] = template[key]);

        // Some values must be manually passed to the combobox'es

        this.bibSourceSelector.applyEntryId(this.selectedBibSource);
        this.matchSetSelector.applyEntryId(this.selectedMatchSet);
        this.providerSelector.applyEntryId(this.selectedProvider);
        this.fiscalYearSelector.applyEntryId(this.selectedFiscalYear);
        this.mergeProfileSelector.applyEntryId(this.selectedMergeProfile);
        this.fallThruMergeProfileSelector
            .applyEntryId(this.selectedFallThruMergeProfile);
    }

    deleteTemplate() {
        delete this.formTemplates[this.selectedTemplate];
        this.formTemplateSelector.selected = null;
        return this.store.setItem(TEMPLATE_SETTING_NAME, this.formTemplates);
    }
}

