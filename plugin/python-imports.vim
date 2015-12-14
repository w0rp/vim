if exists("g:loaded_python_imports")
    finish
endif
let g:loaded_python_imports = 1

let s:import_dict = {
\   "urlencode": "from urllib import urlencode",
\   "transaction": "from django.db import transaction",
\   "timezone": "from django.utils import timezone",
\   "Q": "from django.db.models import Q",
\   "F": "from django.db.models import F",
\   "Avg": "from django.db.models import Avg",
\   "Max": "from django.db.models import Max",
\   "Count": "from django.db.models import Count",
\   "ContentType": "from django.contrib.contenttypes.models import ContentType",
\   "GenericForeignKey": "from django.contrib.contenttypes.fields import GenericForeignKey",
\   "pre_save": "from django.db.models.signals import pre_save",
\   "post_save": "from django.db.models.signals import post_save",
\   "receiver": "from django.dispatch import receiver",
\   "AppConfig": "from django.apps import AppConfig",
\   "render": "from django.shortcuts import render",
\   "JsonResponse": "from django.http import JsonResponse",
\   "get_object_or_404": "from django.shortcuts import get_object_or_404",
\   "cached_property": "from django.utils.functional import cached_property",
\   "cache": "from django.core.cache import cache",
\   "url_reverse": "from django.core.urlresolvers import reverse as url_reverse",
\   "Http404": "from django.http import Http404",
\   "login_required": "from django.contrib.auth.decorators import login_required",
\   "ObjectDoesNotExist": "from django.core.exceptions import ObjectDoesNotExist",
\   "ValidationError": "from django.core.exceptions import ValidationError",
\   "RegexValidator": "from django.core.validators import RegexValidator",
\}

function AutoPythonImport()
    let l:line = get(s:import_dict, expand("<cword>"), "")

    if !empty(l:line)
        " Insert the import line at the beginning of the file.
        call append(0, l:line)
    endif
endfunction
