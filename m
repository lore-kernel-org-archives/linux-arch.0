From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/4] gpiolib: introduce descriptor-based GPIO interface
Date: Wed, 9 Jan 2013 10:35:22 +0000
Message-ID: <201301091035.23206.arnd@arndb.de>
References: <1357629535-26033-1-git-send-email-acourbot@nvidia.com> <201301081259.29839.arnd@arndb.de> <CAAVeFu+4VbCbj9TaeMm+NMDJ9_M4-j4O0ONF7Yh_un63wS38+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:59478 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755272Ab3AIKfm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 9 Jan 2013 05:35:42 -0500
In-Reply-To: <CAAVeFu+4VbCbj9TaeMm+NMDJ9_M4-j4O0ONF7Yh_un63wS38+Q@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>, Guenter Roeck <linux@roeck-us.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

On Wednesday 09 January 2013, Alexandre Courbot wrote:
> On Tue, Jan 8, 2013 at 9:59 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > Please avoid the use of IS_ERR_OR_NULL(), especially on interfaces you
> > introduce yourself. AFAICT, gpiod_get cannot return NULL, so you
> > should not check for that.
> 
> Sure - you sound like IS_ERR_OR_NULL() is generally considered evil,

Correct.

> may I ask why this is the case?

It's very hard to get right: either you are interested in the error code,
and then you don't have one in some cases, or you don't care but have
to check for it anyway. When you define a function, just make it clear
what the expected return values are, either NULL for error or a negative
ERR_PTR value, but not both.

	Arnd
