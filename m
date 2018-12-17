From: Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [PATCH v5 0/5] powerpc: system call table generation support
Date: Mon, 17 Dec 2018 15:13:30 +0530
Message-ID: <CALxhOni8Gynxp-NgcuZk41Qx1GT_pAEQ0tjX2z2q2pJPd49o6A@mail.gmail.com>
References: <1544691770-8938-1-git-send-email-firoz.khan@linaro.org> <20181217080846.GA28424@sathnaga86.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181217080846.GA28424@sathnaga86.in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Ram Pai <linuxram@us.ibm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Boqun Feng <boqun.feng@gmail.com>, Breno Leitao <leitao@debian.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, Linux-Arch <linux-arch@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Marcin Juszkiewicz <marcin.juszkiewicz@lina>
List-Id: linux-arch.vger.kernel.org

Hi Satheesh,

On Mon, 17 Dec 2018 at 13:39, Satheesh Rajendran
<sathnaga@linux.vnet.ibm.com> wrote:
>
> Hi Firoz,
>
> On Thu, Dec 13, 2018 at 02:32:45PM +0530, Firoz Khan wrote:
> Tried to apply on linus "master" and linuxppc-dev(https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git) "merge" branch,
> both failed to apply series.
>
> # git am mbox
> Applying: powerpc: add __NR_syscalls along with NR_syscalls
> Applying: powerpc: move macro definition from asm/systbl.h
> Applying: powerpc: add system call table generation support
> Applying: powerpc: split compat syscall table out from native table
> Applying: powerpc: generate uapi header and system call table files
> error: patch failed: arch/powerpc/include/uapi/asm/Kbuild:1
> error: arch/powerpc/include/uapi/asm/Kbuild: patch does not apply
> Patch failed at 0005 powerpc: generate uapi header and system call table files
> Use 'git am --show-current-patch' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
>
> Then, tried with linuxppc-dev(https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git) "next" branch,
> patch got applied, compiled with ppc64le_defconfig and booted on IBM Power8 box.
>
> # uname -r
> 4.20.0-rc2-gdd2690d2c
>
> Looks like patch series needs a rebase against the latest kernel versions.

Thanks for the update.
Sure, I'll update the patch series and post asap.

Firoz
