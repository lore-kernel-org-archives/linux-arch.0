Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:57963 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932423AbdBPSOQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 Feb 2017 13:14:16 -0500
Date: Thu, 16 Feb 2017 19:13:55 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v4 03/28] x86: Add the Secure Memory Encryption CPU
 feature
Message-ID: <20170216181355.bjxo2h6vlhukz4ih@pd.tnic>
References: <20170216154158.19244.66630.stgit@tlendack-t1.amdoffice.net>
 <20170216154236.19244.7580.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170216154236.19244.7580.stgit@tlendack-t1.amdoffice.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rik van Riel <riel@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Ingo Molnar <mingo@redhat.com>, Alexander Potapenko <glider@google.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Thomas Gleixner <tglx@linutronix.de>, Larry Woodman <lwoodman@redhat.com>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20170216181355.8dyGwMT0TYsvFP5pKXBBwrfmFST-X_uqPkxbZ3O35sQ@z>

On Thu, Feb 16, 2017 at 09:42:36AM -0600, Tom Lendacky wrote:
> Update the CPU features to include identifying and reporting on the
> Secure Memory Encryption (SME) feature.  SME is identified by CPUID
> 0x8000001f, but requires BIOS support to enable it (set bit 23 of
> SYS_CFG MSR).  Only show the SME feature as available if reported by
> CPUID and enabled by BIOS.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/include/asm/cpufeature.h        |    7 +++++--
>  arch/x86/include/asm/cpufeatures.h       |    5 ++++-
>  arch/x86/include/asm/disabled-features.h |    3 ++-
>  arch/x86/include/asm/msr-index.h         |    2 ++
>  arch/x86/include/asm/required-features.h |    3 ++-
>  arch/x86/kernel/cpu/common.c             |   19 +++++++++++++++++++
>  6 files changed, 34 insertions(+), 5 deletions(-)

What happened here?

You had it already:

https://lkml.kernel.org/r/20161110003459.3280.25796.stgit@tlendack-t1.amdoffice.net

The bit in get_cpu_cap() with checking the MSR you can add at the end of
init_amd() for example.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
