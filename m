Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:34732 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751100AbdBTTp6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 20 Feb 2017 14:45:58 -0500
Date: Mon, 20 Feb 2017 20:45:29 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v4 10/28] x86: Insure that boot memory areas are
 mapped properly
Message-ID: <20170220194529.7dekuruclq7hfyhk@pd.tnic>
References: <20170216154158.19244.66630.stgit@tlendack-t1.amdoffice.net>
 <20170216154411.19244.99258.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170216154411.19244.99258.stgit@tlendack-t1.amdoffice.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rik van Riel <riel@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Ingo Molnar <mingo@redhat.com>, Alexander Potapenko <glider@google.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Thomas Gleixner <tglx@linutronix.de>, Larry Woodman <lwoodman@redhat.com>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20170220194529.GhxBU2GT248WUaqy7R1DA93h9v7kPkfuo5Zsf1kyS94@z>

On Thu, Feb 16, 2017 at 09:44:11AM -0600, Tom Lendacky wrote:
> The boot data and command line data are present in memory in a decrypted
> state and are copied early in the boot process.  The early page fault
> support will map these areas as encrypted, so before attempting to copy
> them, add decrypted mappings so the data is accessed properly when copied.
> 
> For the initrd, encrypt this data in place. Since the future mapping of the
> initrd area will be mapped as encrypted the data will be accessed properly.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---

...

> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index 182a4c7..03f8e74 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -46,13 +46,18 @@ static void __init reset_early_page_tables(void)
>  	write_cr3(__sme_pa_nodebug(early_level4_pgt));
>  }
>  
> +void __init __early_pgtable_flush(void)
> +{
> +	write_cr3(__sme_pa_nodebug(early_level4_pgt));
> +}

Move that to mem_encrypt.c where it is used and make it static. The diff
below, ontop of this patch, seems to build fine here.

Also, aren't those mappings global so that you need to toggle CR4.PGE
for that?

PAGE_KERNEL at least has _PAGE_GLOBAL set.

> +
>  /* Create a new PMD entry */
> -int __init early_make_pgtable(unsigned long address)
> +int __init __early_make_pgtable(unsigned long address, pmdval_t pmd)

__early_make_pmd() then, since it creates a PMD entry.

>  	unsigned long physaddr = address - __PAGE_OFFSET;
>  	pgdval_t pgd, *pgd_p;
>  	pudval_t pud, *pud_p;
> -	pmdval_t pmd, *pmd_p;
> +	pmdval_t *pmd_p;
>  
>  	/* Invalid address or early pgt is done ?  */
>  	if (physaddr >= MAXMEM || read_cr3() != __sme_pa_nodebug(early_level4_pgt))

...

> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index ac3565c..ec548e9 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -16,8 +16,12 @@
>  
>  #include <asm/tlbflush.h>
>  #include <asm/fixmap.h>
> +#include <asm/setup.h>
> +#include <asm/bootparam.h>
>  
>  extern pmdval_t early_pmd_flags;
> +int __init __early_make_pgtable(unsigned long, pmdval_t);
> +void __init __early_pgtable_flush(void);

What's with the forward declarations?

Those should be in some header AFAICT.

>   * Since SME related variables are set early in the boot process they must
> @@ -103,6 +107,76 @@ void __init sme_early_decrypt(resource_size_t paddr, unsigned long size)
>  	__sme_early_enc_dec(paddr, size, false);
>  }

...

---
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 03f8e74c7223..c47500d72330 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -46,11 +46,6 @@ static void __init reset_early_page_tables(void)
 	write_cr3(__sme_pa_nodebug(early_level4_pgt));
 }
 
-void __init __early_pgtable_flush(void)
-{
-	write_cr3(__sme_pa_nodebug(early_level4_pgt));
-}
-
 /* Create a new PMD entry */
 int __init __early_make_pgtable(unsigned long address, pmdval_t pmd)
 {
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index ec548e9a76f1..0af020b36232 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -21,7 +21,7 @@
 
 extern pmdval_t early_pmd_flags;
 int __init __early_make_pgtable(unsigned long, pmdval_t);
-void __init __early_pgtable_flush(void);
+extern pgd_t early_level4_pgt[PTRS_PER_PGD];
 
 /*
  * Since SME related variables are set early in the boot process they must
@@ -34,6 +34,11 @@ EXPORT_SYMBOL_GPL(sme_me_mask);
 /* Buffer used for early in-place encryption by BSP, no locking needed */
 static char sme_early_buffer[PAGE_SIZE] __aligned(PAGE_SIZE);
 
+static void __init early_pgtable_flush(void)
+{
+	write_cr3(__sme_pa_nodebug(early_level4_pgt));
+}
+
 /*
  * This routine does not change the underlying encryption setting of the
  * page(s) that map this memory. It assumes that eventually the memory is
@@ -158,7 +163,7 @@ void __init sme_unmap_bootdata(char *real_mode_data)
 	 */
 	__sme_map_unmap_bootdata(real_mode_data, false);
 
-	__early_pgtable_flush();
+	early_pgtable_flush();
 }
 
 void __init sme_map_bootdata(char *real_mode_data)
@@ -174,7 +179,7 @@ void __init sme_map_bootdata(char *real_mode_data)
 	 */
 	__sme_map_unmap_bootdata(real_mode_data, true);
 
-	__early_pgtable_flush();
+	early_pgtable_flush();
 }
 
 void __init sme_early_init(void)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
