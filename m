From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: introduce arch/$ARCH/Kbuild ?
Date: Tue, 21 Apr 2009 21:43:43 +0200
Message-ID: <20090421194343.GA24535@uranus.ravnborg.org>
References: <20090416183701.GA5810@uranus.ravnborg.org> <20090421131430.GA25098@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pfepb.post.tele.dk ([195.41.46.236]:47537 "EHLO
	pfepb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbZDUTlg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Apr 2009 15:41:36 -0400
Content-Disposition: inline
In-Reply-To: <20090421131430.GA25098@linux-mips.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-arch@vger.kernel.org

> 
> Most of arch/mips uses -Werror these days and while painful at times it
> keeps everybody on their toes hopefully cleaner, less buggy code.  So if
> your solution allows adding -Werror to all subdirs automatically with
> a mechanism to remove -Werror from a few selected dirs then I'm interested.

It is already present in mainline - so go wild.

I took a look at mips.
mips supports an impressive amount of platform/boards.
The has resulted in lines like the following in the arch Makefile:

core-$(CONFIG_SGI_IP32)         += arch/mips/sgi-ip32/
cflags-$(CONFIG_SGI_IP32)       += -I$(srctree)/arch/mips/include/asm/mach-ip32
load-$(CONFIG_SGI_IP32)         += 0xffffffff80004000

But this is less then optimal. If two people add a paltform you will
have a merge issue.
And centralize information like that is also questionable.

mips would be better suited if you had all sgi_ip32 information located
in a single directory.

How about a setup like this:

arch/mips/sgi_ip32/Platform:
platfrom-y                      += arch/mips/sgi-ip32/
cflags-$(CONFIG_SGI_IP32)       += -I$(srctree)/arch/mips/include/asm/mach-ip32
load-$(CONFIG_SGI_IP32)         += 0xffffffff80004000


arch/mips/Kbuild.platforms:
#All platforms listed in alphabetic order
platforms-y += lasat/
platforms-y += sgi_ip32/

#include the platform specific files
include $(patsubst %, arch/misp/%Platform)


arch/mips/Kbuild:
subdir-ccflags-y := -Werror

include arch/mips/Kbuild.platforms
obj-y += $(platform-y)

obj-y +=  arch/mips/kernel/ arch/mips/mm/ arch/mips/math-emu/


arch/mips/Makefile:
core-y += arch/mips/
include arch/mips/Kbuild.platforms



The above does a few things:
1) It decentralize the plaform stuff (to the Platform files)
2) In troduces a arch/mips/Kbuild file that specify everything
   that is linked in as core-y
3) It adds a single subdir-ccflags-y := -Werror that covers
   all platforms and the core part of the kernel
   (Everything specified in arch/mips/Kbuild)
4) It reuses Kbuild.platforms in Kbuild and
   in Makefile.
   In Makefile it is used to find ccflags-y
   and load-y definitions.
   In Kbuild it is used to find the objects to add to obj-y.


The above is entirely untested - but I hope to have adressed the principles.

	Sam
