From: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from
 asm
Date: Fri, 9 Dec 2016 11:16:51 -0500
Message-ID: <20161209161651.GB35881@redhat.com>
References: <30bb2db4-47bd-0c35-8328-ef032b551f06@suse.com>
 <CA+55aFxOGw57Gm-QiNs13kfy5k=aRrn3+98415V0g73eGc66mg@mail.gmail.com>
 <20161129195721.GI2697@decadent.org.uk>
 <CA+55aFyQko0t8oMZjhnwhWHrmBUyWjGhsnT=oUOU-W7_04xdzw@mail.gmail.com>
 <20161201051852.28dc335f@roar.ozlabs.ibm.com>
 <CA+55aFzMTrLMrr69ipdaKhz+RJhUu3BxB+kg0689qq_470qEcw@mail.gmail.com>
 <20161201041325.GX35881@redhat.com>
 <20161201153215.43b6cec7@roar.ozlabs.ibm.com>
 <20161201152039.GB35881@redhat.com>
 <20161209135041.5ff12770@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60680 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933449AbcLIQRG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Dec 2016 11:17:06 -0500
Content-Disposition: inline
In-Reply-To: <20161209135041.5ff12770@roar.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, skozina@redhat.com, Ben Hutchings <ben@decadent.org.uk>, Michal Marek <mmarek@suse.com>, Adam Borowski <kilobyte@angband.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Dec 09, 2016 at 01:50:41PM +1000, Nicholas Piggin wrote:
> > 
> > We have plenty of customers with 10 year old drivers, where the expertise
> > has long left the company.  The engineers still around, recompile and make
> > tweaks to get things working on the latest RHEL.  Verify it passes testing
> > and release it.  Then they hope to not touch it again for a few years until
> > the next RHEL comes along.
> > 
> > Scary, huh? :-)
> 
> Oh yeah my aim here is not to make distro or out of tree module vendors
> life harder, actually the opposite. If it turns out modversions really is
> the best approach, I'm not in a position to complain about its complexity
> because we have Suse and Redhat people maintaining the build and module
> systems :) I just want to see if we can do things better.

Hi Nick,

I think we are in pretty good agreement here.  We can do better than
modversions.  On the flip side, I would hate to see modversions ripped out
until we have an alternate path forward as it does get us by for now. :-)

Cheers,
Don
