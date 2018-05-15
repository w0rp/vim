let g:python_import_dict = {
\   'APIView': 'from rest_framework.views',
\   'AnonymousUser': 'from django.contrib.auth.models',
\   'AppConfig': 'from django.apps',
\   'Avg': 'from django.db.models',
\   'BaseManager': 'from django.db.models.manager',
\   'BooleanField': 'from django.db.models',
\   'Case': 'from django.db.models',
\   'Concat': 'from django.db.models.functions',
\   'ContentType': 'from django.contrib.contenttypes.models',
\   'Count': 'from django.db.models',
\   'Decimal': 'from decimal',
\   'Exists': 'from django.db.models',
\   'F': 'from django.db.models',
\   'FloatField': 'from django.db.models',
\   'GenericAPIView': 'from rest_framework.generics',
\   'GenericForeignKey': 'from django.contrib.contenttypes.fields',
\   'Http404': 'from django.http',
\   'HttpResponse': 'from django.http',
\   'HttpResponseRedirect': 'from django.http',
\   'IntegerField': 'from django.db.models',
\   'JSONField': 'from django.contrib.postgres.fields',
\   'JsonResponse': 'from django.http',
\   'Manager': 'from django.db.models',
\   'Max': 'from django.db.models',
\   'ObjectDoesNotExist': 'from django.core.exceptions',
\   'OuterRef': 'from django.db.models',
\   'Prefetch': 'from django.db.models',
\   'Q': 'from django.db.models',
\   'QuerySet': 'from django.db.models',
\   'RawSQL': 'from django.db.models.expressions',
\   'RegexValidator': 'from django.core.validators',
\   'Response': 'from rest_framework.response',
\   'SearchVectorField': 'from django.contrib.postgres.search',
\   'Subquery': 'from django.db.models',
\   'TestCase': 'from unittest',
\   'ValidationError': 'from django.core.exceptions',
\   'Value': 'from django.db.models',
\   'When': 'from django.db.models',
\   'base64': 'import base64',
\   'cache': 'from django.core.cache',
\   'cached_property': 'from django.utils.functional',
\   'call_command': 'from django.core.management',
\   'connection': 'from django.db',
\   'datetime': 'import datetime',
\   'decimal': 'import decimal',
\   'deepcopy': 'from copy',
\   'force_text': 'from django.utils.encoding',
\   'freezegun': 'import freezegun',
\   'frozendict': 'from frozendict',
\   'functools': 'import functools',
\   'generics': 'from rest_framework',
\   'get_object_or_404': 'from django.shortcuts',
\   'io': 'import io',
\   'itertools': 'import itertools',
\   'json': 'import json',
\   'login_required': 'from django.contrib.auth.decorators',
\   'mark_safe': 'from django.utils.safestring',
\   'mock': 'from unittest import mock',
\   'operator': 'import operator',
\   'os': 'import os',
\   'parse_datetime': 'from django.utils.dateparse',
\   'parse_qs': 'from six.moves.urllib.parse',
\   'partial': 'from functools',
\   'permissions': 'from rest_framework',
\   'post_save': 'from django.db.models.signals',
\   'pre_save': 'from django.db.models.signals',
\   'prefetch_related_objects': 'from django.db.models',
\   'pytest': 'import pytest',
\   'pytz': 'import pytz',
\   'quote': 'from six.moves.urllib.parse',
\   'receiver': 'from django.dispatch',
\   'reduce': 'from functools',
\   'render': 'from django.shortcuts',
\   'settings': 'from django.conf',
\   'six': 'import six',
\   'status': 'from rest_framework',
\   'sys': 'import sys',
\   'time': 'import time',
\   'timezone': 'from django.utils',
\   'transaction': 'from django.db',
\   'unittest': 'import unittest',
\   'url_reverse': 'from django.core.urlresolvers import reverse as',
\   'urlencode': 'from six.moves.urllib.parse',
\   'urlparse': 'from six.moves.urllib.parse',
\   'uuid': 'import uuid',
\}
