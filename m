From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH 08/31] nds32: Cache and TLB routines
Date: Wed, 8 Nov 2017 17:01:48 +0800
Message-ID: <CAEbi=3dRR6rAzWnLJC6=fbFpfivEaHnb6A9YVsQmx3q+6Z7s3w@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <220aabe68365f970ed6de79ef88f9598f272dcb9.1510118606.git.green.hu@gmail.com>
 <CAK8P3a0ObXRL+39bPHF_e-06-aC=4X46DqMuC1hPLWH6CW+FOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:50652 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbdKHJC3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Nov 2017 04:02:29 -0500
In-Reply-To: <CAK8P3a0ObXRL+39bPHF_e-06-aC=4X46DqMuC1hPLWH6CW+FOQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>

2017-11-08 16:45 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Wed, Nov 8, 2017 at 6:54 AM, Greentime Hu <green.hu@gmail.com> wrote:
>
>> +#ifndef __NDS32_PROCFNS_H__
>> +#define __NDS32_PROCFNS_H__
>> +
>> +#define CPU_NAME n13
>> +
>> +#ifdef __KERNEL__
>> +
>> +#ifdef __STDC__
>> +#define ____cpu_fn(name,fn)       name##fn
>> +#else
>> +#define ____cpu_fn(name,fn)       name/**/fn
>> +#endif
>> +#define __cpu_fn(name,fn)         ____cpu_fn(name,fn)
>> +
>> +#define cpu_proc_init                  __cpu_fn( CPU_NAME, _proc_init)
>> +#define cpu_proc_fin                   __cpu_fn( CPU_NAME, _proc_fin)
>> +#define cpu_do_idle                    __cpu_fn( CPU_NAME, _do_idle)
>> +#define cpu_reset                      __cpu_fn( CPU_NAME, _reset)
>> +#define cpu_switch_mm                  __cpu_fn( CPU_NAME, _switch_mm)
>
> I see you have copied this from ARM. Do you actually need the same complexity,
> with the ability to build either optimal code for a particular CPU or
> a multi-CPU
> version?
>
> Most other architectures seem to have settled for doing just one of the two
> models. How many CPU implementations to you expect to support that
> differ in all of those functions?
>

I think we can simplify the implementations because we may not have that
many implementations. I will refine it in the next version patch.
