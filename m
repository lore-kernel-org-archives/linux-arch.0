Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dike.telenet-ops.be ([195.130.132.36]:38483 "EHLO
	dike.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbXJUT32 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 21 Oct 2007 15:29:28 -0400
Date: Sun, 21 Oct 2007 20:29:29 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] m68k: Use cc-cross-prefix (was: Re: [GI:wqT PULL] kbuild
 updates - second round)
In-Reply-To: <20071021182245.GA5840@uranus.ravnborg.org>
Message-ID: <Pine.LNX.4.64.0710212028560.6155@anakin>
References: <20071019204415.GA623@uranus.ravnborg.org>
 <Pine.LNX.4.64.0710211956280.6155@anakin> <20071021182245.GA5840@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, linux arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>, Rob Landley <rob@landley.net>
List-ID: <linux-arch.vger.kernel.org>

On Sun, 21 Oct 2007, Sam Ravnborg wrote:
> On Sun, Oct 21, 2007 at 07:57:39PM +0200, Geert Uytterhoeven wrote:
> > On Fri, 19 Oct 2007, Sam Ravnborg wrote:
> > > The cc-cross-prefix is new and developed on request from Geert Uytterhoeven.
> > > With cc-cross-prefix it is now much easier to have a few default
> > > cross compile prefixes and defaulting to none - if none of them were present.
> > > ARCH maintainers are expected to pick up this feature soon.
> > 
> > Thanks, seems to work fine!
> > 
> > m68k: Use cc-cross-prefix
> > 
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> >  arch/m68k/Makefile |    8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> > 
> > --- a/arch/m68k/Makefile
> > +++ b/arch/m68k/Makefile
> > @@ -13,16 +13,14 @@
> >  # Copyright (C) 1994 by Hamish Macdonald
> >  #
> >  
> > -# test for cross compiling
> > -COMPILE_ARCH = $(shell uname -m)
> > -
> >  # override top level makefile
> >  AS += -m68020
> >  LDFLAGS := -m m68kelf
> >  LDFLAGS_MODULE += -T $(srctree)/arch/m68k/kernel/module.lds
> >  ifneq ($(COMPILE_ARCH),$(ARCH))
> > -	# prefix for cross-compiling binaries
> > -	CROSS_COMPILE = m68k-linux-gnu-
> > +	ifeq ($(CROSS_COMPILE),)
> > +	       CROSS_COMPILE := $(call cc-cross-prefix, m68k-linux-gnu- m68k-linux-)
> > +	endif
> >  endif
> Patch seems bogus.
> You kill the assignment to COMPILE_ARCH yet you
> refer to it in the line:
> ifneq ($(COMPILE_ARCH),...
> 
> Did you mean to use $(SUBARCH) here?

Oops, indeed. Sorry, here's a new one...

m68k: Use cc-cross-prefix

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/Makefile |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- a/arch/m68k/Makefile
+++ b/arch/m68k/Makefile
@@ -13,16 +13,14 @@
 # Copyright (C) 1994 by Hamish Macdonald
 #
 
-# test for cross compiling
-COMPILE_ARCH = $(shell uname -m)
-
 # override top level makefile
 AS += -m68020
 LDFLAGS := -m m68kelf
 LDFLAGS_MODULE += -T $(srctree)/arch/m68k/kernel/module.lds
-ifneq ($(COMPILE_ARCH),$(ARCH))
-	# prefix for cross-compiling binaries
-	CROSS_COMPILE = m68k-linux-gnu-
+ifneq ($(SUB_ARCH),$(ARCH))
+	ifeq ($(CROSS_COMPILE),)
+	       CROSS_COMPILE := $(call cc-cross-prefix, m68k-linux-gnu- m68k-linux-)
+	endif
 endif
 
 ifdef CONFIG_SUN3

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
