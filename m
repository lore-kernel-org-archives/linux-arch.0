From: Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [v6,1/5] powerpc: add __NR_syscalls along with NR_syscalls
Date: Mon, 24 Dec 2018 10:48:50 +0530
Message-ID: <CALxhOnhfPbMBXcTP1eT3OTv7ZTQ4OKHOEJxq9coPX6Si39umqQ@mail.gmail.com>
References: <1545043236-11649-2-git-send-email-firoz.khan@linaro.org> <43N38M4cw7z9sNJ@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <43N38M4cw7z9sNJ@ozlabs.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Ram Pai <linuxram@us.ibm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Boqun Feng <boqun.feng@gmail.com>, Breno Leitao <leitao@debian.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, Linux-Arch <linux-arch@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Marcin Juszkiewicz <marcin.juszk>
List-Id: linux-arch.vger.kernel.org

On Sun, 23 Dec 2018 at 18:58, Michael Ellerman
<patch-notifications@ellerman.id.au> wrote:
>
> On Mon, 2018-12-17 at 10:40:32 UTC, Firoz Khan wrote:
> > NR_syscalls macro holds the number of system call exist
> > in powerpc architecture. We have to change the value of
> > NR_syscalls, if we add or delete a system call.
> >
> > One of the patch in this patch series has a script which
> > will generate a uapi header based on syscall.tbl file.
> > The syscall.tbl file contains the number of system call
> > information. So we have two option to update NR_syscalls
> > value.
> >
> > 1. Update NR_syscalls in asm/unistd.h manually by count-
> >    ing the no.of system calls. No need to update NR_sys-
> >    calls until we either add a new system call or delete
> >    existing system call.
> >
> > 2. We can keep this feature in above mentioned script,
> >    that will count the number of syscalls and keep it in
> >    a generated file. In this case we don't need to expli-
> >    citly update NR_syscalls in asm/unistd.h file.
> >
> > The 2nd option will be the recommended one. For that, I
> > added the __NR_syscalls macro in uapi/asm/unistd.h along
> > with NR_syscalls asm/unistd.h. The macro __NR_syscalls
> > also added for making the name convention same across all
> > architecture. While __NR_syscalls isn't strictly part of
> > the uapi, having it as part of the generated header to
> > simplifies the implementation. We also need to enclose
> > this macro with #ifdef __KERNEL__ to avoid side effects.
> >
> > Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
>
> Series applied to powerpc next, thanks.

Thanks Micheal!

Firoz

>
> https://git.kernel.org/powerpc/c/8a19eeeab66dfdd7c67bc8e3048ac0
>
> cheers
