From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: kbuild now support arch/$ARCH/include - time for ARCHs to convert
Date: Wed, 30 Jul 2008 09:07:24 +0200
Message-ID: <200807300907.25186.arnd@arndb.de>
References: <20080728200500.GA14284@uranus.ravnborg.org> <48900EE4.8030606@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:60495 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757538AbYG3HH3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 30 Jul 2008 03:07:29 -0400
In-Reply-To: <48900EE4.8030606@snapgear.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg Ungerer <gerg@snapgear.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Wednesday 30 July 2008, Greg Ungerer wrote:
> I just tried moving the include/asm-m68knommu directory
> to arch/m68knommu/include/asm and it all worked fine.
> Clean compile first go :-) =A0Nice. =A0(As noted
> asm-offsets.h was still generated in incldue/asm-m68knommu
> afterwards though).

I think the more interesting aspect in m68knommu is what happens
when asm-m68k gets moved. Does that work as well?

I think the best way to deal with it is to remove all files
that just include an asm-m68k file with the same name, and
add -Iarch/m68k/include to your CFLAGS. Not sure about 'make
headers_install', if there is an easy way to install the
files from each of the two directories correctly.

	Arnd <><
