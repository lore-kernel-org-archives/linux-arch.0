From: Adam Borowski <kilobyte@angband.pl>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from
 asm
Date: Tue, 29 Nov 2016 14:19:22 +0100
Message-ID: <20161129131922.GA31466@angband.pl>
References: <CA+55aFwXqv6uYmW0kC=c+yyumO_T0CJrz6m+MQCQX6bR5gRBQw@mail.gmail.com>
 <1480382148.16599.61.camel@decadent.org.uk>
 <CA+55aFwDJ8=LQ6jKYuFGZHqbbRoX+Odvnm5BXobNVojqesF1gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFwDJ8=LQ6jKYuFGZHqbbRoX+Odvnm5BXobNVojqesF1gw@mail.gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ben Hutchings <ben@decadent.org.uk>, Nicholas Piggin <npiggin@gmail.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michal Marek <mmarek@suse.com>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Debian kernel maintainers <debian-kernel@lists.debian.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Nov 28, 2016 at 08:08:57PM -0800, Linus Torvalds wrote:
> On Mon, Nov 28, 2016 at 5:15 PM, Ben Hutchings <ben@decadent.org.uk> wrote:
> >>
> >> The modversions stuff may just be too painful to bother with. Very few
> >> people probably use it, and the ones that do likely don't have any
> >> overriding reason why.
> > [...]
> >
> > Debian has some strong reasons:
> 
> Honestly, I'd just like to see actual real patches from people who
> care about this.
> 
> The reason I disabled it entirely was simply that the discussions had
> been going on forever, but nobody actually seemed to care enough to
> just fix the damn thing. There was all the _noise_ about "look, here's
> a patch", but nothing got sent to maintainers and actually actively
> pushed as a "this fixes a regression".

Here's some history:
The day of -rc1, multiple people immediately reported the breakage; it was
quickly found out that reverting 784d5699eddc fixes it.  A "going forward"
patch has been posted but was insufficient; when the real devs went to bed
the last message was
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1250370.html
which ends with instructions and "Care to do a patch for x86?".

Then a random person (me) did the legwork, gathered affected symbols, wrote
and tested the x86 patch.  It was then tested by multiple people; Arnd
Bergmann wrote the ARM equivalent.  Whenever a new lkml thread reporting the
breakage popped up, we pointed people to the patches and everyone was happy.
As for upstreaming, there was a delay because Michal Marek was on vacation.

Michal returned and sent you the pull request, you merged it as 04e36857 on
Nov 18.  For some reason the per-arch pieces were excluded; I was instructed
to send my part to x86 maintainers.

I did so; the patch later got a better description by Nick and a bunch of
Tested-by -- but alas, nary a comment or action from x86 guys, despite
pings/resends (last one: https://lkml.org/lkml/2016/11/23/706).  I guess I'm
lacking the secret handshake or something -- thus, it looks like it's my
fault, the rest of you can be blamed mostly for letting a
not-a-real-kernel-dev unsupervised.

On Nov 24 finally Ingo responded, the discussion ended with you marking
modversions as BROKEN.


> So somebody send me a minimal patch that is
> 
>  (a) tested
>  (b) explains it
>  (c) obvious
> 
> and I'll happily re-enable modversions.

Not sure whether you guys want to revert or to go forward.  If the latter,
my piece handles x86, Arnd's ARM.  Powerpc already has the needed bits in
mainline.  I've just tried arm64 -- despite same toolchain versions as
failing x86, with CONFIG_MODVERSIONS=y it loaded a bunch of modules fine so
it appears no arch bits are needed there.  My uneducated guess is that most
other architectures should be fine without special handling, too.  It'd be
nice if someone with an actual clue could confirm.


Meow!
-- 
The bill declaring Jesus as the King of Poland fails to specify whether
the addition is at the top or end of the list of kings.  What should the
historians do?
