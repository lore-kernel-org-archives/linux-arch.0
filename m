Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:52920 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753251Ab3ITSkt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 20 Sep 2013 14:40:49 -0400
Received: by mail-ob0-f174.google.com with SMTP id uz6so1019343obc.19
        for <linux-arch@vger.kernel.org>; Fri, 20 Sep 2013 11:40:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <52279082.5010105@wwwdotorg.org>
References: <1378294169-22661-1-git-send-email-acourbot@nvidia.com>
	<1378294169-22661-5-git-send-email-acourbot@nvidia.com>
	<52279082.5010105@wwwdotorg.org>
Date: Fri, 20 Sep 2013 20:40:48 +0200
Message-ID: <CACRpkdY70r8mL8PSDmexr+_0Ddi-Y8x0RaDF-WWucZM9V8n=yw@mail.gmail.com>
Subject: Re: [RFC 4/5] gpiolib: add gpiod_get() and gpiod_put() functions
From: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Warren <swarren@wwwdotorg.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Message-ID: <20130920184048.W4zHNwPWeKlnpv1mevSZOJl6PRtyTfIuMu08sHvuZ-4@z>

On Wed, Sep 4, 2013 at 9:56 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 09/04/2013 05:29 AM, Alexandre Courbot wrote:
>> Add gpiod_get() and gpiod_put() functions that provide safer handling of
>> GPIOs.
>>
>> These functions put the GPIO framework in line with the conventions of
>> other frameworks in the kernel, and help ensure every GPIO is declared
>> properly and valid while it is used.
>
>> diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
>
>> +struct gpio_desc *__must_check gpiod_get(struct device *dev,
>> +                                      const char *con_id);
>> +void gpiod_put(struct gpio_desc *desc);
>
> It might be nice to add an "int index" parameter to this function. For
> example, a bit-banged parallel bus protocol driver might have 1
> chip-select GPIO, 1 clock GPIO, and 8 data GPIOs. gpiod_get(dev, "bus",
> 0)..gpiod_get(dev, "bus", 7) might be nicer than gpiod_get(dev,
> "bus0")..gpiod_get(dev, "bus7")? Possibly for client-simplicity,
> implement both gpiod_get(dev, con_id) (as an inline wrapper for ...) and
> gpiod_get_index(dev, con_id, index)?
>
> In DT terms, this would map to:
>
> cs-gpios = <&gpio 3 0>;
> clock-gpios = <&gpio 5 0>;
> bus-gpios = <&gpio 10 0 ... &gpio 17 0>;
>
> ... and with the mapping table registration mechanism, we could
> presumably add "int index" to struct gpiod_lookup.

This is an interesting usability aspect of the API, so I'd especially
like some input from the ACPI people on this as well.

Paging Mika, Rafael, Mathias.

Yours,
Linus Walleij
