Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D74413D82
	for <linux-arch@vger.kernel.org>; Tue, 30 Jun 2026 18:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782844693; cv=none; b=Cd3biTP7xxn0wUkfFdhlm/zHY8dAZASbV1zfaGONuM1bfn0VZ+6qG/0cjbCGbHqwn5AWgahYewMlZwHr5ZmrZV0S0Pc9nqUkgDk8VN4pe4a493EZQZ44Jf4NivqUuD141Wp33CjOeDVXTheBSizRaP/70jNzSpUlImUUNmB6sfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782844693; c=relaxed/simple;
	bh=hoC09ruaTFT69doGplUgeUIsoPbyQFsimJQmBj3k34c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LQcdUBa9bkmgilS9rwXSESRSbEuHDRSWqvg4pj+8wmep2b+mMW2SqmIKivDPBMJua0vaWJWy+IDrPBg1su4PYdKqDY0tZpyLRT1m6vp5D+8elBvr8OhXlfo+5HNjJI2CRvN3FJed0+fUg04zXIHDRhP+NiLSicD3Jeu1earxNF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzu50aqz; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzu50aqz"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7e9fa42f08cso446539a34.1
        for <linux-arch@vger.kernel.org>; Tue, 30 Jun 2026 11:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782844686; x=1783449486; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b65anD9BuvaOJmgxeV/E8/NGlo1JDwrV2r97bE3ThlM=;
        b=dzu50aqzEfLU+c+tFooIZzoOCR7p2LS3UZktfURRIee1gIfIoXorjPB7WenSNkVcU5
         ocCZXRseTXELT900UJt1fmFp2Yp3JxQbaCUPvWlRzHFe2RLRN32Tf7/nT2XAv73zVNM8
         87M6GC5C6AN38NEHDDaecXg9JccQ7Xtxe7OrHbpaeVtyfijWpSeVQPfiLoKInBw0z7+o
         wFogbVKqBYROYNFBcP0p3rAqHRtVQu+JXToP2uVIYwKofLZ+cYr5De+uiKn+8zgSKtne
         SIUMZxSv1uEkaG9mNLXFzeQoVTHBTmi0ytMLdeCrgAeTAkKV1cIrQM6gHSksCEPl8hyh
         IbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782844686; x=1783449486;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b65anD9BuvaOJmgxeV/E8/NGlo1JDwrV2r97bE3ThlM=;
        b=XtKChSnWfuVZ4caXqxtAqMAAlC0ZnLh2NuxDkSIBeiACgcKS1R8/echqEveGSyyx2V
         vU8V4Jzz0TyviGwfX6/RVU+OqO+RNFrXSJofMaCJeiRjIQb0HC/ozCFjthvpeaUa2q22
         lZwiz+DuHhorxigpsSNpBITlTBnDBeXds59cMKwDPa1Zv2vKRoy5av/CkZSNZ6mZczOw
         OcBkpt/Wy5wZjX9RVlbIXafT6HO7x0qqpiN7MIV1ru63LX3I8Tj0pMhwxpv2PPDqK9Ev
         1+MX4EbUZWeWe6oF/GM9RbhBTDlm1kLAjL9H2XQPH4N9H9OD5WDRjZDlqeT7pvUtjI5O
         2MsA==
X-Forwarded-Encrypted: i=1; AFNElJ+HYQGbcv2zSExCoQYtU/+exwvrnf+lomNUORSibMHC4KY7wO700N4/u9nPTNrTP4i1FdicyPF12WVb@vger.kernel.org
X-Gm-Message-State: AOJu0YxP9+ineasFNye3nV6o8SJUcQkwvB5JQyCl+GKTqVQjtzwjrRDY
	0/aMaJeyHZxxUf7wm+XG7glUCOxO16s/2pU5S19kppjn1zls9lJ1sUwg
X-Gm-Gg: AfdE7clQ7MVZWBzyi6IbsbsAfD7CQuPNuq9+2oLSxHUELjsuF4MFF3c79Mw/jRO7JrL
	yggkVKRkn5BQ5YKbiPRzkxSR8tHDnLta55ujxciRrFH1Mu1CJaFuNDYiKcpQ22aPuHPtCr+kdtW
	Woa/Tserpt91g43LvJfIW54Xh2JQCyJaZftXipyMt7YJQrMcwlN5AEqxVKAAvRT25wcmhYggag/
	bkdbd4dnk654MZ0KNb70UlnUV1z26KDr+/jPWrp48Cti35VXDI/1oeo11OpQl8LJZUSDUoWFdql
	77fe8i4pvjoiHELfTRI6wwHhCa+qJkUEIkHoOQ4RcYWbj/xIgD29dpqkrNDifU2oJmynheyIbnE
	+5rHIezETP5ayuMWQ5xlUh+L7E27UzdmYHY5RkAlhDfeHAq29Pv+hsu+EnfXhn+6YfXta1MlT6u
	xigTs7p7Ypr3Q+ufnnI9+yHrN8INLWgb4AHnoVNN3D6mAkiM70nvI=
X-Received: by 2002:a05:6830:61c5:b0:7dc:d2ad:fb17 with SMTP id 46e09a7af769-7e9ec71820fmr4379028a34.20.1782844686104;
        Tue, 30 Jun 2026 11:38:06 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7e9ebfd6ccfsm2940025a34.11.2026.06.30.11.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 11:38:05 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 30 Jun 2026 12:37:54 -0600
Subject: [PATCH v4 5/5] dyndbg.lds.S: fix lost dyndbg sections in modules
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-fix-align-v4-5-42e6ec883342@gmail.com>
References: <20260630-fix-align-v4-0-42e6ec883342@gmail.com>
In-Reply-To: <20260630-fix-align-v4-0-42e6ec883342@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782844678; l=5103;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=hoC09ruaTFT69doGplUgeUIsoPbyQFsimJQmBj3k34c=;
 b=JqM++F8Z5lD89pPJJlwRxqb15MODc0Eml/zw43zB31ivt3aYcSusufSMz8JwZ8ZNgQBTXu7UJ
 f3hbthilk8rDMSnPQsasbcBPxv+d0HqlTxywE1nV0dvdNg1RZo+WcSo
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
index 15011f5752a9..cfc2695d9bbe 100644
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
2.54.0

