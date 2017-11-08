From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 24/31] nds32: Miscellaneous header files
Date: Wed, 8 Nov 2017 10:57:41 +0100
Message-ID: <CAK8P3a2uZSXr9hT=Jzu1a8Lbg3302-FOr-mtHvY_5xewyoW-jA@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <6f3f5675b73bc7fe895c615b0d48f93966499782.1510118606.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6f3f5675b73bc7fe895c615b0d48f93966499782.1510118606.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>
Cc: greentime@andestech.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Nov 8, 2017 at 6:55 AM, Greentime Hu <green.hu@gmail.com> wrote:
> +
> +static inline void __delay(unsigned long loops)
> +{
> +       __asm__ __volatile__(".align 2\n"
> +                            "1:\n"
> +                            "\taddi\t%0, %0, -1\n"
> +                            "\tbgtz\t%0, 1b\n"
> +                            :"=r"(loops)
> +                            :"0"(loops));
> +}

Does the architecture define a high-resolution clock source? If yes,
then it's better
to use that to get exact timing than to rely on the loop calibration.

> +/*
> + * This file is generally used by user-level software, so you need to
> + * be a little careful about namespace pollution etc.  Also, we cannot
> + * assume GCC is being used.
> + */
> +
> +typedef unsigned short __kernel_mode_t;
> +#define __kernel_mode_t __kernel_mode_t
> +
> +typedef unsigned short __kernel_ipc_pid_t;
> +#define __kernel_ipc_pid_t __kernel_ipc_pid_t
> +
> +typedef unsigned short __kernel_uid_t;
> +typedef unsigned short __kernel_gid_t;
> +#define __kernel_uid_t __kernel_uid_t
> +
> +typedef unsigned short __kernel_old_dev_t;
> +#define __kernel_old_dev_t __kernel_old_dev_t
> +
> +#include <asm-generic/posix_types.h>

I don't understand why you would want to override any of those.
Changing them unfortunately means rebuilding all of your user
space, but I think it would be better to do that now than to suffer
from this later on.

      Arnd
