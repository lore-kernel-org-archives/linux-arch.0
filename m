From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 08/23] gpio: remove gpiod_sysfs_set_active_low
Date: Tue, 12 May 2015 10:27:03 +0200
Message-ID: <CACRpkdaWs7P2iBn8uUhtaPBNFfaqNcyPM6h=Wr3pmWcc8HBPfA@mail.gmail.com>
References: <1430752248-15401-1-git-send-email-johan@kernel.org>
	<1430752248-15401-9-git-send-email-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1430752248-15401-9-git-send-email-johan@kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Harry Wei <harryxiyou@gmail.com>, Arnd Bergmann <arnd@arndb.de>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, linux-kernel@zh-kernel.org, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, May 4, 2015 at 5:10 PM, Johan Hovold <johan@kernel.org> wrote:

> Remove gpiod_sysfs_set_active_low (and gpio_sysfs_set_active_low) which
> allowed code to change the polarity of a gpio line even after it had
> been exported through sysfs.
>
> Drivers should not care, and generally does not know, about gpio-line
> polarity which is a hardware feature that needs to be described by
> firmware.
>
> It is currently possible to define gpio-line polarity in device-tree and
> acpi firmware or using platform data. Userspace can also change the
> polarity through sysfs.
>
> Note that drivers using the legacy gpio interface could still use
> GPIOF_ACTIVE_LOW to change the polarity before exporting the gpio.
>
> There are no in-kernel users of this interface.
>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Harry Wei <harryxiyou@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@zh-kernel.org
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Johan Hovold <johan@kernel.org>

GOOD RIDDANCE.

Patch applied.

Yours,
Linus Walleij
