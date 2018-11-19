From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 2/4] powerpc: move macro definition from asm/systbl.h
Date: Mon, 19 Nov 2018 17:11:58 +0100
Message-ID: <CAK8P3a2AsQKPpFRKpNiEo2TVjfanuTSUjhO1wxgvLYyiqeaMNQ@mail.gmail.com>
References: <1542189798-27713-1-git-send-email-firoz.khan@linaro.org> <1542189798-27713-3-git-send-email-firoz.khan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542189798-27713-3-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxram@us.ibm.com, Geert Uytterhoeven <geert@linux-m68k.org>, leitao@debian.org, Boqun Feng <boqun.feng@gmail.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Thomas Gleixner <tglx@linutronix.de>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Nov 14, 2018 at 11:04 AM Firoz Khan <firoz.khan@linaro.org> wrote:

> diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
> index 01b5171..c4321b9 100644
> --- a/arch/powerpc/include/asm/systbl.h
> +++ b/arch/powerpc/include/asm/systbl.h
> @@ -76,7 +76,6 @@
>  SYSCALL_SPU(ssetmask)
>  SYSCALL_SPU(setreuid)
>  SYSCALL_SPU(setregid)
> -#define compat_sys_sigsuspend sys_sigsuspend
>  SYS32ONLY(sigsuspend)

I think the macro here is just a workaround for the fact that SYS32ONLY()
always prepends the name with 'compat_' for the compat version, and there
is no other macro to do this. After the conversion, this can easily be
done using the regular table, as you need separate names for the
32-bit entries anyway.

>  SYSX(sys_ni_syscall,compat_sys_s
> diff --git a/arch/powerpc/platforms/cell/spu_callbacks.c b/arch/powerpc/platforms/cell/spu_callbacks.c
> index 8ae8620..7517a43 100644
> --- a/arch/powerpc/platforms/cell/spu_callbacks.c
> +++ b/arch/powerpc/platforms/cell/spu_callbacks.c
> @@ -47,6 +47,7 @@
>  #define COMPAT_SPU_NEW(func)   sys_##func,
>  #define SYSX_SPU(f, f3264, f32)        f,
>
> +#define compat_sys_sigsuspend  sys_sigsuspend
>  #include <asm/systbl.h>
>  };

The spu_callbacks.c and systbl_chk.c files don't need this macro,
but that doesn't matter once you drop this patch.

      Arnd
