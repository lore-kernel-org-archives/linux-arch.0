From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/4] gpio: introduce descriptor-based interface
Date: Thu, 17 Jan 2013 19:22:13 +0000
Message-ID: <201301171922.13432.arnd@arndb.de>
References: <1357629535-26033-1-git-send-email-acourbot@nvidia.com> <50F7E83E.8000105@uclinux.org> <201301170850.43655.sfking@fdwdc.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:63981 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791Ab3AQTWj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 Jan 2013 14:22:39 -0500
In-Reply-To: <201301170850.43655.sfking@fdwdc.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven King <sfking@fdwdc.com>
Cc: Greg Ungerer <gerg@uclinux.org>, Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Alex Courbot <acourbot@nvidia.com>, Grant Likely <grant.likely@secretlab.ca>, Guenter Roeck <linux@roeck-us.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

On Thursday 17 January 2013, Steven King wrote:
> I haven't been keeping up with the kernel list of late, can someone point me 
> to what''s being discussed so I can see what were talking about here?

We are discussion about changes to the GPIO API, in particular about
adding a descriptor (i.e. pointer to struct) based interface to
replace integers as the primary key.

Any kind of change on this level is currently problematic because it
is basically impossible to tell which files are implementing the
current interface and would need to get changed along with changing
gpiolib. If everything goes through gpiolib, it's much easier
to make compatible extensions in one place.

Do you have any numbers about how much of a difference for your
platforms we are talking about at most?

	Arnd
