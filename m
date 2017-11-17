From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 26/31] nds32: Build infrastructure
Date: Fri, 17 Nov 2017 13:50:02 +0100
Message-ID: <CAK8P3a0ZvAMzG2nRm6Lo8DzdCu-=cCvuWX3ExHtYXP9zOsQ_4Q@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <7278eca76456b412e02d9baa5dc164e83199cbab.1510118606.git.green.hu@gmail.com>
 <CAK8P3a11Mk3XcmP5Ecbv55TuNRjrrp_43GX8hPDfdLh6JMHE=g@mail.gmail.com>
 <CAEbi=3d91XPe0oGFfSB0T4tCU9FN=0SNLk7xKFifrV+-06u8AA@mail.gmail.com>
 <CAK8P3a3i+_ZRcR9ab=Pf26R+1JKuzz3VKQxA=mL131KDCpobHA@mail.gmail.com>
 <CAEbi=3c7tduSHQ2HEAfcJF8A3QPD493_gHPK=_WiQGtSr0bc=A@mail.gmail.com> <CAEbi=3dNwRU0aVqDdHDmmQD=RHCcnOcf2+kik80ZnvrGJ8x-kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAEbi=3dNwRU0aVqDdHDmmQD=RHCcnOcf2+kik80ZnvrGJ8x-kg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Nov 17, 2017 at 1:39 PM, Greentime Hu <green.hu@gmail.com> wrote:
> 2017-11-10 16:26 GMT+08:00 Greentime Hu <green.hu@gmail.com>:
>> 2017-11-09 18:33 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>>> On Thu, Nov 9, 2017 at 10:02 AM, Greentime Hu <green.hu@gmail.com> wrote:
>>>> 2017-11-08 18:16 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>>>>> On Wed, Nov 8, 2017 at 6:55 AM, Greentime Hu <green.hu@gmail.com> wrote:
>>>
>>>>>> +config GENERIC_CALIBRATE_DELAY
>>>>>> +       def_bool y
>>>>>
>>>>> It's better to avoid the delay loop completely and skip the calibration,
>>>>> if your hardware allows.
>>>>
>>>> Thanks.
>>>> Do you mean that this config should be def_bool n?
>>>> why? Almost all arch enable it.
>>>
>>> It depends on what your hardware can do. If you have a way to see how much
>>> time has passed that is guaranteed to be reliable on all machines, then
>>> use that instead.
>>>
>>> On a lot of architectures, it's not possible, so they have to fall back to using
>>> the delay loop.
>>
>> I get it. I will discuss it with our HW colleagues.
>> We may get these informations in some registers.
>
> Hi, Arnd:
>
> I think I can't set it to default n because it will be called in start_kernel.
>
> start_kernel() -> calibrate_delay()
>
> If I don't enable this config, it will link error because it didn't
> build init/calibrate.c

You will have to provide an architecture-specific implementation of
this function, please ahve a look at what others are doing, e.g. tile,
openrisc or
h8300.

          Arnd
