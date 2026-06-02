Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3E23C8719
	for <linux-arch@vger.kernel.org>; Tue,  2 Jun 2026 22:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440495; cv=none; b=VLKoK5WSQbgaOOrBLDh8CcqW1vKPlh1wthc6GVXEzHvMnKuxX4OMX9IEt0WrpGtdEEJVesLkFfQYPv5DArRT8KkIuiwA2T+PCIily6ot1EmRQ8mxLPqolOfvzhH4IFlgUpqPsHXel7Sbh0rQLWxaStiiSGFqy98ve01oqNwWroc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440495; c=relaxed/simple;
	bh=pvqZETCsYkC1jfFJFSdQMsi9nib/U911lUcWXFhah34=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UMvy4SIHpnq4JSdBtHgtk1dcYJDoE5Nt0Jf+eY1CRs8GaFIWqcxIVCu8jBw3vkEjyRIKN/7fvA/Y1MZ5VelOUoZt8VTiis/b2v64GbZ+F+foNit35LbHweAxeAmGbIt4k7hQs8oCrHCnK+JcxR03rGCYZYyzXQrTkSQNjPYUuj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Px3WAmDM; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Px3WAmDM"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49050ff7cbdso111341915e9.2
        for <linux-arch@vger.kernel.org>; Tue, 02 Jun 2026 15:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780440492; x=1781045292; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V9cvVq2UX5qs+A/PtNYPNl1ibkkw2juVOILs+9glAdc=;
        b=Px3WAmDMTdbABUTGXOwlyDv6a9YMHjqCqB3xqnXhYttecVL2nZVXAOqTtNcllYqhEE
         Emoexcjff60POG266s30+mL0wnWUY7Mt5AtYXBHBsCcgx/CaJSRm/Fql2opHEyvKWzzu
         11WSfCNFI2ykDmqZvQ4uYziAgU9JRUvWczPHbx4upXsktllR1/NBBnUv3v4jOVDNtXU9
         e3vdwMjDl2fUqkWuDlvJj5urkTzPpmVs3sxgvVReOP8tqUjBSYDO2oJOBqfU1MKrv3xq
         j/C4J1WHH4Wlswzz/1BG05FpTzl4k/ayN8u05NN/GO75g0kOBmvj/FoAxeZ8oZwO1q71
         wAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780440492; x=1781045292;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9cvVq2UX5qs+A/PtNYPNl1ibkkw2juVOILs+9glAdc=;
        b=nZpVBRBl0XoO8nkIKc17CURen444vYbOUoU18cXCrkRjxNT2ZZu6wJzeQkQgEPCXUN
         1a0KkysIpJyedFSlOxYeC1M/zaLKnac1cZoW4tQyMOxD+80zCVMPijU+s7RbCiY5wV9N
         PQ9MwJ0vYhrvdWWaGNlvos1nWgwydo9Me98iXRitvXbTEJ6zMW9rMaEKqH5fEUm5BhDZ
         2k4olw0aUx8jzebwqUjKtOSaWI2Bzx01HlYkdxuwfwrcGnX4OIve7CAkTe3FlvdXCQ0B
         XlsaDSgMxy/HNDzDHg/O+yfTcNZaB7UDeBwf2eGv09PSEhouBGZtEYmohri3H6AAscN+
         +nKw==
X-Forwarded-Encrypted: i=1; AFNElJ95OXq2VD9lN2C4Apj7v1gimU+dODvo5MmgzEpG9Wum+HyBKoZ8RkGoQMJ9JABjHF024WchjpOwlq+5@vger.kernel.org
X-Gm-Message-State: AOJu0YwP5Oigyob3awo9dI90g5n5jDQBKWPjb3RaY6Npf+OId7m37Kei
	2idv2NYhfrHyi3nol//ylewIwsPVBQSa9FLlCiqV4WJyvuXKtwMt+avJ
X-Gm-Gg: Acq92OH03JOJXfxYpwjTkNdy9/7U4aK6LeSDgVPzo6/wfKzN+6lcpwRBYbOZPKkJK4j
	QKJcrFy+cD0xDZ1v0pRIABsgF5aDrMGzPJKZBEGbfDs1Oonn+4mn7RbZUMaOaRYTKJeira0VWjU
	zYXnYDjt5ToNIeYjMwMr1TEJxxxJ0KvlhhbvGY7kqKu2XoIA6J+DDwDLQmce67FEvJ+bC3cng3b
	v7dY7b6kCjtRP50FfFrPGv3l7t10wapEUymlt4KieUsLRavrAAJkB2lh+ymBhCj1OQMwPBcYf3j
	/Ty2n81V3U/uslh/REjUFHNVzOkpNDYqdm6dGzWWvh01sRSu91zsytsPqjm/lX0fERQ4E2d6T7P
	e4UlRQebTKX2J42GMZibHsUdybrV567Oe/cQ3lrIoUPV7obZ/L56KKN1bBWHWr13VVb73v/UGtL
	W51kRzlcHCy2JENblmffrCffPUlHf6+f7FJeH8Gb9NLw==
X-Received: by 2002:a05:600c:8712:b0:490:b106:4fe8 with SMTP id 5b1f17b1804b1-490b5ed5d5cmr11883645e9.33.1780440491565;
        Tue, 02 Jun 2026 15:48:11 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4601f2f2710sm1999791f8f.14.2026.06.02.15.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:48:10 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v4 00/25] dynamic-debug cleanups refactors maintenance +
 alignment fix
Date: Tue, 02 Jun 2026 22:47:57 +0000
Message-Id: <20260602-dd-maint-2-v4-0-19a1445585a8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WOwQqDMAxAf0V6XkebVp077T/GDrXtNDDtaKVsi
 P++KIy5S+AlvEdmlnxEn9i5mFn0GROGkUAfCmZ7M3aeoyNmIKASJUjuHB8MjhMHXle21CDqhgY
 j4Rn9HV9b7Hoj7jFNIb63doZ1+82ofSYDF7xtVK0kGCNO6tLR6XG0YWBrJqufWom/D7IiVRtZt
 qBl65Tdq8uyfABmofZ03wAAAA==
X-Change-ID: 20260521-dd-maint-2-76c542079420
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 =?utf-8?q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780440488; l=6217;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=pvqZETCsYkC1jfFJFSdQMsi9nib/U911lUcWXFhah34=;
 b=c5JtxMZifQHPMyBgcfsCSWRGiDIiiRZIirFhHQsdyOt6nNO24F5i7nHlhST28dRSas2WCF5nq
 rwhKP25z64EDzaAC8kCEnvcwXRGPVK2kiFNaSe5XO62iU/o9DUJEclW
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

V4 of this series drops 2 doc-only patches in v3, recently picked up
by linux-doc, thx Jonathan

So new 1st 5 are a fix to a linker-script alignment problem in 32bit
arches causing a null-ptr scanning dyndbg-descriptor section on i386.
These were reviewed by Petr Pavlu.

V4 main change is addition and use of match_wildcard_hyphen(), which
allows that "i2c_hid" is same as "i2c-hid" wrt to modname comparison.
This addresses sashiko-dev's feedback on V3.

v3:

The remaining patches are cleanups, refactors in preparation for an
API change needed to fix a regression in DRM when it uses classmaps.
I split these out for easier review, I will follow up with the API
change afterwards.

The biggest revision vs V2 is the new patch: 25.  It addresses a flaw
detected by sashiko which is best described by example.

Dyndbg uses KBUILD_MODNAME to provide module-name, this works well for
loadable modules (module loader requires unique module names), but for
builtin modules, is effectively kbasename, and not unique.

So we get 4 modules named "main": init/main, kernel/power/main,
kernel/base/poser/main.  This ambiguity is visible in user-space since
the beginning of dyndbg.

Now suppose kernel/{,base}/power/main want to define classmaps to
categorize the various pr-debugs they have.  The current code finds a
module's classmaps by strcmp on modname, so init/main will match
against classmaps defined by both kernel/{,base}/power/main.

The current code will also map "main" classes to kernel/*/power/main,
so they will probably work at first, but 2 independent classmaps can
both use class-ids 0-N, but will conflict if they're both used by a
module.  Then we have classmap overlaps and unpredictable results.

patch-24 eliminates the ambiguity by using KBUILD_MODFILE to provide a
unique module-name, then adds matching against kbasename(modname) to
restore the legacy query behavior.  It *does* change the modname
exposed in /proc/dynamic_debug/control, but not the result of a query
like "module main +p".

OLDER VERSIONS:

V2 primarily revises:
 https://lore.kernel.org/lkml/20260504-dd-cleanups-2-v1-0-6fdd24040642@gmail.com/
    
V2 addressed most of sashiko's feedback on V1:
 https://sashiko.dev/#/patchset/20260504-dd-cleanups-2-v1-0-6fdd24040642%40gmail.com
    
It dropped the pr-fmt patch, as not reproducible,
advanced the drop-NAMES patch to reduce subsequent churn,
and fixed the classmaps PARAMs to u64 to avoid 32bit flags on 32bit arches
    
For easy one-stop-shopping, V2 also included 2 smaller series:
    
1st fixes a section alignment problem, with Reviewed-by from Petr Pavlu
 https://lore.kernel.org/lkml/20260515-asm-generic-1-v3-0-680b273666d4@gmail.com/
    
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
    

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
Changes in v4:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v3: https://lore.kernel.org/r/20260601-dd-maint-2-v3-0-4a15b241bd3c@gmail.com

Changes in v3:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v2: https://lore.kernel.org/r/20260523-dd-maint-2-v2-0-b937312aa083@gmail.com

---
Jim Cromie (25):
      docs/dyndbg: update examples \012 to \n
      docs/dyndbg: explain flags parse 1st
      vmlinux.lds.h: refactor BOUNDED_SECTION_* macros into bounded_sections.lds.h
      vmlinux.lds.h: drop unused HEADERED_SECTION* macros
      vmlinux.lds.h: Fix ALIGN(8) omission causing NULL ptr on i386
      vmlinux.lds.h: remove redundant ALIGN(8) directives
      dyndbg.lds.S: fix lost dyndbg sections in modules
      dyndbg: factor ddebug_match_desc out from ddebug_change
      dyndbg: add stub macro for DECLARE_DYNDBG_CLASSMAP
      dyndbg: reword "class unknown," to "class:_UNKNOWN_"
      dyndbg-API: remove DD_CLASS_TYPE_(DISJOINT|LEVEL)_NAMES and code
      dyndbg: drop NUM_TYPE_ARGS
      dyndbg: reduce verbose/debug clutter
      dyndbg: refactor param_set_dyndbg_classes and below
      dyndbg: tighten fn-sig of ddebug_apply_class_bitmap
      dyndbg: replace classmap list with an array-slice
      dyndbg: macrofy a 2-index for-loop pattern
      dyndbg: Upgrade class param storage to u64 for 64-bit classmaps
      dyndbg,module: make proper substructs in _ddebug_info
      dyndbg: move mod_name down from struct ddebug_table to _ddebug_info
      dyndbg: hoist classmap-filter-by-modname up to ddebug_add_module
      selftests-dyndbg: add a dynamic_debug run_tests target
      dyndbg: change __dynamic_func_call_cls* macros into expressions
      lib/parser: add match_wildcard_hyphen() for agnostic matching
      dynamic_debug: use KBUILD_MODFILE for unique builtin module names

 Documentation/admin-guide/dynamic-debug-howto.rst  |  55 ++-
 MAINTAINERS                                        |   2 +
 drivers/gpu/drm/drm_print.c                        |   6 +-
 include/asm-generic/bounded_sections.lds.h         |  32 ++
 include/asm-generic/dyndbg.lds.h                   |  18 +
 include/asm-generic/vmlinux.lds.h                  |  68 +--
 include/drm/drm_print.h                            |   2 +-
 include/linux/dynamic_debug.h                      | 133 +++---
 include/linux/parser.h                             |   1 +
 kernel/module/main.c                               |  12 +-
 lib/dynamic_debug.c                                | 507 ++++++++++-----------
 lib/parser.c                                       |  58 ++-
 lib/test_dynamic_debug.c                           |  30 +-
 scripts/module.lds.S                               |   2 +
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/dynamic_debug/Makefile     |   9 +
 tools/testing/selftests/dynamic_debug/config       |   8 +
 .../selftests/dynamic_debug/dyndbg_selftest.sh     | 343 ++++++++++++++
 18 files changed, 833 insertions(+), 454 deletions(-)
---
base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
change-id: 20260521-dd-maint-2-76c542079420

Best regards,
-- 
Jim Cromie <jim.cromie@gmail.com>

