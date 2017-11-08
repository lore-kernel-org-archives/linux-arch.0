From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH 10/31] nds32: IRQ handling
Date: Wed, 8 Nov 2017 17:06:21 +0800
Message-ID: <CAEbi=3c+BWiJMQ5=aD8QY1uCZ74QawrYBXL4i4kWcB-QG0VajA@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <9dea9004aa59acc2e02405b192887b8e60449100.1510118606.git.green.hu@gmail.com>
 <CAK8P3a2GPMaYc+Nq3MBrbTYJwNFE5GqYn=ThAHBmFpJoBG+s5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ua0-f179.google.com ([209.85.217.179]:45522 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbdKHJHC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Nov 2017 04:07:02 -0500
In-Reply-To: <CAK8P3a2GPMaYc+Nq3MBrbTYJwNFE5GqYn=ThAHBmFpJoBG+s5A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>

2017-11-08 16:49 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Wed, Nov 8, 2017 at 6:54 AM, Greentime Hu <green.hu@gmail.com> wrote:
>
>> +
>> +#ifdef CONFIG_TRACE_IRQFLAGS
>> +void notrace arch_trace_hardirqs_on(void)
>> +{
>> +       trace_hardirqs_on();
>> +}
>> +
>> +void notrace arch_trace_hardirqs_off(void)
>> +{
>> +       trace_hardirqs_off();
>> +}
>> +#endif
>
> I don't see those wrappers on other architectures, what do you need them for?

Thanks.

I will remove them in the next version patch.
