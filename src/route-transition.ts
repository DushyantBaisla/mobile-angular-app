import { animate, query, style, transition, trigger } from '@angular/animations';


export const routeTransition = trigger('routeTransition', [
    transition('* => *', [
        query(':enter', [
            style({ opacity: 0, scale: 0.9, transform: 'translateY(50px)' }),
        ], { optional: true }),
        // query(':leave', [
        //     animate('0.2s', style({ opacity: 0, scale: 0.9, transform: 'translateY(50px)'}))
        // ], { optional: true }),
        query(':enter', [
            animate('0.4s', style({ opacity: 1, scale: 1, transform: 'translateY(0)' }))
        ], { optional: true })
    ])
])