Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35969 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752704AbcLIDu7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Dec 2016 22:50:59 -0500
Date: Fri, 9 Dec 2016 13:50:41 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported
 from asm
Message-ID: <20161209135041.5ff12770@roar.ozlabs.ibm.com>
In-Reply-To: <20161201152039.GB35881@redhat.com>
References: <20161129135118.24696-1-kilobyte@angband.pl>
        <CA+55aFyZiB4YkwvqzrXO=HD8bcnc2xHkAYrek2QHVnhVvAi3Fw@mail.gmail.com>
        <30bb2db4-47bd-0c35-8328-ef032b551f06@suse.com>
        <CA+55aFxOGw57Gm-QiNs13kfy5k=aRrn3+98415V0g73eGc66mg@mail.gmail.com>
        <20161129195721.GI2697@decadent.org.uk>
        <CA+55aFyQko0t8oMZjhnwhWHrmBUyWjGhsnT=oUOU-W7_04xdzw@mail.gmail.com>
        <20161201051852.28dc335f@roar.ozlabs.ibm.com>
        <CA+55aFzMTrLMrr69ipdaKhz+RJhUu3BxB+kg0689qq_470qEcw@mail.gmail.com>
        <20161201041325.GX35881@redhat.com>
        <20161201153215.43b6cec7@roar.ozlabs.ibm.com>
        <20161201152039.GB35881@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Don Zickus <dzickus@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, skozina@redhat.com, Ben Hutchings <ben@decadent.org.uk>, Michal Marek <mmarek@suse.com>, Adam Borowski <kilobyte@angband.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20161209035041.YS9TS2e62230H0FB4-yWM1kt0UL3QylQSiDQe6P_wfc@z>

On Thu, 1 Dec 2016 10:20:39 -0500
Don Zickus <dzickus@redhat.com> wrote:

> On Thu, Dec 01, 2016 at 03:32:15PM +1100, Nicholas Piggin wrote:
> > > Anyway, MODVERSIONS is our way of protecting our kabi for the last 10 years.
> > > It isn't perfect and we have fixed the genksyms tool over the years, but so
> > > far it mostly works fine.  
> > 
> > Okay. It would be good to get all the distros in on this.
> > 
> > What I want to do is work out exactly what it is that modversions is
> > giving you.
> > 
> > We know it's fairly nasty code to maintain and it does not detect ABI
> > changes very well. But it's not such a burden that we can't maintain
> > it if there are good reasons to keep it.  
> 
> Hi Nick,
> 
> I won't disagree with you there. :-)

Sorry for the late reply, I was moving house and got side tracked.

> modversions is a pretty heavy handed approach that basically says if all the
> symbols and types haven't changed for a given EXPORT_SYMBOL (recursively
> checked), then there is a high degree of confidence the OOT driver will not
> only load, but run correctly.

It's heavy handed in that it is quite complex in the kernel build system,
but it is also light handed in that it does not do a very good job.

I would say the degree of confidence is not very high. People have told
me modversions follows pointers to objects in its calculation, but I have
not seen that to be the case. Even if you did have that, it can not replace
a code review for semantics of data and code.

> The question is how to provide a similar guarantee if a different way?

As a tool to aid distro reviewers, modversions has some value, but the
debug info parsing tools that have been mentioned in this thread seem
superior (not that I've tested them).

> 
> We have plenty of customers with 10 year old drivers, where the expertise
> has long left the company.  The engineers still around, recompile and make
> tweaks to get things working on the latest RHEL.  Verify it passes testing
> and release it.  Then they hope to not touch it again for a few years until
> the next RHEL comes along.
> 
> Scary, huh? :-)

Oh yeah my aim here is not to make distro or out of tree module vendors
life harder, actually the opposite. If it turns out modversions really is
the best approach, I'm not in a position to complain about its complexity
because we have Suse and Redhat people maintaining the build and module
systems :) I just want to see if we can do things better.

Thanks,
Nick
