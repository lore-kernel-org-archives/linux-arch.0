Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD644344DB1
	for <linux-arch@vger.kernel.org>; Thu,  2 Jul 2026 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010478; cv=none; b=m2asU0zGqzCCnDUn8LXrX7Qzbyqpu4vFSslzYyNRD5NjLtcDkQYws+slgv/2zUad9qdvVLy/r+BT59B0d7E2BH11qeQBVjLv2OxnRQWs/LO3i8fKi2PG/txzhJy/r5ONER8ag4Eq9tGdceYm720zTwg+Ty9iTBqU17rBTKHr7Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010478; c=relaxed/simple;
	bh=/F3G78oZT/zqPROLzjF6UYQussePtN2a475lu4sjhRc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XzeATIyOAZn8Stb/+q2/On6wojCRIAQ/P6gAVG2Y1ug52JtDLQ6NvYUliLYnsoCUs4Mw5P3lO7t4WbpfOSvOwIGEypmo0YA/5yixpp0epW5+tuZoBB2kwkfjK+7hUi1lUUXXfIAhG4PKcuT+c/5BfEhnD2qiAPRI2/bH1hwc8FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvUVa441; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvUVa441"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6a145935764so826017eaf.3
        for <linux-arch@vger.kernel.org>; Thu, 02 Jul 2026 09:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783010475; x=1783615275; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6vj9Y8YPdjXLyONUMUrksIBiqtXi2GJzV4uQluCx+vw=;
        b=cvUVa441MffTyPS51fYGiVZzzZ38XAEjzfcjW1g0krr7N8lJpx5LzcT1Pn3O0eihTJ
         UJxnN8C0VKZ8p5rZXXxka8dI3+qVLKXc3hGWz2ed04tLLi2R57FXtuw//ikxLfFzDgVv
         FYBsrS/M5WDL5tdpDuWbu2826hbCrYIIQxo64kqcZVXL1No8ecKPshrrUwdsudWLQtqC
         fRLVV5f6v+QGXpJL3+ezcQ7cnhmY4M9wFYB5Nn1iqd13/YH+yg62K+BqGyIPzMFM4wW3
         T5JYdbuqNIauvlC+vonZvWiCQGGxjSmEyEk9S53Z7L87BS7H2wP8FRkWqnBn3fLvViRn
         MsmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783010475; x=1783615275;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vj9Y8YPdjXLyONUMUrksIBiqtXi2GJzV4uQluCx+vw=;
        b=Vahrt+6QlnxruYOWINlkKhxUjhoZm3NGiSXWHmJDAuKv8FrxVKo3LUVq737kDQpSoS
         CmOqOKc9P4Dv4IqvOqE8KDjy2EFEUg941B+4CigGTiZfU7cRuY2wsIDY++4U+Af0lKqa
         JCPCE7F9mBIZ6pv3mo1STXJ4qKqWfSwV2Nc0wCouikeoS1ZgW6Qucot5uKfe/bLDL623
         adWvSDNQj8UXSCga7TZ0rMJgN/e/3OMutU5L0QFt1DgKxLcirWGBg+vK3quD9VGvRyBs
         2hEIl89t30u6OJ0opeecaqZmmI10srhqEXr8yFuhyuISVESmUz2+sUq3O7SoGGsig6gN
         lGvA==
X-Forwarded-Encrypted: i=1; AFNElJ9j1f4zfaUkRlsymZfWlJ59YirJ8oN4FGWmQSr5MsN+YVs6UzU1sWxfD/dUfxAXVJUMX67MFPe1mdCU@vger.kernel.org
X-Gm-Message-State: AOJu0YwqlQBiixXINYrbCBqzinA7+YVm5sNTXMpLslummWemKoirTn3G
	5+lNkn3waWSz/7Y5DgrSoa/DR+MYgK6slIc02BB8Nu/AsVl8tfZWEM5s
X-Gm-Gg: AfdE7cmzYsHYXzU+YC4s8NKt54OIxQZ8ewmAPm6uoH0tMsViwafRPn01cjAzegieRkl
	jeAF+pSScgZSg1wfUnOrBXIGeIwOIe0Rmd1EX0TUuBcUgS/T41XmfBYDtJ7EBKoTT+WunnEoMVC
	XG01CTZe4M3BAbwydNcvaF5PsUDIRrEaKvL530AHjl4IBMF0oKt5RSI5a83lKxD6YQOkyNScxQE
	3trOPysG0YES2e3w7vpvWwMQCErtSbpLal2wu9mEMyJ0f23mrQ7gGGinJzsG1ovi9Ajwi7nHHEA
	5QOnxtixcSINZWvNXhpaajA9+K0rjpoayjoK/GM8d8u+MhQ/FaR78NfKdtphxDvYlSvXSvaVcxq
	sH5zSfAfcvfHU26hVL0ixZx6jYTMum1Ru5v/S+V2gdKNWS7wVjo8oYTtTbk9K7j0FLVMjGnlVB8
	UxFicCD8YSG2kLlUzXwu27Z9HIdm7168qt2WYFNKMnbEoKoIV+v3RYn0QLe9BgvQ==
X-Received: by 2002:a4a:ee11:0:b0:69d:281c:27aa with SMTP id 006d021491bc7-6a309a9cdcfmr3662607eaf.29.1783010474852;
        Thu, 02 Jul 2026 09:41:14 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-44cbec93702sm3189652fac.12.2026.07.02.09.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 09:41:14 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 00/18] dyndbg: cleanups, refactors in prep for API fix
Date: Thu, 02 Jul 2026 10:40:52 -0600
Message-Id: <20260702-dd-maint-2-v5-0-24f22b052bf2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12QQW7DIBBFr2Kx7kQwAxh71XtUWWCbOEiJnWIXt
 Yp890xiRXG6Qfqg95g/VzGFFMMk6uIqUshxiuPAwXwUoj36oQ8QO84CJVppUEHXwdnHYQaE0rZ
 GoywrPgQDlxQO8fch+9pzPsZpHtPfw53xfvvU0FaTESQ0FZWk0Hvp6LPnp9OuHc/irsn0Qq18m
 yATo9or06BWTUftf1RvUXxDNaOq8kprY5zxbosua5sUvn94I/Na6bWQuliNJIELgz/FfgDjqpK
 ctaisqvnj/bLcAM30vqNeAQAA
X-Change-ID: 20260521-dd-maint-2-76c542079420
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783010473; l=6243;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=/F3G78oZT/zqPROLzjF6UYQussePtN2a475lu4sjhRc=;
 b=6W5WsAv71vlWu3Awx4fELrUATsZFBvjRoWKEAILIb0kIvfEGoWqEVQuxzuGtXFGwRYsfMbJgP
 4N2YLkGcDa8AD+wexGxyWfBYJc00bjj4ScAWaJ0DmYAMBbHxUlfYjS0
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

This series has cleanups and refactors in preparation for an API
change needed to fix a regression in DRM when it uses dyndbg
classmaps.  I split these out for easier review, and to stay under
gmail's 500/day message limit.

Whats here:

. factor ddebug_match_desc out from ddebug_change
  separate selecting from altering

. add stub macro for DECLARE_DYNDBG_CLASSMAP
  for cleaner patches later
  
. reword class unknown to class _UNKNOWN_
  a more greppable error announcement

. API remove DD_CLASS_TYPE_ DISJOINT LEVEL _NAME
  these are unused, just extra untested code.

. drop NUM_TYPE_ARGS - just use ~ARRAY_SIZE
  
. bump num tokens in a query cmd from 9 to 15
  with class keyword, can have 13 words in a query

. reduce verbose debug clutter
  7 log-lines to 4, with same info
  
. lib parser add match_wildcard_hyphen for underscore/hypen equivalence
  "module kvm-intel" is same as "module kvm_intel"

. dynamic_debug use KBUILD_MODFILE for unique builtin names
  disambiguate init/main from kernel/module/main

. refactor param_set_dyndbg_classes and below
  improve selectivity of callchain underneath
  
. tighten fn sig of ddebug_apply_class_bitmap
  make more args const

. replace classmap list with an array slice
  section records are directly usable from the array

. macrofy a 2 index for loop pattern - DRY

. pin class param storage to u32
  avoid param size ambiguity across arches
  this also changes __drm_debug from long unsigned to u32.
  
. module make proper substructs in _ddebug_info
  its just cleaner

. move mod_name down from struct ddebug_table to _ddebug_info
  makes mod_name more available where its needed

. hoist classmap filter-by-modname up to ddebug_add_module
  closer to where its done for pr-debug descriptors

. change __dynamic_func_call_cls macros into expressions
  Xe driver uses it inside an if (cond), do-while-0 cant sit there.

"user visible" changes:

The KBUILD_MODFILE derived name appears in dynamic_debug/control, so
[main] changes to [init/main] etc.  The query parser is adjusted so
that "module main" still selects all of the former [main] modules.
It is user visible, but not a behavior change.

If a coder calls __pr_debug_cls(5, "...") but does not register a
classmap for it, that callsite will display in dynamic_debug/control
as "class:_UNKNOWN_ _id:5", not "class unknown, _id:5" as previously.
This is an error case, and has never been seen in the wild.

---
Changes in v5:
  moves KBUILD_MODFILE ahead of array-slice, to address sashiko
  complaints which were fixed later in V4.

Changes in v4:

Dyndbg previously used KBUILD_MODNAME to provide module-name, this
works well for loadable modules (module loader requires unique module
names), but for builtin modules, is effectively kbasename, and is not
guaranteed unique.

So we get 4 modules named "main": init/main, kernel/power/main,
kernel/base/power/main.  This ambiguity is visible in user-space since
the beginning of dyndbg.

Now suppose kernel/{,base}/power/main want to define classmaps to
categorize the various pr-debugs they have.  The current code finds a
module's classmaps by strcmp on modname, so init/main will match
against classmaps defined by both kernel/{,base}/power/main.

The current code will also map "main" classes to kernel/*/power/main,
so they will probably work at first, but 2 independent classmaps can
both use class-ids 0-N, but will conflict if they're both used by a
module.  Then we have classmap overlaps and unpredictable results.

Changes in v3:

fix some (not all) of sashiko's complaints.

Changes in v2:

 https://lore.kernel.org/lkml/20260504-dd-cleanups-2-v1-0-6fdd24040642@gmail.com/
    
V2 addressed most of sashiko's feedback on V1:
 https://sashiko.dev/#/patchset/20260504-dd-cleanups-2-v1-0-6fdd24040642%40gmail.com

---
Jim Cromie (18):
      dyndbg: factor ddebug_match_desc out from ddebug_change
      dyndbg: add stub macro for DECLARE_DYNDBG_CLASSMAP
      dyndbg: reword "class unknown," to "class:_UNKNOWN_"
      dyndbg-API: remove DD_CLASS_TYPE_(DISJOINT|LEVEL)_NAMES and code
      dyndbg: drop NUM_TYPE_ARGS
      dyndbg: bump num-tokens in a query-cmd from 9 to 15
      dyndbg: reduce verbose/debug clutter
      lib/parser: add match_wildcard_hyphen() for agnostic matching
      dyndbg: use KBUILD_MODFILE for unique builtin module names
      dyndbg: refactor param_set_dyndbg_classes and below
      dyndbg: tighten fn-sig of ddebug_apply_class_bitmap
      dyndbg: replace classmap list with an array-slice
      dyndbg: macrofy a 2-index for-loop pattern
      dyndbg: pin class param storage to u32
      dyndbg,module: make proper substructs in _ddebug_info
      dyndbg: move mod_name down from struct ddebug_table to _ddebug_info
      dyndbg: hoist classmap-filter-by-modname up to ddebug_add_module
      dyndbg: change __dynamic_func_call_cls* macros into expressions

 Documentation/admin-guide/dynamic-debug-howto.rst |  42 +-
 drivers/gpu/drm/drm_print.c                       |   6 +-
 include/asm-generic/dyndbg.lds.h                  |  14 +-
 include/drm/drm_print.h                           |   2 +-
 include/linux/dynamic_debug.h                     | 130 +++---
 include/linux/parser.h                            |   1 +
 kernel/module/main.c                              |  12 +-
 lib/dynamic_debug.c                               | 494 +++++++++++-----------
 lib/parser.c                                      |  58 ++-
 lib/test_dynamic_debug.c                          |  28 +-
 10 files changed, 397 insertions(+), 390 deletions(-)
---
base-commit: 4dcdecc52686a3fbd4545e86fc711fdcd15f09cb
change-id: 20260521-dd-maint-2-76c542079420
prerequisite-change-id: 20260630-fix-align-589738662161:v4
prerequisite-patch-id: d6b2b7d254c7e8bbc0aea891d49b15dc1e71eaa4
prerequisite-patch-id: 3dffaa165e78dc58e443469755eddb07972d0ddf
prerequisite-patch-id: 2c4827d84b4159e71df89cca2a03938a534ecdb5
prerequisite-patch-id: 4599f9be1eb06c0d7f2a7c657d4940411635e94b
prerequisite-patch-id: aea9e121b30e3c7f3d76921b49f81ad421b7af51

Best regards,
-- 
Jim Cromie <jim.cromie@gmail.com>

