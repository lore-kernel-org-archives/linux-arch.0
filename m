From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] asm-generic/io.h: provide default ioremap/iounmap for !HAS_IOMEM
Date: Wed, 30 Mar 2016 22:38:16 +0200
Message-ID: <5347598.RDs9sKVU3U@wuerfel>
References: <1459275781-3863-1-git-send-email-robh@kernel.org> <CAMuHMdWc_97Yk7XJ6e4n6tibs99pPHSnJU2qqC7CGcoo4kWuNA@mail.gmail.com> <56FC3899.4000100@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:59339 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653AbcC3Uif (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 30 Mar 2016 16:38:35 -0400
In-Reply-To: <56FC3899.4000100@nod.at>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh@kernel.org>, Lee Jones <lee.jones@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Wednesday 30 March 2016 22:35:37 Richard Weinberger wrote:
> Am 30.03.2016 um 22:08 schrieb Geert Uytterhoeven:
> >> I actually started a patch to remove the HAS_IOMEM dependency
> >> everywhere (or just the per driver cases). It didn't break as bad as I
> >> expected, but became more than I wanted to fix. Mainly, all the devm_
> >> variants also need empty versions or to be always enabled.
> > 
> > Should these dependencies on HAS_IOMEM be changed to "HAS_IOMEM ||
> > COMPILE_TEST"?
> 
> Another idea, the issue with COMPILE_TEST is that it is automatically selected
> by make targets such as allyesconfig or allmodconfig.
> Couldn't we make COMPILE_TEST just harder to select?
> i.e. that with allyesconfig it is still disabled and if someone really wants to
> do a compile test of anything we could issue something like "make allyesconfig COMPILE_TEST=y"
> to have COMPILE_TEST selected?
> 

I think it's essential for allmodconfig and allyesconfig to enable
COMPILE_TEST: the only reason for ever building those configurations
is for compile tests.

	Arnd
