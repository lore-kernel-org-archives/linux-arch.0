Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:39446 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751540AbdFIKz5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Jun 2017 06:55:57 -0400
Date: Fri, 9 Jun 2017 12:55:40 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v6 04/34] x86/CPU/AMD: Add the Secure Memory Encryption
 CPU feature
Message-ID: <20170609105540.jpkle2qja4kyin6i@pd.tnic>
References: <20170607191309.28645.15241.stgit@tlendack-t1.amdoffice.net>
 <20170607191353.28645.85058.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170607191353.28645.85058.stgit@tlendack-t1.amdoffice.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rik van Riel <riel@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Larry Woodman <lwoodman@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Dave Young <dyoung@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20170609105540.ddPZb15nnXJTk4hS1bVairns_hXv42pVmq-b8c92LiM@z>

On Wed, Jun 07, 2017 at 02:13:53PM -0500, Tom Lendacky wrote:
> Update the CPU features to include identifying and reporting on the
> Secure Memory Encryption (SME) feature.  SME is identified by CPUID
> 0x8000001f, but requires BIOS support to enable it (set bit 23 of
> MSR_K8_SYSCFG).  Only show the SME feature as available if reported by
> CPUID and enabled by BIOS.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/include/asm/cpufeatures.h |    1 +
>  arch/x86/include/asm/msr-index.h   |    2 ++
>  arch/x86/kernel/cpu/amd.c          |   13 +++++++++++++
>  arch/x86/kernel/cpu/scattered.c    |    1 +
>  4 files changed, 17 insertions(+)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
