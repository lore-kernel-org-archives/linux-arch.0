From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/1] Add new syscall sys_sendmmsg to generic unistd
Date: Sun, 29 May 2011 20:27:10 +0200
Message-ID: <201105292027.10350.arnd@arndb.de>
References: <1306613969-9426-1-git-send-email-jonas.bonn@gmail.com> <201105282324.31818.arnd@arndb.de> <1306619746.3001.977.camel@localhost>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:53082 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755219Ab1E2S1N (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 29 May 2011 14:27:13 -0400
In-Reply-To: <1306619746.3001.977.camel@localhost>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonas Bonn <jonas@southpole.se>
Cc: linux-arch@vger.kernel.org

On Saturday 28 May 2011 23:55:46 Jonas Bonn wrote:
> On Sat, 2011-05-28 at 23:24 +0200, Arnd Bergmann wrote:
> > I just saw your git tree for the OpenRISC architecture port and it
> > looks really really nice, mostly by virtue of being very small, but
> > also by not copying all the things that new architecture ports normally
> > get wrong at the time when they show up on my radar.
> 
> > Do you plan to submit it upstream any time soon?
> 
> Yes, it's pretty much ready for submission.  There are a couple of areas
> that I'm aware of that still need some work and there are some cleanups
> to do, but everything that faces userspace (ABI) has settled so it's
> stuff that could be done even after merging upstream.

Ok, great! Please submit them as soon as possible, while there is time
before the next merge window.

> What would be the best approach to request review?  I saw that the
> unicore32 architecture was posted in 'functional/subsystem' chunks... is
> that the best way to do it?  Shall I do the same, or do you have a
> suggestion for a better way to do it?

Yes, that is the best way. At first, leave out any device driver changes,
and submit only the code you need to have something that boots. Split
that up into around 15 patches, e.g.

* boot code
* memory management
* user interface
* platform support
* ptrace
* signal handling
* ...

It's ok if these are of very different size, the most important point
in the split is to do it in a way that most reviewers only need to
look at the few patches that they are interested in.

You can simultaneously start submitting device driver changes to the
respective subsystem mailing lists (netdev, spi, ...), those do not
need to be posted to linux-arch.

When you submit the patches, use git-send-email --no-chain-reply --thread
and put a good summary in the introductory mail, describing any changes
you still plan to do, and changes you have done since the previous
submission.

A few minor things that you might still want to do (or list them as TODO)
are:

* fold the board/config.c file into kernel/setup.c.

* replace trivial files in openrisc/include/asm/ with "generic-y += foo.h"
  entries in asm/Kbuild

* use CONFIG_GENERIC_CSUM instead of providing your own implementation

* remove all __ARCH_WANT_* from asm/unistd.h and use the generic glibc
  implementation.

* Figure out what the dma-mapping implementation should look like.
  It seems to me that you just copied from microblaze but didn't
  completely understand what you need. We can definitely help you here
  if you can explain how DMA works on openrisc. In doubt, don't
  set CONFIG_HAS_DMA and use asm-generic/dma-mapping-broken.h.

	Arnd
