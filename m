From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 4/4] powerpc: generate uapi header and system call
 table files
Date: Tue, 4 Dec 2018 22:33:13 +0100
Message-ID: <CAK8P3a0DX6Eh0OwUh975RL2Pq_ux_AQeBPSakPFxZf+t62EJ=w@mail.gmail.com>
References: <1543465611-17122-1-git-send-email-firoz.khan@linaro.org>
 <1543465611-17122-5-git-send-email-firoz.khan@linaro.org> <CAK8P3a2SP0eX50NoFKaM2N85mgSejToQkD9ZOE_7V_RT__BCvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a2SP0eX50NoFKaM2N85mgSejToQkD9ZOE_7V_RT__BCvg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Geert Uytterhoeven <geert@linux-m68k.org>, linuxram@us.ibm.com, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, leitao@debian.org, Boqun Feng <boqun.feng@gmail.com>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Dec 4, 2018 at 10:17 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> > diff --git a/arch/powerpc/kernel/systbl.S b/arch/powerpc/kernel/systbl.S
> > index 9ff1913..d756348 100644
> > --- a/arch/powerpc/kernel/systbl.S
> > +++ b/arch/powerpc/kernel/systbl.S
>
> >  #ifdef CONFIG_PPC64
> > @@ -47,5 +25,17 @@
> >  .globl sys_call_table
> >  sys_call_table:
> >
> > +#if defined CONFIG_PPC64 && defined(CONFIG_COMPAT)
> > +#define __SYSCALL(nr, entry, nargs) .8byte entry
> >  #define compat_sys_sigsuspend  sys_sigsuspend
> > -#include <asm/systbl.h>
> > +#include <asm/syscall_table_c32.h>
> > +#undef __SYSCALL
> > +#elif defined CONFIG_PPC64 && !defined(CONFIG_COMPAT)
> > +#define __SYSCALL(nr, entry, nargs) .8byte entry
> > +#include <asm/syscall_table_64.h>
> > +#undef __SYSCALL
>
> This part looks wrong: where the old sys_call_table contained
> both the native and compat calls side by side, the new table
> contains only the compat versions (note that CONFIG_COMPAT is
> always set on PPC64). I think you copy-pasted this incorrectly from
> one of the other architectures that uses a different layout for the
> compat calls.
>
> The way I think this could work best is if you add a preparation
> patch that splits out the 64-bit table into two separate ones
> (and make sure that works). After that, you can add your
> existing patch, rebased to use the two generated tables
> instead of the old-style tables. I'll follow up with an untested
> patch for illustration.

One more thing I noticed while writing up that patch: you also need
to use the DOTSYM() macro in __SYSCALL() to generate the correct
symbol name for the old ELF ABI (when PPC64_ELF_ABI_v2 is
not set).

       Arnd
