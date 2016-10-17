// module Framework7
"use strict"

exports.initialize = function(parameters) {
  return new Framework7(parameters);
}

exports.addView = function(f7) {
  return function(selector) {
    return f7.addView(selector, { domCache: true });
  }
}

exports.searchbar = function(f7) {
  return function(selector) {
    return f7.searchbar(selector, { customSearch: true });
  }
}

exports.showTab = function(f7) {
  return function(selector) {
    return f7.showTab(selector);
  }
}

exports.routerLoad = function(f7View) {
  return function(pageName) {
    return function(animate) {
      return f7View.router.load({ pageName: pageName, animatePages: animate });
    }
  }
}

exports.routerBack = function(f7View) {
  return f7View.router.back();
}

exports.backButtonHandler = function(f7View) {
  return function(action) {
    if (f7View.history.length > 1) {
      f7View.router.back();
    }
    else {
      action();
    }
  }
}

exports.addNotificationImpl = function(f7) {
  return function(parameters) {
    return f7.addNotification(parameters);
  }
}

exports.closeNotification = function(f7) {
  return function(notificationElement) {
    f7.closeNotification(notificationElement);
  }
}

exports.openPanel = function(f7) {
  return function(panel) {
    return f7.openPanel(panel);
  }
}

exports.closePanel = function(f7) {
  f7.closePanel();
}
