From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 12/25] metag: Add 32 bit time_t and clock_t
Date: Tue, 13 May 2014 10:22:22 +0100
Message-ID: <5371E44E.20509@imgtec.com>
References: <1399971456-3941-1-git-send-email-lftan@altera.com> <1399971885-4413-1-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1399971885-4413-1-git-send-email-lftan@altera.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ley Foon Tan <lftan@altera.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lftan.linux@gmail.com, cltang@codesourcery.com, linux-metag@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi,

On 13/05/14 10:04, Ley Foon Tan wrote:
> Override time_t and clock_t in include/uapi/asm-generic.
> 
> Signed-off-by: Ley Foon Tan <lftan@altera.com>
> ---
>  arch/metag/include/asm/Kbuild             |  1 -
>  arch/metag/include/uapi/asm/Kbuild        |  1 +
>  arch/metag/include/uapi/asm/posix_types.h | 17 +++++++++++++++++
>  3 files changed, 18 insertions(+), 1 deletion(-)
>  create mode 100644 arch/metag/include/uapi/asm/posix_types.h
> 
> diff --git a/arch/metag/include/asm/Kbuild b/arch/metag/include/asm/Kbuild
> index c29ead8..5a97e0d6 100644
> --- a/arch/metag/include/asm/Kbuild
> +++ b/arch/metag/include/asm/Kbuild
> @@ -31,7 +31,6 @@ generic-y += param.h
>  generic-y += pci.h
>  generic-y += percpu.h
>  generic-y += poll.h
> -generic-y += posix_types.h
>  generic-y += preempt.h
>  generic-y += scatterlist.h
>  generic-y += sections.h
> diff --git a/arch/metag/include/uapi/asm/Kbuild b/arch/metag/include/uapi/asm/Kbuild
> index 84e09fe..1542689 100644
> --- a/arch/metag/include/uapi/asm/Kbuild
> +++ b/arch/metag/include/uapi/asm/Kbuild
> @@ -3,6 +3,7 @@ include include/uapi/asm-generic/Kbuild.asm
>  
>  header-y += byteorder.h
>  header-y += ech.h
> +header-y += posix_types.h

I don't think you need this. The file
include/uapi/asm-generic/Kbuild.asm which is included at the top of each
arches uapi/asm/Kbuild already has it.
(Admittedly there's already a lot of duplication of these that should
probably be fixed at some point).

Other than that it looks okay to me.

Cheers
James

>  header-y += ptrace.h
>  header-y += resource.h
>  header-y += sigcontext.h
> diff --git a/arch/metag/include/uapi/asm/posix_types.h b/arch/metag/include/uapi/asm/posix_types.h
> new file mode 100644
> index 0000000..d643b22
> --- /dev/null
> +++ b/arch/metag/include/uapi/asm/posix_types.h
> @@ -0,0 +1,17 @@
> +#ifndef __ARCH_METAG_POSIX_TYPES_H
> +#define __ARCH_METAG_POSIX_TYPES_H
> +
> +/*
> + * This file is generally used by user-level software, so you need to
> + * be a little careful about namespace pollution etc. Also, we cannot
> + * assume GCC is being used.
> + */
> +typedef long	__kernel_time_t;
> +#define __kernel_time_t __kernel_time_t
> +
> +typedef long	__kernel_clock_t;
> +#define __kernel_clock_t __kernel_clock_t
> +
> +#include <asm-generic/posix_types.h>
> +
> +#endif
> 
