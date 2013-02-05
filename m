From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/9] gpiolib: use gpio_chips list in gpiolib_sysfs_init
Date: Tue, 5 Feb 2013 18:04:43 +0100
Message-ID: <CACRpkdaz8h_1uKoH1q9gLmCxE0BMAxBakaq_eFfnfJr2V_Ct5w@mail.gmail.com>
References: <1359822572-26009-1-git-send-email-acourbot@nvidia.com>
	<1359822572-26009-4-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:43037 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754925Ab3BEREn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 5 Feb 2013 12:04:43 -0500
Received: by mail-ie0-f171.google.com with SMTP id 10so526616ied.2
        for <linux-arch@vger.kernel.org>; Tue, 05 Feb 2013 09:04:43 -0800 (PST)
In-Reply-To: <1359822572-26009-4-git-send-email-acourbot@nvidia.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, gnurou@gmail.com

On Sat, Feb 2, 2013 at 5:29 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:

> Use the small list of GPIO chips instead of parsing the whole GPIO
> number space.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
