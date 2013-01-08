From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/4] gpiolib: add gpiod_get and gpiod_put functions
Date: Tue, 8 Jan 2013 13:07:04 +0000
Message-ID: <201301081307.04229.arnd@arndb.de>
References: <1357629535-26033-1-git-send-email-acourbot@nvidia.com> <1357629535-26033-3-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:51412 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755153Ab3AHNHW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 Jan 2013 08:07:22 -0500
In-Reply-To: <1357629535-26033-3-git-send-email-acourbot@nvidia.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>, Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Alexandre Courbot <gnurou@gmail.com>

On Tuesday 08 January 2013, Alexandre Courbot wrote:
> 
> Adds new GPIO allocation functions that work with the opaque descriptor
> interface.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

I think you need to reorder the patches slightly, since the gpiod_get
function introduced here is already being used in the first patch, which
breaks bisection.

	Arnd
