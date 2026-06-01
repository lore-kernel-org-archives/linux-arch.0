Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B29535E1DA
	for <linux-arch@vger.kernel.org>; Mon,  1 Jun 2026 12:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780315502; cv=none; b=UirBDa4RmYC2C7pMQpUIQ6nH9RNNUi5jAnVZqmc+YQ2n57d6yfhRglsvmsVf8KL3mZI2B61LFWemvkIyJmOXCsAwcOCcVcEzarUkTLMgxfSIlN0rM12k9DL5jUdnPPYT6lX7we5I0QkERJAIcjr8UW6q/nO/MYmFEs6EI60uswk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780315502; c=relaxed/simple;
	bh=UexA6IlALDsQZOTV0hLwfWpaRW3TbsQLPhPBboqis4A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oTZkDCMdvSvsSXNR+yfV4CN3e71jAF8j03KJti31gzgyH6Ar7zdnN2OIsHxVfHTpNzeu5ZqV3akqX7r5bBZxybf2eKh+BRH0dZhBG3U+3n9iC+ItoauYQj3S8xTalSC8TxvVoIAlUAi8A88drCrBuoGvJNUd4Slb228Cvpg+cqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQ7F7Xxq; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQ7F7Xxq"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4909e3fa4b2so29255495e9.0
        for <linux-arch@vger.kernel.org>; Mon, 01 Jun 2026 05:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780315499; x=1780920299; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n5qzKyfnccgdjCAGXdsv8yWwGixxrImvsfnV142aaYI=;
        b=JQ7F7XxqW9g6DVtsZTVcda+KjsdeNYn03hmt1o6VGeG8nxxIPttdGcU2M3XHOG1i/o
         j8BQD+cSziDz2A3oOPRlYD8cXBkW3gRsJZup1Z7KrLkD+8yKuGZpMdGg0HFyOcHHErNj
         pPn8msShsZmISyTLfGbxQRUWehoHPj0nbB/knuRc2A5NIzEWaW87Kwn73G/eFSwpwz/p
         08mQMiTn/KI/RXo3qWKj9Wk7aX7Mu7l7MeuDUpln6AsUedO1PVyF/10kJZSLJX96Z8dq
         GxdF5jRwpCqMnWT3Bj1SkWjBR/xpawinuD53I1lZypcGGqPuiafesvGeIuqtaipOtIbb
         fQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780315499; x=1780920299;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5qzKyfnccgdjCAGXdsv8yWwGixxrImvsfnV142aaYI=;
        b=PrJ5uW7utHLEnRPML5k/UG6F62Eu7uU5MBnNOq3eIT48V2Xbj74VLaKqxsOtCw+jIM
         ikgKZXLsZfcpirRaiFvbkPkW+SpcYN/wmvqzyLcqV3twaxYetVSzO1uySDsCXCv1XwO1
         J+YBGhN5F/937u7me+Lw0yujx2EhRW/504bNearKf6X8bhHneAgt5DmnVj/lP4bvXGqs
         GsxsQcigziFqwjyxLi/oTlz0DHdDrVsisf8KbIFRyDq14pq5nZsz12zjlhyFTGpn8jwJ
         BwDZb+b9Fq2N8M+xjtZR+XGoE1ps9phS3IsCzqk8QZBRaGM36oOLHqiPu7HeSAGpXamU
         pK8A==
X-Forwarded-Encrypted: i=1; AFNElJ+ivF9zqTVWARUPep8RVNbfB+NVYHmQP0bhpxXigbofot8hTPBeQub3XEIK2N+snHJiyUrtNejVLT3k@vger.kernel.org
X-Gm-Message-State: AOJu0YydkgbXWL/r7z+MV1qUnGgKY3dL8kWeuRbp2tD3xmVVB9SyL4nR
	S+HK8XC7hFo83vb8soVUvqRgR/I+6YfTTYbFdC+xTpvOfmvW1o9ujcmD
X-Gm-Gg: Acq92OHTth2jS0gTUURr3XzSM5x5T5H4lw5kqJ6KVS45eIN8iDpAgyn6pHJK6mko4eD
	3bdJ4PHmrY+JL9saSOkpWC6RkftvI+W8Sd4aHYx4SqLWVJCac7G4+Zu5+fuahJdoPjTzNab/pQQ
	V8IehrU7U03tf2KWjfNuJmhVTqBsxTbryGxp3+cY5jZ/s4hORF04wODr1RO43tyUkwkfd7x8Njz
	3toM0+pDsJo7h9WtsJZERzkET0MDioszgDZ1PKgYnY7SxQTMsHm3tHnEvxwgohCQ8u6XrrdHuy/
	POS1vV8N4AS39BI3JRhPxY8KfHjtsVSBZK7gOhVO/z/wzt5LfGUMSl/DL4PEEGcyt1m+zoHDaN/
	jVne45k4YPJSE/hNgurGcKcJ168gysCcn3SSvJ1tsx+qAJB+Es+V+DsCZT9d0FV7Ccp6Mayw9Id
	svZVlMq0abBg7e8NsV4VgPat6NWcjiJ1tjs7OT0TA2jQ==
X-Received: by 2002:a05:600c:3487:b0:48f:e1ac:c94f with SMTP id 5b1f17b1804b1-490a2918103mr212890145e9.10.1780315498448;
        Mon, 01 Jun 2026 05:04:58 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4909c152570sm103972805e9.9.2026.06.01.05.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 05:04:57 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 00/24] dynamic-debug cleanups refactors maintenance +
 alignment fix
Date: Mon, 01 Jun 2026 12:04:46 +0000
Message-Id: <20260601-dd-maint-2-v3-0-4a15b241bd3c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02MwQrCMBBEf6Xs2ZV0Yxvryf+QHmIS2wWblKQEp
 fTfjQXBy8CbYd4KyUV2CS7VCtFlThx8AXmowIzaDw7ZFgYS1IqGarQWJ81+QULVmuZEQnUloBz
 m6B782mW3vvDIaQnxvbszfdufRv5rMqHAeyeVrElrcZbXoUzPowkT9Nu2fQATd1+rpAAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780315495; l=5739;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=UexA6IlALDsQZOTV0hLwfWpaRW3TbsQLPhPBboqis4A=;
 b=lvmgQ8g7xkH604t4KBSwylbWD7BLSeGoj0N94EqFttk+uNoSZ34wsVJ4kCQjAP+56C7j9e8+r
 8/livVa5JYuDL7dtGrwkxv+mPMASsWpXe10/NQqoJFwX0pqQwFAG0+r
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

This series starts with 2 doc-only patches updating the current state
of dynamic-debug, they were posted separately here, without pushback.

https://lore.kernel.org/linux-doc/20260502-dyndbg-doc-v1-0-67cc4a93a77e@gmail.com/
    
Next 5 are a fix to a linker-script alignment problem in 32bit arches
causing a null-ptr scanning dyndbg-descriptor section on i386.  These
were reviewed by Petr Pavlu.

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

patch-25 eliminates the ambiguity by using KBUILD_MODFILE to provide a
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
Changes in v3:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v2: https://lore.kernel.org/r/20260523-dd-maint-2-v2-0-b937312aa083@gmail.com

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
      dynamic_debug: use KBUILD_MODFILE for unique builtin module names

 Documentation/admin-guide/dynamic-debug-howto.rst  |  55 ++-
 MAINTAINERS                                        |   2 +
 drivers/gpu/drm/drm_print.c                        |   6 +-
 include/asm-generic/bounded_sections.lds.h         |  32 ++
 include/asm-generic/dyndbg.lds.h                   |  18 +
 include/asm-generic/vmlinux.lds.h                  |  68 +--
 include/drm/drm_print.h                            |   2 +-
 include/linux/dynamic_debug.h                      | 133 +++---
 kernel/module/main.c                               |  12 +-
 lib/dynamic_debug.c                                | 501 ++++++++++-----------
 lib/test_dynamic_debug.c                           |  30 +-
 scripts/module.lds.S                               |   2 +
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/dynamic_debug/Makefile     |   9 +
 tools/testing/selftests/dynamic_debug/config       |   8 +
 .../selftests/dynamic_debug/dyndbg_selftest.sh     | 294 ++++++++++++
 16 files changed, 736 insertions(+), 437 deletions(-)
---
base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
change-id: 20260521-dd-maint-2-76c542079420

Best regards,
-- 
Jim Cromie <jim.cromie@gmail.com>

