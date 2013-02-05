From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/9] gpiolib: use gpio_chips list in gpiochip_find
Date: Tue, 5 Feb 2013 18:05:32 +0100
Message-ID: <CACRpkdaVwjv2DwSx667sgVkHqx-tHsy6A0mP-kvq6h9nDDBrGA@mail.gmail.com>
References: <1359822572-26009-1-git-send-email-acourbot@nvidia.com>
	<1359822572-26009-5-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:46455 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755304Ab3BERFc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 5 Feb 2013 12:05:32 -0500
Received: by mail-ie0-f173.google.com with SMTP id 9so521906iec.32
        for <linux-arch@vger.kernel.org>; Tue, 05 Feb 2013 09:05:32 -0800 (PST)
In-Reply-To: <1359822572-26009-5-git-send-email-acourbot@nvidia.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, gnurou@gmail.com

On Sat, Feb 2, 2013 at 5:29 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:

> Using the GPIO chips list is much faster than parsing the entire GPIO
> number space.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

You don't say :-)
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
