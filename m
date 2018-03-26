From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 12/19] csky: Debug and Ptrace GDB
Date: Mon, 26 Mar 2018 15:06:21 +0200
Message-ID: <CAK8P3a276dfzFE8kxYFx_RgJWx31px6M24tf+h7eRowma69Fhg@mail.gmail.com>
References: <cover.1521399976.git.ren_guo@c-sky.com> <31d854396de0d279cdd3bc621806362e79cca60e.1521399976.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <31d854396de0d279cdd3bc621806362e79cca60e.1521399976.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
List-Id: linux-arch.vger.kernel.org

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
