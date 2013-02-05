From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 9/9] gpiolib: dynamically allocate descriptors array
Date: Tue, 5 Feb 2013 19:02:29 +0100
Message-ID: <CACRpkdaTF1Ca5GX-D+cx-_LrOVZyhX_mgLGRfv65dabof5-RYQ@mail.gmail.com>
References: <1359822572-26009-1-git-send-email-acourbot@nvidia.com>
	<1359822572-26009-11-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:37394 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755283Ab3BESC3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 5 Feb 2013 13:02:29 -0500
Received: by mail-ie0-f174.google.com with SMTP id k10so611810iea.33
        for <linux-arch@vger.kernel.org>; Tue, 05 Feb 2013 10:02:29 -0800 (PST)
In-Reply-To: <1359822572-26009-11-git-send-email-acourbot@nvidia.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, gnurou@gmail.com

On Sat, Feb 2, 2013 at 5:29 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:

> Allocate the GPIO descriptor's memory dynamically when GPIO chips are
> added instead of using the static gpio_desc[] array. gpio_desc[] is now
> totally unused and therefore removed.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
