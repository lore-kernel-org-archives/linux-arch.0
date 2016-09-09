Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:49978 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750796AbcIIRes (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Sep 2016 13:34:48 -0400
Date: Fri, 9 Sep 2016 19:34:42 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v2 13/20] x86: Decrypt trampoline area if memory
 encryption is active
Message-ID: <20160909173442.wypsprnzb5ax6xqb@pd.tnic>
References: <20160822223529.29880.50884.stgit@tlendack-t1.amdoffice.net>
 <20160822223757.29880.24107.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160822223757.29880.24107.stgit@tlendack-t1.amdoffice.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20160909173442.2RUrvcqwHa4-4MmbF3xbsAjhAo7ZOOfJ-bjBe8icZ38@z>

On Mon, Aug 22, 2016 at 05:37:57PM -0500, Tom Lendacky wrote:
> When Secure Memory Encryption is enabled, the trampoline area must not
> be encrypted. A cpu running in real mode will not be able to decrypt

s/cpu/CPU/... always :-)

> memory that has been encrypted because it will not be able to use addresses
> with the memory encryption mask.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/realmode/init.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
> index 5db706f1..f74925f 100644
> --- a/arch/x86/realmode/init.c
> +++ b/arch/x86/realmode/init.c
> @@ -6,6 +6,7 @@
>  #include <asm/pgtable.h>
>  #include <asm/realmode.h>
>  #include <asm/tlbflush.h>
> +#include <asm/mem_encrypt.h>
>  
>  struct real_mode_header *real_mode_header;
>  u32 *trampoline_cr4_features;
> @@ -130,6 +131,14 @@ static void __init set_real_mode_permissions(void)
>  	unsigned long text_start =
>  		(unsigned long) __va(real_mode_header->text_start);
>  
> +	/*
> +	 * If memory encryption is active, the trampoline area will need to
> +	 * be in non-encrypted memory in order to bring up other processors

Let's stick with either "unencrypted" - I'd prefer that one - or
"non-encrypted" nomenclature so that there's no distraction. I see both
versions in the patchset.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
