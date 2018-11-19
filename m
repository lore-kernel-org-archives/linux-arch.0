From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 2/5] mips: add +1 to __NR_syscalls in uapi header
Date: Mon, 19 Nov 2018 16:57:32 +0100
Message-ID: <CAK8P3a2+W64=-pFaGyN27fdYOSpOrS7oRAzvZqaJUakB0aXtCg@mail.gmail.com>
References: <1542262461-29024-1-git-send-email-firoz.khan@linaro.org> <1542262461-29024-3-git-send-email-firoz.khan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542262461-29024-3-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Thomas Gleixner <tglx@linutronix.de>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Nov 15, 2018 at 7:15 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> All other architectures are hold a value for __NR_syscalls will
> be equal to the last system call number +1.
>
> But in mips architecture, __NR_syscalls hold the value equal to
> total number of system exits in the architecture. One of the
> patch in this patch series will genarate uapi header files.
>
> In order to make the implementation common across all architect-
> ures, add +1 to __NR_syscalls, which will be equal to the last
> system call number +1.
>
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>

The patch looks correct to me, and is a nice cleanup, but I found a
couple of things remaining that could be done slightly better.

> diff --git a/arch/mips/include/asm/unistd.h b/arch/mips/include/asm/unistd.h
> index c68b8ae..16f21c3 100644
> --- a/arch/mips/include/asm/unistd.h
> +++ b/arch/mips/include/asm/unistd.h
> @@ -15,11 +15,11 @@
>  #include <uapi/asm/unistd.h>
>
>  #ifdef CONFIG_MIPS32_N32
> -#define NR_syscalls  (__NR_N32_Linux + __NR_N32_Linux_syscalls)
> +#define NR_syscalls  (__NR_N32_Linux + __NR_N32_Linux_syscalls - 1)
>  #elif defined(CONFIG_64BIT)
> -#define NR_syscalls  (__NR_64_Linux + __NR_64_Linux_syscalls)
> +#define NR_syscalls  (__NR_64_Linux + __NR_64_Linux_syscalls - 1)
>  #else
> -#define NR_syscalls  (__NR_O32_Linux + __NR_O32_Linux_syscalls)
> +#define NR_syscalls  (__NR_O32_Linux + __NR_O32_Linux_syscalls - 1)
>  #endif

I suppose these can simply get removed, there are no users of NR_syscalls
in MIPS kernels.

> diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
> index 7f3dfdb..add4301 100644
> --- a/arch/mips/kernel/ftrace.c
> +++ b/arch/mips/kernel/ftrace.c
> @@ -410,13 +410,13 @@ unsigned long __init arch_syscall_addr(int nr)
>  unsigned long __init arch_syscall_addr(int nr)
>  {
>  #ifdef CONFIG_MIPS32_N32
> -       if (nr >= __NR_N32_Linux && nr <= __NR_N32_Linux + __NR_N32_Linux_syscalls)
> +       if (nr >= __NR_N32_Linux && nr <= __NR_N32_Linux + __NR_N32_Linux_syscalls - 1)
>                 return (unsigned long)sysn32_call_table[nr - __NR_N32_Linux];
>  #endif
> -       if (nr >= __NR_64_Linux  && nr <= __NR_64_Linux + __NR_64_Linux_syscalls)
> +       if (nr >= __NR_64_Linux  && nr <= __NR_64_Linux + __NR_64_Linux_syscalls - 1)
>                 return (unsigned long)sys_call_table[nr - __NR_64_Linux];
>  #ifdef CONFIG_MIPS32_O32
> -       if (nr >= __NR_O32_Linux && nr <= __NR_O32_Linux + __NR_O32_Linux_syscalls)
> +       if (nr >= __NR_O32_Linux && nr <= __NR_O32_Linux + __NR_O32_Linux_syscalls - 1)
>                 return (unsigned long)sys32_call_table[nr - __NR_O32_Linux];
>  #endif

Here I would drop the '-1' and instead replace the '<=' with '<' for
better readability

> diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
> index 91d3c8c..a9b895f 100644
> --- a/arch/mips/kernel/scall32-o32.S
> +++ b/arch/mips/kernel/scall32-o32.S
> @@ -23,7 +23,7 @@
>  #include <asm/asm-offsets.h>
>
>  /* Highest syscall used of any syscall flavour */
> -#define MAX_SYSCALL_NO __NR_O32_Linux + __NR_O32_Linux_syscalls
> +#define MAX_SYSCALL_NO __NR_O32_Linux + __NR_O32_Linux_syscalls - 1

This is also unused as of commit 2957c9e61ee9 ("[MIPS] IRIX: Goodbye and
thanks for all the fish"), eight years ago, so I'd remove this as well.

I'd suggest doing one patch for the removal of the unused macros, and another
patch for the other changes.

       Arnd
