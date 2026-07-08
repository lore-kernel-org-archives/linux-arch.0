Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD5A3803E7
	for <linux-arch@vger.kernel.org>; Wed,  8 Jul 2026 02:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783477107; cv=none; b=RJ8aNRCCJJzr0+hJdBnQUqGY8kXnj9KCGR2SzLuAzDWwfzNS6WiH6fHra6dSnPADYiBusB/y0Tb0OqMGpqwtfGazK8v6ctQbsgsViP06CGejg65HP9Kid06XRv0y8VLRjfpHFYLQlC5WJedyKzRG25U1URYGxpKrFebKz+Z08OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783477107; c=relaxed/simple;
	bh=Y6iplDL8rNgmn0X2LDL04ve9ymDJVghIuEaIPWNObfk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K7fIs4pLY1ZBUA7tXMXfiA3zBt6f5PEyRRtJEzX1Ivl9gA/XnIigYrrNljlV+Pg6SfFJM1pk6VndSb61DXlo0Izw0MuwKA444v5GWO3lZfWgB6nRBl9tuQW2iWtYspNJaxLQQ4jN2rNC1RrI3OZR/HdgcNlsU7U1Uz0vJAYJ/4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enYAPEWu; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enYAPEWu"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-495ee8e807aso83972b6e.2
        for <linux-arch@vger.kernel.org>; Tue, 07 Jul 2026 19:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783477105; x=1784081905; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NMN7ABXuRfB8gym1Nu0oTUlXvbUyY+lInnKbjPM/RBo=;
        b=enYAPEWuEkBRAlI5Do5YpusL/ZlGkLm7whDsgiMj8PBjYxxeZD5o4bvqwrjj65xYrq
         uluxIS5YlYSYaBIXqtgeugzZCig+jjphoZ33scGPW/vG1g9gTpQjr3KupOwedVdZJL2W
         PQd/+vn2S32cCpX8mFNRecUJhZkASH5vK4bL2UHXoKtQ+Q6NKGawCM1XxZA/ae3iXmjF
         oOQhQN4dSjSbmKSkPMZ+LMCiZeqositjhYquaB50WT/axlSTRyTgS88zdbpd0wKhench
         I8kisr33ShxkwpDezkHHvPVqCwQv3QnHGS5aywCdjNtCubYCZ7jPxR1qijWl1mM0DwM8
         b7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783477105; x=1784081905;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NMN7ABXuRfB8gym1Nu0oTUlXvbUyY+lInnKbjPM/RBo=;
        b=OPM0tB7yEbm6A/qcJvc7k7XdeqTxezV2SmzO3kcm6qQFoBDOCE0ccXbwPnKNPblqnw
         6Glyzq5UnULR4zhnRbx5CcMwM2HuYduYCocpNzZk5AUKrk0hTOGLFKdy6WxNPd2MECCk
         NiylPoIOzUDvub4XUPslFCDtwewoD4N4wvERbULfNhjZzEBsHvbTy6dyeH6BxY7k68q6
         0deZlCqsbWa2kAb5MNjSps4ACTKJlbqc09FQSoYP3DBQ8SDA1uC4FUP8Q1cqJoqsqfZZ
         SMF8m4mvNzZPGiG4RuAqD18vTX5UYnuX0Zg9r0zJpHYwn+0nfYCcAr3VR9w14kr9jfCz
         JUww==
X-Forwarded-Encrypted: i=1; AFNElJ/VwhVoLmrPgRdltqy29iq3Kcm8+Br+f2Xf+1GUs71kfgflYj4NWm06Dj/9cRhWTwPLw55LLvL46eLA@vger.kernel.org
X-Gm-Message-State: AOJu0YyypeBfZ4QbVLJ2b1Z5bi/CmaEPQdgegQH2ifwSvI7q0Y+MPubh
	HE8xakPbpp+SFy5QjCp/C18bkltNF7uue/OwMAKk6Xy8ljRrzZuhKZ03
X-Gm-Gg: AfdE7ckTGwDuXY8Gww4r7p5kdwol2SLH3TVtRYgBUNls2p8bAPvwktNYay6z/FhaB+M
	wSwLG0hpuLNSZ2FI+XkyFy2+mzYoSRnF/8s7D+CU9wXIqvn8HHPFZCo+MgVq4i8+CaSFp6ZIpb/
	5VBlxC1EkVTE0SUxOJslFRuKnwtekNEqjltwJ8vMzt6nYwlpqDwJEhHN/mkX8oXP/lldPh4EDeH
	A6JnFBTrVGx1uKlF8tNXPIPL44uLUjwj+m5zW+rQxhWz/XiJWvQZPQvrlh+GKKk1Q5zMPe3KBE9
	9WNCtgk1osoCOkMw0YivBXqQLH5LNQcLmyRb/VVGkgNtq/6JyUT9aHkkQ60XEoQPnQMLw/9kLrp
	W2w6KYBYDjAY04PUQLl0jYMZ52SunsXW0JSemV6hRRTSMAVYwRmfnY2QkH0ey9cOpYdi5+itfyF
	/Ni1AyqqJ/1vgJPr0tOax50GVYWkMyMX9jr6bPgSyWq8avunhpPhk=
X-Received: by 2002:a05:6808:3305:b0:492:5b42:ab02 with SMTP id 5614622812f47-4a1fe930f52mr487342b6e.0.1783477104559;
        Tue, 07 Jul 2026 19:18:24 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4a1aa006f74sm799975b6e.0.2026.07.07.19.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 19:18:24 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 00/24] fix dynamic-debug classmaps API for DRM
Date: Tue, 07 Jul 2026 20:18:00 -0600
Message-Id: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13QTW6DMBAF4KsgrzuVPf4DVr1HlYUNhlhKIDXUa
 hVx906CKggbS2Prexq/O5tCimFidXFnKeQ4xXGgwbwVrDm7oQ8QW5oZcjRco4C2hauLwwwI1jR
 aIbcVHYzALYUu/jzDPk80n+M0j+n3mZ3xcfsfI/cxGYGDr6SVAp3jpfzo6eny3oxX9ojJcqOGv
 2yQJVHlhPaohG9lc6RqT/GFKqKickIprUvtyiPVG7UHqomi6hA9/cV3uKfLWkQKX99U5ry2sXV
 ZF+sykgN1Be4S+wF0WVlZGoPCiJp2Pi3LH4EByVuZAQAA
X-Change-ID: 20260521-dd-maint-2-76c542079420
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783477102; l=6982;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=Y6iplDL8rNgmn0X2LDL04ve9ymDJVghIuEaIPWNObfk=;
 b=hWui+05aR2eCgLHG18GUk6iggaF9pb0RRyc9fuSQ1A3d8frVErXNCduqRoSg+LWSEuaT6EG92
 EWCyo8dj6zEASJiOtzA9I2v/73xkxdS+1F7bjpsf+KOR3j+igWyo56D
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

This series fixes problems which broke CONFIG_DRM_USE_DYNAMIC_DEBUG=Y.

1st chunk fixes a section misalignement on i386, when CONFIG_DRM=y and
CONFIG_DRM_USE_DYNAMIC_DEBUG=Y.  It also repairs a linkage failure
where the dyndbg sections got dropped from loadable modules in some
arches.  This chunk was reviewed by Petr Pavlu (thx).

2nd chunk is a set of cleanups, callchain refactors, struct refactors,
and internal reorgs in preparation for the API change needed to fix
the regression seen in DRM where boot-time drm.debug settings (in
core) did not propagate to drivers.

3rd is the API change itself; replacing DECLARE_DYNDBG_CLASSMAP (used
in both core and drivers, a K&R define-once-use-thereafter violation,
which caused the regression) with DYNAMIC_DEBUG_CLASSMAP_DEFINE in
core, and $1_USE in drivers and helpers.

There are 2 user-visible changes:

1. change an ERROR condition displayed in dynamic_debug/control,
from "class:unknown, _id:1" to "class:_UNKNOWN_ id:1"

This only happens if a classmap is incorrectly defined, so it should
not pass review, and should be SHOUTED about.  And since classmaps are
BROKEN for DRM (its only user), this affects no users.

2. change builtin module names, displayed in dynamic_debug/control,
from simple "[main]" to subsystem "[init/main]" etc.  This corrects an
existing naming ambiguity, which is disallowed for loadable modules by
the module loader.  To preserve legacy query behavior, "module main"
will select all of "[*/main]".

NB: the current ambiguity prevents cleanly adding classmaps to
builtins named "[main]".  Such an addition is quite unlikely, so this
change could be dropped, but it seemed proper to correct it and point
it out.

3. revert a change in classmaps-v1 (2022) which enlarged __drm_debug
from (unsigned) int to long int.  64 categories of drm-debug is well
past reasonable, the param is now a u32, for clarity.

---
this is based on v7.2-rc2
Ive trimmed the cc-list to stay under gmail's 500msgs/day

Changes in v6:

previous versions split the 1st chunk into a separate submission, in
an attempt to get past gmail's 500 msgs/day limit, and to ease review.

This complicated application; although the 2nd chunk had the b4
dependency on the 1st, this fact was missed by sashiko, which
therefore couldnt apply it.

A followon series adds compile-time and runtime checks to fail-fast if
classmaps are used incorrectly.

Changes in v5:

move KBUILD_MODFILE ahead of array-slice, to address sashiko
complaints which were fixed by later patches in V4.

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

v3:
- move #includes to top of files,
- drop redundant ALIGN(8) in dydnbg.lds.S: DYNDBG_SECTIONS macro
- add Reviewed-by tag (thx Petr)

v2:
- avoid BOUNDED_SECTION in modules, dont need _start & _end symbols.
- sets 0 address to the sections, not just whatever current is.

---
Jim Cromie (24):
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
      dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP

 Documentation/admin-guide/dynamic-debug-howto.rst |  42 +-
 MAINTAINERS                                       |   1 +
 drivers/gpu/drm/drm_print.c                       |   6 +-
 include/asm-generic/bounded_sections.lds.h        |  32 ++
 include/asm-generic/dyndbg.lds.h                  |  22 +
 include/asm-generic/vmlinux.lds.h                 |  68 +--
 include/drm/drm_print.h                           |   2 +-
 include/linux/dynamic_debug.h                     | 275 +++++++---
 include/linux/parser.h                            |   1 +
 kernel/module/main.c                              |  15 +-
 lib/Kconfig.debug                                 |  24 +-
 lib/Makefile                                      |   3 +
 lib/dynamic_debug.c                               | 608 +++++++++++++---------
 lib/parser.c                                      |  58 ++-
 lib/test_dynamic_debug.c                          | 145 ++++--
 lib/test_dynamic_debug_submod.c                   |  14 +
 scripts/module.lds.S                              |   2 +
 17 files changed, 846 insertions(+), 472 deletions(-)
---
base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
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

