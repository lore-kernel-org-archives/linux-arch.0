From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: kbuild now support arch/$ARCH/include - time for ARCHs to convert
Date: Mon, 4 Aug 2008 07:10:09 +0200
Message-ID: <20080804051009.GA23197@uranus.ravnborg.org>
References: <20080728200500.GA14284@uranus.ravnborg.org> <48900EE4.8030606@snapgear.com> <20080730083853.GB18366@uranus.ravnborg.org> <4892A719.5090302@snapgear.com> <Pine.LNX.4.64.0808032205120.23329@anakin> <48964E83.80002@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtpout3.tre.se ([80.251.192.228]:11960 "EHLO smtpout3.tre.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751626AbYHDFJg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 4 Aug 2008 01:09:36 -0400
Content-Disposition: inline
In-Reply-To: <48964E83.80002@snapgear.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg Ungerer <gerg@snapgear.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>

> >
> >As (a) I'm not using git (yet) for merging with Linus, and (b) this will
> >cause some breakage in the m68knommu tree anyway, perhaps it's easiest if 
> >Greg
> >takes care of it in m68knommu.git?
> >
> >Greg, is that OK for you?
> 
> Yep, I will do that.

Good. I also think this is the only right way to do it
so we do not have a longer period with m68knommu being broken.

	Sam
