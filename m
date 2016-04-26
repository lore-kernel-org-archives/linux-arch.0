Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn1on0085.outbound.protection.outlook.com ([157.56.110.85]:53156
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753149AbcDZW6z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 26 Apr 2016 18:58:55 -0400
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: [RFC PATCH v1 16/18] x86: Do not specify encrypted memory for VGA
 mapping
Date: Tue, 26 Apr 2016 17:58:45 -0500
Message-ID: <20160426225845.13567.94417.stgit@tlendack-t1.amdoffice.net>
In-Reply-To: <20160426225553.13567.19459.stgit@tlendack-t1.amdoffice.net>
References: <20160426225553.13567.19459.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org
Cc: Radim =?utf-8?b?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20160426225845.BTfBotDQBuxFMhk0AY4YfeWqpGJRjnxL3TJ5JNliQxM@z>

Since the VGA memory needs to be accessed unencrypted be sure that the
memory encryption mask is not set for the VGA range being mapped.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/vga.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/include/asm/vga.h b/arch/x86/include/asm/vga.h
index c4b9dc2..55fe164 100644
--- a/arch/x86/include/asm/vga.h
+++ b/arch/x86/include/asm/vga.h
@@ -7,12 +7,25 @@
 #ifndef _ASM_X86_VGA_H
 #define _ASM_X86_VGA_H
 
+#include <asm/mem_encrypt.h>
+
 /*
  *	On the PC, we can just recalculate addresses and then
  *	access the videoram directly without any black magic.
+ *	To support memory encryption however, we need to access
+ *	the videoram as un-encrypted memory.
  */
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+#define VGA_MAP_MEM(x, s)					\
+({								\
+	unsigned long start = (unsigned long)phys_to_virt(x);	\
+	sme_set_mem_dec((void *)start, s);			\
+	start;							\
+})
+#else
 #define VGA_MAP_MEM(x, s) (unsigned long)phys_to_virt(x)
+#endif
 
 #define vga_readb(x) (*(x))
 #define vga_writeb(x, y) (*(y) = (x))

