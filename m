From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: kbuild now support arch/$ARCH/include - time for ARCHs to convert
Date: Mon, 4 Aug 2008 16:35:11 +0200
Message-ID: <200808041635.11854.arnd@arndb.de>
References: <20080728200500.GA14284@uranus.ravnborg.org> <4892A719.5090302@snapgear.com> <Pine.LNX.4.64.0808032205120.23329@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:51855 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551AbYHDOfb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 Aug 2008 10:35:31 -0400
In-Reply-To: <Pine.LNX.4.64.0808032205120.23329@anakin>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Ungerer <gerg@snapgear.com>, Sam Ravnborg <sam@ravnborg.org>, linux arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>

On Sunday 03 August 2008, Geert Uytterhoeven wrote:
> There seem to be 3 classes of m68knommu header files:
> =A0 1. Plain files (some of them may be (nearly) identical copies of =
the
> =A0 =A0 =A0m68k variants,

=46or reference, I found the files auxvec.h, device.h, emergency-restar=
t.h,
futex.h, ioctl.h, irq_regs.h, kdebug.h, mutex.h and topology.h to be
entirely identical, so you may remove the m68knommu variants with your
approach.

> =A0 2. Files that just include the m68k variant,
> =A0 3. Files that include the m68k variant and do something more (pci=
=2Eh and
> =A0 =A0 =A0setup.h).
>
> Since I don't think we want to do the m68k/m68knommu merge right now
> (Sorry Arnd, I'll keep your script in mind anyway!), the simplest way=
 is to:
>  - Remove all files from class 2, and add to the Makefile:

Does this work with the exported headers? I guess it should if you
always use the m68k exports for m68knommu as well, but if that's
possible is is a question you haven't answered yet.

Right now, you would remove the following exported headers from m68knom=
mu:
auxvec.h, errno.h, fcntl.h, ioctl.h, ioctls.h, ipcbuf.h, mman.h, msgbuf=
=2Eh,
poll.h, posix_types.h, resource.h, sembuf.h, shmbuf.h, socket.h, stat.h=
,
statfs.h, termbits.h.

If you don't want to use the m68k exports on m68knomu, you'd also have
to duplicate all these.

	Arnd <><
