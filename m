Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:47678 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbfBLMNy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 Feb 2019 07:13:54 -0500
Date: Tue, 12 Feb 2019 13:13:47 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v7 05/28] x86/asm/entry: annotate THUNKs
Message-ID: <20190212121347.GD30028@zn.tnic>
References: <20190130124711.12463-1-jslaby@suse.cz>
 <20190130124711.12463-6-jslaby@suse.cz>
 <20190209112551.GA5089@zn.tnic>
 <b75f2a0d-974a-c63b-64f8-8f333991e826@suse.cz>
 <20190212110501.GB30028@zn.tnic>
 <6b6aebb5-5f7c-e3b7-545e-3a4558e01e66@suse.cz>
 <20190212114654.GC30028@zn.tnic>
 <37e83ece-28c0-a7ec-86a3-b9b5ca2c61f6@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <37e83ece-28c0-a7ec-86a3-b9b5ca2c61f6@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: mingo@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Message-ID: <20190212121347.0cHp1RRC_M9D-ytcZ7hFRCRT7jMlmlA-n-AlaNRq4jA@z>

On Tue, Feb 12, 2019 at 12:51:08PM +0100, Jiri Slaby wrote:
> And what if the LOCAL macros prepend .L automatically? The references
> would need to be via macro or by manually adding .L. I mean:
> 
> SYM_CODE_START_LOCAL(function)
>   ret
> SYM_CODE_END(function)
> 
> And then used as:
> call .Lfunction
> or
> call SYM_LOCAL(function)
> 
> Is that too ugly?

I'd prefer SYM_LOCAL because not everyone is aware of the fact that the
GNU toolchain makes .L-prepended symbols local.

However:

"Local Symbol Names

A local symbol is any symbol beginning with certain local label
prefixes. By default, the local label prefix is `.L' for ELF systems or
`L' for traditional a.out systems, but each target may have its own set
of local label prefixes. On the HPPA local symbols begin with `L$'."

Now if you make those macros arch-independent, you need to have the
correct local symbol definition for those arches and targets(!) which
differ.

If you don't macroize the local symbols stuff, OTOH, then that's one
less problem you have.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
