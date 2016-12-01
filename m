From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from
 asm
Date: Thu, 1 Dec 2016 17:06:11 +0100
Message-ID: <20161201160611.GA30910@kroah.com>
References: <CA+55aFxOGw57Gm-QiNs13kfy5k=aRrn3+98415V0g73eGc66mg@mail.gmail.com>
 <20161129195721.GI2697@decadent.org.uk>
 <CA+55aFyQko0t8oMZjhnwhWHrmBUyWjGhsnT=oUOU-W7_04xdzw@mail.gmail.com>
 <20161201051852.28dc335f@roar.ozlabs.ibm.com>
 <CA+55aFzMTrLMrr69ipdaKhz+RJhUu3BxB+kg0689qq_470qEcw@mail.gmail.com>
 <20161201041325.GX35881@redhat.com>
 <20161201153215.43b6cec7@roar.ozlabs.ibm.com>
 <20161201152039.GB35881@redhat.com>
 <20161201152609.GA21862@infradead.org>
 <20161201154059.GC35881@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:55516 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760444AbcLAQGD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Dec 2016 11:06:03 -0500
Content-Disposition: inline
In-Reply-To: <20161201154059.GC35881@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Don Zickus <dzickus@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, skozina@redhat.com, Ben Hutchings <ben@decadent.org.uk>, Michal Marek <mmarek@suse.com>, Adam Borowski <kilobyte@angband.pl>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Dec 01, 2016 at 10:40:59AM -0500, Don Zickus wrote:
> Unfortunately, there are various drivers that will never go upstream
> 
> - paid storage drivers that provide bells and whistles on top of inbox
>   driver

That's because the developer doesn't want them upstream, that's their
fault, nothing we can do about them.

> - old drivers/fs that application has been relying on for a long time but
>   company doesn't have resources to migrate to current technology.

That's what drivers/staging/ is for, I'll take anything that builds (and
sometimes stuff that doesn't build) as long as people are actually using
it.  So send the stuff that is in this category on to me and that will
reduce your burden a _lot_.

thanks,

greg k-h
