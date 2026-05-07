Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0A131E106
	for <linux-arch@vger.kernel.org>; Thu,  7 May 2026 20:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778186420; cv=none; b=RKLZI74b5fdpbK6wG/ojWxqRP8WmigSsxpKrrHvge+DaUF403IDuzDFvphkjlJQ90Pvi3T+SNG/ZA0zLga7aFyaEyN9jMzmJk8Vqc+dgK6S6pwV/onlgufT8IjY/TLLU3VjgwGtbijBneoJokvzCUn00jZXT+6COvKuoWnBf15I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778186420; c=relaxed/simple;
	bh=LQHJZCxU6Q7ooi37BUaV02Qq/f4agm5h2b+zuvE79OU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FEqppKAeUmaue7H27D7Pswx2E4x1iIJ7yaaSCZJp7GQOkWj9htIHS/nlwr4SgowJo7StxTSCFdBFUFkpq1wyarCDAoT2HAbG+6WcScTTmqxXdpg977Glvsg9pBz26LIwf5ZKYR/p9qijmjF43CcBzaNmBkgr6omgq0KdRzZgKGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWauzlgf; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWauzlgf"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48909558b3aso15360215e9.0
        for <linux-arch@vger.kernel.org>; Thu, 07 May 2026 13:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778186415; x=1778791215; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I5Ah0oz6fw0sPiyZmy/m/dxlaFmzyQ2PaO1MKyQmf0U=;
        b=XWauzlgfzlMVamEYd+xiW2N8oOQrra9fd7OAxtPxr8uSYggHr7kElNcRdHVadAGI/v
         jP7Jb8UXgtWbjIWuNrqW0QhLl74hcvkyVtDDrRvQJtdpfLlcTj8UGgDc0GX84ju0M04k
         5/Ws6vEfSqGhVQcu7QsAx7hmg0ldr/MgsZ0ReeXSSCCGLYp7R8z8+kxw/yxLNTD9XSnL
         TERLPf+DgUSF3nvI0SmIn2k1c+aAWojON9tO7Mfyp8XVtwAHY6jNt/uhNY7rYbXMJCZC
         fGSBXF98CUILCF3zCZnSqAcv5BJA+HGxtBYNE0fePLtVMAoFt23h2y1QKIreOZ/mOA6N
         ms/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778186415; x=1778791215;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I5Ah0oz6fw0sPiyZmy/m/dxlaFmzyQ2PaO1MKyQmf0U=;
        b=HBugo0G11730rqU1U3u3yUB7knhW54J4iYliq1ymYi8pQBNG59VZM2g49FHHBJoyp1
         Bh9arDpKWMBKXj4wjaaj1xFUSHawHrm+pnq/363EBQCglE3gF6I/sUFiPpDUuEa8i4o8
         9m8G9tc6KI+865/swa8fEGDT8RCVtv3pgVCWYMBEwaKlh2tLiDD9tnFWQeYF/fVeAehb
         UVjexIjam1aNC0Wgbq4HSfUmhw4AAaOdZgFsBIUQ3zxddpm2Vh1aW5zSgCS26n6OLFNa
         APdpmxm7KU8ljkFY8A8yGW6Tm+Ivpr6p8OtWs0yKhJhRcCzBh/HorwY61hCyORqoQ1O8
         fIEQ==
X-Gm-Message-State: AOJu0Yx1e0wWJATyr23pJGBkeL1Bfdrx1zpVkKZx6bpkX6Yyg3VPNZu8
	VsmKPm8H75aWGFssTRMKnRG9ztJ5KJjOKc1cN7mgGX5MhyBEK8q4SFGu
X-Gm-Gg: AeBDieuyLgzBKknWIHLOApcPjSWGtXFUn4CeywU6MH9O+fAlAswvqlvBWDnpO90amLV
	kst1LNaNP1uijdX3UcelOXwYzX78KHEIEbRYGs/hypGq0rhXN925VxrqcGlYV3XUti8nAGRnOAL
	vcU1dT6i80dTFoEZg0FQzBG8mcYgduyoxNrx/0n+HmzDtgIVfirXlv/BjWYsVIU6SeEkxGZa/Qv
	E8hS2FYN1Vu07TjUWwrE+albwo17fEwqdF8nkc7o1bHxNyX8kqlINO+58X74gBUM/HDmYaE7Tqx
	TpmI/hbKSLeynrVIxcOln6ejcgZyaoQjjQKj+4aqOIF7OpqZWrIBdmDd9Y6vwU11vW7bK05bQGr
	7tUmV6Znu1AuyPvJg1KA4wGHdnnO1NqEPoOvvkuiXs/5uqt/pGfoWWmvKBf1mLC7/AdYtgZWO66
	3zuoaaIhWXm2ZKYQxqMdWSIDzqXAw3
X-Received: by 2002:a05:600c:b8a:b0:48a:5574:3a48 with SMTP id 5b1f17b1804b1-48e51f32bf7mr156015195e9.16.1778186415446;
        Thu, 07 May 2026 13:40:15 -0700 (PDT)
Received: from [100.82.231.29] ([185.57.101.106])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48e5382a327sm264367515e9.0.2026.05.07.13.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 13:40:15 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 07 May 2026 14:40:09 -0600
Subject: [PATCH v2 5/5] dyndbg.lds.S: fix lost dyndbg sections in modules
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-asm-generic-1-v2-5-47c52759d268@gmail.com>
References: <20260507-asm-generic-1-v2-0-47c52759d268@gmail.com>
In-Reply-To: <20260507-asm-generic-1-v2-0-47c52759d268@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778186409; l=5042;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=LQHJZCxU6Q7ooi37BUaV02Qq/f4agm5h2b+zuvE79OU=;
 b=mJYphSTpVC76jOzppfFoTvmZdzYnOuVDwN/viBxLujtKCjutc8Sv0WKtsaL6KIwUgcvmeuVcZ
 piM03q0cm44CiV4/R28PNLheZfLkvtBJes5hv9/L7zlaNtGAgijTU1o
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

MOD_DYNDBG_SECTIONS declares the 2 BOUNDED_SECTION_BY calls, but wraps
them with output section syntax to keep them as known and separate ELF
sections in the module.ko.  The KEEP fixes the lost section.

dyndbg.lds.h includes (reuses) bounded-section.lds.h

scripts/module.lds.S: now calls MOD_DYNDBG_SECTIONS right before the
CODETAG macro (consistent with their placements in vmlinux.lds.h), and
also includes dyndbg.lds.h

This isolates vmlinux.lds.h from further __dyndbg section additions.

CC: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---

v2 - Address linker script review feedback for relocatable modules.

v1 of MOD_DYNDBG_SECTIONS() used the BOUNDED_SECTION_BY() macro, which
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
---
 MAINTAINERS                       |  1 +
 include/asm-generic/dyndbg.lds.h  | 19 +++++++++++++++++++
 include/asm-generic/vmlinux.lds.h |  6 ++----
 scripts/module.lds.S              |  2 ++
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 882214b0e7db..54bb257b60ee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9070,6 +9070,7 @@ DYNAMIC DEBUG
 M:	Jason Baron <jbaron@akamai.com>
 M:	Jim Cromie <jim.cromie@gmail.com>
 S:	Maintained
+F:	include/asm-generic/dyndbg.lds.h
 F:	include/linux/dynamic_debug.h
 F:	lib/dynamic_debug.c
 F:	lib/test_dynamic_debug.c
diff --git a/include/asm-generic/dyndbg.lds.h b/include/asm-generic/dyndbg.lds.h
new file mode 100644
index 000000000000..844f1cb82020
--- /dev/null
+++ b/include/asm-generic/dyndbg.lds.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ASM_GENERIC_DYNDBG_LDS_H
+#define __ASM_GENERIC_DYNDBG_LDS_H
+
+#include <asm-generic/bounded_sections.lds.h>
+#define DYNDBG_SECTIONS()					\
+	. = ALIGN(8);						\
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
index d9d2eb708355..54897d742c6c 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -332,6 +332,7 @@
 /*
  * .data section
  */
+#include <asm-generic/dyndbg.lds.h>
 #define DATA_DATA							\
 	*(.xiptext)							\
 	*(DATA_MAIN)							\
@@ -345,10 +346,7 @@
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

