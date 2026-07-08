Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382ED3ACF16
	for <linux-arch@vger.kernel.org>; Wed,  8 Jul 2026 02:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783477117; cv=none; b=JB6iNzfJYNLj4knhUezyGuehCskQ/EYlBARHcqoX7N5wih6BbO/ccHBatnY17U2TxIlSDTf97dcxiKb3NFJC4Ttw0iffWATQbUPE4L9Ab2tQxeoN8Zp1b20AbWZYC14QX90zEiPL0YB5YPzyF2LUrmwK3OjnC5dGhTAv3fpqgvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783477117; c=relaxed/simple;
	bh=48IhllGZGlKVUO2aWGnTjwvlc3GYofwCmRrA9ZA4NVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hBpMHaChrbPYrJEJg3SrhDt7n0b7mRKz3IP39yTIeCE+4VJtnHZE/9JpFmheCyRW/O1WxFDI5Ovn+4peWgnpuwIe37sxOGwaiyrSG/pE9e4vcPOzuvLUeaMqEAuDnmF+IZmB4Ebnc84jk3QOO0y2Lb+BZWvCYgFb9xmdqV7UtN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLX+fB04; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLX+fB04"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-489f3611e0cso152830b6e.1
        for <linux-arch@vger.kernel.org>; Tue, 07 Jul 2026 19:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783477114; x=1784081914; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IthTBY0ylXLMf8SIGUJ5qIKEdVrHHeLRSYWe1vKaXJM=;
        b=JLX+fB04EYXM79brG6ppOp22l5FHrRHMZQV3WKPBP7kPXpjgDlhiCXMYcXoZ5n1S8Y
         M9GkFj63HIWDYgdjffTjeM//HkwATw+dTSTi03PGaxgYEVjLwZj5MblF1s1pfkNcHXaK
         aabygfF47CC4TOM/VxDAlFOWK7dFAbluOPEx9EgYIDzqS4+FIU0WHd3ALIcJVdtwmyxj
         lYzuFSAhr11/Hr+I4wG9+FksNUQPMmsIkJzYV0qBrTKRdLqoMkt11uLuTzlcun6LCZvc
         OEOkhVvAOsCLtU4MTv0XF8iqhhLNkiqXGj+JsaQqa2VNNkXuBekZRjlSGYsCgYx/9tog
         GxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783477114; x=1784081914;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IthTBY0ylXLMf8SIGUJ5qIKEdVrHHeLRSYWe1vKaXJM=;
        b=SvNsdSxXepEY7mmhCyQJVfzFG3ylBa0poNsToVsb458PBtvN7d8uNcJ4+28oyJpLOI
         jVJMXd5lrfX9ImL9mN5fr3xw0ftdZVPYKEmGVLtbe0cuenscUaLPdT1qgK+Mrk4BGNKk
         ZADHxYjUVqs8c2iVPKOl7ECXAmH64ahvMn4paI7OQvW9p0+HKy5w/WmK0jC2qBjWgpPm
         fTQ/Zuqv+JOqOLVzrmvCI41cEyfexmO8mY9r37DRuIhdb5eHhBXxmReDIy//uViagpk2
         mA4y+fDrC04ynYf8LHrlqlAFqP7ZzeZZebYnS3t8xJKdCOteP0pX9A+SwgaUFOXgluac
         EfpQ==
X-Forwarded-Encrypted: i=1; AFNElJ8OiaQsUxckvtDcv7jTwblVQZr+ZUrjd+Hf1GSiYP5bH/dLZL79OpHowTrw3TmAzZZzdG5azvd0+eB2@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/vdUexA4bGBGtYywsL7G9IZJJu+UefgQN4KM4GBZIXUDSFc9k
	XnUZfo6N5Hwdf3f1dAgGfX65CMA4U6AQQs87AFNuz9rndNOMN/NK9w+X
X-Gm-Gg: AfdE7cmO5sSkyBSZFEbsa7v014lubdi9HPWsdIXDyViRjqHmQfM6/M2zO46HZRU4gD7
	+y3d0pwboLS0zMamIgLD0iZruvbUyPOVy9C92Y/ATFjytiyIKaKy7MTkyuK95bIS+LtqRudq/AH
	uC7M9x8uV3pojdnbUJ/44RyysmT7edLuuyy1FHeX6JpmHlKwcDRbxOPVNsLzqjOoESXiUL6GztI
	SOuLg0ovCACpTaxBuv/osEfpahF2Hgi8SdP1FFSIZoARW2jJhGmu9qYUFBGBP0Nyyf9wYcuK3lw
	aJRrVaUCzGbmDGbgkntqrPUeNEh+TRLN6wTN9LLGK5JeQuhpIiHdNZovQs3uCXiZblxXmm+og9u
	0RhPNkD6rto0y3qoRxvyDtuZiLJHeXiaWUkHrzfCsDs6M9K1L0SDLu0T8i+B3I32RdwfXYJPxI2
	59NGBZGqNizZW7B8rWCFROIAdNuT8V04yqQcE2ctni1IZndSgZd7c=
X-Received: by 2002:a05:6808:670b:b0:496:233:3c3a with SMTP id 5614622812f47-4a20550e7aemr357266b6e.22.1783477114134;
        Tue, 07 Jul 2026 19:18:34 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4a1aa006f74sm799975b6e.0.2026.07.07.19.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 19:18:33 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 07 Jul 2026 20:18:05 -0600
Subject: [PATCH v6 05/24] dyndbg.lds.S: fix lost dyndbg sections in modules
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dd-maint-2-v6-5-381f3edb0045@gmail.com>
References: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
In-Reply-To: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
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
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783477102; l=5103;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=48IhllGZGlKVUO2aWGnTjwvlc3GYofwCmRrA9ZA4NVw=;
 b=Dgizoa0dMPSdWw/1QoGENMuIOfcE8tq0L21huZWFCgpycKW/rvEdNeHdmYrS95ivvI/cPN5kJ
 u5IiJbf/JjpCiBg7YzPsfmrYDeeyKHY4bBZ0VGqN9CxkGLi5wofxlym
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

With CONFIG_DRM_USE_DYNAMIC_DEBUG=y, several build configs had
problems with __dyndbg* sections getting lost in drm drivers.  Fix
this by following the model demonstrated in codetag.lds.h.

Introduce include/asm-generic/dyndbg.lds.h, to bundle dynamic-debug's
multiple sections together, into 2 macros:

vmlinux.lds.h DATA_DATA: move the 2 BOUNDED_SECTION_BY(__dyndbg*)
calls into dyndbg.lds.h DYNDBG_SECTIONS(). vmlinux.lds.h now includes
the new file and calls the new macro.

MOD_DYNDBG_SECTIONS keeps the 2 sections by name, aligns them and sets
the output address to 0 when the sections are empty.

dyndbg.lds.h includes (reuses) bounded-section.lds.h

scripts/module.lds.S: now calls MOD_DYNDBG_SECTIONS right before the
CODETAG macro (consistent with their placements in vmlinux.lds.h), and
also includes dyndbg.lds.h

This isolates vmlinux.lds.h from further __dyndbg section additions.

CC: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
v3: move #includes to top, drop extra ALIGN(8) in DYNDBG_SECTIONS, add RvBy

v2: Address linker script review feedback for relocatable modules.

MOD_DYNDBG_SECTIONS() used the BOUNDED_SECTION_BY() macro, which
proved problematic for kernel modules for two reasons:

1. Unwanted Empty Sections:
   BOUNDED_SECTION_BY() automatically generates `__start` and `__stop`
   symbols. When applied to `MOD_DYNDBG_SECTIONS()`, the linker assumes
   the sections are populated due to the symbol definitions, forcing an
   empty `__dyndbg` and `__dyndbg_classes` output section in every
   compiled module, even those without dynamic debug configuration.
   Since the module loader uses `section_objs()` to locate data via
   ELF headers instead of relying on `__start`/`__stop` symbols, these
   assignments are completely unnecessary.

2. Non-zero Output Addresses:
   During relocatable linking (e.g., `ld.bfd -r`), omitting an explicit
   base address causes the section to inherit the current location
   counter. This results in non-zero sh_addr values in `.ko` files,
   which is confusing, degrades compressibility, and can cause issues
   with external tools parsing the ELF.

Fix both issues by dropping `BOUNDED_SECTION_BY()` in favor of a simple
`KEEP(*(...))` constraint and explicitly defining the sections with a `0`
base address: `__dyndbg 0 : ALIGN(8) { ... }`.

fixup-inc-vml
---
 MAINTAINERS                       |  1 +
 include/asm-generic/dyndbg.lds.h  | 18 ++++++++++++++++++
 include/asm-generic/vmlinux.lds.h |  6 ++----
 scripts/module.lds.S              |  2 ++
 4 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4a8b0fd665ce..25400fee9f32 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9178,6 +9178,7 @@ DYNAMIC DEBUG
 M:	Jason Baron <jbaron@akamai.com>
 M:	Jim Cromie <jim.cromie@gmail.com>
 S:	Maintained
+F:	include/asm-generic/dyndbg.lds.h
 F:	include/linux/dynamic_debug.h
 F:	lib/dynamic_debug.c
 F:	lib/test_dynamic_debug.c
diff --git a/include/asm-generic/dyndbg.lds.h b/include/asm-generic/dyndbg.lds.h
new file mode 100644
index 000000000000..9d8951bef688
--- /dev/null
+++ b/include/asm-generic/dyndbg.lds.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ASM_GENERIC_DYNDBG_LDS_H
+#define __ASM_GENERIC_DYNDBG_LDS_H
+
+#include <asm-generic/bounded_sections.lds.h>
+#define DYNDBG_SECTIONS()					\
+	BOUNDED_SECTION_BY(__dyndbg, ___dyndbg)			\
+	BOUNDED_SECTION_BY(__dyndbg_classes, ___dyndbg_classes)
+
+#define MOD_DYNDBG_SECTIONS()						\
+	__dyndbg 0 : ALIGN(8) {						\
+		KEEP(*(__dyndbg))					\
+	}								\
+	__dyndbg_classes 0 : ALIGN(8) {					\
+		KEEP(*(__dyndbg_classes))				\
+	}
+
+#endif /* __ASM_GENERIC_DYNDBG_LDS_H */
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 3758a79d0430..bd60f278f762 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -52,6 +52,7 @@
 
 #include <asm-generic/bounded_sections.lds.h>
 #include <asm-generic/codetag.lds.h>
+#include <asm-generic/dyndbg.lds.h>
 
 #ifndef LOAD_OFFSET
 #define LOAD_OFFSET 0
@@ -344,10 +345,7 @@
 	*(.data..do_once)						\
 	STRUCT_ALIGN();							\
 	*(__tracepoints)						\
-	/* implement dynamic printk debug */				\
-	. = ALIGN(8);							\
-	BOUNDED_SECTION_BY(__dyndbg_classes, ___dyndbg_classes)		\
-	BOUNDED_SECTION_BY(__dyndbg, ___dyndbg)				\
+	DYNDBG_SECTIONS()						\
 	CODETAG_SECTIONS()						\
 	LIKELY_PROFILE()		       				\
 	BRANCH_PROFILE()						\
diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index b62683061d79..2e62dc5bd5d4 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -10,6 +10,7 @@
 #endif
 
 #include <asm-generic/codetag.lds.h>
+#include <asm-generic/dyndbg.lds.h>
 
 SECTIONS {
 	/DISCARD/ : {
@@ -61,6 +62,7 @@ SECTIONS {
 		*(.rodata..L*)
 	}
 
+	MOD_DYNDBG_SECTIONS()
 	MOD_SEPARATE_CODETAG_SECTIONS()
 }
 

-- 
2.55.0

