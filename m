Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:56084 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751131AbdFTUjZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Jun 2017 16:39:25 -0400
Date: Tue, 20 Jun 2017 22:39:06 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v7 19/36] x86/mm: Add support to access boot related data
 in the clear
Message-ID: <20170620203906.fzkez2f7es6ow4gr@pd.tnic>
References: <20170616184947.18967.84890.stgit@tlendack-t1.amdoffice.net>
 <20170616185326.18967.43278.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170616185326.18967.43278.stgit@tlendack-t1.amdoffice.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, xen-devel@lists.xen.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, "Michael S. Tsirkin" <mst@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andy Lutomirski <luto@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, Juergen Gross <jgross@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20170620203906.9EYbSOU0okHk4pgVkR4C9Rq6r-BExCIsVxN0qYM2Ytw@z>

On Fri, Jun 16, 2017 at 01:53:26PM -0500, Tom Lendacky wrote:
> Boot data (such as EFI related data) is not encrypted when the system is
> booted because UEFI/BIOS does not run with SME active. In order to access
> this data properly it needs to be mapped decrypted.
> 
> Update early_memremap() to provide an arch specific routine to modify the
> pagetable protection attributes before they are applied to the new
> mapping. This is used to remove the encryption mask for boot related data.
> 
> Update memremap() to provide an arch specific routine to determine if RAM
> remapping is allowed.  RAM remapping will cause an encrypted mapping to be
> generated. By preventing RAM remapping, ioremap_cache() will be used
> instead, which will provide a decrypted mapping of the boot related data.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/include/asm/io.h |    5 +
>  arch/x86/mm/ioremap.c     |  179 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/io.h        |    2 +
>  kernel/memremap.c         |   20 ++++-
>  mm/early_ioremap.c        |   18 ++++-
>  5 files changed, 217 insertions(+), 7 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
