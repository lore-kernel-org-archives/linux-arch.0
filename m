Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:49440 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751120AbdFTHVk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Jun 2017 03:21:40 -0400
Date: Tue, 20 Jun 2017 09:21:25 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v7 03/36] x86, mpparse, x86/acpi, x86/PCI, x86/dmi, SFI:
 Use memremap for RAM mappings
Message-ID: <20170620072124.p6wztvxw5fj25a6m@pd.tnic>
References: <20170616184947.18967.84890.stgit@tlendack-t1.amdoffice.net>
 <20170616185023.18967.72831.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170616185023.18967.72831.stgit@tlendack-t1.amdoffice.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, xen-devel@lists.xen.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, "Michael S. Tsirkin" <mst@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andy Lutomirski <luto@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, Juergen Gross <jgross@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20170620072125.KWkMxkt6X5IrRH1TDQZzh2cfgShs-oVx47K-fgycmu0@z>

On Fri, Jun 16, 2017 at 01:50:23PM -0500, Tom Lendacky wrote:
> The ioremap() function is intended for mapping MMIO. For RAM, the
> memremap() function should be used. Convert calls from ioremap() to
> memremap() when re-mapping RAM.
> 
> This will be used later by SME to control how the encryption mask is
> applied to memory mappings, with certain memory locations being mapped
> decrypted vs encrypted.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/include/asm/dmi.h   |    8 ++++----
>  arch/x86/kernel/acpi/boot.c  |    6 +++---
>  arch/x86/kernel/kdebugfs.c   |   34 +++++++++++-----------------------
>  arch/x86/kernel/ksysfs.c     |   28 ++++++++++++++--------------
>  arch/x86/kernel/mpparse.c    |   10 +++++-----
>  arch/x86/pci/common.c        |    4 ++--
>  drivers/firmware/dmi-sysfs.c |    5 +++--
>  drivers/firmware/pcdp.c      |    4 ++--
>  drivers/sfi/sfi_core.c       |   22 +++++++++++-----------
>  9 files changed, 55 insertions(+), 66 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
