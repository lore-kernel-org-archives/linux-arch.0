Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:41420 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751106AbeC0HsY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Mar 2018 03:48:24 -0400
MIME-Version: 1.0
In-Reply-To: <20180327022128.GB10185@guoren>
References: <cover.1521399976.git.ren_guo@c-sky.com> <8a9c9b588cdfdf8b25ca9d449bf5c862d329c1d8.1521399976.git.ren_guo@c-sky.com>
 <CAK8P3a3L-zO3K5qcmBPChhSqh+E6WtNRFV1cJRbksGZ74uaEAQ@mail.gmail.com> <20180327022128.GB10185@guoren>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 27 Mar 2018 09:48:23 +0200
Message-ID: <CAK8P3a2CD4nEDzMZxtn1QQJA3oQeX=-4v17AxhpTuUqk8boVhg@mail.gmail.com>
Subject: Re: [PATCH 17/19] csky: defconfig
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
Message-ID: <20180327074823.jzQMKtYP6nF5uMl8C2kOs9KtKOAHvRBSazzDFG3Q55s@z>

On Tue, Mar 27, 2018 at 4:21 AM, Guo Ren <ren_guo@c-sky.com> wrote:
> On Mon, Mar 26, 2018 at 03:16:31PM +0200, Arnd Bergmann wrote:

>> > +CONFIG_CFG80211=y
>> > +CONFIG_CFG80211_DEBUGFS=y
>> > +CONFIG_CFG80211_WEXT=y
>>
>> I would guess you want IPV6 but not WEXT here.
> Gx6605s devlepment board support usb-wifi.
> Perhaps WEXT is needed by iwconfig or iwlist? So I just enable it.
> However, I'll consider to remove it.

I think it's only for backwards compatibility with old versions of
those tools. There are some older drivers that use WEXT as the
native interface, but CFG80211 based drivers have a netlink
interface.

>> > +CONFIG_FB=y
>> > +CONFIG_FB_TILEBLITTING=y
>> > +CONFIG_FB_SIMPLE=y
>> > +CONFIG_BACKLIGHT_LCD_SUPPORT=y
>> > +# CONFIG_LCD_CLASS_DEVICE is not set
>> > +# CONFIG_BACKLIGHT_CLASS_DEVICE is not set
>> > +# CONFIG_VGA_CONSOLE is not set
>> > +CONFIG_FRAMEBUFFER_CONSOLE=y
>> > +CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
>> > +CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
>> > +CONFIG_LOGO=y
>> > +# CONFIG_LOGO_LINUX_MONO is not set
>> > +# CONFIG_LOGO_LINUX_VGA16 is not set
>>
>> For new platforms, using the DRM subsystem is the recommend
>> way to do graphics, it mostly replaces the framebuffer subsystem
>> here.
> These used by:
> https://github.com/c-sky/addons-linux/tree/master/addons/drivers/video/fbdev/nationalchip
>
> I'll consider the DRM subsystem.

It used to be rather hard to write a new DRM driver, but that has
improved a lot recently. You might be able to fit your driver into
drivers/gpu/drm/tinydrm/, or maybe do something a bit more complex
like drivers/gpu/drm/pl111/ or drivers/gpu/drm/stm/.

       Arnd
