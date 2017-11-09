From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH 03/31] nds32: Support early_printk
Date: Thu, 9 Nov 2017 15:19:57 +0800
Message-ID: <CAEbi=3e_Sz_VyE0H_VAFW9rJ98VwNgJe36ayFbQsL0UdQMQ7Mw@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <f01f62d9666876052cc37043b605b60355bf54d7.1510118606.git.green.hu@gmail.com>
 <20171108094705.GK1370@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:53937 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbdKIHUj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Nov 2017 02:20:39 -0500
In-Reply-To: <20171108094705.GK1370@distanz.ch>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, netdev <netdev@vger.kernel.org>, Rick Chen <rick@andestech.com>

2017-11-08 17:47 GMT+08:00 Tobias Klauser <tklauser@distanz.ch>:
> On 2017-11-08 at 06:54:51 +0100, Greentime Hu <green.hu@gmail.com> wrote:
>> From: Greentime Hu <greentime@andestech.com>
>>
>> Signed-off-by: Rick Chen <rick@andestech.com>
>> Signed-off-by: Greentime Hu <greentime@andestech.com>
>> ---
>>  arch/nds32/kernel/early_printk.c |  124 ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 124 insertions(+)
>>  create mode 100644 arch/nds32/kernel/early_printk.c
>>
>> diff --git a/arch/nds32/kernel/early_printk.c b/arch/nds32/kernel/early_printk.c
>> new file mode 100644
>> index 0000000..269c3cd
>> --- /dev/null
>> +++ b/arch/nds32/kernel/early_printk.c
>
> Could be implemented using earlycon (the 8250 drivers already supports
> it) instead of duplicating functionality in arch/nds32?  See e.g. the
> nios2 port for how this could be done, specifically commit e118c3fec9c0
> ("nios2: remove custom early console implementation").

Thanks.
I will try to use earlycon in the next version patch.
I will remove this patch if earlycon is able to be used in nds32.
