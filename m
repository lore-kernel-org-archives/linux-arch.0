From: Adam Borowski <kilobyte@angband.pl>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from
 asm
Date: Tue, 29 Nov 2016 15:24:08 +0100
Message-ID: <20161129142408.GA8105@angband.pl>
References: <CA+55aFwXqv6uYmW0kC=c+yyumO_T0CJrz6m+MQCQX6bR5gRBQw@mail.gmail.com>
 <1480382148.16599.61.camel@decadent.org.uk>
 <CA+55aFwDJ8=LQ6jKYuFGZHqbbRoX+Odvnm5BXobNVojqesF1gw@mail.gmail.com>
 <20161129131922.GA31466@angband.pl>
 <20161129132953.GB24321@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from tartarus.angband.pl ([89.206.35.136]:47919 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754373AbcK2OYR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Nov 2016 09:24:17 -0500
Content-Disposition: inline
In-Reply-To: <20161129132953.GB24321@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ben Hutchings <ben@decadent.org.uk>, Nicholas Piggin <npiggin@gmail.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michal Marek <mmarek@suse.com>, Arnd Bergmann <arnd@arndb.de>, Debian kernel maintainers <debian-kernel@lists.debian.org>, Al Viro <viro@zeniv.linux.org.uk>

On Tue, Nov 29, 2016 at 02:29:54PM +0100, Ingo Molnar wrote:
> * Adam Borowski <kilobyte@angband.pl> wrote:
> 
> > Here's some history:
> > The day of -rc1, multiple people immediately reported the breakage; it was
> > quickly found out that reverting 784d5699eddc fixes it.  A "going forward"
> > patch has been posted but was insufficient; when the real devs went to bed
[...]
> > For some reason the per-arch pieces were excluded; I was instructed
> > to send my part to x86 maintainers.
> > 
> > I did so; the patch later got a better description by Nick and a bunch of
> > Tested-by -- but alas, nary a comment or action from x86 guys, despite
> > pings/resends (last one: https://lkml.org/lkml/2016/11/23/706).  I guess I'm
> > lacking the secret handshake or something -- thus, it looks like it's my
> > fault, the rest of you can be blamed mostly for letting a
> > not-a-real-kernel-dev unsupervised.
> 
> My part of the story is easy to explain: the reason I skipped the 11/23 patch was 
> because it was tagged 'kbuild' and because the commit that broke it was never 
> acked by (or was upstreamed via) the x86 maintainers - we never upstreamed any 
> modversions changes in the past AFAIR - so I assumed it would be handled via 
> whatever path got the breakage upstream (turns out it was via the VFS tree?),
> or via the kbuild tree.

The problematic merge was 84d6984 (it brought in 22823ab4^..590abbdd).
Interesting commits have "$ARCH: move exports to definitions" in their
subjects, they indeed did not go through arch trees.

> > On Nov 24 finally Ingo responded, the discussion ended with you marking 
> > modversions as BROKEN.
> 
> Yeah, that was when my internal timer ran out: modversions breakage was reported 
> against -rc1 already and it still wasn't working (a seemingly working kernel build 
> resulted in an unbootable system) - due to the timeline and confusion you 
> explained.
> 
> I totally agree with marking it BROKEN: it was the simplest, most robust way to 
> fix it and nobody seemed to be owning the modversions feature.

Per Ben Hutchings' objection, it doesn't look like BROKEN is an option at
least for 4.9 -- even if mainline leaves it as is, distro maintainers would
need to do the work themselves.

Architectures that look like they could be affected:
    x86 alpha m68k s390 arm ppc sparc ia64
(this list might be incomplete!).

Of these, ppc and arm are already fixed, x86 is in this thread,
arm64 is not on the list which explains why it works for me.  No idea about
the rest.


Meow!
-- 
The bill declaring Jesus as the King of Poland fails to specify whether
the addition is at the top or end of the list of kings.  What should the
historians do?
