From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 6/6] mips: generate uapi header and system call table files
Date: Thu, 29 Nov 2018 15:22:16 +0100
Message-ID: <CAK8P3a0rTwm_pCtQXyn_fyJttihKJ6Gpq97mw-r5ySUNBksCig@mail.gmail.com>
References: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org> <1543481016-18500-7-git-send-email-firoz.khan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543481016-18500-7-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>
Cc: "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Nov 29, 2018 at 9:45 AM Firoz Khan <firoz.khan@linaro.org> wrote:

> diff --git a/arch/mips/include/uapi/asm/Kbuild b/arch/mips/include/uapi/asm/Kbuild
> index 7a4becd..ed4bd03 100644
> --- a/arch/mips/include/uapi/asm/Kbuild
> +++ b/arch/mips/include/uapi/asm/Kbuild
> @@ -1,5 +1,11 @@
>  # UAPI Header export list
>  include include/uapi/asm-generic/Kbuild.asm
>
> +generated-y += unistd_n32.h
> +generated-y += unistd_n64.h
> +generated-y += unistd_o32.h
> +generated-y += unistd_nr_n32.h
> +generated-y += unistd_nr_n64.h
> +generated-y += unistd_nr_o32.h
>  generic-y += bpf_perf_event.h
>  generic-y += ipcbuf.h

I'd argue that the unistd_nr_*.h headers should not be in the uapi directory
but instead be included only from the in-kernel header.


> diff --git a/arch/mips/kernel/scall64-n64.S b/arch/mips/kernel/scall64-n64.S
> new file mode 100644
> index 0000000..402a085
> --- /dev/null
> +++ b/arch/mips/kernel/scall64-n64.S
> @@ -0,0 +1,117 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 1995, 96, 97, 98, 99, 2000, 01, 02 by Ralf Baechle
> + * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
> + * Copyright (C) 2001 MIPS Technologies, Inc.
> + */
> +#include <linux/errno.h>
> +#include <asm/asm.h>
> +#include <asm/asmmacro.h>
> +#include <asm/irqflags.h>

It looks like you change and rename this file at the same time.
Generally speaking, I would not do that in one patch. Either
leave the slightly inconsistent name unchanged, or rename
it in a separate patch.

         Arnd
