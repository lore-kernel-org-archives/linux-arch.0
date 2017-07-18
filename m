Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:32822 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751457AbdGRQ5K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Jul 2017 12:57:10 -0400
MIME-Version: 1.0
In-Reply-To: <20170718140651.15973-7-ebiederm@xmission.com>
References: <87o9shg7t7.fsf_-_@xmission.com> <20170718140651.15973-7-ebiederm@xmission.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 18 Jul 2017 09:57:09 -0700
Message-ID: <CA+55aFyKsmf+BpYjcH30MGpHTDJ=zgYPx6kwyEB9CXXFxj_xsw@mail.gmail.com>
Subject: Re: [PATCH 7/7] signal: Remove kernel interal si_code magic
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, Andrei Vagin <avagin@virtuozzo.com>, Thomas Gleixner <tglx@linutronix.de>, Greg KH <greg@kroah.com>, Andrey Vagin <avagin@openvz.org>, Serge Hallyn <serge@hallyn.com>, Pavel Emelyanov <xemul@virtuozzo.com>, Cyrill Gorcunov <gorcunov@openvz.org>, Peter Zijlstra <peterz@infradead.org>, Willy Tarreau <w@1wt.eu>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Linux Containers <containers@lists.linux-foundation.org>, Michael Kerrisk <mtk.manpages@gmail.com>
Message-ID: <20170718165709.y5bnAGeiW1_ep3Y5rNi1fMMfx3uYETfMyRuc4-efjfU@z>

On Tue, Jul 18, 2017 at 7:06 AM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> struct siginfo is a union and the kernel since 2.4 has been hiding a union
> tag in the high 16bits of si_code using the values:
> __SI_KILL
> __SI_TIMER
> __SI_POLL
> __SI_FAULT
> __SI_CHLD
> __SI_RT
> __SI_MESGQ
> __SI_SYS
>
> While this looks plausible on the surface, in practice this situation has
> not worked well.

So on the whole I think we just need to do this, but the part I really
hate about this series is still this the siginfo_layout() part.

I can well believe that it is needed for the compat case. siginfo is a
piece of crap crazy type, and re-ordering fields for compat is
something we are always going to have to do.

But for the native case, the *only* reason we do not just copy the
siginfo as-is seems to be that it's just too big, due to other bad
design decisions in siginfo ("let's make sure it's big enough by
allocating 512 bytes for it).

And afaik, absolutely nobody uses more than about 36 bytes of that
512-byte _sifields union (and that one use is SIGILL with three
pointers and three integers and some padding.

So why don't we just say "screw this idiotic layout crap, and just
unconditionally copy that much smaller maximum of bytes"?

Leave that layout thing purely for compat handling.

Yes, yes, there's a couple of small gotchas's:

 - "_sys_private" for posix timers, and it would have to be moved to
the end of the structure so that it doesn't get copied.

 - make sure those 36 bytes are cleared when allocating the siginfo
(this should be trivial) so that we don't leak any other memory.

But on the whole, it looks pretty straightforward to just get rid of
those stupid layout things, and make them purely about compat stuff.

Please?

The si_code stuff clearly needs to be done regardless, so much of this
patch series looks good to me.  But if we're doign this cleanup, can't
we please go that one extra step and get rid of the crazy "let's treat
the union as different types", and just treat it as a largely opaque
thing.

Pretty please?

                  Linus
