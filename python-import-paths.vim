let g:python_import_dict = {
\   'APIView': 'from rest_framework.views',
\   'AnonymousUser': 'from django.contrib.auth.models',
\   'Any': 'from typing',
\   'AppConfig': 'from django.apps',
\   'ArrayAgg': 'from django.contrib.postgres.aggregates',
\   'Avg': 'from django.db.models',
\   'BaseManager': 'from django.db.models.manager',
\   'BasePermission': 'from rest_framework.permissions',
\   'BooleanField': 'from django.db.models',
\   'BytesIO': 'from io',
\   'Callable': 'from typing',
\   'Case': 'from django.db.models',
\   'CharField': 'from django.db.models',
\   'ClassVar': 'from typing',
\   'Coalesce': 'from django.db.models.functions',
\   'Collection': 'from typing',
\   'CombinedExpression': 'from django.db.models.expressions',
\   'Concat': 'from django.db.models.functions',
\   'ContentType': 'from django.contrib.contenttypes.models',
\   'Count': 'from django.db.models',
\   'D': 'from decimal import Decimal as',
\   'Decimal': 'from decimal',
\   'Dict': 'from typing',
\   'Exists': 'from django.db.models',
\   'F': 'from django.db.models',
\   'FieldDoesNotExist': 'from django.core.exceptions',
\   'FloatField': 'from django.db.models',
\   'Func': 'from django.db.models',
\   'Generator': 'from typing',
\   'Generic': 'from typing',
\   'GenericAPIView': 'from rest_framework.generics',
\   'GenericForeignKey': 'from django.contrib.contenttypes.fields',
\   'HStoreField': 'from django.contrib.postgres.fields',
\   'Http404': 'from django.http',
\   'HttpRequest': 'from django.http',
\   'HttpResponse': 'from django.http',
\   'HttpResponseRedirect': 'from django.http',
\   'IntegerField': 'from django.db.models',
\   'IsAuthenticated': 'from rest_framework.permissions',
\   'Iterable': 'from typing',
\   'Iterator': 'from typing',
\   'JSONField': 'from django.contrib.postgres.fields',
\   'JSONObject': 'from django.db.models.functions',
\   'JsonResponse': 'from django.http',
\   'List': 'from typing',
\   'Literal': 'from typing',
\   'Manager': 'from django.db.models',
\   'Mapping': 'from typing',
\   'Max': 'from django.db.models',
\   'Min': 'from django.db.models',
\   'Model': 'from django.db.models',
\   'NamedTuple': 'from typing',
\   'NoReturn': 'from typing',
\   'ObjectDoesNotExist': 'from django.core.exceptions',
\   'Optional': 'from typing',
\   'OuterRef': 'from django.db.models',
\   'PermissionDenied': 'from rest_framework.exceptions',
\   'Prefetch': 'from django.db.models',
\   'ProgrammingError': 'from django.db.utils',
\   'Protocol': 'from typing',
\   'Q': 'from django.db.models',
\   'QuerySet': 'from django.db.models',
\   'RawSQL': 'from django.db.models.expressions',
\   'RegexValidator': 'from django.core.validators',
\   'Response': 'from rest_framework.response',
\   'SearchVectorField': 'from django.contrib.postgres.search',
\   'Sequence': 'from typing',
\   'Set': 'from typing',
\   'Subquery': 'from django.db.models',
\   'TYPE_CHECKING': 'from typing',
\   'TestCase': 'from unittest',
\   'TestClient': 'from fastapi.testclient',
\   'Trim': 'from django.db.models.functions',
\   'Tuple': 'from typing',
\   'Type': 'from typing',
\   'TypeAlias': 'from typing_extensions',
\   'TypeVar': 'from typing',
\   'TypedDict': 'from typing',
\   'Union': 'from typing',
\   'ValidationError': 'from django.core.exceptions',
\   'Value': 'from django.db.models',
\   'When': 'from django.db.models',
\   'Worksheet': 'from openpyxl.worksheet.worksheet',
\   'apps': 'from django.apps',
\   'argparse': 'import argparse',
\   'base64': 'import base64',
\   'cache': 'from django.core.cache',
\   'cached_property': 'from django.utils.functional',
\   'call_command': 'from django.core.management',
\   'cast': 'from typing',
\   'connection': 'from django.db',
\   'csv': 'import csv',
\   'datetime': 'import datetime',
\   'decimal': 'import decimal',
\   'deepcopy': 'from copy',
\   'force_text': 'from django.utils.encoding',
\   'freeze_time': 'from freezegun',
\   'freezegun': 'import freezegun',
\   'frozendict': 'from frozendict',
\   'functools': 'import functools',
\   'generics': 'from rest_framework',
\   'get_object_or_404': 'from django.shortcuts',
\   'io': 'import io',
\   'itertools': 'import itertools',
\   'json': 'import json',
\   'logging': 'import logging',
\   'login_required': 'from django.contrib.auth.decorators',
\   'mark_safe': 'from django.utils.safestring',
\   'mock': 'from unittest',
\   'namedtuple': 'from collections',
\   'openpyxl': 'import openpyxl',
\   'operator': 'import operator',
\   'os': 'import os',
\   'overload': 'from typing',
\   'parse_datetime': 'from django.utils.dateparse',
\   'parse_qs': 'from urllib.parse',
\   'parse_qsl': 'from urllib.parse',
\   'partial': 'from functools',
\   'permissions': 'from rest_framework',
\   'post_save': 'from django.db.models.signals',
\   'pre_save': 'from django.db.models.signals',
\   'prefetch_related_objects': 'from django.db.models',
\   'pytest': 'import pytest',
\   'pytz': 'import pytz',
\   'quote': 'from urllib.parse',
\   'random': 'import random',
\   're': 'import re',
\   'receiver': 'from django.dispatch',
\   'reduce': 'from functools',
\   'render': 'from django.shortcuts',
\   'settings': 'from django.conf',
\   'shutil': 'import shutil',
\   'six': 'import six',
\   'status': 'from rest_framework',
\   'sys': 'import sys',
\   'tempfile': 'import tempfile',
\   'textwrap': 'import textwrap',
\   'time': 'import time',
\   'timezone': 'from django.utils',
\   'transaction': 'from django.db',
\   'typing': 'import typing',
\   'unittest': 'import unittest',
\   'url_reverse': 'from django.urls import reverse as',
\   'urlencode': 'from urllib.parse',
\   'urlparse': 'from urllib.parse',
\   'urlunparse': 'from urllib.parse',
\   'uuid': 'import uuid',
\}
