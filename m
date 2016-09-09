Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:48215 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750938AbcIIRXV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Sep 2016 13:23:21 -0400
Date: Fri, 9 Sep 2016 19:23:15 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v2 12/20] x86: Add support for changing memory
 encryption attribute
Message-ID: <20160909172314.ifcteua7nr52mzgs@pd.tnic>
References: <20160822223529.29880.50884.stgit@tlendack-t1.amdoffice.net>
 <20160822223749.29880.10183.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160822223749.29880.10183.stgit@tlendack-t1.amdoffice.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20160909172315.i551qCbTF6UViLFi5TR7Dbr_fCoBnMF4zjZqphuHAb8@z>

On Mon, Aug 22, 2016 at 05:37:49PM -0500, Tom Lendacky wrote:
> This patch adds support to be change the memory encryption attribute for
> one or more memory pages.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/include/asm/cacheflush.h  |    3 +
>  arch/x86/include/asm/mem_encrypt.h |   13 ++++++
>  arch/x86/mm/mem_encrypt.c          |   43 +++++++++++++++++++++
>  arch/x86/mm/pageattr.c             |   75 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 134 insertions(+)

...

> diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
> index 72c292d..0ba9382 100644
> --- a/arch/x86/mm/pageattr.c
> +++ b/arch/x86/mm/pageattr.c
> @@ -1728,6 +1728,81 @@ int set_memory_4k(unsigned long addr, int numpages)
>  					__pgprot(0), 1, 0, NULL);
>  }
>  
> +static int __set_memory_enc_dec(struct cpa_data *cpa)
> +{
> +	unsigned long addr;
> +	int numpages;
> +	int ret;
> +
> +	if (*cpa->vaddr & ~PAGE_MASK) {
> +		*cpa->vaddr &= PAGE_MASK;
> +
> +		/* People should not be passing in unaligned addresses */
> +		WARN_ON_ONCE(1);

Let's make this more user-friendly:

	if (WARN_ONCE(*cpa->vaddr & ~PAGE_MASK, "Misaligned address: 0x%lx\n", *cpa->vaddr))
		*cpa->vaddr &= PAGE_MASK;

> +	}
> +
> +	addr = *cpa->vaddr;
> +	numpages = cpa->numpages;
> +
> +	/* Must avoid aliasing mappings in the highmem code */
> +	kmap_flush_unused();
> +	vm_unmap_aliases();
> +
> +	ret = __change_page_attr_set_clr(cpa, 1);
> +
> +	/* Check whether we really changed something */
> +	if (!(cpa->flags & CPA_FLUSHTLB))
> +		goto out;
> +
> +	/*
> +	 * On success we use CLFLUSH, when the CPU supports it to
> +	 * avoid the WBINVD.
> +	 */
> +	if (!ret && static_cpu_has(X86_FEATURE_CLFLUSH))
> +		cpa_flush_range(addr, numpages, 1);
> +	else
> +		cpa_flush_all(1);

So if we fail (ret != 0) we do WBINVD unconditionally even if we don't
have to?

Don't you want this instead:

        ret = __change_page_attr_set_clr(cpa, 1);
        if (ret)
                goto out;

        /* Check whether we really changed something */
        if (!(cpa->flags & CPA_FLUSHTLB))
                goto out;

        /*
         * On success we use CLFLUSH, when the CPU supports it to
         * avoid the WBINVD.
         */
        if (static_cpu_has(X86_FEATURE_CLFLUSH))
                cpa_flush_range(addr, numpages, 1);
        else
                cpa_flush_all(1);

out:
        return ret;
}

?

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
