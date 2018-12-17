Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io1-f67.google.com ([209.85.166.67]:33640 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeLQJnm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Dec 2018 04:43:42 -0500
Received: by mail-io1-f67.google.com with SMTP id t24so9508130ioi.0
        for <linux-arch@vger.kernel.org>; Mon, 17 Dec 2018 01:43:41 -0800 (PST)
MIME-Version: 1.0
References: <1544691770-8938-1-git-send-email-firoz.khan@linaro.org> <20181217080846.GA28424@sathnaga86.in.ibm.com>
In-Reply-To: <20181217080846.GA28424@sathnaga86.in.ibm.com>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Mon, 17 Dec 2018 15:13:30 +0530
Message-ID: <CALxhOni8Gynxp-NgcuZk41Qx1GT_pAEQ0tjX2z2q2pJPd49o6A@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] powerpc: system call table generation support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Ram Pai <linuxram@us.ibm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Boqun Feng <boqun.feng@gmail.com>, Breno Leitao <leitao@debian.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, Linux-Arch <linux-arch@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, Deepa Dinamani <deepa.kernel@gmail.com>
Message-ID: <20181217094330.MZd7aWezMDA4exTPuYobMY0L9sBh4fzYOR3sA_xgBG0@z>

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
