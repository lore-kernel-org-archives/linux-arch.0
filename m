From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 10/12] platform/early: implement support for early
 platform drivers
Date: Tue, 15 May 2018 20:06:52 -0500
Message-ID: <CAL_JsqK0o_xRLhkZPjpM2NN5_hm_3-XLGzymgD1ae1DZCUFtkQ@mail.gmail.com>
References: <20180511162028.20616-1-brgl@bgdev.pl> <20180511162028.20616-11-brgl@bgdev.pl>
 <CAL_JsqJw8UXktcLK8ADUfo1P+1un+omJ31sGcq7GFbNwJMsHKg@mail.gmail.com> <CAMRc=MdsDWb0Ve29_d=30nc1F0aVhTrG74GX=sv0iB5WycWwLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMRc=MdsDWb0Ve29_d=30nc1F0aVhTrG74GX=sv0iB5WycWwLw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, David Lechner <david@lechnology.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Peter Rosin <peda@axentia.se>, Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Magnus Damm <magnus.damm@gmail.com>, Johan Hovold <johan@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, May 15, 2018 at 9:06 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> 2018-05-14 15:37 GMT+02:00 Rob Herring <robh+dt@kernel.org>:
>> On Fri, May 11, 2018 at 11:20 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>
>>> This introduces the core part of support for early platform drivers
>>> and devices.
>>>
>>
>> It looks like most of your prep patches are to separate the alloc and
>> init of platform devices because you are essentially making early
>> devices/drivers a sub-class. Maybe you could avoid doing that and
>> simplify things a bit. Comments below based on doing that...
>>
>
> My aim was to change as little as possible for everybody else while
> fixing our problem. These changes are already controversial enough
> without risky reusing of existing fields in common structures. I was
> just afraid that there are too many intricacies for it to be safe.

I don't think those intricacies would go away just by having separate
fields. Perhaps it would make things fail more explicitly. After all,
I think it needs to be a very atomic operation when a device is
switched.

>>> +/**
>>> + * struct early_platform_driver
>>> + *
>>> + * @pdrv: real platform driver associated with this early platform driver
>>> + * @list: list head for the list of early platform drivers
>>> + * @early_probe: early probe callback
>>> + */
>>> +struct early_platform_driver {
>>> +       struct platform_driver pdrv;
>>> +       struct list_head list;
>>
>> Couldn't you use an existing list in driver_private until you move
>> over to the normal bus infra.
>>
>
> This is something that the previous implementation did. It was quite
> unreadable, so I decided to go with a separate list.
>
>>> +       int (*early_probe)(struct platform_device *);
>>
>> Just add this to platform_driver.
>>
>
> This would extend the structure for everybody else while there'll be
> very few such devices and not all systems would even require it.
>
>>> +};
>>> +
>>> +/**
>>> + * struct early_platform_device
>>> + *
>>> + * @pdev: real platform device associated with this early platform device
>>> + * @list: list head for the list of early platform devices
>>> + * @deferred: true if this device's early probe was deferred
>>> + * @deferred_drv: early platform driver with which this device was matched
>>> + */
>>> +struct early_platform_device {
>>> +       struct platform_device pdev;
>>> +       struct list_head list;
>>
>> Use a list in device_private?
>>
>>> +       bool deferred;
>>> +       struct early_platform_driver *deferred_drv;
>>
>> Can't you use the existing deferred probe list?
>>
>
> I thought about it, but I was afraid there could be some timing issues
> with that and decided against it. The early deferral also doesn't work
> in a workque, but is synchronous instead.

I didn't mean use the wq, but just the list fields. You'd still have
the early list and normal list with different list heads. If you ever
had a device wanting to be on both lists at the same time, then you've
got major problems.

Rob
