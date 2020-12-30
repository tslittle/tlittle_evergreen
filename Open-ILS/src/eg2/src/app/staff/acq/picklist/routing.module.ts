import {NgModule} from '@angular/core';
import {RouterModule, Routes} from '@angular/router';
import {UploadComponent} from './upload.component';
import {VandelayService} from '@eg/staff/cat/vandelay/vandelay.service';
import {PicklistUploadService} from './upload.service'


const routes: Routes = [{
  path: 'upload',
  component: UploadComponent
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
  providers: [VandelayService, PicklistUploadService]
})

export class PicklistRoutingModule {}