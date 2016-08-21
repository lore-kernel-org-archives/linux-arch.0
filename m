From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] ARC: uaccess: get_user to zero out dest in cause of fault
Date: Sat, 20 Aug 2016 17:45:00 -0700
Message-ID: <CA+55aFyYOZ2U=Fb=oGrVzqvKUprFOAdL8Ra7sTw5KhgibvN0pA@mail.gmail.com>
References: <1471633802-2936-1-git-send-email-vgupta@synopsys.com>
 <20160819212428.GR2356@ZenIV.linux.org.uk> <CA+55aFyvBd+sMTC-NsEG4QzVApmy0UhSfpoVOP58m-Zg2wumPQ@mail.gmail.com>
 <CA+55aFyB_r5KMJrYMygdkFw-UdxFUCExQJDL-d2Cd+Sk2+xLrw@mail.gmail.com>
 <CA+55aFx9ih9WX-8iUM95fvbuFJ8hf-dK6vwKsVZPh=fdcSB8Cg@mail.gmail.com> <20160821001141.GV2356@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33848 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752517AbcHUApC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 20 Aug 2016 20:45:02 -0400
In-Reply-To: <20160821001141.GV2356@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>, Jakub Jelinek <jakub@redhat.com>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>

On Sat, Aug 20, 2016 at 5:11 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Interesting...  BTW, how's this in the "really vile tricks" department?
>
>         if (!uaccess_begin())
>                 goto fail;

So I slightly considered it, because gcc actually has support for that
kind of behavior thanks to setjmp/longjmp (and yes, the compiler
actually needs to know about the magic "this code can be entered a
second time from elsewhere" - it _used_ to be purely a library thing
back in the days of stupid compilers, but no more).

And I'm not saying it's wrong, but I'm not a huge fan of
setjmp/longjmp. Afaik it tends to make gcc generate potentially much
worse code in the function that uses setjmp.

That said, you have a really strong argument that I hadn't even thought about:

> AFAICS, it should avoid the problems with asm goto, right?

Yes. That was something I never even thought about. I just thought
"asm goto has some limitations, but they aren't _fundamental_, so
hopefully they get fixed". But they may not be fundamental, but it
will take a long time. If ever.

And you're right, using setjmp semantics would avoid all that and
"just work". Even for "get_user()" that needs to return a value.

Hmm.

You have to save the stack pointer at the setjmp point too. And there
might be other architecture-specific ABI rules for that. But you're
right, it might be worth it.

I *would* be a bit worried about code generation issues.
setjmp/longjmp is so seldom used that it's one of those things where
it might be best to verify with some gcc person that it doesn't cause
huge code-gen problems.

Adding Jakub just to check: Jakub, would a setjump/longjump kind of
interface for exception handling going to cause us problems
(performance or correctness) with gcc?

            Linus
