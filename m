Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:63349 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756198Ab3BESBe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 5 Feb 2013 13:01:34 -0500
Received: by mail-ie0-f169.google.com with SMTP id 13so613597iea.14
        for <linux-arch@vger.kernel.org>; Tue, 05 Feb 2013 10:01:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1359822572-26009-10-git-send-email-acourbot@nvidia.com>
References: <1359822572-26009-1-git-send-email-acourbot@nvidia.com>
	<1359822572-26009-10-git-send-email-acourbot@nvidia.com>
Date: Tue, 5 Feb 2013 19:01:34 +0100
Message-ID: <CACRpkdbXvf8mRgpr2MrmcJcT1gTg4mfBOnF8s3=+jS5iAcMtkQ@mail.gmail.com>
Subject: Re: [PATCH 8/9] gpiolib: use gpio_chips list in gpio_to_desc
From: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, gnurou@gmail.com
Message-ID: <20130205180134.ChV_44rqoaLJqKBZC-pHy0LEkYkaTb9z94LiPECrEXI@z>

On Sat, Feb 2, 2013 at 5:29 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:

> Parse the list of chips to find the descriptor corresponding to a GPIO
> number instead of directly picking the entry of the global gpio_desc[]
> array, which is due to be removed.
>
> This turns the complexity of converting a GPIO number into a descriptor
> from O(1) to O(n) where n is the number of GPIO chips in the system.
> Since n is ought to be small anyway, there should be no noticeable
> performance impact. Moreover, GPIO users who care for speed already have
> implemented their own gpio_get_value() and gpio_set_value() with a
> fast path for the GPIO numbers that matter and this change does not
> affect such use cases.
>
> The descriptor-based GPIO API, due to be introduced soon, will make this
> lookup unnecessary.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

OK it's a nice stepping stone.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
