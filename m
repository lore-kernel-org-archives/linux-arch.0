Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from yorgi.telenet-ops.be ([195.130.133.69]:49955 "EHLO
	yorgi.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754582AbYG3M0d (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 30 Jul 2008 08:26:33 -0400
Received: from winston.telenet-ops.be (winston.telenet-ops.be [195.130.137.75])
	by yorgi.telenet-ops.be (Postfix) with ESMTP id DF922680E8C
	for <linux-arch@vger.kernel.org>; Wed, 30 Jul 2008 14:26:31 +0200 (CEST)
Date: Wed, 30 Jul 2008 14:26:04 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: kbuild now support arch/$ARCH/include - time for ARCHs to convert
In-Reply-To: <3995.1217410495@redhat.com>
Message-ID: <Pine.LNX.4.64.0807301422380.3316@anakin>
References: <200807300907.25186.arnd@arndb.de> <20080728200500.GA14284@uranus.ravnborg.org>
 <48900EE4.8030606@snapgear.com> <3995.1217410495@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Ungerer <gerg@snapgear.com>, Sam Ravnborg <sam@ravnborg.org>, linux arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>, uClinux list <uclinux-dev@uclinux.org>
Message-ID: <20080730122604.J8FML_bknVfquCM-NMtEJAI53qJvAjICqY5RhNxjUGM@z>

On Wed, 30 Jul 2008, David Howells wrote:
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > I think the more interesting aspect in m68knommu is what happens
> > when asm-m68k gets moved. Does that work as well?
> 
> Can m68knommu be merged into m68k and be made contingent on CONFIG_MMU?  This
> is what FRV does.

Sure it can ;-)

Actually I did a bit of work to add nommu support to m68k to make it
boot on old MMU-less Amigas, but it dates back to the 2.6.8.1 era...

The bigger issue is in those parts that are done differently by m68k and
m68knommu (esp. head.S).

Who's gonna take the work? :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
