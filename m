From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported
 from asm
Date: Thu, 1 Dec 2016 12:55:45 +1100
Message-ID: <20161201125545.406d092c@roar.ozlabs.ibm.com>
References: <20161129131922.GA31466@angband.pl>
        <20161129135118.24696-1-kilobyte@angband.pl>
        <CA+55aFyZiB4YkwvqzrXO=HD8bcnc2xHkAYrek2QHVnhVvAi3Fw@mail.gmail.com>
        <30bb2db4-47bd-0c35-8328-ef032b551f06@suse.com>
        <CA+55aFxOGw57Gm-QiNs13kfy5k=aRrn3+98415V0g73eGc66mg@mail.gmail.com>
        <20161129195721.GI2697@decadent.org.uk>
        <CA+55aFyQko0t8oMZjhnwhWHrmBUyWjGhsnT=oUOU-W7_04xdzw@mail.gmail.com>
        <20161201051852.28dc335f@roar.ozlabs.ibm.com>
        <CA+55aFzMTrLMrr69ipdaKhz+RJhUu3BxB+kg0689qq_470qEcw@mail.gmail.com>
        <1480541581.16599.78.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36607 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753428AbcLAB4H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Nov 2016 20:56:07 -0500
In-Reply-To: <1480541581.16599.78.camel@decadent.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Michal Marek <mmarek@suse.com>, Adam Borowski <kilobyte@angband.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, 30 Nov 2016 21:33:01 +0000
Ben Hutchings <ben@decadent.org.uk> wrote:

> On Wed, 2016-11-30 at 10:40 -0800, Linus Torvalds wrote:
> > > On Wed, Nov 30, 2016 at 10:18 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
> > > 
> > > Here's an initial rough hack at removing modversions. It gives an idea
> > > of the complexity we're carrying for this feature (keeping in mind most
> > > of the lines removed are generated parser).  
> > 
> > You definitely don't have to try to convince me. We've had many issues
> > with modversions over the years. This was just the "last drop" as far
> > as I'm concerned, we've had random odd crc generation failures due to
> > some build races too.
> >   
> > > In its place I just added a simple config option to override vermagic
> > > so distros can manage it entirely themselves.  
> > 
> > So at least Fedora doesn't even enable CONFIG_MODVERSIONS as-is. I'm
> > _hoping_ it's just Debian that wants this,  
> 
> The last time I looked, RHEL and SLE did.  They change the release
> string for each new kernel version, but they will copy/link old out-of-
> tree modules into the new version's "weak-updates" module subdirectory
> if the symbol versions still match.
> 
> > and we'd need to get some
> > input from the Debian people whether that "control vermagic" is
> > sufficient? I suspect it isn't, but I can't come up with any simple
> > alternate model either..  
> 
> Allowing the vermagic to be changed separately doesn't help us, as we
> already control the release string.  If we were to change some of the
> module tools to consider vermagic then it would allow us to report the
> full version in the release string while not forcing rebuilds on every
> kernel upgrade - but that's not a pressing problem.

Okay, but existing modversions AFAIKS does not solve your problems described
in yor your earlier mail either. Modversions hardly catches ABI breakage at
all, you can't rely on it that way. It's far more likely that some structure
size changes deep in the kernel than an exported function type signature
changes.

I'm not sure how you know which exports are used only by in-tree modules
and which are used out of tree, but if you know that then you can version
them manually as we said by adding _v2 in the rare case you need to change
a behaviour.

So I'm still having trouble understanding what modversions is giving you.

> One thing that could work for us would be:
> 
> - Stricter version matching for in-tree modules (maybe some extra
>   part in vermagic that is skipped for out-of-tree modules)
> - Ability to blacklist use of a symbol, or all symbols in a module,
>   by out-of-tree modules
> 
> where the blacklist would be a matter of distribution policy.  But this
> would still require a fair amount of work by someone, and I doubt you'd
> want this upstream.

I don't think people are adverse to carrying some upstream complexity for
ditsros. Although for this fancy blacklist case, can it just be done in
userspace?

Thanks,
Nick
