Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:35170 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbdK2HY6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Nov 2017 02:24:58 -0500
MIME-Version: 1.0
In-Reply-To: <20171127135136.3gnguzaf6d52tcpd@lakrids.cambridge.arm.com>
References: <cover.1511785528.git.green.hu@gmail.com> <ba92adae5d20d99c7c18e75146642a2ccbd5d047.1511785528.git.green.hu@gmail.com>
 <20171127135136.3gnguzaf6d52tcpd@lakrids.cambridge.arm.com>
From: Greentime Hu <green.hu@gmail.com>
Date: Wed, 29 Nov 2017 15:24:16 +0800
Message-ID: <CAEbi=3d8roTJHjsea3Up3uB+fu0fOmMcS7Dh=5-bV1GW4Y4e8Q@mail.gmail.com>
Subject: Re: [PATCH v2 06/35] nds32: MMU fault handling and page table management
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, netdev <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Vincent Chen <vincentc@andestech.com>
Message-ID: <20171129072416.hyY4uRaFZAMeJVku2slceCcTrL_bq8r_Pb8fT3yvJqA@z>

Hi, Mark:

2017-11-27 21:51 GMT+08:00 Mark Rutland <mark.rutland@arm.com>:
> Hi,
>
> On Mon, Nov 27, 2017 at 08:27:53PM +0800, Greentime Hu wrote:
>> +void do_page_fault(unsigned long entry, unsigned long addr,
>> +                unsigned int error_code, struct pt_regs *regs)
>> +{
>
>> +     /*
>> +      * As per x86, we may deadlock here. However, since the kernel only
>> +      * validly references user space from well defined areas of the code,
>> +      * we can bug out early if this is from code which shouldn't.
>> +      */
>> +     if (unlikely(!down_read_trylock(&mm->mmap_sem))) {
>> +             if (!user_mode(regs) &&
>> +                 !search_exception_tables(instruction_pointer(regs)))
>> +                     goto no_context;
>> +retry:
>> +             down_read(&mm->mmap_sem);
>> +     } else {
>> +             /*
>> +              * The above down_read_trylock() might have succeeded in which
>> +              * case, we'll have missed the might_sleep() from down_read().
>> +              */
>> +             might_sleep();
>> +             if (IS_ENABLED(CONFIG_DEBUG_VM)) {
>> +                     if (!user_mode(regs) &&
>> +                         !search_exception_tables(instruction_pointer(regs)))
>> +                             goto no_context;
>> +             }
>> +     }
>
>> +     fault = handle_mm_fault(vma, addr, flags);
>> +
>> +     /*
>> +      * If we need to retry but a fatal signal is pending, handle the
>> +      * signal first. We do not need to release the mmap_sem because it
>> +      * would already be released in __lock_page_or_retry in mm/filemap.c.
>> +      */
>> +     if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
>> +             return;
>
> I believe you can get stuck in a livelock here (with an unkillable
> task), if a uaccess primitive tries to access a region protected by a
> userfaultfd. Please see:
>
>   https://lkml.kernel.org/r/1499782590-31366-1-git-send-email-mark.rutland@arm.com
>
> ... for details and a test case.
>

Thanks for your teatcase and patch. It works.
I will apply it to the next version patch.
