From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: kbuild now support arch/$ARCH/include - time for ARCHs to convert
Date: Wed, 30 Jul 2008 10:52:19 +0200
Message-ID: <20080730085219.GA18585@uranus.ravnborg.org>
References: <20080728200500.GA14284@uranus.ravnborg.org> <48900EE4.8030606@snapgear.com> <200807300907.25186.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtpout3.tre.se ([80.251.192.228]:35775 "EHLO smtpout3.tre.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752338AbYG3Iwd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 30 Jul 2008 04:52:33 -0400
Content-Disposition: inline
In-Reply-To: <200807300907.25186.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Ungerer <gerg@snapgear.com>, linux arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Wed, Jul 30, 2008 at 09:07:24AM +0200, Arnd Bergmann wrote:
> On Wednesday 30 July 2008, Greg Ungerer wrote:
> > I just tried moving the include/asm-m68knommu directory
> > to arch/m68knommu/include/asm and it all worked fine.
> > Clean compile first go :-) =A0Nice. =A0(As noted
> > asm-offsets.h was still generated in incldue/asm-m68knommu
> > afterwards though).
>=20
> I think the more interesting aspect in m68knommu is what happens
> when asm-m68k gets moved. Does that work as well?
>=20
> I think the best way to deal with it is to remove all files
> that just include an asm-m68k file with the same name, and
> add -Iarch/m68k/include to your CFLAGS. Not sure about 'make
> headers_install', if there is an easy way to install the
> files from each of the two directories correctly.
We had ALTARCH that I just killed as sparc was the only user.
And if we need something again I will try to come up
with something better somehow.

But m68knommu does no export any files atm,
and m68k exports only a single file.
So I doubt it is actually used by gcc/glibc atm.

	Sam
