Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33923 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751132AbeCZNGW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Mar 2018 09:06:22 -0400
MIME-Version: 1.0
In-Reply-To: <31d854396de0d279cdd3bc621806362e79cca60e.1521399976.git.ren_guo@c-sky.com>
References: <cover.1521399976.git.ren_guo@c-sky.com> <31d854396de0d279cdd3bc621806362e79cca60e.1521399976.git.ren_guo@c-sky.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 26 Mar 2018 15:06:21 +0200
Message-ID: <CAK8P3a276dfzFE8kxYFx_RgJWx31px6M24tf+h7eRowma69Fhg@mail.gmail.com>
Subject: Re: [PATCH 12/19] csky: Debug and Ptrace GDB
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
Message-ID: <20180326130621.4BifPPIO96nE0aXP8xf4ibJeUoBv7IXLud1E0t1sJVc@z>

On Sun, Mar 18, 2018 at 8:51 PM, Guo Ren <ren_guo@c-sky.com> wrote:
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>

> + */
> +long arch_ptrace(struct task_struct *child, long request, unsigned long addr,
> +               unsigned long data)
> +{
> +       unsigned long tmp = 0, ret = 0;
> +       int i;
> +
> +       switch (request) {
> +               /* read the word at location addr in the USER area. */
> +       case PTRACE_PEEKUSR:

> +
> +       case PTRACE_POKEUSR:  /* write the word at location addr in the USER area */

> +       case PTRACE_GETREGS:    /* Get all gp regs from the child. */

> +       case PTRACE_SETREGS:    /* Set all gp regs in the child. */
> +               for (i = 0; i <= CSKY_GREG_NUM; i++) {
> +                       ret = get_user(tmp, (unsigned long *)data);


I think all of these should use the regset code like arch/riscv/kernel/ptrace.c
does.

       Arnd
