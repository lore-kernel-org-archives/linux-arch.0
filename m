From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH 16/25] openrisc: Add 32 bit time_t and clock_t
Date: Tue, 13 May 2014 11:30:23 +0200
Message-ID: <5371E62F.9090203@southpole.se>
References: <1399971456-3941-1-git-send-email-lftan@altera.com>
	<1399971958-4561-1-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-bounces@lists.openrisc.net>
In-Reply-To: <1399971958-4561-1-git-send-email-lftan@altera.com>
List-Unsubscribe: <http://lists.openrisc.net/options/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=unsubscribe>
List-Archive: <http://lists.openrisc.net/pipermail/linux>
List-Post: <mailto:linux@lists.openrisc.net>
List-Help: <mailto:linux-request@lists.openrisc.net?subject=help>
List-Subscribe: <http://lists.openrisc.net/listinfo/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=subscribe>
Sender: linux-bounces@lists.openrisc.net
Errors-To: linux-bounces@lists.openrisc.net
To: Ley Foon Tan <lftan@altera.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lftan.linux@gmail.com, cltang@codesourcery.com, linux@lists.openrisc.net
List-Id: linux-arch.vger.kernel.org

On 05/13/2014 11:05 AM, Ley Foon Tan wrote:
> Override time_t and clock_t in include/uapi/asm-generic.
> 
> diff --git a/arch/openrisc/include/uapi/asm/posix_types.h b/arch/openrisc/include/uapi/asm/posix_types.h
> new file mode 100644
> index 0000000..5ccf37d
> --- /dev/null
> +++ b/arch/openrisc/include/uapi/asm/posix_types.h
> @@ -0,0 +1,17 @@
> +#ifndef __ARCH_OPENRISC_POSIX_TYPES_H
> +#define __ARCH_OPENRISC_POSIX_TYPES_H
> +
> +/*
> + * This file is generally used by user-level software, so you need to
> + * be a little careful about namespace pollution etc. Also, we cannot
> + * assume GCC is being used.
> + */

I don't think the above comment needs to be copied to this file... given
that the file is in the uapi/ directory, we know the file is exported to
userspace, and the GCC comment isn't relevant given the rest of the
files contents.

But that's really just a nit!  Nice work, otherwise.

Acked-by: Jonas Bonn <jonas@southpole.se>

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
