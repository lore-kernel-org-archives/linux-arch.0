From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 14/19] csky: Misc headers
Date: Tue, 20 Mar 2018 00:11:24 +0800
Message-ID: <CAK8P3a15wbEmejpiokATLW=Cwe-XHZEdgU8fNQY-opjbjuU3-w@mail.gmail.com>
References: <cover.1521399976.git.ren_guo@c-sky.com> <9cb4cf158b8c73325dc524cba8d575e41647131f.1521399976.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9cb4cf158b8c73325dc524cba8d575e41647131f.1521399976.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
List-Id: linux-arch.vger.kernel.org

On Mon, Mar 19, 2018 at 3:51 AM, Guo Ren <ren_guo@c-sky.com> wrote:
> +++ b/arch/csky/include/uapi/asm/fcntl.h
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> +#ifndef __ASM_CSKY_FCNTL_H
> +#define __ASM_CSKY_FCNTL_H
> +
> +#define O_DIRECTORY    040000
> +#define O_NOFOLLOW     0100000
> +#define O_DIRECT       0200000
> +#define O_LARGEFILE    0400000
> +
> +#include <asm-generic/fcntl.h>

This should just use the generic file without overrides: Please don't diverge
from the generic syscall ABI.

> --- /dev/null
> +++ b/arch/csky/include/uapi/asm/stat.h
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> +#ifndef _CSKY_STAT_H
> +#define _CSKY_STAT_H
> +
> +struct __old_kernel_stat {
> +       unsigned short st_dev;

Same here: no need for __old_kernel_stat  or the headers on new architectures.

          Arnd
