Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795301379;
	b=5PgDyS5ej5zC9LyeIxs+5/whQgZ4Zpxe3Tfh2gTXtzB/exQ+h0wji6liil/LUVMv5KPj
	 m3WUK16k0BlpRSBt3QnQRbYFqZPK2DzznmdFwrM7BxAFz0+KcN/GT2nj5TTwudSJXYs9l
	 QBenK4Ovocs1wDYv9dzhBUVFS5SNaAwr/ZSgWq3UO0yjmXbiskCbA683UYB+9aMhunSZ8
	 zzfgpjkdufJVsLNCSG1dTBfX8dYkiIf5kg+naaTzbEgvqDUQSgqh7H50Q5esd8h4TNWH7
	 3Nvx1k/DL7yWa8bFQN0qs14KnL0Q8gZA0J9B2KU1O80Ket21i/1+dco92/8WE+Mdk6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795301379;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=UTT8OkObfe6cRhBlKhj1MV4E7XO2MA6bMUAmOfnMFEg=;
	b=MQr1J94nIwJTT73Ryr2xwOfxmZhVil6vH/5NXcr9crcWhWnDXzQ5en6PxG9YwggJ0MOc
	 Qa4xIDah1pk48vWdRoIpL7SKrZUDVL6PGWVeBM9K1gOy4uEowz4tBPgblI+kddFTfvy7X
	 20DtT7Rc2uLVTaLaewA/1T6ATbRnLj79Zy0uxS0rT7xmKYEkOGlXbNk0cdEUEw57+6SMq
	 PKhEAL53zk6tWq5I28Kub220VaD5ryP5mF0i2GmBVLA4Xrxxlfw+jw47CtsVcH1rzriQp
	 Y4hw0SK4Z6PyjjPiiOTukOkQc+ELvBCHT352Kne/n+YdcJKZxkpuvy59rO3GnltwT/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VnyfW3nO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF56606A690;
	Sat, 21 Nov 2026 22:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VnyfW3nO
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795301379;
	b=jLnJbnADuZ4wAWt8au1J192Lt9wa+bwB0GGIaqGBbgiYQpaejFoPMw5OW9KyH5R+hn6O
	 6e/du29p4K1oGqO9ALKLOstag/OCgjeIaFyFK/GkGEzW5ejAaN4syxQ8a7XpIlQI1j2WO
	 jm3ovPiYxmOAM4xTpdBVl23JlOwudLDlHW8c+BnS6Ie4KIPJlNiSBBYqCv4uoZC2gG3wR
	 FLnoyK1wlBUFJMTYZUsjEPjTTK48NhSVvc2ZN5Q4yHTu2azyIsphrRoG2c93RwGDx47SL
	 jCtIml8yWzmno4/nyAaJd+aPs87hv0u5sUrYUugx7cJr7ALtLMKn2oUQ8EmiNyL6eRg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795301379;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=UTT8OkObfe6cRhBlKhj1MV4E7XO2MA6bMUAmOfnMFEg=;
	b=hsqA8J9aWl3/o4J2vgDjvj6bXPmzaBB/JrgdVuBt2qX9IB+Nt0K7N8zQd5MAsWKKN5+/
	 Jiu7yBFidtVSrEux3TD4xRT5zoBqBtTy3GqzqEZNPsErMdcnHo0sgSictlMVl+LecpIbF
	 BI9dGZW3FIjweRps84qgSHk/x8IDzdojLCH+0EwOkofm8HQKG85oC8BcZgiU5bQ6GtiZb
	 gl4KihPS8N50qXpKvNeDn0QwYg+15jZuZAb/cAkG7gF/2iGNmLdzMgxDuByZjTug+37RR
	 +wywqNjjesUNtDOzYrFY/cvYWZiHrBcKfPQiGAwrTyAbHQsd3DUtvPmCS7p0xfVQPtA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2A1101F000CA;
	Sat, 21 Nov 2026 22:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795301379;
	bh=UTT8OkObfe6cRhBlKhj1MV4E7XO2MA6bMUAmOfnMFEg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=VnyfW3nO7soR0i1D035+F4GuV13+jGW/aPaTro/qL9EyF8AnlSe50+MzQMJJmtlzO
	 LCDwaZgzAjhlykF5R/gere75pcIz6p1Ebrd7usgKK/mp/P8PkOKQt60lRujzjn9D1t
	 c2kVlGFKRxVdJQq00njgtBkX6F11km+R7/EVCUJ9TZsXwEHIUGRDaEYfvWUM+cSG0I
	 vMzpQqt8upNmPFxnEq3tMUqEesh8mPvokqMbk5d30MN2pih3WftwKEmQhhXbkOErZH
	 ueiI15oWitB4B54+ez84Uyw4GVdJsOHJg2zUAOBclPyPkCAm48O4i9dSNFTU60VWSK
	 LJwsYCDtj5fpQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id F3B1D4BE62;
	Sat, 21 Nov 2026 22:49:36 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Sat, 21 Nov 2026 15:49:23 -0700
Subject: [PATCH 5/6] dyndbg.lds.S: fix lost dyndbg sections in modules
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261121-vmlinux-lds-v1-5-49818f3f5cc0@gmail.com>
References: <20261121-vmlinux-lds-v1-0-49818f3f5cc0@gmail.com>
In-Reply-To: <20261121-vmlinux-lds-v1-0-49818f3f5cc0@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795301375; l=5098;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=VzsP1ToJjgJAp9UDySI4ByI7IFGoSIBhUQQ/fSWeluo=;
 b=h9nzpVBJz4uteoBt80zsnV8Hf8iD65fBRGPhEl1a7wMNjtBsi3JJdv5oAmwCjD1fWaqxP07yN
 KYMQ6K2FvMyDP96lanEiubSsDTBHeEg8xJq9Dinx07RL1lSzVaI6WnR
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com
Content-Transfer-Encoding: 7bit

From: Jim Cromie <jim.cromie@gmail.com>

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
index ccbcdc0799b9..1acdf6e8b30b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9505,6 +9505,7 @@ DYNAMIC DEBUG
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
index 20c49684d89d..f2f29f2e4e6c 100644
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
index d0f200428957..5950ff8edc31 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -5,6 +5,7 @@
  */
 
 #include <asm-generic/codetag.lds.h>
+#include <asm-generic/dyndbg.lds.h>
 
 SECTIONS {
 	/DISCARD/ : {
@@ -56,6 +57,7 @@ SECTIONS {
 		*(.rodata..L*)
 	}
 
+	MOD_DYNDBG_SECTIONS()
 	MOD_SEPARATE_CODETAG_SECTIONS()
 }
 

-- 
2.56.1


