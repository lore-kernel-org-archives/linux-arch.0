From: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 06/35] nds32: MMU fault handling and page table management
Date: Wed, 29 Nov 2017 15:24:16 +0800
Message-ID: <CAEbi=3d8roTJHjsea3Up3uB+fu0fOmMcS7Dh=5-bV1GW4Y4e8Q@mail.gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com> <ba92adae5d20d99c7c18e75146642a2ccbd5d047.1511785528.git.green.hu@gmail.com>
 <20171127135136.3gnguzaf6d52tcpd@lakrids.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171127135136.3gnguzaf6d52tcpd-agMKViyK24J5pKCnmE3YQBJ8xKzm50AiAL8bYrjMMd8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Greentime <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, netdev <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, DTML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Chen <vincentc-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

Hi, Mark:

2017-11-27 21:51 GMT+08:00 Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>:
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
>   https://lkml.kernel.org/r/1499782590-31366-1-git-send-email-mark.rutland-5wv7dgnIgG8@public.gmane.org
>
> ... for details and a test case.
>

Thanks for your teatcase and patch. It works.
I will apply it to the next version patch.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
