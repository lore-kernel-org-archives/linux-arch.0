From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 6/9] gpiolib: use descriptors internally
Date: Tue, 12 Feb 2013 17:18:48 +0000
Message-ID: <201302121718.48244.arnd@arndb.de>
References: <1359822572-26009-1-git-send-email-acourbot@nvidia.com> <CACRpkdaHuv7CXCy15-o94G0r0+2BStsi34ZVbBAhyGj=U3xgOg@mail.gmail.com> <20130212155927.GE6088@linux-sh.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:52400 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933383Ab3BLRTH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 12 Feb 2013 12:19:07 -0500
In-Reply-To: <20130212155927.GE6088@linux-sh.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Mundt <lethal@linux-sh.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Grant Likely <grant.likely@secretlab.ca>, Alexandre Courbot <acourbot@nvidia.com>, linux-arch <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Mike Turquette <mturquette@linaro.org>

On Tuesday 12 February 2013, Paul Mundt wrote:
> > While I do get the point... I chatted with Grant about it and
> > I want to talk to some toolchain people about this to see if
> > pointers containing potential error codes can somehow be
> > "flagged" by the compiler so we can enforce error checking on
> > them. (It may sound a bit utopic...)
> > 
> At the very least you can __must_check annotate, although that's probably
> still a bit coarser grained than what you're after.

There is an idea: we could have variants of __must_check for different
classes of returns: NULL error, ERR_PTR, negative integer on error, ...

	Arnd
