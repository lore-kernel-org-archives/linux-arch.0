Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44872 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbeINPPx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Sep 2018 11:15:53 -0400
MIME-Version: 1.0
References: <1536913980-4811-1-git-send-email-firoz.khan@linaro.org> <1536913980-4811-3-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1536913980-4811-3-git-send-email-firoz.khan@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 14 Sep 2018 12:01:51 +0200
Message-ID: <CAK8P3a1PCnHy1JX4T21LjOr3ZGAVLdqxQaPYfLHAgM-9Y5yxVg@mail.gmail.com>
Subject: Re: [PATCH 2/3] powerpc: Add system call table generation support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Firoz Khan <firoz.khan@linaro.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxram@us.ibm.com, leitao@debian.org, Boqun Feng <boqun.feng@gmail.com>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20180914100151.RjslpIFS6vVVIcJacST7h7d6Q9lU0nZOK5c0htqdIUs@z>

On Fri, Sep 14, 2018 at 10:33 AM Firoz Khan <firoz.khan@linaro.org> wrote:

> ---
>  arch/powerpc/kernel/syscalls/Makefile       |  51 ++++
>  arch/powerpc/kernel/syscalls/syscall_32.tbl | 378 ++++++++++++++++++++++++++++
>  arch/powerpc/kernel/syscalls/syscall_64.tbl | 372 +++++++++++++++++++++++++++
>  arch/powerpc/kernel/syscalls/syscallhdr.sh  |  37 +++
>  arch/powerpc/kernel/syscalls/syscalltbl.sh  |  38 +++

I think you should only need a single .tbl  input file here.


> +
> +systbl_abi_syscall_table_32 := 32
> +$(out)/syscall_table_32.h: $(syscall32) $(systbl)
> +       $(call if_changed,systbl)
> +
> +systbl_abi_syscall_table_64 := 64
> +$(out)/syscall_table_64.h: $(syscall64) $(systbl)
> +       $(call if_changed,systbl)
> +
> +systbl_abi_syscall_table_c32 := c32
> +$(out)/syscall_table_c32.h: $(syscall32) $(systbl)
> +       $(call if_changed,systbl)

And here you need a fourth output file for the SPU table on ppc64.

> +383     common  statx                           sys_statx
> +384     common  pkey_alloc                      sys_pkey_alloc
> +385     common  pkey_free                       sys_pkey_free
> +386     common  pkey_mprotect                   sys_pkey_mprotect

This also misses rseq and io_pgetevents.

       Arnd
