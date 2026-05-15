Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A12426686
	for <linux-arch@vger.kernel.org>; Fri, 15 May 2026 08:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835517; cv=none; b=JqMm1M5M8yHelGcdpIODirywGqk2OdxWOVymMj12ytwm82D+8kPTGrp6KfxA5zzD4hkUULNnjSLXskXzBc1X9uXUNrQMgMDYzk3FOK/ebm3qIw36tGekALHPL5WfvFwQiaLS0p6zxuoReZBizAu92M/8bd/7OzDBKjnfd5PLJh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835517; c=relaxed/simple;
	bh=kUSow6akBfhQlY1Zb90I/sAp9Gjz8mVUGJE3qqGhnlg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o3qd8dX/z8pw5XS24Rii25m9NM4m7aYd3vg5jgg1qJSor8qrJMmhiQdzdIFhUn85WGNZEe1tb9Xilao5HK4BSjsKOPBkAlt2wHLnPNi0jy0NHqzFjK3QwF58iBVUmZBBfIsN3My06HZTSYP3Lh/zR6DY4QvCgQi9e3T+HS1PaPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3bvVlQO; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3bvVlQO"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso60876465e9.1
        for <linux-arch@vger.kernel.org>; Fri, 15 May 2026 01:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778835511; x=1779440311; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SGQvnLQVKY/YqzA8GEWJP9yasc16ZREqdYGYIRZWIfE=;
        b=h3bvVlQOG7Eg24Qod0XJBa+rpaZWwbEa198EXRNoyuXgmzKNA1xmXb3snNuQilLSqm
         iNLNXVxUP7VZPWIdsQXaF6KqGysFwMBuBu+rgpi0Q3aQ0xM+67HFsJVIQtS756LpK52H
         Ygw2HlhCseQ8bcV6JPcYdjjhcRZa8mQYxzFKNAmJfICseQ43QYrgC/6RHK1oq3lyNsrn
         cXV/KBL6y2pQPrfEinzvz2xqUGvcKiXvErhYGCxODtbR4runMVC2O7jAnRfrXL+COAXi
         iDf874eDL6i8U6sD8G+3rj0RY/6eMYPTqCvBzD06ET33MWUTT/ODLuV/gRLpabISKxw9
         Gc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778835511; x=1779440311;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SGQvnLQVKY/YqzA8GEWJP9yasc16ZREqdYGYIRZWIfE=;
        b=Ul1MNuReLfTtcoPHfHZkWGpB8TBlrgelMw+gxiW0QNhQvh5yf6bWSODCndONNXc4rW
         V47BVRqg02NKHHGGNH7Mv/c9dmvRdVYW20bsOlPDyeQIoRf0sQqeZuDJWDADQaANe/KZ
         EFEhUaWb3V2tonFAaILqY/xJV4QfGBPH/RkhhKxDzFjlcycOPe57/8g2pJXpQrqm2zgX
         SlGzx3ACnV21l/1H89qMOuSGU5afi7iUXkI6RLCRBAhkYtEB6Ifs8pq2+B8Yn/tQn3WH
         TI+EergZB/FL6HpzZ7hb5kz+Up8WIAgGlKTHpewRf21YmLsczxBIGPeUIlnYslyO5UN8
         K38w==
X-Gm-Message-State: AOJu0YyfoWDSrQzfEE9Po+YkpMAjsgn7m+ToF6ipcYqxL8rUJbFn6ZRG
	mAK9MCJGoaVWsbfxjcxh5UDAXfOzVl6WpPKYm0mLFUwQGbbWnZS7bwpr
X-Gm-Gg: Acq92OGaw/2kk8YbSfq4VMITD0Yd5HGWG9O13NnIZFPc13NHHC12GIo5/2D/ErPldXx
	JPDKI8KFlWaIKnltzaYoiGeRSjfIch6dyBANyW14t08qqJ3C5rKDry+VBIkwUCl4iBY0hKbxahg
	Xk7/6/LWNo/SeaR7+e+CmXgRiRuy1Q9H3KomMMH7vG+98U30C5N8kdWBsp7JZ13dj9rvv2PDO59
	ZavOp/rXBv15KB+0peRYw3fhMfuiTyIwL0z3k/RpJitdZ00LVuJjyaQgLGP+96RHw3lPGO64g6x
	5Hck0sueQp1EPI1KxDVpiCllunfxgDK3PthvsD1cSlFmfoDl0YI6paijI+4EStOEG3/Nc+BA56i
	80RGF/KOPU1cvu6TUw88mj+S2YlSuzgW6TTQ8J6wtq/tb2yDP4C3ctt2hb481zUvax/0/IwL4D9
	ZIIxe4u+Gz31ubpebD6FjBJtKaFOuh/LzK
X-Received: by 2002:a05:600c:3104:b0:48e:89b8:7c6d with SMTP id 5b1f17b1804b1-48fe63074edmr39610915e9.25.1778835511104;
        Fri, 15 May 2026 01:58:31 -0700 (PDT)
Received: from [192.168.1.210] ([2a00:23c8:33b9:3b01:f7b1:b7a0:6254:c325])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-45d9e768c4fsm13142610f8f.8.2026.05.15.01.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 01:58:30 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Fri, 15 May 2026 02:58:14 -0600
Subject: [PATCH v3 5/5] dyndbg.lds.S: fix lost dyndbg sections in modules
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-asm-generic-1-v3-5-680b273666d4@gmail.com>
References: <20260515-asm-generic-1-v3-0-680b273666d4@gmail.com>
In-Reply-To: <20260515-asm-generic-1-v3-0-680b273666d4@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778835503; l=5183;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=kUSow6akBfhQlY1Zb90I/sAp9Gjz8mVUGJE3qqGhnlg=;
 b=KNsqVyKxqwSY91LXSENqvLLbOQ8Bb2cS+RTLuSWlHKZ96ZekMdw6xLAlCb23wBDkZCbMQ44T8
 VhpdygpGFpYCuq2SFOE5ecaFO1zMm9SZPj0pZi7bYDAKxRw7DUpINy4
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
index b2040011a386..2ef1e481af26 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9073,6 +9073,7 @@ DYNAMIC DEBUG
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
index 9fa11baf27d3..016ca653232e 100644
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

