From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 3/3] gpiolib: add gpiod_get() and gpiod_put() functions
Date: Wed, 16 Oct 2013 13:37:45 +0200
Message-ID: <CACRpkdZTqZKyG3Lbs_GmdnqB0yEjRApsaUhJA9-s_uPb_Wrq8A@mail.gmail.com>
References: <1381515273-25466-1-git-send-email-acourbot@nvidia.com>
	<1381515273-25466-4-git-send-email-acourbot@nvidia.com>
	<52587C37.3070606@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:59126 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934260Ab3JPLhq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2013 07:37:46 -0400
Received: by mail-ie0-f173.google.com with SMTP id u16so976106iet.4
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2013 04:37:45 -0700 (PDT)
In-Reply-To: <52587C37.3070606@nvidia.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Courbot <acourbot@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "gnurou@gmail.com" <gnurou@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Sat, Oct 12, 2013 at 12:31 AM, Alex Courbot <acourbot@nvidia.com> wrote:
>> +#else
>> +static struct device_node *of_find_gpio(struct device *dev, const char *id
>> +                                     unsigned int idx, unsigned long flags)
>> +{
>> +     return ERR_PTR(-ENODEV);
>> +}
>> +#endif
>
> ... and of course I forgot to fix the main compilation error. Linus,
> would you mind squashing what follows into this patch? Apologies for
> the inconvenience.

I guess you'll fix this if you respin it?

If it's too much trouble now we can just defer this for early in the v3.14
cycle.

Yours,
Linus Walleij
