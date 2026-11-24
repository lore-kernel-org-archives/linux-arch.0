Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795483856;
	b=F81QHco7ITgTXzrZAq8VMAOqCZjBPQirGB4Cmaz1P0JIpE2Xo04T4TzityDZCl+g7N9O
	 Swh8Iacj1YNiDW5/vdPLNKmujHidPFPShTsZ0ugSBIqCMWCtm7+KLPLJyOTRBMe3fZB+Z
	 lmjdd+LJ2FA+ukXKj+INGJQssrCchftiepE2GNM7ZZfAdCVGkdvCrcOWX/H7/HA9yN8X6
	 Koub2AfKDYF+X3O4vjLRlL8qF+sjmu9fvd1yxrJkVaHG9Ceu3ulVS5UbARIxyn7QOUt4r
	 cWiIKIHL2+p2b6B8v9RXplRUthCTw0nLoFL20Y4Cs8xVVo6GwjPQroiNmQe/0m+Xwjg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795483856;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=I3SJCEeBCqQgX6ak1XXgn0YAH8Pq6WGPMKjeQmqrm/E=;
	b=ldDDL5IyQCrgQoGlrTDbSKBlIAdKwddW8w+xBie8IMAhPLJC7xie9lQyqKJchfB/wped
	 SpcYJhAvDStapXGZAJ57I7M9CIfkWInn05v9Y4Br9GLPaBLL9CCuzf1ww6pRiIerEwwbQ
	 10Uvl+DykJPNz7JconLMztbbMI/uG+ml0bov/JiqpDPy/AwKkNixAX2CkSumfu7mtvOoe
	 qhGtmFnHtjVC7DKBxJLyMxsg6odOjvWBrXMYAo0Mvj1o6a0dBH3nu4x5086+2aISYZ4u6
	 xC1OWYZBdVRZZ53qQLcidvXkJPeOxakslT9Ts91n1pptMwXIkI64gYQzVu3VLQnyv6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b0c77cK2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB07606A690;
	Tue, 24 Nov 2026 01:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b0c77cK2
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795483855;
	b=ugAqDQK3quVP2FqyWJo8y+VP2Xfn1qsX5SUAS7a5Iprkt74Y+5d2ieT/PjMmAn1ceiuI
	 Q0uxrEpgHp6m1/jPxhE2QKlbjEHvHS/TTUqr64kMvVsBcijMYwjQp7/m4PfVSRat0yjb3
	 05m1ACyKtQ3RSQThOHedKp+vTA80LvFKSfaNLPj9E56pCzVx5nl2AMNmwSZoQHs77B4dk
	 sfYu7F7Qzpvwl13Wln/fo/UdRX/I5g2G/qa3VLMAxDSuEu+kLH/TApCDS7M0F1+HFdPbe
	 ksvhZbDZkxh1u/pSPi+e1dkJvnehQOVzN+ZYWNdq5n2zpF8lWJ0NyboPakBsVSF6qIQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795483855;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=I3SJCEeBCqQgX6ak1XXgn0YAH8Pq6WGPMKjeQmqrm/E=;
	b=STvxidLnT4moIBGHxCRE7UTOOk5RFNXPxF7cOZ1QxLUZdQJi1+I6z7ZqPXpVJ118z9EX
	 vEzaelOkEWAoU2iJRADmdUmnyUjKyqsfQbIS9jrzMd6tqgkb1A1rJdrXaZz4ZbEgD+7HK
	 anoFvOBPOut0wB9SHXS7G532OV1zjgk8VbiUD8lL0RzB8XmqKvhb3w+p3RnfL3btAN1wH
	 yo4V9jIWSVkl6zTSWzi6fA4cUMYE+7lRBjJmpLb/70SsQyvkpqjqbhpQa4Z1TeDe9595e
	 akTpvqVrKRB8jRe45WI6P7VyZO5H7AtmOUoeZbDnD4IbjII1E6UZ+p0ivpmREXpDxPQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E34171F000D3;
	Tue, 24 Nov 2026 01:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795483855;
	bh=I3SJCEeBCqQgX6ak1XXgn0YAH8Pq6WGPMKjeQmqrm/E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=b0c77cK2a0unJXqU4q9WVk3NDvlOQch71ZZfDusCEYZ6bnPZtl4lHhQmV/UyL4K4O
	 P6/Be9bTRjmyHWyUXQNEEFw4IWYmYZQP5Ya3b6BRr5PCQ/ydlb8F1+yPt7u/wd9HPX
	 pf7UQYlzNXZ8dxUwtkAjg6bFgV60zMHEwMqyabhw523PziuYzwqC7Si1Do3klcPMVE
	 NlpjFcjrVLiNPBuAb/znzbCdIjOjnTc/1tbSEIy/lQe3OCqvRSDvXU+zrFAEsfkYDD
	 Umfu5hg1sjmeYdMOvXxTG793Fuc5APFOrTU/0nMyLlVUABT1TLt31NU4nb640lHqBX
	 X/SJgSjJSzGaA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DE3834C82A;
	Tue, 24 Nov 2026 01:30:35 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Mon, 23 Nov 2026 18:30:37 -0700
Subject: [PATCH v2 5/6] dyndbg.lds.h: fix lost dyndbg sections in modules
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
Message-Id: <20261123-vmlinux-lds-v2-5-6f608abfa042@gmail.com>
References: <20261123-vmlinux-lds-v2-0-6f608abfa042@gmail.com>
In-Reply-To: <20261123-vmlinux-lds-v2-0-6f608abfa042@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795483834; l=5081;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=iy8rxT5tB9V+o3jGbrb598Kflz2glZXvHyxI3vDPBGg=;
 b=oS9SpdrfINQFUW3Akmb+uMNFso40ckfqQT2JEPRLGarqAuZzSr49mrXHvdZgFdBslESGYhDBF
 Grqh5o2JwP8A4S3jfMyqGSa0cVoaYqD1TUDrREfQkC8RkcTWC5pw8fI
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

Introduce include/asm-generic/dyndbg.lds.h to bundle dynamic-debug's
multiple sections together into 2 macros:

- DYNDBG_SECTIONS(): move the 2 BOUNDED_SECTION_BY(__dyndbg*) calls
  out of vmlinux.lds.h DATA_DATA into dyndbg.lds.h.  vmlinux.lds.h now
  includes dyndbg.lds.h and calls DYNDBG_SECTIONS().

- MOD_DYNDBG_SECTIONS(): keeps the 2 sections by name with KEEP(),
  aligns them to 8 bytes, and sets the output section base address to
  0 for relocatable module linking.

dyndbg.lds.h includes (reuses) bounded_sections.lds.h.

scripts/module.lds.S now includes dyndbg.lds.h and calls
MOD_DYNDBG_SECTIONS() right before MOD_SEPARATE_CODETAG_SECTIONS()
(consistent with their placements in vmlinux.lds.h).

This isolates vmlinux.lds.h from further __dyndbg section additions.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
v2: Address linker script review feedback for relocatable modules.

MOD_DYNDBG_SECTIONS() previously used BOUNDED_SECTION_BY(), which
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
 include/asm-generic/dyndbg.lds.h  | 18 ++++++++++++++++++
 include/asm-generic/vmlinux.lds.h |  6 ++----
 scripts/module.lds.S              |  2 ++
 4 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 44540a1eb2b8..85c006bcb41c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9500,6 +9500,7 @@ DYNAMIC DEBUG
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


