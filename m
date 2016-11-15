Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:45385 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965615AbcKOPdm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Nov 2016 10:33:42 -0500
Date: Tue, 15 Nov 2016 16:33:39 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v3 04/20] x86: Handle reduction in physical address
 size with SME
Message-ID: <20161115153338.a2cxmatnpqcgiaiy@pd.tnic>
References: <20161110003426.3280.2999.stgit@tlendack-t1.amdoffice.net>
 <20161110003513.3280.12104.stgit@tlendack-t1.amdoffice.net>
 <20161115121035.GD24857@8bytes.org>
 <20161115121456.f4slpk4i2jl3e2ke@pd.tnic>
 <a4cc5b07-89e1-aaa0-1977-1de95883ba62@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a4cc5b07-89e1-aaa0-1977-1de95883ba62@amd.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Joerg Roedel <joro@8bytes.org>, linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rik van Riel <riel@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Larry Woodman <lwoodman@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20161115153339.us4PmJXWJRqiXe9LIxMJx2fzX9hT9YBQXoibxGyPqU8@z>

On Tue, Nov 15, 2016 at 08:40:05AM -0600, Tom Lendacky wrote:
> The feature may be present and enabled even if it is not currently
> active.  In other words, the SYS_CFG MSR bit could be set but we aren't
> actually using encryption (sme_me_mask is 0).  As long as the SYS_CFG
> MSR bit is set we need to take into account the physical reduction in
> address space.

But later in the series I see sme_early_mem_enc() which tests exactly
that mask.

And in patch 12 you have:

+       /*
+        * If memory encryption is active, the trampoline area will need to
+        * be in un-encrypted memory in order to bring up other processors
+        * successfully.
+        */
+       sme_early_mem_dec(__pa(base), size);
+       sme_set_mem_unenc(base, size);

What's up?

IOW, it all sounds to me like you want to have an sme_active() helper
and use it everywhere.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
