Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:51439 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753971Ab2LGWYN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Dec 2012 17:24:13 -0500
Date: Fri, 7 Dec 2012 22:23:58 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [update] Re: new execve/kernel_thread design
Message-ID: <20121207222358.GB4939@ZenIV.linux.org.uk>
References: <20121016223508.GR2616@ZenIV.linux.org.uk>
 <20121026183107.GQ2616@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20121026183107.GQ2616@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Mike Frysinger <vapier@gentoo.org>, Jesper Nilsson <jesper.nilsson@axis.com>, David Howells <dhowells@redhat.com>, Tony Luck <tony.luck@intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Hirokazu Takata <takata@linux-m32r.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Jonas Bonn <jonas@southpole.se>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Richard Kuo <rkuo@codeaurora.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Lennox Wu <lennox.wu@gmail.com>, "David S. Miller" <davem@davemloft.net>, Paul Mundt <lethal@linux-sh.org>, Chris Zankel <chris@zankel.net>, Chris Metcalf <cmetcalf@tilera.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Guan Xuetao <gxt@mprc.pku.edu.cn>
Message-ID: <20121207222358.Xr4iGGfkz8ZU6-HUzpCBb-825xz1lUvflZRoxkd3WCY@z>

Current situation:

* most of the architectures are OK - alpha arm arm64 c6x frv hexagon ia64 m68k
microblaze mips openrisc parisc sparc s390 tile um unicore32 x86 xtensa

* powerpc *still* awaits an ACK from maintainers; no reports of any breakage
on linux-next and seems to be doing fine on my tests.

* sh - still nothing from Paul; I'm going to assume that what we have in
linux-next is OK

* mn10300 - untested, AFAIK
* avr32, blackfin, cris, h8300, score - maintainers seem to be MIA
* m32r - maintainer is not MIA, but I'm not sure if anyone, including
maintainer, has working m32r test boxen anymore...  Anyway, not a word on
m32r patches in that pile.

Folks, this is the final warning - I *will* send a pull request on the
stuff currently in linux-next as soon as the merge window opens.  It had
been sitting there for a long time by now and you've all been Cc'd on
that thread all along.
