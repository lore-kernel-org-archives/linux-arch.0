From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 04/31] nds32: Exception handling
Date: Wed, 8 Nov 2017 09:23:15 +0100
Message-ID: <CAK8P3a3P1Si7hxXCYAFq-qbW+SbQFC8W3vVbANkz5dp__mJupg@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <9caaf73b79b22357ef957382eb7c0151a2d7d189.1510118606.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:55546 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbdKHIXQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Nov 2017 03:23:16 -0500
In-Reply-To: <9caaf73b79b22357ef957382eb7c0151a2d7d189.1510118606.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: greentime@andestech.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>

On Wed, Nov 8, 2017 at 6:54 AM, Greentime Hu <green.hu@gmail.com> wrote:
> From: Greentime Hu <greentime@andestech.com>
>
> Signed-off-by: Vincent Chen <vincentc@andestech.com>
> Signed-off-by: Greentime Hu <greentime@andestech.com>
>  arch/nds32/mm/alignment.c       |  564 +++++++++++++++++++++++++++++++++++++++

> diff --git a/arch/nds32/mm/alignment.c b/arch/nds32/mm/alignment.c
> new file mode 100644
> index 0000000..05589e7
> --- /dev/null
> +++ b/arch/nds32/mm/alignment.c

> +static int mode = 0x3;
> +module_param(mode, int, S_IWUSR | S_IRUGO);

It's an interesting question how to best handle alignment faults, both in
kernel and user mode. While it can help for debugging to have the handler,
I'd argue that you are better off in the long run not fixing up the faults
automatically but to modify the code that triggers them instead.

How about making the faults disabled by default?

> +static int _do_unaligned_access(unsigned long entry, unsigned long addr,
> +                               unsigned long type, struct pt_regs *regs)
> +{
> +       unsigned long inst;
> +       int ret = -EFAULT;
> +
> +       if (user_mode(regs)) {
> +               /* user mode */
> +               if (!va_present(current->mm, addr))
> +                       return ret;
> +       } else {
> +               /* kernel mode */
> +               if (!va_kernel_present(addr))
> +                       return ret;
> +       }

This looks racy, the address might be present when you get here, but not
later when you actually access it. I think what you need here is something
like ARM does with get32_unaligned_check() etc and their fixup tables.

> +       inst = get_inst(regs->ipc);
> +
> +       DEBUG(mode & 0x04, 1,
> +             "Faulting Addr: 0x%08lx, PC: 0x%08lx [ 0x%08lx ]\n", addr,
> +             regs->ipc, inst);
> +
> +       if ((user_mode(regs) && (mode & 0x01))
> +           || (!user_mode(regs) && (mode & 0x02))) {
> +
> +               mm_segment_t seg = get_fs();
> +
> +               set_fs(KERNEL_DS);
> +
> +               if (inst & 0x80000000)
> +                       ret = do_16((inst >> 16) & 0xffff, regs);
> +               else
> +                       ret = do_32(inst, regs);
> +
> +               set_fs(seg);
> +       }
> +
> +       return ret;
> +}

Doesn't this allow user space to read all of kernel memory simply by
passing unaligned addresses?

> +static const struct file_operations fops = {
> +       .open = simple_open,
> +       .read = proc_alignment_read,
> +       .write = proc_alignment_write,
> +};

This should really be a sysctl rather than an open-coded procfs file,
for consistency with other architectures.

Please have a look at that interface on other architectures and pick
whatever the majority do.

     Arnd
