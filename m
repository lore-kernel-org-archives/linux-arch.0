Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:40495 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556Ab3BIKKE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 9 Feb 2013 05:10:04 -0500
Received: by mail-wi0-f174.google.com with SMTP id hi8so1702053wib.13
        for <linux-arch@vger.kernel.org>; Sat, 09 Feb 2013 02:10:03 -0800 (PST)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/9] gpiolib: use gpio_chips list in gpiochip_find
In-Reply-To: <CACRpkdaVwjv2DwSx667sgVkHqx-tHsy6A0mP-kvq6h9nDDBrGA@mail.gmail.com>
References: <1359822572-26009-1-git-send-email-acourbot@nvidia.com> <1359822572-26009-5-git-send-email-acourbot@nvidia.com> <CACRpkdaVwjv2DwSx667sgVkHqx-tHsy6A0mP-kvq6h9nDDBrGA@mail.gmail.com>
Date: Sat, 09 Feb 2013 09:25:25 +0000
Message-ID: <20130209092525.9F9A23E2C48@localhost>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, gnurou@gmail.com
Message-ID: <20130209092525.Hw7A6l9XxS0eVeUX_Gekf3WlUplWE3t3kux3uSuoNdI@z>

On Tue, 5 Feb 2013 18:05:32 +0100, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sat, Feb 2, 2013 at 5:29 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:
> 
> > Using the GPIO chips list is much faster than parsing the entire GPIO
> > number space.
> >
> > Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> 
> You don't say :-)
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Applied, thanks.

g.

