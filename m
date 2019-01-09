Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38066 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729281AbfAIKLA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Jan 2019 05:11:00 -0500
MIME-Version: 1.0
References: <1546871413-2433-1-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1546871413-2433-1-git-send-email-firoz.khan@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 9 Jan 2019 11:10:42 +0100
Message-ID: <CAK8P3a2CqpjG4b9WNYwi5-B8=RHN+edji0p5_Y3Ln-oH_B-Auw@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/syscalls: add system call table file for asm-generic
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20190109101042.flYxF7qj1bWDyiF6OeSnZwltL9y0bTk6uV0-vW-ydGM@z>

On Mon, Jan 7, 2019 at 3:31 PM Firoz Khan <firoz.khan@linaro.org> wrote:

> +242    common  accept4                         sys_accept4
> +243    common  recvmmsg                        sys_recvmmsg                    compat_sys_recvmmsg
> +244    archs0  arch_specific_syscall0          sys_arch_specific_syscall0
> +245    archs1  arch_specific_syscall1          sys_arch_specific_syscall1
> +246    archs2  arch_specific_syscall2          sys_arch_specific_syscall2
> +247    archs3  arch_specific_syscall3          sys_arch_specific_syscall3
> +248    archs4  arch_specific_syscall4          sys_arch_specific_syscall4
> +260    common  wait4                           sys_wait4                       compat_sys_wait4

This arch_specific_syscall0 should be fine as well, but there is a small
chance that existing user space code refers to the __NR_arch_specific_syscall
(without trailing 0) macro, so please change 244 back to
'arch_specific_syscall'.

Not sure if we should then count from 0 or 1, i.e. whether 245 should be
arch_specific_syscall1 or arch_specific_syscall2.

      Arnd
