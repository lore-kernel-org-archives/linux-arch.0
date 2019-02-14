Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:41278 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405023AbfBNKfE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 14 Feb 2019 05:35:04 -0500
Date: Thu, 14 Feb 2019 11:34:57 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v7 05/28] x86/asm/entry: annotate THUNKs
Message-ID: <20190214103457.GA12467@zn.tnic>
References: <20190130124711.12463-1-jslaby@suse.cz>
 <20190130124711.12463-6-jslaby@suse.cz>
 <20190209112551.GA5089@zn.tnic>
 <b75f2a0d-974a-c63b-64f8-8f333991e826@suse.cz>
 <20190212110501.GB30028@zn.tnic>
 <6b6aebb5-5f7c-e3b7-545e-3a4558e01e66@suse.cz>
 <20190212114654.GC30028@zn.tnic>
 <37e83ece-28c0-a7ec-86a3-b9b5ca2c61f6@suse.cz>
 <20190212121347.GD30028@zn.tnic>
 <cd09f00f-7174-4d06-50a2-3cc056b7d763@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cd09f00f-7174-4d06-50a2-3cc056b7d763@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: mingo@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Message-ID: <20190214103457.bjmczVn0NhdxkzO8tjzMcQxA7B7svcueYYhXbeTBxjw@z>

On Thu, Feb 14, 2019 at 11:03:14AM +0100, Jiri Slaby wrote:
> first results in objtool complaints:
> > arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x190: unsupported intra-function call
> > arch/x86/entry/entry_64.o: warning: objtool: If this is a retpoline, please patch it in with alternatives and annotate it with ANNOTATE_NOSPEC_ALTERNATIVE.

objtool can be fixed.

> and also the crash is misleading:
> > BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> > #PF error: [WRITE] 
> > PGD 0 P4D 0 
> > Oops: 0002 [#1] PREEMPT SMP
> ...
> > RIP: 0010:__switch_to_asm+0x70/0x80

You have RIP.

But yes, there is some disadvantage of not having global symbols vs
polluting the ELF symtable with random ones.

If we're going to keep them global, then we should at least make sure
their names have proper prefix so that at least one can map them to the
kernel namespace they belong to and there is no confusion when staring
at stack traces.

Also, they should not be a lot because the places where we do all these
funky trampoline etc games where a chunk of code is outside of the
boundaries of a function, are only a couple.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
