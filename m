From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v7 12/28] x86/boot/compressed: annotate data appropriatelly
Date: Wed, 30 Jan 2019 13:46:55 +0100
Message-ID: <20190130124711.12463-13-jslaby@suse.cz>
References: <20190130124711.12463-1-jslaby@suse.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130124711.12463-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com
Cc: bp@alien8.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

Use the new SYM_DATA, SYM_DATA_START, and SYM_DATA_END* macros for data.

Now, the data in the object file look sane:
Value   Size Type    Bind   Vis      Ndx Name
  0000    10 OBJECT  GLOBAL DEFAULT    3 efi32_boot_gdt
  000a    10 OBJECT  LOCAL  DEFAULT    3 save_gdt
  0014     8 OBJECT  LOCAL  DEFAULT    3 func_rt_ptr
  001c    48 OBJECT  GLOBAL DEFAULT    3 efi_gdt64
  004c     0 OBJECT  LOCAL  DEFAULT    3 efi_gdt64_end

  0000    48 OBJECT  LOCAL  DEFAULT    3 gdt
  0030     0 OBJECT  LOCAL  DEFAULT    3 gdt_end
  0030     8 OBJECT  LOCAL  DEFAULT    3 efi_config
  0038    49 OBJECT  GLOBAL DEFAULT    3 efi32_config
  0069    49 OBJECT  GLOBAL DEFAULT    3 efi64_config

All have correct size and type now.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: x86@kernel.org
---
 arch/x86/boot/compressed/efi_thunk_64.S | 21 +++++++++-------
 arch/x86/boot/compressed/head_64.S      | 32 ++++++++++++-------------
 arch/x86/boot/compressed/mem_encrypt.S  |  3 +--
 3 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_thunk_64.S b/arch/x86/boot/compressed/efi_thunk_64.S
index bff9ab7c6317..d66000d23921 100644
--- a/arch/x86/boot/compressed/efi_thunk_64.S
+++ b/arch/x86/boot/compressed/efi_thunk_64.S
@@ -176,16 +176,19 @@ ENDPROC(efi_enter32)
 
 	.data
 	.balign	8
-	.global	efi32_boot_gdt
-efi32_boot_gdt:	.word	0
-		.quad	0
+SYM_DATA_START(efi32_boot_gdt)
+	.word	0
+	.quad	0
+SYM_DATA_END(efi32_boot_gdt)
+
+SYM_DATA_START_LOCAL(save_gdt)
+	.word	0
+	.quad	0
+SYM_DATA_END(save_gdt)
 
-save_gdt:	.word	0
-		.quad	0
-func_rt_ptr:	.quad	0
+SYM_DATA_LOCAL(func_rt_ptr, .quad 0)
 
-	.global efi_gdt64
-efi_gdt64:
+SYM_DATA_START(efi_gdt64)
 	.word	efi_gdt64_end - efi_gdt64
 	.long	0			/* Filled out by user */
 	.word	0
@@ -194,4 +197,4 @@ efi_gdt64:
 	.quad	0x00cf92000000ffff	/* __KERNEL_DS */
 	.quad	0x0080890000000000	/* TS descriptor */
 	.quad   0x0000000000000000	/* TS continued */
-efi_gdt64_end:
+SYM_DATA_END_LABEL(efi_gdt64, SYM_L_LOCAL, efi_gdt64_end)
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index b840618edd58..8f5a58c28dd4 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -646,12 +646,13 @@ SYM_FUNC_END(no_longmode)
 #include "../../kernel/verify_cpu.S"
 
 	.data
-gdt64:
+SYM_DATA_START_LOCAL(gdt64)
 	.word	gdt_end - gdt
 	.long	0
 	.word	0
 	.quad   0
-gdt:
+SYM_DATA_END(gdt64)
+SYM_DATA_START_LOCAL(gdt)
 	.word	gdt_end - gdt
 	.long	gdt
 	.word	0
@@ -660,25 +661,24 @@ gdt:
 	.quad	0x00cf92000000ffff	/* __KERNEL_DS */
 	.quad	0x0080890000000000	/* TS descriptor */
 	.quad   0x0000000000000000	/* TS continued */
-gdt_end:
+SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
 
 #ifdef CONFIG_EFI_STUB
-efi_config:
-	.quad	0
+SYM_DATA_LOCAL(efi_config, .quad 0)
 
 #ifdef CONFIG_EFI_MIXED
-	.global efi32_config
-efi32_config:
+SYM_DATA_START(efi32_config)
 	.fill	5,8,0
 	.quad	efi64_thunk
 	.byte	0
+SYM_DATA_END(efi32_config)
 #endif
 
-	.global efi64_config
-efi64_config:
+SYM_DATA_START(efi64_config)
 	.fill	5,8,0
 	.quad	efi_call
 	.byte	1
+SYM_DATA_END(efi64_config)
 #endif /* CONFIG_EFI_STUB */
 
 /*
@@ -686,23 +686,21 @@ efi64_config:
  */
 	.bss
 	.balign 4
-boot_heap:
-	.fill BOOT_HEAP_SIZE, 1, 0
-boot_stack:
+SYM_DATA_LOCAL(boot_heap,	.fill BOOT_HEAP_SIZE, 1, 0)
+
+SYM_DATA_START_LOCAL(boot_stack)
 	.fill BOOT_STACK_SIZE, 1, 0
-boot_stack_end:
+SYM_DATA_END_LABEL(boot_stack, SYM_L_LOCAL, boot_stack_end)
 
 /*
  * Space for page tables (not in .bss so not zeroed)
  */
 	.section ".pgtable","a",@nobits
 	.balign 4096
-pgtable:
-	.fill BOOT_PGT_SIZE, 1, 0
+SYM_DATA_LOCAL(pgtable,		.fill BOOT_PGT_SIZE, 1, 0)
 
 /*
  * The page table is going to be used instead of page table in the trampoline
  * memory.
  */
-top_pgtable:
-	.fill PAGE_SIZE, 1, 0
+SYM_DATA_LOCAL(top_pgtable,	.fill PAGE_SIZE, 1, 0)
diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
index a480356e0ed8..9acc5eab9b71 100644
--- a/arch/x86/boot/compressed/mem_encrypt.S
+++ b/arch/x86/boot/compressed/mem_encrypt.S
@@ -99,6 +99,5 @@ ENDPROC(set_sev_encryption_mask)
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	.balign	8
-GLOBAL(sme_me_mask)
-	.quad	0
+SYM_DATA(sme_me_mask, .quad 0)
 #endif
-- 
2.20.1
