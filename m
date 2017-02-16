Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:56548 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933101AbdBPUGa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 Feb 2017 15:06:30 -0500
Date: Thu, 16 Feb 2017 21:06:08 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v4 03/28] x86: Add the Secure Memory Encryption CPU
 feature
Message-ID: <20170216200608.xli5fybhh3mhlujw@pd.tnic>
References: <20170216154158.19244.66630.stgit@tlendack-t1.amdoffice.net>
 <20170216154236.19244.7580.stgit@tlendack-t1.amdoffice.net>
 <20170216181355.bjxo2h6vlhukz4ih@pd.tnic>
 <a1a6a6d7-3aac-3138-1e75-6160f0427a6b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a1a6a6d7-3aac-3138-1e75-6160f0427a6b@amd.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rik van Riel <riel@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Ingo Molnar <mingo@redhat.com>, Alexander Potapenko <glider@google.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Thomas Gleixner <tglx@linutronix.de>, Larry Woodman <lwoodman@redhat.com>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20170216200608.5ygdyoEZ_nSR-V2H5H7gYXU063h5612GQ0Yc7FVoXtM@z>

On Thu, Feb 16, 2017 at 01:42:13PM -0600, Tom Lendacky wrote:
> I realize it's a bit more code and expands the changes but I thought it
> would be a bit clearer as to what was going on this way. And then the
> follow on patch for the physical address reduction goes in nicely, too.

Well, the code from the next patch should go to AMD-specific place like
arch/x86/kernel/cpu/amd.c anyway, where you don't have to do vendor
checks.

> If you prefer I stay with the scattered feature approach and then clear
> the bit based on the MSR at the end of init_amd() I can do that. I'm
> not attached to either method.

Yes please. We should keep the shole X86_FEATURE machinery from
exploding in size. Especially if CPUID_0x8000001f is not a leaf we're
going to be adding the majority of its bits, to warrant a separate
->x86_capability array element.

  [If it does later, we can always move it to a separate element. ]

Thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
