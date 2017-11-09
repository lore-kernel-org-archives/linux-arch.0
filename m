From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH 20/31] nds32: L2 cache support
Date: Thu, 9 Nov 2017 15:24:08 +0800
Message-ID: <CAEbi=3cf8tyFjieNs+WKqNfJWn9mere7dZLqyZjVCprEqhiC5A@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <b8c4d4dd7b5ce02123300018041923d0dfa97af9.1510118606.git.green.hu@gmail.com>
 <CAK8P3a22ROs70434v=vJ8BMaa4_-5CeBTjTGxPwz8Ri3z2EPyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a22ROs70434v=vJ8BMaa4_-5CeBTjTGxPwz8Ri3z2EPyA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>, deanbo422@gmail.com
List-Id: linux-arch.vger.kernel.org

2017-11-08 17:48 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Wed, Nov 8, 2017 at 6:55 AM, Greentime Hu <green.hu@gmail.com> wrote:
>> From: Greentime Hu <greentime@andestech.com>
>>
>> Signed-off-by: Vincent Chen <vincentc@andestech.com>
>> Signed-off-by: Greentime Hu <greentime@andestech.com>
>
>> +
>> +/* This is defined for head.S to use due to device tree is not yet built. */
>> +#define L2CC_PA_BASE           0x90F00000
>
> This looks problematic, since it prevents you from using the same head.S for
> multiple SoCs that have different L2 controllers or that have them at different
> addresses.
>
> What does head.S actually do to the L2CC? Could the boot protocol require
> that to be done by the boot loader before entering the kernel instead?
>

Thanks.
It will disable and invalidate L2 cache. I think we can do these
things in bootloader.
I will refine it in the next version patch.
