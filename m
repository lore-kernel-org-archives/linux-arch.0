From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 7/9] gpiolib: let gpio_chip reference its descriptors
Date: Tue, 5 Feb 2013 19:00:09 +0100
Message-ID: <CACRpkdZ3L15vbfBGC-SmmGKnt8N_GZGKP92su3aZWQZdPPVR2Q@mail.gmail.com>
References: <1359822572-26009-1-git-send-email-acourbot@nvidia.com>
	<1359822572-26009-9-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:34744 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756286Ab3BESAK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 5 Feb 2013 13:00:10 -0500
Received: by mail-ie0-f173.google.com with SMTP id 9so606159iec.32
        for <linux-arch@vger.kernel.org>; Tue, 05 Feb 2013 10:00:10 -0800 (PST)
In-Reply-To: <1359822572-26009-9-git-send-email-acourbot@nvidia.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, gnurou@gmail.com

On Sat, Feb 2, 2013 at 5:29 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:

> Add a pointer to the gpio_chip structure that references the array of
> GPIO descriptors belonging to the chip, and update gpiolib code to use
> this pointer instead of the global gpio_desc[] array. This is another
> step towards the removal of the gpio_desc[] global array.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.orh>

Yours,
Linus Walleij
