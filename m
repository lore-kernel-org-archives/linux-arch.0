Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:44193 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753406Ab3IWKQK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 23 Sep 2013 06:16:10 -0400
Date: Mon, 23 Sep 2013 13:21:35 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [RFC 0/5] New descriptor-based GPIO interface
Message-ID: <20130923102134.GB28875@intel.com>
References: <1378294169-22661-1-git-send-email-acourbot@nvidia.com>
 <CACRpkdYjkDf7c9VxfDTHtFx_upWWRAK8vpXTkrkrRsMjErq1dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYjkDf7c9VxfDTHtFx_upWWRAK8vpXTkrkrRsMjErq1dQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Message-ID: <20130923102135.vrXIOvqw2-fG37_oAzGd85jj_yUEcsQFb02XW1CZXu4@z>

On Fri, Sep 20, 2013 at 08:06:00PM +0200, Linus Walleij wrote:
> On Wed, Sep 4, 2013 at 1:29 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:
> 
> > Here is a first RFC for the new GPIO interface.
> 
> I'm quite happy with this, and given that all DT-implementations will start
> to use it from day 1 I'll happily merge it when you think it's tested enough.
> 
> On my wishlist is to also switch over the ACPI GPIO driver:
> drivers/gpio/gpiolib-acpi.c to use the descriptors directly, so
> I'd like one of the ACPI folks to have a look at this patch set
> and see how it looks from their angle.
> 
> Mika, Rafael, Mathias, and either of you guys have a look
> at this?

Apart from the con_id thing I commented, I don't see huge problems
converting the ACPI GPIO helpers to this new interface.

One thing that is special to ACPI is that we have two kind of GPIO
"connections":

	GpioIo - a normal GPIO that the driver can toggle or read values

	GpioInt - this is specifically used as a GPIO interrupt

The drivers should be able to distinguish between the two. Currently we
have an extra parameter in acpi_get_gpio_by_index(..., &info) that can be
used for this. However, with the new gpiod_get() I'm not sure how we are
supposed to do this now?

Anyway, that shouldn't prevent merging this patch set. I'm sure that we can
come up with some working solution :-)
