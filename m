Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:54629 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbdKIHYt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Nov 2017 02:24:49 -0500
MIME-Version: 1.0
In-Reply-To: <CAK8P3a22ROs70434v=vJ8BMaa4_-5CeBTjTGxPwz8Ri3z2EPyA@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <b8c4d4dd7b5ce02123300018041923d0dfa97af9.1510118606.git.green.hu@gmail.com>
 <CAK8P3a22ROs70434v=vJ8BMaa4_-5CeBTjTGxPwz8Ri3z2EPyA@mail.gmail.com>
From: Greentime Hu <green.hu@gmail.com>
Date: Thu, 9 Nov 2017 15:24:08 +0800
Message-ID: <CAEbi=3cf8tyFjieNs+WKqNfJWn9mere7dZLqyZjVCprEqhiC5A@mail.gmail.com>
Subject: Re: [PATCH 20/31] nds32: L2 cache support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>, deanbo422@gmail.com
Message-ID: <20171109072408.Vfx9HK3d_JB0yOg5deVwxo2Uk9DmAVGdWtakXJGi9Fo@z>

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
