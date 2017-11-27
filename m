From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 14/35] nds32: System calls handling
Date: Mon, 27 Nov 2017 15:46:00 +0100
Message-ID: <CAK8P3a3V7=4LjT38xT2VBQW4sTgpKergar2KoO8brbMZjR--1w@mail.gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com> <ee45d9c7b0388c87a93a26484e859001477eb3a2.1511785528.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ee45d9c7b0388c87a93a26484e859001477eb3a2.1511785528.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Nov 27, 2017 at 1:28 PM, Greentime Hu <green.hu@gmail.com> wrote:

> diff --git a/arch/nds32/include/asm/syscalls.h b/arch/nds32/include/asm/syscalls.h
> new file mode 100644
> index 0000000..741ccdc
> --- /dev/null
> +++ b/arch/nds32/include/asm/syscalls.h
> @@ -0,0 +1,27 @@
> +/*
> + * Copyright (C) 2005-2017 Andes Technology Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef __ASM_NDS32_SYSCALLS_H
> +#define __ASM_NDS32_SYSCALLS_H
> +
> +int sys_cacheflush(unsigned long addr, unsigned long len, unsigned int op);
> +long sys_fadvise64_64_wrapper(int fd, int advice, loff_t offset, loff_t len);
> +asmlinkage int sys_syscall(void);
> +asmlinkage int sys_rt_sigreturn_wrapper(void);

You mentioned that sys_syscall() should be removed in this version.

By convention, all syscall declarations should start with 'asmlinkage long',
even though this has no effect in your architecture.

> diff --git a/arch/nds32/include/uapi/asm/unistd.h b/arch/nds32/include/uapi/asm/unistd.h
> new file mode 100644
> index 0000000..2bad1e7
> --- /dev/null
> +++ b/arch/nds32/include/uapi/asm/unistd.h

> +
> +#define __ARCH_WANT_RENAMEAT
> +#define __ARCH_WANT_SYSCALL_OFF_T

These two should not be here.

> +#define __ARCH_WANT_SYNC_FILE_RANGE2

This one is fine though

> +/* Use the standard ABI for syscalls */
> +#include <asm-generic/unistd.h>
> +
> +__SYSCALL(__NR_fadvise64_64, sys_fadvise64_64_wrapper)
> +__SYSCALL(__NR_rt_sigreturn, sys_rt_sigreturn_wrapper)

I think you are overriding the array assignment here, this may cause a
compiler warning when building with "make C=1 V=1" since you have
the same index assigned to two pointers. A better way to do this
is to override the name:

#define sys_rt_sigreturn sys_rt_sigreturn_wrapper
#define sys_fadvise64_64 sys_fadvise64_64_wrapper
#include <asm-generic/unistd.h>


      Arnd
