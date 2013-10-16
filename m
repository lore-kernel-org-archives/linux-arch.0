From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 1/3] gpiolib: export descriptor-based GPIO interface
Date: Wed, 16 Oct 2013 10:11:08 +0200
Message-ID: <CACRpkdYTJ_JQvFmf+AuCxmk5kGGw_CLGn0-xnO+PqGav45Se3Q@mail.gmail.com>
References: <1381515273-25466-1-git-send-email-acourbot@nvidia.com>
	<1381515273-25466-2-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:47172 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760109Ab3JPILI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2013 04:11:08 -0400
Received: by mail-ie0-f175.google.com with SMTP id aq17so660723iec.20
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2013 01:11:08 -0700 (PDT)
In-Reply-To: <1381515273-25466-2-git-send-email-acourbot@nvidia.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Fri, Oct 11, 2013 at 8:14 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:

> This patch exports the gpiod_* family of API functions, a safer
> alternative to the legacy GPIO interface. Differences between the gpiod
> and legacy gpio APIs are:
>
> - gpio works with integers, whereas gpiod operates on opaque handlers
>   which cannot be forged or used before proper acquisition
> - gpiod get/set functions are aware of the active low state of a GPIO
> - gpio consumers should now include <linux/gpio/consumer.h> to access
>   the new interface, whereas chips drivers will use
>   <linux/gpio/driver.h>
>
> The legacy gpio API is now built as inline functions on top of gpiod.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Typically I have applied the patch adding gpio_[un]lock_as_irq()
and it conflicts with this. And it requires adding gpiod_* accessors
for these functions too...

Would you mind rebasing this on top of my "devel" branch?

Sorry for the moving target, but after this I think we are ready to
merge the gpiod* interface.

Yours,
Linus Walleij
