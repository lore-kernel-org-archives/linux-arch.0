From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH 08/23] gpio: remove gpiod_sysfs_set_active_low
Date: Mon, 27 Apr 2015 17:34:38 +0900
Message-ID: <CAAVeFuJH0d-08-HBjCx6zEvUJMhkVNFnGaK-X_FCucNbo9vbSA@mail.gmail.com>
References: <1429630951-27082-1-git-send-email-johan@kernel.org>
 <1429630951-27082-9-git-send-email-johan@kernel.org> <CAAVeFuLc8U_fhmb=oyr+hTsH8XgkQU0Z-oSS4K3CRObqv_P_AQ@mail.gmail.com>
 <20150427081629.GA27877@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20150427081629.GA27877@localhost>
Sender: linux-doc-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Harry Wei <harryxiyou@gmail.com>, Arnd Bergmann <arnd@arndb.de>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, linux-kernel@zh-kernel.org, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Apr 27, 2015 at 5:16 PM, Johan Hovold <johan@kernel.org> wrote:
> On Mon, Apr 27, 2015 at 12:54:15PM +0900, Alexandre Courbot wrote:
>> On Wed, Apr 22, 2015 at 12:42 AM, Johan Hovold <johan@kernel.org> wrote:
>> > Remove gpiod_sysfs_set_active_low (and gpio_sysfs_set_active_low) which
>> > allowed code to change the polarity of a gpio line even after it had
>> > been exported through sysfs.
>> >
>> > Drivers should not care, and generally does not know, about gpio-line
>> > polarity which is a hardware feature that needs to be described by
>> > firmware.
>> >
>> > It is currently possible to define gpio-line polarity in device-tree and
>> > acpi firmware or using platform data. Userspace can also change the
>> > polarity through sysfs.
>> >
>> > Note that drivers using the legacy gpio interface could still use
>> > GPIOF_ACTIVE_LOW to change the polarity before exporting the gpio.
>> >
>> > There are no in-kernel users of this interface.
>> >
>> > Cc: Jonathan Corbet <corbet@lwn.net>
>> > Cc: Harry Wei <harryxiyou@gmail.com>
>> > Cc: Arnd Bergmann <arnd@arndb.de>
>> > Cc: linux-doc@vger.kernel.org
>> > Cc: linux-kernel@zh-kernel.org
>> > Cc: linux-arch@vger.kernel.org
>> > Signed-off-by: Johan Hovold <johan@kernel.org>
>> > ---
>
>> > diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
>> > index 31434c5a90ef..8a95a954f514 100644
>> > --- a/drivers/gpio/gpiolib-sysfs.c
>> > +++ b/drivers/gpio/gpiolib-sysfs.c
>> > @@ -293,8 +293,8 @@ static int sysfs_set_active_low(struct gpio_desc *desc, struct device *dev,
>> >                 clear_bit(FLAG_ACTIVE_LOW, &desc->flags);
>> >
>> >         /* reconfigure poll(2) support if enabled on one edge only */
>> > -       if (dev != NULL && (!!test_bit(FLAG_TRIG_RISE, &desc->flags) ^
>> > -                               !!test_bit(FLAG_TRIG_FALL, &desc->flags))) {
>> > +       if (!!test_bit(FLAG_TRIG_RISE, &desc->flags) ^
>> > +                               !!test_bit(FLAG_TRIG_FALL, &desc->flags)) {
>>
>> This change seems to be unrelated to this patch...
>
> This helper is now only called from the attribute operation and dev
> will never be NULL.
>
> On the other hand, it was never called with a NULL argument before this
> patch either (the test has always been bogus). Let me know if you prefer
> this bit to be a separate patch.

Nope, after reading your explanation I understand why you want to have
this here. Thanks for clarifying!
