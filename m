From: "Guan Xuetao" <guanxuetao@mprc.pku.edu.cn>
Subject: [PATCHv1 010/211] unicore32: new file arch/unicore32/boot/compressed/vmlinux.lds.in
Date: Thu, 9 Dec 2010 17:40:21 +0800
Message-ID: <01de01cb9785$193cf160$4bb6d420$@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mprc.pku.edu.cn ([162.105.203.9]:51995 "EHLO mprc.pku.edu.cn"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755379Ab0LIJkY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 9 Dec 2010 04:40:24 -0500
Content-Language: zh-cn
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

From: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>

	this file generate vmlinux.lds, a ld-script for vmlinux

Signed-off-by: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>
---
 arch/unicore32/boot/compressed/vmlinux.lds.in |   61
+++++++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/arch/unicore32/boot/compressed/vmlinux.lds.in
b/arch/unicore32/boot/compressed/vmlinux.lds.in
new file mode 100644
index 0000000..d5a3ce2
--- /dev/null
+++ b/arch/unicore32/boot/compressed/vmlinux.lds.in
@@ -0,0 +1,61 @@
+/*
+ * linux/arch/unicore/boot/compressed/vmlinux.lds.in
+ *
+ * Code specific to PKUnity SoC and UniCore ISA
+ *
+ * Copyright (C) 2001-2010 GUAN Xue-tao
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+OUTPUT_ARCH(unicore32)
+ENTRY(_start)
+SECTIONS
+{
+  /DISCARD/ : {
+    /*
+     * Discard any r/w data - this produces a link error if we have any,
+     * which is required for PIC decompression.  Local data generates
+     * GOTOFF relocations, which prevents it being relocated independently
+     * of the text/got segments.
+     */
+    *(.data)
+  }
+
+  . = TEXT_START;
+  _text = .;
+
+  .text : {
+    _start = .;
+    *(.start)
+    *(.text)
+    *(.text.*)
+    *(.fixup)
+    *(.gnu.warning)
+    *(.rodata)
+    *(.rodata.*)
+    *(.piggydata)
+    . = ALIGN(4);
+  }
+
+  _etext = .;
+
+  /* Assume size of decompressed image is 4x the compressed image */
+  _image_size = (_etext - _text) * 4;
+
+  _got_start = .;
+  .got			: { *(.got) }
+  _got_end = .;
+  .got.plt		: { *(.got.plt) }
+  _edata = .;
+
+  . = BSS_START;
+  __bss_start = .;
+  .bss			: { *(.bss) }
+  _end = .;
+
+  .stack		: { *(.stack) }
+  .comment 0		: { *(.comment) }
+}
+
