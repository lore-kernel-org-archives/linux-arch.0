Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:34633 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751111AbeAWH2I (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Jan 2018 02:28:08 -0500
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2HKWHxmkcx5Lf3VFT6yErppXY+brmGr7k2KBLeXgvuFw@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <65ae3b5b7eabe8680857b1821c72127f611c950b.1515766253.git.green.hu@gmail.com>
 <CAK8P3a2HKWHxmkcx5Lf3VFT6yErppXY+brmGr7k2KBLeXgvuFw@mail.gmail.com>
From: Vincent Chen <deanbo422@gmail.com>
Date: Tue, 23 Jan 2018 15:28:07 +0800
Message-ID: <CAJsyPhwPsgMoReEaijkL6SAM6Q_fTL3BK9opa3yTaLtEE1PNTA@mail.gmail.com>
Subject: Re: [PATCH v6 22/36] nds32: Debugging support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greentime Hu <green.hu@gmail.com>, Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.com>, Randy Dunlap <rdunlap@infradead.org>, David Miller <davem@davemloft.net>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, Vincent Chen <vincentc@andestech.com>
Message-ID: <20180123072807.Qu65qMoh8oE66bj6_aOxlD3nVTg2v6vMBEYXtmPDA98@z>

2018-01-18 18:37 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu@gmail.com> wrote:
>> From: Greentime Hu <greentime@andestech.com>
>>
>> This patch adds ptrace support.
>>
>> Signed-off-by: Vincent Chen <vincentc@andestech.com>
>> Signed-off-by: Greentime Hu <greentime@andestech.com>
>
> I must have missed this patch earlier, unfortunately I don't think
> this is ready:
>
>> +long arch_ptrace(struct task_struct *child, long request, unsigned long addr,
>> +                unsigned long data)
>> +{
>> +       int ret;
>> +
>> +       switch (request) {
>> +       case PTRACE_PEEKUSR:
>> +               ret =
>> +                   ptrace_read_user(child, addr, (unsigned long __user *)data);
>> +               break;
>> +
>> +       case PTRACE_POKEUSR:
>> +               ret = ptrace_write_user(child, addr, data);
>> +               break;
>> +
>> +       case PTRACE_GETREGS:
>> +               ret = ptrace_getregs(child, (void __user *)data);
>> +               break;
>> +
>> +       case PTRACE_SETREGS:
>> +               ret = ptrace_setregs(child, (void __user *)data);
>> +               break;
>> +
>> +       case PTRACE_GETFPREGS:
>> +               ret = ptrace_getfpregs(child, (void __user *)data);
>> +               break;
>> +
>> +       case PTRACE_SETFPREGS:
>> +               ret = ptrace_setfpregs(child, (void __user *)data);
>> +               break;
>> +
>> +       default:
>> +               ret = ptrace_request(child, request, addr, data);
>> +               break;
>> +       }
>> +
>> +       return ret;
>> +}
>
> It appears that you are implementing the old-style ptrace handling
> with architecture specific commands. Please have a look at how
> this is done in risc-v or arm64. If this takes more too much time
> to address, I'd suggest using an empty stub function for sys_ptrace
> and adding it back at a later point, but not send the current version
> upstream.
>
>      Arnd

Dear Arnd:

Thanks for your comments.

After referring to risc-v and arm64, I realize that PTRACE_GETREGSET
and PTRACE_SETREGSET is used to replace arch specific command.
The needed port for the two ptrace commands had done in current
version patch.

Could I keep them and just removing the code for old-style ptrace
handling in the next version patch?

Thanks

Vincent
