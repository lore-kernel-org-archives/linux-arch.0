Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45963 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754759AbeARKhD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Jan 2018 05:37:03 -0500
MIME-Version: 1.0
In-Reply-To: <65ae3b5b7eabe8680857b1821c72127f611c950b.1515766253.git.green.hu@gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <65ae3b5b7eabe8680857b1821c72127f611c950b.1515766253.git.green.hu@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 18 Jan 2018 11:37:02 +0100
Message-ID: <CAK8P3a2HKWHxmkcx5Lf3VFT6yErppXY+brmGr7k2KBLeXgvuFw@mail.gmail.com>
Subject: Re: [PATCH v6 22/36] nds32: Debugging support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.com>, Randy Dunlap <rdunlap@infradead.org>, David Miller <davem@davemloft.net>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, Vincent Chen <vincentc@andestech.com>
Message-ID: <20180118103702.2Fl-b-p4nEMFEkVgk2u2x-xVqPhM0fcJtcghU39siWg@z>

On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu@gmail.com> wrote:
> From: Greentime Hu <greentime@andestech.com>
>
> This patch adds ptrace support.
>
> Signed-off-by: Vincent Chen <vincentc@andestech.com>
> Signed-off-by: Greentime Hu <greentime@andestech.com>

I must have missed this patch earlier, unfortunately I don't think
this is ready:

> +long arch_ptrace(struct task_struct *child, long request, unsigned long addr,
> +                unsigned long data)
> +{
> +       int ret;
> +
> +       switch (request) {
> +       case PTRACE_PEEKUSR:
> +               ret =
> +                   ptrace_read_user(child, addr, (unsigned long __user *)data);
> +               break;
> +
> +       case PTRACE_POKEUSR:
> +               ret = ptrace_write_user(child, addr, data);
> +               break;
> +
> +       case PTRACE_GETREGS:
> +               ret = ptrace_getregs(child, (void __user *)data);
> +               break;
> +
> +       case PTRACE_SETREGS:
> +               ret = ptrace_setregs(child, (void __user *)data);
> +               break;
> +
> +       case PTRACE_GETFPREGS:
> +               ret = ptrace_getfpregs(child, (void __user *)data);
> +               break;
> +
> +       case PTRACE_SETFPREGS:
> +               ret = ptrace_setfpregs(child, (void __user *)data);
> +               break;
> +
> +       default:
> +               ret = ptrace_request(child, request, addr, data);
> +               break;
> +       }
> +
> +       return ret;
> +}

It appears that you are implementing the old-style ptrace handling
with architecture specific commands. Please have a look at how
this is done in risc-v or arm64. If this takes more too much time
to address, I'd suggest using an empty stub function for sys_ptrace
and adding it back at a later point, but not send the current version
upstream.

     Arnd
