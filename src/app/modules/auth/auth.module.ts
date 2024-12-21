import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { AuthPageComponent } from './pages/auth-page/auth-page.component';
import { RouterModule, Routes } from '@angular/router';
import { LoginFormComponent } from './forms/login-form/login-form.component';
import { RegistrationFormComponent } from './forms/registration-form/registration-form.component';

const routes: Routes = [
  {path: '', redirectTo: 'auth/login', pathMatch:'full'},
  {
    path: 'auth', component: AuthPageComponent, children: [
      { path: 'register', component: RegistrationFormComponent},
      { path: 'login', component: LoginFormComponent}
  ] },
];

@NgModule({
  declarations: [
    AuthPageComponent
  ],
  imports: [
    CommonModule,
    RouterModule,
    RouterModule.forChild(routes),
    LoginFormComponent,
    RegistrationFormComponent
  ]
})
export class AuthModule { }
