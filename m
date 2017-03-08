Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:57274 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751803AbdCHPef (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 8 Mar 2017 10:34:35 -0500
Date: Wed, 8 Mar 2017 16:05:20 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v4 28/28] x86: Add support to make use of Secure
 Memory Encryption
Message-ID: <20170308150520.fwdrit6bjweqsztq@pd.tnic>
References: <20170216154158.19244.66630.stgit@tlendack-t1.amdoffice.net>
 <20170216154825.19244.32545.stgit@tlendack-t1.amdoffice.net>
 <20170301184055.gl3iic3gir6zzb23@pd.tnic>
 <7e6c308f-3caf-5531-3cb2-9b6986f4288e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7e6c308f-3caf-5531-3cb2-9b6986f4288e@amd.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rik van Riel <riel@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Ingo Molnar <mingo@redhat.com>, Alexander Potapenko <glider@google.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Thomas Gleixner <tglx@linutronix.de>, Larry Woodman <lwoodman@redhat.com>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20170308150520.Qh6kHfGd7Fyxq2-ik1E1zml-cITP6YV_eomXuMTD9aE@z>

On Tue, Mar 07, 2017 at 10:05:00AM -0600, Tom Lendacky wrote:
> > And then you need to correct the function signature in the
> > !CONFIG_AMD_MEM_ENCRYPT case, at the end of this file, too:
> > 
> > unsigned long __init sme_enable(struct boot_params *bp)		{ return 0; }
> 
> Yup, missed that.  I'll make it match.

Or, you can do this:

unsigned long __init sme_enable(void *boot_data)
{
#ifdef CONFIG_AMD_MEM_ENCRYPT
        struct boot_params *bp = boot_data;
        unsigned int eax, ebx, ecx, edx;
        unsigned long cmdline_ptr;

	...

out:
#endif /* CONFIG_AMD_MEM_ENCRYPT */
        return sme_me_mask;
}

and never worry for function headers going out of whack.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
