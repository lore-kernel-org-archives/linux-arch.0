From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 1/2] asm-generic/io.h: provide default ioremap/iounmap for
 !HAS_IOMEM
Date: Wed, 30 Mar 2016 22:35:37 +0200
Message-ID: <56FC3899.4000100@nod.at>
References: <1459275781-3863-1-git-send-email-robh@kernel.org>
 <3074778.3TElYrXjM1@wuerfel>
 <CAL_JsqKsXirYNa-mUTKqeP4ra8w+MW55we8pFmN=S0a7osLy4w@mail.gmail.com>
 <CAMuHMdWc_97Yk7XJ6e4n6tibs99pPHSnJU2qqC7CGcoo4kWuNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from a.ns.miles-group.at ([95.130.255.143]:11950 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750860AbcC3Ufm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 30 Mar 2016 16:35:42 -0400
In-Reply-To: <CAMuHMdWc_97Yk7XJ6e4n6tibs99pPHSnJU2qqC7CGcoo4kWuNA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee.jones@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Am 30.03.2016 um 22:08 schrieb Geert Uytterhoeven:
>> I actually started a patch to remove the HAS_IOMEM dependency
>> everywhere (or just the per driver cases). It didn't break as bad as I
>> expected, but became more than I wanted to fix. Mainly, all the devm_
>> variants also need empty versions or to be always enabled.
> 
> Should these dependencies on HAS_IOMEM be changed to "HAS_IOMEM ||
> COMPILE_TEST"?

Another idea, the issue with COMPILE_TEST is that it is automatically selected
by make targets such as allyesconfig or allmodconfig.
Couldn't we make COMPILE_TEST just harder to select?
i.e. that with allyesconfig it is still disabled and if someone really wants to
do a compile test of anything we could issue something like "make allyesconfig COMPILE_TEST=y"
to have COMPILE_TEST selected?

Thanks,
//richard
