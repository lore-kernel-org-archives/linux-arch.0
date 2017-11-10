From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH 25/31] nds32: defconfig
Date: Fri, 10 Nov 2017 16:16:03 +0800
Message-ID: <CAEbi=3d+3m7rPYnLjpMNB9cK+3R46aFGu4EcP9dmfN_SP0wjAA@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <805f8432979e2707fbc9bf62dc52b8abfbd2cb14.1510118606.git.green.hu@gmail.com>
 <CAK8P3a0XciTazM7OewyRV+92J0JgfbpvXJ5jizNcoL3LV=XOOQ@mail.gmail.com>
 <CAEbi=3dvkAs8=gpjtaKKBOa2MkQb1bh87q4nEsWxNuWn_1SxUw@mail.gmail.com> <CAK8P3a3_vY1NLtc+Mpimn22qWrnPVSj+QJWkd=_s=evTc=toiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a3_vY1NLtc+Mpimn22qWrnPVSj+QJWkd=_s=evTc=toiw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>, deanbo422@gmail.com
List-Id: linux-arch.vger.kernel.org

2017-11-09 18:20 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Thu, Nov 9, 2017 at 9:00 AM, Greentime Hu <green.hu@gmail.com> wrote:
>> 2017-11-08 18:03 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>>> On Wed, Nov 8, 2017 at 6:55 AM, Greentime Hu <green.hu@gmail.com> wrote:
>>>> From: Greentime Hu <greentime@andestech.com>
>>>>
>>>> Signed-off-by: Vincent Chen <vincentc@andestech.com>
>>>> Signed-off-by: Greentime Hu <greentime@andestech.com>
>>>> ---
>>>>  arch/nds32/configs/ae3xx_defconfig  |  110 +++++++++++++++++++++++++++++++++++
>>>>  arch/nds32/configs/ag101p_defconfig |  109 ++++++++++++++++++++++++++++++++++
>>>
>>> Are those two incompatible? I would recommend starting without board
>>> specific defconfig
>>> files, it just gets messy once you get more than a few machines you
>>> want to support.
>>
>> Thanks.
>> These 2 are incompatible.
>> They use different drivers. I may still keep these 2 defconfigs.
>
> Using different drivers doesn't make machines incompatible. For instance, the
> x86 desktop machine has drivers for all kinds of devices, but it uses
> one configuration
> that works on basically any x86 machine.
>
> Similarly, we only have one defconfig file on arm64, and it works across very
> diverse machines (phone, home routers, large servers, etc.).
>
> All drivers should be written in a way to allow being built into the
> kernel without
> doing any harm when you don't have the respective hardware.

Thanks.
Make sense.
I will keep only one defconfig in the next version patch.

>>>> +CONFIG_FB=y
>>>> +# CONFIG_VGA_CONSOLE is not set
>>>> +CONFIG_FRAMEBUFFER_CONSOLE=y
>>>
>>> You have a framebuffer console here, but no framebuffer driver?
>>
>> Thanks.
>> I shall enable it when I push our framebuffer in the next time.
>> I will disable it in the next version patch.
>
> The fbdev subsystem is no longer recommended for new drivers, they
> should be written on top of the DRM framework. You can use
> CONFIG_DRM_FBDEV_EMULATION to get the framebuffer
> console on top of that, but then you don't need to enable CONFIG_FB.
>
> Please have a look at drivers/gpu/drm/tinydrm/ to see if you can either
> use that directly, or take it as a skeleton for your own driver.
>

Thanks.
We will check how to use CONFIG_DRM_FBDEV_EMULATION to get framebuffer.
