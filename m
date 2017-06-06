From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv7 05/14] x86/boot/efi: Define __KERNEL32_CS GDT on 64-bit configurations
Date: Tue,  6 Jun 2017 14:31:24 +0300
Message-ID: <20170606113133.22974-6-kirill.shutemov@linux.intel.com>
References: <20170606113133.22974-1-kirill.shutemov@linux.intel.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20170606113133.22974-1-kirill.shutemov@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Matt Fleming <matt@codeblueprint.co.uk>
List-Id: linux-arch.vger.kernel.org

We would need to switch temporarily to compatibility mode during booting
with 5-level paging enabled. It would require 32-bit code segment
descriptor.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
---
 arch/x86/boot/compressed/eboot.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index b75c20f779ea..c3e869eaef0c 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -1046,8 +1046,29 @@ struct boot_params *efi_main(struct efi_config *c,
 	memset((char *)gdt->address, 0x0, gdt->size);
 	desc = (struct desc_struct *)gdt->address;
 
-	/* The first GDT is a dummy and the second is unused. */
-	desc += 2;
+	/* The first GDT is a dummy. */
+	desc++;
+
+	if (IS_ENABLED(CONFIG_X86_64)) {
+		/* __KERNEL32_CS */
+		desc->limit0 = 0xffff;
+		desc->base0 = 0x0000;
+		desc->base1 = 0x0000;
+		desc->type = SEG_TYPE_CODE | SEG_TYPE_EXEC_READ;
+		desc->s = DESC_TYPE_CODE_DATA;
+		desc->dpl = 0;
+		desc->p = 1;
+		desc->limit = 0xf;
+		desc->avl = 0;
+		desc->l = 0;
+		desc->d = SEG_OP_SIZE_32BIT;
+		desc->g = SEG_GRANULARITY_4KB;
+		desc->base2 = 0x00;
+		desc++;
+	} else {
+		/* Second entry is unused on 32-bit */
+		desc++;
+	}
 
 	/* __KERNEL_CS */
 	desc->limit0 = 0xffff;
-- 
2.11.0

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
