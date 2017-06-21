Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:47712 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751590AbdFUHTC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jun 2017 03:19:02 -0400
Date: Wed, 21 Jun 2017 09:18:59 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v7 10/36] x86/mm: Provide general kernel support for
 memory encryption
In-Reply-To: <20170616185140.18967.61905.stgit@tlendack-t1.amdoffice.net>
Message-ID: <alpine.DEB.2.20.1706210916590.2328@nanos>
References: <20170616184947.18967.84890.stgit@tlendack-t1.amdoffice.net> <20170616185140.18967.61905.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, xen-devel@lists.xen.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, "Michael S. Tsirkin" <mst@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, Juergen Gross <jgross@suse.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20170621071859.iEP1aFvob4W87fu9-xoFK_aIHhe0NgoTYqRc8MRMor0@z>

On Fri, 16 Jun 2017, Tom Lendacky wrote:
>  
> +#ifndef pgprot_encrypted
> +#define pgprot_encrypted(prot)	(prot)
> +#endif
> +
> +#ifndef pgprot_decrypted

That looks wrong. It's not decrypted it's rather unencrypted, right?

Thanks,

	tglx
