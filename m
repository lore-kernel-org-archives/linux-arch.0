From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH v4 04/36] nds32: Kernel booting and initialization
Date: Wed, 20 Dec 2017 10:35:30 +0800
Message-ID: <CAEbi=3cyccwHNurEmXFC1nfVzEc9FZMp5bxNi8un4c3w4xA7Sg@mail.gmail.com>
References: <cover.1513577007.git.green.hu@gmail.com> <935ff034982f077b2e6f5eeccd6fe2110614fc9c.1513577007.git.green.hu@gmail.com>
 <78afd442-4482-f104-746e-5984214658ee@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <78afd442-4482-f104-746e-5984214658ee@infradead.org>
Sender: netdev-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, netdev <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>
List-Id: linux-arch.vger.kernel.org

2017-12-20 6:01 GMT+08:00 Randy Dunlap <rdunlap@infradead.org>:
> On 12/17/2017 10:46 PM, Greentime Hu wrote:
>> From: Greentime Hu <greentime@andestech.com>
>>
>> This patch includes the kernel startup code. It can get dtb pointer
>> passed from bootloader. It will create a temp mapping by tlb
>> instructions at beginning and goto start_kernel.
>>
>> Signed-off-by: Vincent Chen <vincentc@andestech.com>
>> Signed-off-by: Greentime Hu <greentime@andestech.com>
>> ---
>>  arch/nds32/kernel/head.S  |  189 ++++++++++++++++++++++
>>  arch/nds32/kernel/setup.c |  383 +++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 572 insertions(+)
>>  create mode 100644 arch/nds32/kernel/head.S
>>  create mode 100644 arch/nds32/kernel/setup.c
>>
>
>> diff --git a/arch/nds32/kernel/setup.c b/arch/nds32/kernel/setup.c
>> new file mode 100644
>> index 0000000..7718c58
>> --- /dev/null
>> +++ b/arch/nds32/kernel/setup.c
>> @@ -0,0 +1,383 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (C) 2005-2017 Andes Technology Corporation
>> +
>
> [snip]
>
>> +struct cache_info L1_cache_info[2];
>> +static void __init dump_cpu_info(int cpu)
>> +{
>> +     int i, p = 0;
>> +     char str[sizeof(hwcap_str) + 16];
>> +
>> +     for (i = 0; hwcap_str[i]; i++) {
>> +             if (elf_hwcap & (1 << i)) {
>> +                     sprintf(str + p, "%s ", hwcap_str[i]);
>> +                     p += strlen(hwcap_str[i]) + 1;
>> +             }
>> +     }
>> +
>> +     pr_info("CPU%d Featuretures: %s\n", cpu, str);
>
>                        Features:
>

Thanks Randy. I will fix this typo.
