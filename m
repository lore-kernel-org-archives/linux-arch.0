Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:59028 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752707AbdBTPpS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 20 Feb 2017 10:45:18 -0500
Date: Mon, 20 Feb 2017 16:43:54 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v4 08/28] x86: Extend the early_memremap support with
 additional attrs
Message-ID: <20170220154354.ggb7yzpjotmbrd5a@pd.tnic>
References: <20170216154158.19244.66630.stgit@tlendack-t1.amdoffice.net>
 <20170216154348.19244.11884.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170216154348.19244.11884.stgit@tlendack-t1.amdoffice.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rik van Riel <riel@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Ingo Molnar <mingo@redhat.com>, Alexander Potapenko <glider@google.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Thomas Gleixner <tglx@linutronix.de>, Larry Woodman <lwoodman@redhat.com>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20170220154354.3DAma_uM4t0X5_UDa3hhOvgEYpdJjKLY1Bk66FVQPD4@z>

On Thu, Feb 16, 2017 at 09:43:48AM -0600, Tom Lendacky wrote:
> Add to the early_memremap support to be able to specify encrypted and

early_memremap()

Please append "()" to function names in your commit messages text.

> decrypted mappings with and without write-protection. The use of
> write-protection is necessary when encrypting data "in place". The
> write-protect attribute is considered cacheable for loads, but not
> stores. This implies that the hardware will never give the core a
> dirty line with this memtype.

By "hardware will never give" you mean that WP writes won't land dirty
in the cache but will go out to mem and when some other core needs them,
they will have to come from memory?

> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/Kconfig                     |    4 +++
>  arch/x86/include/asm/fixmap.h        |   13 ++++++++++
>  arch/x86/include/asm/pgtable_types.h |    8 ++++++
>  arch/x86/mm/ioremap.c                |   44 ++++++++++++++++++++++++++++++++++
>  include/asm-generic/early_ioremap.h  |    2 ++
>  mm/early_ioremap.c                   |   10 ++++++++
>  6 files changed, 81 insertions(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index a3b8c71..581eae4 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1417,6 +1417,10 @@ config AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
>  	  If set to N, then the encryption of system memory can be
>  	  activated with the mem_encrypt=on command line option.
>  
> +config ARCH_USE_MEMREMAP_PROT
> +	def_bool y
> +	depends on AMD_MEM_ENCRYPT

Why do we need this?

IOW, all those helpers below will end up being defined unconditionally,
in practice. Think distro kernels. Then saving the couple of bytes is
not really worth the overhead.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
