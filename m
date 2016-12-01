From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from
 asm
Date: Thu, 1 Dec 2016 07:26:09 -0800
Message-ID: <20161201152609.GA21862@infradead.org>
References: <CA+55aFyZiB4YkwvqzrXO=HD8bcnc2xHkAYrek2QHVnhVvAi3Fw@mail.gmail.com>
 <30bb2db4-47bd-0c35-8328-ef032b551f06@suse.com>
 <CA+55aFxOGw57Gm-QiNs13kfy5k=aRrn3+98415V0g73eGc66mg@mail.gmail.com>
 <20161129195721.GI2697@decadent.org.uk>
 <CA+55aFyQko0t8oMZjhnwhWHrmBUyWjGhsnT=oUOU-W7_04xdzw@mail.gmail.com>
 <20161201051852.28dc335f@roar.ozlabs.ibm.com>
 <CA+55aFzMTrLMrr69ipdaKhz+RJhUu3BxB+kg0689qq_470qEcw@mail.gmail.com>
 <20161201041325.GX35881@redhat.com>
 <20161201153215.43b6cec7@roar.ozlabs.ibm.com>
 <20161201152039.GB35881@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:33789 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758521AbcLAP0T (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Dec 2016 10:26:19 -0500
Content-Disposition: inline
In-Reply-To: <20161201152039.GB35881@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Don Zickus <dzickus@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, skozina@redhat.com, Ben Hutchings <ben@decadent.org.uk>, Michal Marek <mmarek@suse.com>, Adam Borowski <kilobyte@angband.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Dec 01, 2016 at 10:20:39AM -0500, Don Zickus wrote:
> 
> - provide the memory allocation (instead of having the driver staticly
>   allocate)
> - provide functions to retrieve various internal data (instead of having the
>   driver do direct referencing to deep internal elements)
> - cut down on some static inlines (and use accessory functions instead),
>   etc.
> 
> Those types of changes allow the OOT driver to be more ignorant of kernel
> changes and struct modifications.

All that is counter to what we really want to have:  a well integrated
kernel that moves forward together so that we can see and improve the
whole situation.  No need to make things worse just to help leeches.
Get your damn drivers upstream ASAP and let's stop this discussion..
