From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC 5/5] gpiolib: update documentation
Date: Fri, 20 Sep 2013 19:59:00 +0200
Message-ID: <CACRpkdbB29rL_kTqKQ6ZC=J=p9amRODRDVFMP6ZoF=aa6k9pqA@mail.gmail.com>
References: <1378294169-22661-1-git-send-email-acourbot@nvidia.com>
	<1378294169-22661-6-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1378294169-22661-6-git-send-email-acourbot@nvidia.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Sep 4, 2013 at 1:29 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:

> +The GPIO framework has quite a bit of history behind it. Currently there exist
> +two different (although very similar) ways of using GPIOs:
> +
> +  - The legacy integer-based interface represents GPIOs as integers. This is
> +    the "historic" way of accessing GPIOs and it was done so because it makes
> +    GPIOs easy to represent and also allows for the compiler to statically know
> +    the GPIO number and use fast-paths on GPIOs for which performance matters.
> +    However, GPIOs can easily be forged this way, and the maximum number of
> +    GPIOs in the system must be known in advance. Functions of this interface
> +    are prefixed with "gpio_".
> +
> +  - The new descriptor-based interface represents GPIOs as an opaque pointer.
> +    This ensures GPIOs are properly acquired before usage, and also does not
> +    presume anything about their underlying implementation. This interface
> +    provides get/put functions to acquire GPIOs according to their function for
> +    a particular device, similarly to e.g. the regulator framework. For these
> +    reasons, it is the preferred way to access GPIOs. Its functions are prefixed
> +    with "gpiod_".

I would put all the new style gpiod_* based things on top of the file, and
all the old stuff under a separate heading below DEPRECATED LEGACY INTERFACE
so it's crystal clear that this is going away.

Yours,
Linus Walleij
