const selector = '.mdc-card__primary-action'
const ripples = Array.from(document.querySelectorAll(selector))
    .map(elt => mdc.ripple.MDCRipple.attachTo(elt))