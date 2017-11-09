From: Vincent Chen <deanbo422@gmail.com>
Subject: Re: FW: [PATCH 24/31] nds32: Miscellaneous header files
Date: Thu, 9 Nov 2017 18:42:00 +0800
Message-ID: <CAJsyPhzbt61Tp2URKqNfOA0Q5epr5FMHZKR7stLvcDqwWoGcrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arndbergmann@gmail.com
Cc: greentime@andestech.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

>>On Wed, Nov 8, 2017 at 6:55 AM, Greentime Hu <green.hu@gmail.com> wrote:
>> +
>> +static inline void __delay(unsigned long loops) {
>> +       __asm__ __volatile__(".align 2\n"
>> +                            "1:\n"
>> +                            "\taddi\t%0, %0, -1\n"
>> +                            "\tbgtz\t%0, 1b\n"
>> +                            :"=r"(loops)
>> +                            :"0"(loops)); }
>
> Does the architecture define a high-resolution clock source? If yes, then it's better to use that to get exact timing than to rely on the loop calibration.
>
Dear Arnd:

Thanks.
I will modify it in the next version patch.

>> +/*
>> + * This file is generally used by user-level software, so you need to
>> + * be a little careful about namespace pollution etc.  Also, we
>> +cannot
>> + * assume GCC is being used.
>> + */
>> +
>> +typedef unsigned short __kernel_mode_t; #define __kernel_mode_t
>> +__kernel_mode_t
>> +
>> +typedef unsigned short __kernel_ipc_pid_t; #define __kernel_ipc_pid_t
>> +__kernel_ipc_pid_t
>> +
>> +typedef unsigned short __kernel_uid_t; typedef unsigned short
>> +__kernel_gid_t; #define __kernel_uid_t __kernel_uid_t
>> +
>> +typedef unsigned short __kernel_old_dev_t; #define __kernel_old_dev_t
>> +__kernel_old_dev_t
>> +
>> +#include <asm-generic/posix_types.h>
>
> I don't understand why you would want to override any of those.
> Changing them unfortunately means rebuilding all of your user space, but I think it would be better to do that now than to suffer from this later on.
>
>     Arnd

Thanks.
I will remove them in the next version patch.

Best regards
Vincent
