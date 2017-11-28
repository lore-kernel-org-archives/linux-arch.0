Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:42247 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752104AbdK1CV6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Nov 2017 21:21:58 -0500
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2czU7=jECXFOvtRNhrq3zyX7gV7sa3OFPQ-8A4U8iH0A@mail.gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com> <01fc485408504e6a43b768664f44b9fd42a89503.1511785528.git.green.hu@gmail.com>
 <CAK8P3a2czU7=jECXFOvtRNhrq3zyX7gV7sa3OFPQ-8A4U8iH0A@mail.gmail.com>
From: Vincent Chen <deanbo422@gmail.com>
Date: Tue, 28 Nov 2017 10:21:56 +0800
Message-ID: <CAJsyPhxQpYO1JF+WrthROynYEMr084kdSiaXbAkcvFf592DvQA@mail.gmail.com>
Subject: Re: [PATCH v2 18/35] nds32: Debugging support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greentime Hu <green.hu@gmail.com>, Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Vincent Chen <vincentc@andestech.com>
Message-ID: <20171128022156.22vOtjRj4_IqLrmRJi-ShrVgaKypeou28ju5qZjeRks@z>

2017-11-27 22:34 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Mon, Nov 27, 2017 at 1:28 PM, Greentime Hu <green.hu@gmail.com> wrote:
>> +struct user_pt_regs {
>> +       long uregs[26];
>> +       long fp;
>> +       long gp;
>> +       long lp;
>> +       long sp;
>> +       long ipc;
>> +#if defined(CONFIG_HWZOL)
>> +       long lb;
>> +       long le;
>> +       long lc;
>> +#else
>> +       long dummy[3];
>> +#endif
>> +       long syscallno;
>> +};
>
> You cannot reference CONFIG_ symbols in a uapi header, since the
> configuration headers
> are not available.
>
Thanks
I will modify it in the next version patch.

>        Arnd
