import {NgModule} from '@angular/core';
import {StaffCommonModule} from '@eg/staff/common.module';
import {CatalogCommonModule} from '@eg/share/catalog/catalog-common.module';
import {PicklistRoutingModule} from './routing.module';
import {HttpClientModule} from '@angular/common/http';
import {UploadComponent} from './upload.component';

@NgModule({
  declarations: [
    UploadComponent
  ],
  imports: [
    StaffCommonModule,
    CatalogCommonModule,
    PicklistRoutingModule,
    HttpClientModule
  ]
})

export class AcqPicklistModule {}