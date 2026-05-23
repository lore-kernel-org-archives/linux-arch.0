Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE2E346A10
	for <linux-arch@vger.kernel.org>; Sat, 23 May 2026 07:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779520505; cv=none; b=AndoaErk5q9RscYSm9pIorEsd1KrjTPmVKXk9BN86Qprc/NAscRmEJiZyF+osyEieAlofIl58xXOj/cB1o9c6aBatQiaL9rPU1smYGKr/Q0Zm28/tKckYVEezffcp3+jibHf2ve3h6spTNn07zvouGiZRhyf1+27b2b909KZNOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779520505; c=relaxed/simple;
	bh=hHbUbuvMq67kK92AX9bALnGMbnsaNAMLaVZBi9x7aP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pNsueYfj5GOZydKcuAv+H4Lcq1MJRTfrKldAcUSN8xnwgbTrykI3sSgnj7G2i3mNp/WUnjWaH9rZ54zCxQmOlu5q5DeCrC/czSly+HRNmwT6BeF0vb3tc1Q4eZN9rG9kMqsynXnwPpQuIn3o6F0TFwUGr+XRL+TaUyWK9wIpNFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kp/FpIu+; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kp/FpIu+"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4904c1ce4c1so8497915e9.3
        for <linux-arch@vger.kernel.org>; Sat, 23 May 2026 00:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779520502; x=1780125302; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IqFCuVgcu75FRpSrJUke7IG04IUYAp0EBZ0uoXXXPv4=;
        b=Kp/FpIu+JAHdDvxgWdnucmak6TkclLWGfWO/H16/85ZowDKcN2fTKmZClTk1/r7dJW
         RUeRHT+S1vXJWleeHj/lq9D1Lx1oeuGzkbhYLx5e7csyo6IpUGitglrXc78b6UWwqsbL
         Qt0HbKJtrOt/13xLp0G9pkDtBdPTugo5UmaxEdQuf7jEd4sGXj7tZGQ3zRx66LaCTEdh
         pFYev8te/Ed690UNbWT1e/Gcav8DK5d0Voyut1DMW+J7AmRZOOLb3Id9CbvAtpcdq9wn
         +voUEvkDOZGcI1vt9AF+jbfxJzvxRgU8AdH2Hto3lH6uw6cbNFfmvgOm8lU87dOLXpso
         JSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779520502; x=1780125302;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IqFCuVgcu75FRpSrJUke7IG04IUYAp0EBZ0uoXXXPv4=;
        b=Q/w1T9jVmTiN5rBpoS3J8PIaPygYCjh1bzHn3G/QlUwkNrfg7atPqyg+Uutcm+BdR9
         xLZ/Bmp8vMoHKtT76bQqxi1WsFEf55vkg7scAy93PQUhHirJMrSe+uU6t06rM5j1wgG7
         oDZ7KmRWJ7qgRxJqxy2MtZLDNwUI2oqbzW1Vqmvj/N09I0zLKCdzhoGsz5/sNYRZAz4l
         L9A6XKEjIFAKHX1ANvBYDICPCzc0pVBvh9fjwrAZBgOtrToWzHAqgkgZJEjChlJUOr5v
         85nrCN3YccTMa1hfhTTdIcp93c+t7iXFHDTP3OKKvMb//ddyY9bLRtY08X5tutJ4wN8j
         tAkA==
X-Forwarded-Encrypted: i=1; AFNElJ8xb2SUR8ENak0nQUj6kHsQV1KzLBFkwDItQU/CZLMhLK5kKZsUmV1Wb8oMMjlyN4Q1ZuujSa7s2XHT@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5AI1UhxWuRObHdiVMDc+gyZeh+j//5wnWz+/MNoaW5CSb3r2h
	qetvXIkcecM8ey1U7yKm1vcDXT3m74P3tGh3ObiBs9P8BKCfhKsQe+7k
X-Gm-Gg: Acq92OF4O4LNdxbRjAOMuYBv6Ep3w1Pbz/Enwqop9bKHccwtczPUlSZWRu/4RA740ck
	bgiTFU0JCZBJD3ikcGpcTan3eduGaoNAAipR5XaeH1zwBvB8MBSizYV7vg/I9+rUplXouwFAWBE
	aKHCk/SFhuqRpxaEcz6YmXCZ0ZHp01TwZYhsDmudpoBXlil66ssFU5KeSFWTX/9Sc7BMBrLEfj7
	GLnw0xtE2hOeDK2HDEVR/ml7B1uO2NmWGQmFo3XM7FsIZ4lwWiNWIPDIrzSbE+LJsVXNlx8qJ4b
	9CfbTi/DpDkobnZlo/+0b1eViAakehDXtVRzfiYAw1lT/zx+QSWne4i6mjjlUi1HkFksqPlgCjM
	rWr/Qr1dc2qyGwl295ss/4F9F+A7KrxkVZlf47rJRmsuHUFxC8/sMAn+oQVl831zrXcPdP/3WJ1
	/ZoBR1EKnj9keS99FnS85ARbmbYJYR
X-Received: by 2002:a05:600c:154d:b0:490:44eb:c1e4 with SMTP id 5b1f17b1804b1-49044ebc273mr92866025e9.26.1779520501613;
        Sat, 23 May 2026 00:15:01 -0700 (PDT)
Received: from [192.168.0.174] ([31.96.183.250])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-45eb6d5cb76sm8639838f8f.25.2026.05.23.00.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 00:15:01 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 23 May 2026 01:14:40 -0600
Subject: [PATCH v2 07/24] dyndbg.lds.S: fix lost dyndbg sections in modules
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-dd-maint-2-v2-7-b937312aa083@gmail.com>
References: <20260523-dd-maint-2-v2-0-b937312aa083@gmail.com>
In-Reply-To: <20260523-dd-maint-2-v2-0-b937312aa083@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779520485; l=5103;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=hHbUbuvMq67kK92AX9bALnGMbnsaNAMLaVZBi9x7aP8=;
 b=qNGOyDxAj678uYPPSb3AMv+D39xUv181s2qeCaRNn8MAS2/vJ951M1OnGqV9FrNQYKjM0c4e3
 udMiRqeIIYUCrA8M36uQ1otlhDsqiqVZChLkGkRzKDAM2Rg1gLLaJ7F
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
index c2c6d79275c6..e87bfe2e9e62 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9079,6 +9079,7 @@ DYNAMIC DEBUG
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
index 0e4677b71d16..f2ec36a35809 100644
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
2.54.0

