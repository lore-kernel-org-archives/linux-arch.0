From: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v3 4/6] parisc: uapi header and system call table file
 generation
Date: Mon, 8 Oct 2018 21:43:15 +0200
Message-ID: <b1883a34-f256-0940-4e92-574ba48b5ca8@gmx.de>
References: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
 <1538975801-13735-5-git-send-email-firoz.khan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538975801-13735-5-git-send-email-firoz.khan@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>, linux-parisc@vger.kernel.org, "James E . J . Bottomley" <jejb@parisc-linux.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org
List-Id: linux-arch.vger.kernel.org

On 08.10.2018 07:16, Firoz Khan wrote:
> System call table generation script must be run to generate
> unistd_32/64.h and syscall_table_32/64/c32.h files. This patch
> will have changes which will invokes the script.
> 
> This patch will generate unistd_32/64.h and syscall_table_
> 32/64/c32.h files by the syscall table generation script
> invoked by arch/parisc/Makefile and the generated files against
> the removed files will be identical.
> 
> The generated uapi header file will be included in uapi/asm/
> unistd_32/64.h and generated system call table support file will
> be included by arch/sparc/kernel/syscall_table_32/64.S file.
> 
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
...
> diff --git a/arch/parisc/include/uapi/asm/unistd.h b/arch/parisc/include/uapi/asm/unistd.h
> index f10d065..76e3a3b 100644
> --- a/arch/parisc/include/uapi/asm/unistd.h
> +++ b/arch/parisc/include/uapi/asm/unistd.h
> @@ -2,374 +2,13 @@
>  #ifndef _UAPI_ASM_PARISC_UNISTD_H_
>  #define _UAPI_ASM_PARISC_UNISTD_H_
>  
...
> -
> -#ifdef __KERNEL__
> -#define __NR_syscalls           351
> +#define __NR_Linux           0
> +#ifdef CONFIG_64BIT

You can't use CONFIG_64BIT in an uapi header file.
It's only defined inside the kernel when building the kernel.
Please use
	#ifdef __LP64__
instead here.

> +#include <asm/unistd_64.h>
> +#else
> +#include <asm/unistd_32.h>
>  #endif
