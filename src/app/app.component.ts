import { Component } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { routeTransition } from 'src/route-transition';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss'],
  animations: [
    routeTransition
  ]
})
export class AppComponent {
  title = 'mobile-angular-app';

  constructor(protected route: ActivatedRoute){}
}
