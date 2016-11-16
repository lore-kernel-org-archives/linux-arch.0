Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:56043 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752195AbcKPKrA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 16 Nov 2016 05:47:00 -0500
Date: Wed, 16 Nov 2016 11:46:56 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v3 08/20] x86: Add support for early
 encryption/decryption of memory
Message-ID: <20161116104656.qz5wp33zzyja373r@pd.tnic>
References: <20161110003426.3280.2999.stgit@tlendack-t1.amdoffice.net>
 <20161110003610.3280.22043.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161110003610.3280.22043.stgit@tlendack-t1.amdoffice.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rik van Riel <riel@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Larry Woodman <lwoodman@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20161116104656.USIhWGroH0YtPyRNPLe9R1BHRBfsK-6u1UhsyeE_QMc@z>

Btw, for your next submission, this patch can be split in two exactly
like the commit message paragraphs are:

On Wed, Nov 09, 2016 at 06:36:10PM -0600, Tom Lendacky wrote:
> Add support to be able to either encrypt or decrypt data in place during
> the early stages of booting the kernel. This does not change the memory
> encryption attribute - it is used for ensuring that data present in either
> an encrypted or un-encrypted memory area is in the proper state (for
> example the initrd will have been loaded by the boot loader and will not be
> encrypted, but the memory that it resides in is marked as encrypted).

Patch 2: users of the new memmap change

> The early_memmap support is enhanced to specify encrypted and un-encrypted
> mappings with and without write-protection. The use of write-protection is
> necessary when encrypting data "in place". The write-protect attribute is
> considered cacheable for loads, but not stores. This implies that the
> hardware will never give the core a dirty line with this memtype.

Patch 1: change memmap

This makes this aspect of the patchset much clearer and is better for
bisection.

> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/include/asm/fixmap.h        |    9 +++
>  arch/x86/include/asm/mem_encrypt.h   |   15 +++++
>  arch/x86/include/asm/pgtable_types.h |    8 +++
>  arch/x86/mm/ioremap.c                |   28 +++++++++
>  arch/x86/mm/mem_encrypt.c            |  102 ++++++++++++++++++++++++++++++++++
>  include/asm-generic/early_ioremap.h  |    2 +
>  mm/early_ioremap.c                   |   15 +++++
>  7 files changed, 179 insertions(+)

...

> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index d642cc5..06235b4 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -14,6 +14,9 @@
>  #include <linux/init.h>
>  #include <linux/mm.h>
>  
> +#include <asm/tlbflush.h>
> +#include <asm/fixmap.h>
> +
>  extern pmdval_t early_pmd_flags;
>  
>  /*
> @@ -24,6 +27,105 @@ extern pmdval_t early_pmd_flags;
>  unsigned long sme_me_mask __section(.data) = 0;
>  EXPORT_SYMBOL_GPL(sme_me_mask);
>  
> +/* Buffer used for early in-place encryption by BSP, no locking needed */
> +static char sme_early_buffer[PAGE_SIZE] __aligned(PAGE_SIZE);
> +
> +/*
> + * This routine does not change the underlying encryption setting of the
> + * page(s) that map this memory. It assumes that eventually the memory is
> + * meant to be accessed as encrypted but the contents are currently not
> + * encrypted.
> + */
> +void __init sme_early_mem_enc(resource_size_t paddr, unsigned long size)
> +{
> +	void *src, *dst;
> +	size_t len;
> +
> +	if (!sme_me_mask)
> +		return;
> +
> +	local_flush_tlb();
> +	wbinvd();
> +
> +	/*
> +	 * There are limited number of early mapping slots, so map (at most)
> +	 * one page at time.
> +	 */
> +	while (size) {
> +		len = min_t(size_t, sizeof(sme_early_buffer), size);
> +
> +		/* Create a mapping for non-encrypted write-protected memory */
> +		src = early_memremap_dec_wp(paddr, len);
> +
> +		/* Create a mapping for encrypted memory */
> +		dst = early_memremap_enc(paddr, len);
> +
> +		/*
> +		 * If a mapping can't be obtained to perform the encryption,
> +		 * then encrypted access to that area will end up causing
> +		 * a crash.
> +		 */
> +		BUG_ON(!src || !dst);
> +
> +		memcpy(sme_early_buffer, src, len);
> +		memcpy(dst, sme_early_buffer, len);

I still am missing the short explanation why we need the temporary buffer.


Oh, and we can save us the code duplication a little. Diff ontop of yours:

---
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 06235b477d7c..50e2c4fc7338 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -36,7 +36,8 @@ static char sme_early_buffer[PAGE_SIZE] __aligned(PAGE_SIZE);
  * meant to be accessed as encrypted but the contents are currently not
  * encrypted.
  */
-void __init sme_early_mem_enc(resource_size_t paddr, unsigned long size)
+static void __init noinline
+__mem_enc_dec(resource_size_t paddr, unsigned long size, bool enc)
 {
 	void *src, *dst;
 	size_t len;
@@ -54,15 +55,15 @@ void __init sme_early_mem_enc(resource_size_t paddr, unsigned long size)
 	while (size) {
 		len = min_t(size_t, sizeof(sme_early_buffer), size);
 
-		/* Create a mapping for non-encrypted write-protected memory */
-		src = early_memremap_dec_wp(paddr, len);
+		src = (enc ? early_memremap_dec_wp(paddr, len)
+			   : early_memremap_enc_wp(paddr, len));
 
-		/* Create a mapping for encrypted memory */
-		dst = early_memremap_enc(paddr, len);
+		dst = (enc ? early_memremap_enc(paddr, len)
+			   : early_memremap_dec(paddr, len));
 
 		/*
-		 * If a mapping can't be obtained to perform the encryption,
-		 * then encrypted access to that area will end up causing
+		 * If a mapping can't be obtained to perform the dec/encryption,
+		 * then (un-)encrypted access to that area will end up causing
 		 * a crash.
 		 */
 		BUG_ON(!src || !dst);
@@ -78,52 +79,14 @@ void __init sme_early_mem_enc(resource_size_t paddr, unsigned long size)
 	}
 }
 
-/*
- * This routine does not change the underlying encryption setting of the
- * page(s) that map this memory. It assumes that eventually the memory is
- * meant to be accessed as not encrypted but the contents are currently
- * encrypted.
- */
-void __init sme_early_mem_dec(resource_size_t paddr, unsigned long size)
+void __init sme_early_mem_enc(resource_size_t paddr, unsigned long size)
 {
-	void *src, *dst;
-	size_t len;
-
-	if (!sme_me_mask)
-		return;
-
-	local_flush_tlb();
-	wbinvd();
-
-	/*
-	 * There are limited number of early mapping slots, so map (at most)
-	 * one page at time.
-	 */
-	while (size) {
-		len = min_t(size_t, sizeof(sme_early_buffer), size);
-
-		/* Create a mapping for encrypted write-protected memory */
-		src = early_memremap_enc_wp(paddr, len);
-
-		/* Create a mapping for non-encrypted memory */
-		dst = early_memremap_dec(paddr, len);
-
-		/*
-		 * If a mapping can't be obtained to perform the decryption,
-		 * then un-encrypted access to that area will end up causing
-		 * a crash.
-		 */
-		BUG_ON(!src || !dst);
-
-		memcpy(sme_early_buffer, src, len);
-		memcpy(dst, sme_early_buffer, len);
-
-		early_memunmap(dst, len);
-		early_memunmap(src, len);
+	return __mem_enc_dec(paddr, size, true);
+}
 
-		paddr += len;
-		size -= len;
-	}
+void __init sme_early_mem_dec(resource_size_t paddr, unsigned long size)
+{
+	return __mem_enc_dec(paddr, size, false);
 }
 
 void __init sme_early_init(void)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
