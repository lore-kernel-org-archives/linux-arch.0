From: Vincent Chen <deanbo422@gmail.com>
Subject: Fwd: FW: [PATCH 04/31] nds32: Exception handling
Date: Mon, 13 Nov 2017 18:54:47 +0800
Message-ID: <CAJsyPhzBtbq9boC1pa7objSSc+vnDGKPzGQFKy67i-AzxRwZ3g@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <9caaf73b79b22357ef957382eb7c0151a2d7d189.1510118606.git.green.hu@gmail.com>
 <CAK8P3a3P1Si7hxXCYAFq-qbW+SbQFC8W3vVbANkz5dp__mJupg@mail.gmail.com> <E26F4CF8B7DDDB4383A6C2D78D5C3CD56B4974CE@ATCPCS16.andestech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:48657 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751521AbdKMKyt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Nov 2017 05:54:49 -0500
In-Reply-To: <E26F4CF8B7DDDB4383A6C2D78D5C3CD56B4974CE@ATCPCS16.andestech.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arndbergmann@gmail.com>
Cc: greentime@andestech.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org

>> From: Greentime Hu <greentime@andestech.com>
>>
>> Signed-off-by: Vincent Chen <vincentc@andestech.com>
>> Signed-off-by: Greentime Hu <greentime@andestech.com>
>>  arch/nds32/mm/alignment.c       |  564 +++++++++++++++++++++++++++++++++++++++
>
>> diff --git a/arch/nds32/mm/alignment.c b/arch/nds32/mm/alignment.c new
>> file mode 100644 index 0000000..05589e7
>> --- /dev/null
>> +++ b/arch/nds32/mm/alignment.c
>
>> +static int mode = 0x3;
>> +module_param(mode, int, S_IWUSR | S_IRUGO);
>
>It's an interesting question how to best handle alignment faults, both in
>kernel and user mode. While it can help for debugging to have the handler,
>I'd argue that you are better off in the long run not fixing up the faults
>automatically but to modify the code that triggers them instead.
>
>How about making the faults disabled by default?

Thanks
OK, I will disable alignment fault handling by default in next version patch

>> +static int _do_unaligned_access(unsigned long entry, unsigned long addr,
>> +                               unsigned long type, struct pt_regs *regs)
>> +{
>> +       unsigned long inst;
>> +       int ret = -EFAULT;
>> +
>> +       if (user_mode(regs)) {
>> +               /* user mode */
>> +               if (!va_present(current->mm, addr))
>> +                       return ret;
>> +       } else {
>> +               /* kernel mode */
>> +               if (!va_kernel_present(addr))
>> +                       return ret;
>> +       }
>
>This looks racy, the address might be present when you get here, but not
>later when you actually access it. I think what you need here is something
>like ARM does with get32_unaligned_check() etc and their fixup tables.

Thanks.
I will follow your suggestion to modify it


>> +       inst = get_inst(regs->ipc);
>> +
>> +       DEBUG(mode & 0x04, 1,
>> +             "Faulting Addr: 0x%08lx, PC: 0x%08lx [ 0x%08lx ]\n", addr,
>> +             regs->ipc, inst);
>> +
>> +       if ((user_mode(regs) && (mode & 0x01))
>> +           || (!user_mode(regs) && (mode & 0x02))) {
>> +
>> +               mm_segment_t seg = get_fs();
>> +
>> +               set_fs(KERNEL_DS);
>> +
>> +               if (inst & 0x80000000)
>> +                       ret = do_16((inst >> 16) & 0xffff, regs);
>> +               else
>> +                       ret = do_32(inst, regs);
>> +
>> +               set_fs(seg);
>> +       }
>> +
>> +       return ret;
>> +}
>
>Doesn't this allow user space to read all of kernel memory simply by
>passing unaligned addresses?

Thanks
I will fix it in next version patch.


>> +static const struct file_operations fops = {
>> +       .open = simple_open,
>> +       .read = proc_alignment_read,
>> +       .write = proc_alignment_write,
>> +};
>
>This should really be a sysctl rather than an open-coded procfs file,
>for consistency with other architectures.
>
>Please have a look at that interface on other architectures and pick
>whatever the majority do.

OK. I will use sysctl instaed of procfs to control this alignment
correction feature.
Thanks

>
>     Arnd

Best regards
Vincent
