From: Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 22/36] nds32: Debugging support
Date: Tue, 23 Jan 2018 15:28:07 +0800
Message-ID: <CAJsyPhwPsgMoReEaijkL6SAM6Q_fTL3BK9opa3yTaLtEE1PNTA@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <65ae3b5b7eabe8680857b1821c72127f611c950b.1515766253.git.green.hu@gmail.com>
 <CAK8P3a2HKWHxmkcx5Lf3VFT6yErppXY+brmGr7k2KBLeXgvuFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAK8P3a2HKWHxmkcx5Lf3VFT6yErppXY+brmGr7k2KBLeXgvuFw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greentime <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Networking <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, DTML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert.uytterhoeven-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Guo Ren <ren_guo-Y+KPrCd2zL4AvxtiuMwx3w@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

2018-01-18 18:37 GMT+08:00 Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>:
> On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> From: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
>>
>> This patch adds ptrace support.
>>
>> Signed-off-by: Vincent Chen <vincentc-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
>> Signed-off-by: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
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
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
