From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from
 asm
Date: Tue, 29 Nov 2016 14:29:54 +0100
Message-ID: <20161129132953.GB24321@gmail.com>
References: <CA+55aFwXqv6uYmW0kC=c+yyumO_T0CJrz6m+MQCQX6bR5gRBQw@mail.gmail.com>
 <1480382148.16599.61.camel@decadent.org.uk>
 <CA+55aFwDJ8=LQ6jKYuFGZHqbbRoX+Odvnm5BXobNVojqesF1gw@mail.gmail.com>
 <20161129131922.GA31466@angband.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36160 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932645AbcK2N36 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Nov 2016 08:29:58 -0500
Content-Disposition: inline
In-Reply-To: <20161129131922.GA31466@angband.pl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Adam Borowski <kilobyte@angband.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ben Hutchings <ben@decadent.org.uk>, Nicholas Piggin <npiggin@gmail.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michal Marek <mmarek@suse.com>, Arnd Bergmann <arnd@arndb.de>, Debian kernel maintainers <debian-kernel@lists.debian.org>, Al Viro <viro@zeniv.linux.org.uk>


* Adam Borowski <kilobyte@angband.pl> wrote:

> Here's some history:
> The day of -rc1, multiple people immediately reported the breakage; it was
> quickly found out that reverting 784d5699eddc fixes it.  A "going forward"
> patch has been posted but was insufficient; when the real devs went to bed
> the last message was
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1250370.html
> which ends with instructions and "Care to do a patch for x86?".
> 
> Then a random person (me) did the legwork, gathered affected symbols, wrote
> and tested the x86 patch.  It was then tested by multiple people; Arnd
> Bergmann wrote the ARM equivalent.  Whenever a new lkml thread reporting the
> breakage popped up, we pointed people to the patches and everyone was happy.
> As for upstreaming, there was a delay because Michal Marek was on vacation.
> 
> Michal returned and sent you the pull request, you merged it as 04e36857 on
> Nov 18.  For some reason the per-arch pieces were excluded; I was instructed
> to send my part to x86 maintainers.
> 
> I did so; the patch later got a better description by Nick and a bunch of
> Tested-by -- but alas, nary a comment or action from x86 guys, despite
> pings/resends (last one: https://lkml.org/lkml/2016/11/23/706).  I guess I'm
> lacking the secret handshake or something -- thus, it looks like it's my
> fault, the rest of you can be blamed mostly for letting a
> not-a-real-kernel-dev unsupervised.

My part of the story is easy to explain: the reason I skipped the 11/23 patch was 
because it was tagged 'kbuild' and because the commit that broke it was never 
acked by (or was upstreamed via) the x86 maintainers - we never upstreamed any 
modversions changes in the past AFAIR - so I assumed it would be handled via 
whatever path got the breakage upstream (turns out it was via the VFS tree?),
or via the kbuild tree.

> On Nov 24 finally Ingo responded, the discussion ended with you marking 
> modversions as BROKEN.

Yeah, that was when my internal timer ran out: modversions breakage was reported 
against -rc1 already and it still wasn't working (a seemingly working kernel build 
resulted in an unbootable system) - due to the timeline and confusion you 
explained.

I totally agree with marking it BROKEN: it was the simplest, most robust way to 
fix it and nobody seemed to be owning the modversions feature.

Thanks,

	Ingo
