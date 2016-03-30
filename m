From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] asm-generic/io.h: provide default ioremap/iounmap for !HAS_IOMEM
Date: Wed, 30 Mar 2016 10:04:46 +0200
Message-ID: <6746826.YZLTqKTgkv@wuerfel>
References: <1459275781-3863-1-git-send-email-robh@kernel.org> <CAL_JsqKsXirYNa-mUTKqeP4ra8w+MW55we8pFmN=S0a7osLy4w@mail.gmail.com> <56FB853E.2050309@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:59295 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758702AbcC3IFK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 30 Mar 2016 04:05:10 -0400
In-Reply-To: <56FB853E.2050309@nod.at>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: Rob Herring <robh@kernel.org>, Lee Jones <lee.jones@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

On Wednesday 30 March 2016 09:50:22 Richard Weinberger wrote:
> Am 29.03.2016 um 22:13 schrieb Rob Herring:
> >>> Reuse the !MMU variants for !HAS_IOMEM as they are sufficient for our
> >>> needs. This fixes build errors for UM allyesconfig:
> >>>
> >>> drivers/mfd/syscon.c:89:2: error: implicit declaration of function 'iounmap' [-Werror=implicit-function-declaration]
> >>>      iounmap(base);
> >>>
> >>> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
> >>> Cc: Arnd Bergmann <arnd@arndb.de>
> >>> Cc: linux-arch@vger.kernel.org
> >>> Signed-off-by: Rob Herring <robh@kernel.org>
> >>
> >> (adding Richard and the UML list to cc)
> >>
> >> I actually prototyped a patch that did the opposite: remove the readl/writel/...
> >> definitions when HAS_IOMEM is unset. I didn't get far enough to submit it,
> >> but see below for what I did.
> > 
> > Ewww. Why do the opposite of what we do for every other Kconfig symbol
> > which is provide empty functions? It really only functions as a
> > disable on UML flag which runs counter to enabling drivers to build
> > for all arches.
> > 
> > I actually started a patch to remove the HAS_IOMEM dependency
> > everywhere (or just the per driver cases). It didn't break as bad as I
> > expected, but became more than I wanted to fix. Mainly, all the devm_
> > variants also need empty versions or to be always enabled.
> 
> The root cause of the problem is COMPILE_TEST. People who use it need to
> get forced to think about the consequences.
> COMPILE_TEST means that the driver will also be build on not so fancy archs
> like UML, s390 and m68k where you don't have IOMEM or also DMA in every
> possible configuration.
> So a quick build test on x86 is not sufficient.
> 
> This is why I'm absolutely not a fan of having stubs for iounmap() an friends
> for UML. It only tries to bypass the root cause.
> What is next? Stubs for DMA? PCI? For everything else that does not build?
> 
> With COMPILE_TEST we have created a monster and now we have to deal with it in terms of
> having correct dependencies when COMPILE_TEST is being used.
> 

One way out of this would be accept that UML is just too different
from the other architectures, and make COMPILE_TEST itself depend
on !UML.

COMPILE_TEST is highly valuable for me, because it means that all the
ARM specific drivers can now be build-tested on x86 and they show up
for anyone doing allmodconfig builds. If we introduce a regression
in any of the drivers, it gets caught much quicker because many
subsystem maintainers run an x86 allmodconfig build after pulling
downstream maintainer trees. There is also stuff like Coverity that
only ever runs on x86.

It does make sense to have COMPILE_TEST imply that we are able
to build things on all architectures, not just x86 in addition to
the platform a driver is meant for, but the value of compile-testing
a random driver with UML in particular approaches zero, and instead
causes lots of work.

	Arnd
