Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E73F33F5A5
	for <linux-arch@vger.kernel.org>; Sat, 23 May 2026 07:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779520491; cv=none; b=XTPQNHqTNqJcAk498AXvD2Fhaab3eUDOdTtErR+cdCwQzcCYf5GTb/ZhgE4uHNBBe7zh9bwUwiC2nQhTuFmQro6S2cliHgqjIX7Xg8IE9n+Yg/bLIK4m2ftvL8vOVULcvvjRx1j69yvwhWZoFMrdoKd5IN7OUW9qd02/WqvYiGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779520491; c=relaxed/simple;
	bh=8jBhjuduixufihDKJwrZElFIwWaRLsRSBwULeuL0jsU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DkogaV9XrOEQ0oYCTBKEBQNDwwc7lmZPs2XkXzkOeR57+4jgIAlkaOt59+x31k0FwBi50XRY1BeP7F3felkwweiFWLYtpRMzCkGEBvasUMAwJ8Ow42aJO7vC3RmxaoczakJ/gtZd54+PF+iQ4Mi4DSAZA0lKdb4bBRGoHrZOiIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=beok2vwJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beok2vwJ"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso50624435e9.1
        for <linux-arch@vger.kernel.org>; Sat, 23 May 2026 00:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779520489; x=1780125289; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B82AnjYCPnbmlWKD17P8b3BcjZ6LxKe5i6P2twPjNbk=;
        b=beok2vwJ/b8+s1rbCtgYZYZ64LTndN1z5uqKA5BZWSYzoY32TuDVQBYduBXnHbQRaD
         yAXJlfIs84QRwX0Nu21nedbnS+hHCmLHyPZiA0KfTs/V1WQFnAFu0BKbF4d8/tWWqASU
         nspBquXhZtTN1zNcJGS6xN90bXev1k/FQSk+ucoetQYm2Z9QZ6r72vvq2ZUJILPEz6+e
         UyeKiEXf+FIuppDby+Twy0V2FR6jbqkXT7WZw97yt0tbarFxFDWVPEYDfB8OqgRXCBUD
         lRNMjVaVsTbz3AIfVS48Fx6cO4IsmaIPVOw1dY5waEvUSK8FzfYXLcrQAaSkzU+yLuxp
         oaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779520489; x=1780125289;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B82AnjYCPnbmlWKD17P8b3BcjZ6LxKe5i6P2twPjNbk=;
        b=E6b8BiUgC6yEXmjhRYlkF2hPIbY3IZ7HdyCRQbh+bJ5cJJBsGJH1W57bdt65lCfS/W
         qiiIMk1anjKNxsrwZo8Z93yQSqkwj224aCvdKcZvjkeRxKe5L0tD6DAwvWz18XJOY1/8
         xJxd3tvCr9QFtSCx0orsRuhJVEHrXYMu5AUVX7VLc49Ps8Ktbd0OVA60yK3yi5csXgKb
         rm8YFilSKbZ53leHNJCXBDZfWe71VGhGVsLPkZ5yjEAKT6JcD59XsxIVy+0l1PJxW6d+
         iRPQmAdDJ2PAtjGuWWOu55vE/6SfFcay8r68LMBvCbTYgPR+AsqQ+xEw4h7d2CpGDnQd
         8dJw==
X-Forwarded-Encrypted: i=1; AFNElJ8XzxrJyvSiX/77GqEk4IQi8tG9wmaIjpYgm5gAjx22wESi1m8f/0Fh3L/J9NWkgXXuYjJJGub0Cyzv@vger.kernel.org
X-Gm-Message-State: AOJu0YyvwpYripPbFgNX5lwyGJ9NRfSFmLWeDpt2suDZl76IL3D2yhbm
	y0gEDNBVPQNNPeEQxVAxmvT6bJlT5DhmGLLR6Tj31B+jgsI1XmgYpAmX
X-Gm-Gg: Acq92OF8KB5/KHDgQmriiI8kSHEiRQMbm/zaEnNl4QXCBiSsopAwK0JrPFeLiBGTwVm
	Bw7yFhD5UCp2UZ3LpaugLG9e0SxTGNZoqOrEuN7tC3mO8dWzNvTSijSldK2JsLQc8/bJXb8MzS0
	WWVzFunvGZVN1HUgF9cUU56zszZpBF+erEa1cIs9BDLc6aRqBM9Ri/WeKFt3rbRS99lFYjlrxOX
	nxkrElXMn2X5sm8EgkMOYmRsf0XtmKofeBXgat6l6jMxd5iqAehl/W5y19YgTeCTmTuZyOrb6Bw
	2z82UOQ5gdgFfFXEwBPBg8NCJrtXoJOIF/+9c/JXUburjgh2eCUZXw/I/KQ+MdKHMWg/jOMug9f
	lC5aU88ypFOfNZDa3vy58AR2BgaqrDcAJVxICtz0rVofkZfE9ELWMAi14+GhnGH4xcI6vx0z4dz
	DwPhIfnVux244aDqdd0RWPLDG311YD
X-Received: by 2002:a05:600c:4ecc:b0:488:aa33:dcbd with SMTP id 5b1f17b1804b1-490428db91cmr94029285e9.26.1779520488375;
        Sat, 23 May 2026 00:14:48 -0700 (PDT)
Received: from [192.168.0.174] ([31.96.183.250])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-45eb6d5cb76sm8639838f8f.25.2026.05.23.00.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 00:14:47 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 00/24] dynamic-debug cleanups refactors maintenance +
 alignment fix
Date: Sat, 23 May 2026 01:14:33 -0600
Message-Id: <20260523-dd-maint-2-v2-0-b937312aa083@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzMDUyND3ZQU3dzEzLwSXSNdc7NkUxMjA3NLIKEE1FBQlJqWWQE2LDq2thY
 A3hR6GVwAAAA=
X-Change-ID: 20260521-dd-maint-2-76c542079420
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 =?utf-8?q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779520485; l=3760;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=8jBhjuduixufihDKJwrZElFIwWaRLsRSBwULeuL0jsU=;
 b=JjcUo67/lmTXoqAjuxUxZQpl8pkrrmgrF7bJWqbmi20rNUPZ8PajaRsy5AFPIKOeJ7ywl34Ry
 jHzP4NAZ92FAbLmRPBkk1d6EJ5PgR7wU377fdGYBettYWvkO0wEhkbv
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

This series primarily revises:
 https://lore.kernel.org/lkml/20260504-dd-cleanups-2-v1-0-6fdd24040642@gmail.com/
    
rev2 addresses all of sashiko's feedback:
 https://sashiko.dev/#/patchset/20260504-dd-cleanups-2-v1-0-6fdd24040642%40gmail.com
    
I dropped the pr-fmt patch as not reproducible,
advanced the drop-NAMES patch to reduce subsequent churn,
and fixed the classmaps PARAMs to u64 to avoid 32bit flags on 32bit arches
    
For easy one-stop-shopping, it also includes 2 smaller series:
    
1st fixes a section alignment problem, with Reviewed-by from Petr Pavlu
 https://lore.kernel.org/lkml/20260515-asm-generic-1-v3-0-680b273666d4@gmail.com/
    
2nd is 2 doc-only patches for current behavior, not drawing any comments:
 https://lore.kernel.org/linux-doc/20260502-dyndbg-doc-v1-0-67cc4a93a77e@gmail.com/
    
Not included here is the API fix for classmaps, which splits
DECLARE_DYNDBG_CLASSES into DYNAMIC_DEBUG_CLASSMAP{_DEFINE,_USE}, and
the changes to drivers/gpu/drm/* to use the repaired api.
I'll schedule that flight after this one lands.
    
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
    

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
Jim Cromie (24):
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
      dyndbg: improve section names

 Documentation/admin-guide/dynamic-debug-howto.rst  |  35 +-
 MAINTAINERS                                        |   2 +
 include/asm-generic/bounded_sections.lds.h         |  32 ++
 include/asm-generic/dyndbg.lds.h                   |  18 +
 include/asm-generic/vmlinux.lds.h                  |  65 +--
 include/linux/dynamic_debug.h                      | 120 ++---
 kernel/module/main.c                               |  12 +-
 lib/dynamic_debug.c                                | 496 ++++++++++-----------
 lib/test_dynamic_debug.c                           |  30 +-
 scripts/module.lds.S                               |   2 +
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/dynamic_debug/Makefile     |   9 +
 tools/testing/selftests/dynamic_debug/config       |   8 +
 .../selftests/dynamic_debug/dyndbg_selftest.sh     | 257 +++++++++++
 14 files changed, 664 insertions(+), 423 deletions(-)
---
base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
change-id: 20260521-dd-maint-2-76c542079420

Best regards,
-- 
Jim Cromie <jim.cromie@gmail.com>

