Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:32707 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751495AbdFFLbl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Jun 2017 07:31:41 -0400
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv7 04/14] x86/boot/efi: Fix __KERNEL_CS definition of GDT entry on 64-bit configuration
Date: Tue,  6 Jun 2017 14:31:23 +0300
Message-ID: <20170606113133.22974-5-kirill.shutemov@linux.intel.com>
In-Reply-To: <20170606113133.22974-1-kirill.shutemov@linux.intel.com>
References: <20170606113133.22974-1-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Matt Fleming <matt@codeblueprint.co.uk>
Message-ID: <20170606113123.GQ1Jd28xjWRqK-UOCkni6c0nVnCfkZGmAweWFygMB5A@z>

Define __KERNEL_CS GDT entry as long mode (.L=1, .D=0) on 64-bit
configuration.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
---
 arch/x86/boot/compressed/eboot.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 1d5093d1f319..b75c20f779ea 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -1059,8 +1059,13 @@ struct boot_params *efi_main(struct efi_config *c,
 	desc->p = 1;
 	desc->limit = 0xf;
 	desc->avl = 0;
-	desc->l = 0;
-	desc->d = SEG_OP_SIZE_32BIT;
+	if (IS_ENABLED(CONFIG_X86_64)) {
+		desc->l = 1;
+		desc->d = 0;
+	} else {
+		desc->l = 0;
+		desc->d = SEG_OP_SIZE_32BIT;
+	}
 	desc->g = SEG_GRANULARITY_4KB;
 	desc->base2 = 0x00;
 	desc++;
-- 
2.11.0
