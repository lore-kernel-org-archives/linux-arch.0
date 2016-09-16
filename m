Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:39241 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752388AbcIPHI2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 16 Sep 2016 03:08:28 -0400
Date: Fri, 16 Sep 2016 09:08:27 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v2 15/20] iommu/amd: AMD IOMMU support for memory
 encryption
Message-ID: <20160916070827.GA23229@nazgul.tnic>
References: <20160822223529.29880.50884.stgit@tlendack-t1.amdoffice.net>
 <20160822223820.29880.17752.stgit@tlendack-t1.amdoffice.net>
 <20160912114550.nwhtpmncwp22l7vy@pd.tnic>
 <27bc5c87-3a74-a1ee-55b1-7f19ec9cd6cc@amd.com>
 <20160914144139.GA9295@nazgul.tnic>
 <421c767b-2410-2537-4f4e-b70670898fee@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <421c767b-2410-2537-4f4e-b70670898fee@amd.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20160916070827.0itqyI-K49eXXkkYFlhy8juITUall86wGLwGS_kD4p4@z>

On Thu, Sep 15, 2016 at 11:57:41AM -0500, Tom Lendacky wrote:
> If I do that, then I could put an #ifdef in the header to include the
> asm/mem_encrypt.h if the memory encryption is configured, else set the
> value to zero.

Yeah, something along those lines...

> I'll look into this. One immediate question becomes do we keep the
> name very specific vs. making it more generic, sme_me_mask vs me_mask,
> etc.

No strong opinion either way from me. My angle is that whatever it is,
we can always rename it later if we decide to.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
