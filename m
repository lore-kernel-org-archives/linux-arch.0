From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 7/9] gpiolib: let gpio_chip reference its descriptors
Date: Sat, 09 Feb 2013 13:28:03 +0000
Message-ID: <20130209132803.AC8323E30EC@localhost>
References: <1359822572-26009-1-git-send-email-acourbot@nvidia.com> <1359822572-26009-9-git-send-email-acourbot@nvidia.com> <CACRpkdZ3L15vbfBGC-SmmGKnt8N_GZGKP92su3aZWQZdPPVR2Q@mail.gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:54964 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142Ab3BIN2I (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 9 Feb 2013 08:28:08 -0500
Received: by mail-wg0-f42.google.com with SMTP id 12so1334718wgh.1
        for <linux-arch@vger.kernel.org>; Sat, 09 Feb 2013 05:28:07 -0800 (PST)
In-Reply-To: <CACRpkdZ3L15vbfBGC-SmmGKnt8N_GZGKP92su3aZWQZdPPVR2Q@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, gnurou@gmail.com

On Tue, 5 Feb 2013 19:00:09 +0100, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sat, Feb 2, 2013 at 5:29 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:
> 
> > Add a pointer to the gpio_chip structure that references the array of
> > GPIO descriptors belonging to the chip, and update gpiolib code to use
> > this pointer instead of the global gpio_desc[] array. This is another
> > step towards the removal of the gpio_desc[] global array.
> >
> > Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.orh>

Applied, thanks.

g.
