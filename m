From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 6/9] RISC-V: Device, timer, IRQs, and the SBI
Date: Thu, 29 Jun 2017 15:52:44 -0700 (PDT)
Message-ID: <mhng-b71fc2a8-a47a-49af-82e1-fb88c016d547@palmer-si-x1c4>
References: <20170629083924.GB5851@distanz.ch>
Mime-Version: 1.0 (MHng)
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170629083924.GB5851@distanz.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: tklauser@distanz.ch
Cc: peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, will.deacon@arm.com, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com
List-Id: linux-arch.vger.kernel.org

On Thu, 29 Jun 2017 01:39:25 PDT (-0700), tklauser@distanz.ch wrote:
> On 2017-06-28 at 20:55:35 +0200, Palmer Dabbelt <palmer@dabbelt.com> wrote:
> [...]
>> diff --git a/arch/riscv/include/asm/device.h b/arch/riscv/include/asm/device.h
>> new file mode 100644
>> index 000000000000..28975e528d2f
>> --- /dev/null
>> +++ b/arch/riscv/include/asm/device.h
>> @@ -0,0 +1,27 @@
>> +/*
>> + * Copyright (C) 2016 SiFive
>> + *
>> + *   This program is free software; you can redistribute it and/or
>> + *   modify it under the terms of the GNU General Public License
>> + *   as published by the Free Software Foundation, version 2.
>> + *
>> + *   This program is distributed in the hope that it will be useful,
>> + *   but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *   GNU General Public License for more details.
>> + */
>> +
>> +
>> +#ifndef _ASM_RISCV_DEVICE_H
>> +#define _ASM_RISCV_DEVICE_H
>> +
>> +#include <linux/sysfs.h>
>> +
>> +struct dev_archdata {
>> +	struct dma_map_ops *dma_ops;
>> +};
>
> The dma_ops member isn't used in any arch code or driver from what I can
> tell (I checked against your riscv-for-submission-v3 branch). Could
> device.h from asm-generic be used instead, or did I miss something?

I think you're right.  I'll include this

  diff --git a/arch/riscv/include/asm/device.h b/arch/riscv/include/asm/device.h
  index 28975e528d2f..a310c2c26101 100644
  --- a/arch/riscv/include/asm/device.h
  +++ b/arch/riscv/include/asm/device.h
  @@ -11,17 +11,9 @@
    *   GNU General Public License for more details.
    */

  -
   #ifndef _ASM_RISCV_DEVICE_H
   #define _ASM_RISCV_DEVICE_H

  -#include <linux/sysfs.h>
  -
  -struct dev_archdata {
  -       struct dma_map_ops *dma_ops;
  -};
  -
  -struct pdev_archdata {
  -};
  +#include <asm-generic/device.h>

   #endif /* _ASM_RISCV_DEVICE_H */

in the v4

>
>> +
>> +struct pdev_archdata {
>> +};
>> +
>> +#endif /* _ASM_RISCV_DEVICE_H */

Thanks!
