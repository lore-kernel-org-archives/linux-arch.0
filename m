Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35992 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756850Ab2HNSIK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Aug 2012 14:08:10 -0400
From: David Daney <ddaney.cavm@gmail.com>
Subject: [PATCH 1/2] vmlinux.lds.h: Allow architectures to add sections to the front of .bss
Date: Tue, 14 Aug 2012 11:08:00 -0700
Message-ID: <1344967681-13179-2-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1344967681-13179-1-git-send-email-ddaney.cavm@gmail.com>
References: <1344967681-13179-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-mips@linux-mips.org, ralf@linux-mips.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Cc: David Daney <david.daney@cavium.com>
Message-ID: <20120814180800.a7vm4VTGM7svaiKpRYB4H_imGZ6XRcgwZmFx6Irplig@z>

From: David Daney <david.daney@cavium.com>

Follow-on MIPS patch will put an object here that needs 64K alignment
to minimize padding.

For those architectures that don't define BSS_FIRST_SECTIONS, there is
no change.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 include/asm-generic/vmlinux.lds.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 4e2e1cc..d1ea7ce 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -530,9 +530,18 @@
 		*(.scommon)						\
 	}
 
+/*
+ * Allow archectures to redefine BSS_FIRST_SECTIONS to add extra
+ * sections to the front of bss.
+ */
+#ifndef BSS_FIRST_SECTIONS
+#define BSS_FIRST_SECTIONS
+#endif
+
 #define BSS(bss_align)							\
 	. = ALIGN(bss_align);						\
 	.bss : AT(ADDR(.bss) - LOAD_OFFSET) {				\
+		BSS_FIRST_SECTIONS					\
 		*(.bss..page_aligned)					\
 		*(.dynbss)						\
 		*(.bss)							\
-- 
1.7.2.3

