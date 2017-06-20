Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:46087 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751820AbdFTUtk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Jun 2017 16:49:40 -0400
Date: Tue, 20 Jun 2017 22:49:31 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v7 06/36] x86/mm: Add Secure Memory Encryption (SME)
 support
In-Reply-To: <20170616185054.18967.52228.stgit@tlendack-t1.amdoffice.net>
Message-ID: <alpine.DEB.2.20.1706202244480.2157@nanos>
References: <20170616184947.18967.84890.stgit@tlendack-t1.amdoffice.net> <20170616185054.18967.52228.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, xen-devel@lists.xen.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, "Michael S. Tsirkin" <mst@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, Juergen Gross <jgross@suse.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20170620204931.5n5Y3MArGpBaT_zYFjlBeciXkB7NmPjEwrngrXzzbfg@z>

On Fri, 16 Jun 2017, Tom Lendacky wrote:
>  
> +config ARCH_HAS_MEM_ENCRYPT
> +	def_bool y
> +	depends on X86

That one is silly. The config switch is in the x86 KConfig file, so X86 is
on. If you intended to move this to some generic place outside of
x86/Kconfig then this should be

config ARCH_HAS_MEM_ENCRYPT
	bool

and x86/Kconfig should have

    	select ARCH_HAS_MEM_ENCRYPT

and that should be selected by AMD_MEM_ENCRYPT

> +config AMD_MEM_ENCRYPT
> +	bool "AMD Secure Memory Encryption (SME) support"
> +	depends on X86_64 && CPU_SUP_AMD
> +	---help---
> +	  Say yes to enable support for the encryption of system memory.
> +	  This requires an AMD processor that supports Secure Memory
> +	  Encryption (SME).

Thanks,

	tglx
