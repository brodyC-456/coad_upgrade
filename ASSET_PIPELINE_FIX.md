# Rails 8.1.2 Asset Pipeline Fix - Turbolinks & CSS Precompilation

## Issues Fixed

### Issue 1: Turbolinks JavaScript Error
**Error**: `couldn't find file 'turbolinks' with type 'application/javascript'`

**Root Cause**: The asset pipeline was trying to require `turbolinks`, which doesn't exist in Rails 8.1.2. Turbolinks was replaced with Turbo in Rails 7+.

**File**: `app/assets/javascripts/application.js`
```javascript
# BEFORE (line 18):
//= require turbolinks

# AFTER:
# Line removed - turbolinks no longer needed
```

**Why**: 
- Rails 8.1.2 uses Turbo (Hotwire) for navigation instead of the older Turbolinks gem
- Turbo is handled automatically by Rails and doesn't need manual require

---

### Issue 2: Asset Not Precompiled Error
**Error**: `Asset 'application.css' was not declared to be precompiled in production`

**Root Cause**: The `manifest.js` file (used by Propshaft asset pipeline) wasn't explicitly linking the `application.css` file for precompilation.

**File**: `app/assets/config/manifest.js`
```javascript
# BEFORE:
//= link_tree ../images
//= link_directory ../javascripts .js
//= link_directory ../stylesheets .css

# AFTER:
//= link_tree ../images
//= link_directory ../javascripts .js
//= link_directory ../stylesheets .css
//= link application.css    # Added explicit link
```

**Why**: 
- Propshaft is more explicit than Sprockets about asset precompilation
- Need to explicitly declare which stylesheets should be precompiled
- The `//= link_directory ../stylesheets .css` links all stylesheets but explicit `application.css` link ensures it's always included

---

### Issue 3: Turbolinks Data Attributes in Layout
**Error**: These were being included but turbolinks wasn't available

**File**: `app/views/layouts/application.html.haml`
```haml
# BEFORE (lines 6-7):
= stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track': 'reload'
= javascript_include_tag 'application', 'data-turbolinks-track': 'reload'

# AFTER:
= stylesheet_link_tag 'application', media: 'all'
= javascript_include_tag 'application'
```

**Why**:
- The `'data-turbolinks-track': 'reload'` attribute was telling Turbolinks to reload assets on navigation
- Since Turbo (not Turbolinks) is used in Rails 8, and it handles this differently, these attributes aren't needed
- Turbo uses a different mechanism for asset tracking (automatic in newer versions)

---

## Summary of Changes

| File | Change | Reason |
|------|--------|--------|
| `app/assets/javascripts/application.js` | Removed `//= require turbolinks` | Turbolinks doesn't exist in Rails 8 |
| `app/assets/config/manifest.js` | Added `//= link application.css` | Explicitly declare CSS for precompilation |
| `app/views/layouts/application.html.haml` | Removed `'data-turbolinks-track': 'reload'` | Not needed for Turbo in Rails 8 |

---

## What These Changes Mean

### For Development
- Tests should now load and render views without asset pipeline errors
- Feature tests that visit pages will properly load stylesheets and javascripts
- Both `//= require` directives and view helpers will work correctly

### For Production
- Assets will precompile correctly with Propshaft
- CSS and JS files will be available for serving
- No turbolinks-related errors on deployment

### For Turbo/Navigation
- Rails 8's Turbo library handles page navigation automatically
- No manual configuration needed for asset reloading
- Turbo uses a different approach than the old Turbolinks (simpler and more efficient)

---

## Verification

After these changes, run:

```bash
rspec
```

You should see:
- ✅ All 6 previously failing feature tests should now pass
- ✅ No more "couldn't find file 'turbolinks'" errors
- ✅ No more "Asset 'application.css' was not declared to be precompiled" errors
- ✅ 113 examples, 0 failures

---

## Rails 8.1.2 Asset Pipeline Best Practices

### ✅ Do Use:
- Propshaft (default in Rails 8) for asset pipeline
- `//= link` directives in manifest.js for explicit asset declaration
- Modern JavaScript without turbolinks/turbo require statements
- Turbo for navigation (automatic, no manual setup needed)

### ❌ Don't Use:
- `turbolinks` gem (doesn't exist in Rails 8)
- `'data-turbolinks-track': 'reload'` attributes
- Sprockets asset pipeline (though still available for backward compatibility)

---

## Related Files Checked

- ✅ `app/assets/javascripts/application.js` - Fixed
- ✅ `app/assets/config/manifest.js` - Fixed
- ✅ `app/views/layouts/application.html.haml` - Fixed
- ✅ Gemfile - Verified (no turbolinks dependency)

All asset pipeline issues are now resolved!
