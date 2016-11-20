Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:46683 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750728AbcKTXEm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 20 Nov 2016 18:04:42 -0500
Date: Mon, 21 Nov 2016 00:04:35 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v3 10/20] Add support to access boot related data in
 the clear
Message-ID: <20161120230435.gqjp7gboshhqplbf@pd.tnic>
References: <20161110003426.3280.2999.stgit@tlendack-t1.amdoffice.net>
 <20161110003631.3280.73292.stgit@tlendack-t1.amdoffice.net>
 <20161117155543.vg3domfqm3bhp4f7@pd.tnic>
 <f7bf8301-7d91-dd43-d5f0-05e977c0c5a2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f7bf8301-7d91-dd43-d5f0-05e977c0c5a2@amd.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rik van Riel <riel@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Larry Woodman <lwoodman@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20161120230435.5Z2qq_xU_7Mcxw7QmBASpjpMcEtsNOqmjoVIbMhwAIU@z>

On Sat, Nov 19, 2016 at 12:33:49PM -0600, Tom Lendacky wrote:
> >> +{
> >> +	/* SME is not active, just return true */
> >> +	if (!sme_me_mask)
> >> +		return true;
> > 
> > I don't understand the logic here: SME is not active -> apply encryption?!
> 
> It does seem counter-intuitive, but it is mainly because of the memremap
> vs. early_memremap support. For the early_memremap support, if the
> sme_me_mask is 0 it doesn't matter whether we return true or false since
> the mask is zero even if you try to apply it. But for the memremap
> support, it's used to determine whether to do the ram remap vs an
> ioremap.
> 
> I'll pull the sme_me_mask check out of the function and put it in the
> individual functions to remove the contradiction and make things
> clearer.

But that would be more code, right?

Instead, you could simply explain in a comment above it what do you
mean exactly. Something along the lines of "if sme_me_mask is not
set, we should map encrypted because if not set, we can simply remap
RAM. Otherwise we have to ioremap because we need to access it in the
clear..."

I presume - I still don't grok that difference here completely.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
