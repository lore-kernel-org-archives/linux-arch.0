From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 14/35] nds32: System calls handling
Date: Tue, 28 Nov 2017 10:23:50 +0100
Message-ID: <CAK8P3a2WuJGi8vdMHzGtRS6dny9VeTpWL8ShAFqzuxL4yZ2zhw@mail.gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com> <ee45d9c7b0388c87a93a26484e859001477eb3a2.1511785528.git.green.hu@gmail.com>
 <CAK8P3a3V7=4LjT38xT2VBQW4sTgpKergar2KoO8brbMZjR--1w@mail.gmail.com> <CAJsyPhyep2xp1tANCUO=p9GwsAFZGcV=EdFnjdem8v3-o--O=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:38367 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751322AbdK1JXw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Nov 2017 04:23:52 -0500
In-Reply-To: <CAJsyPhyep2xp1tANCUO=p9GwsAFZGcV=EdFnjdem8v3-o--O=Q@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincent Chen <deanbo422@gmail.com>
Cc: Greentime Hu <green.hu@gmail.com>, Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Vincent Chen <vincentc@andestech.com>

On Tue, Nov 28, 2017 at 3:18 AM, Vincent Chen <deanbo422@gmail.com> wrote:
> 2017-11-27 22:46 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>> On Mon, Nov 27, 2017 at 1:28 PM, Greentime Hu <green.hu@gmail.com> wrote:

>>> diff --git a/arch/nds32/include/uapi/asm/unistd.h b/arch/nds32/include/uapi/asm/unistd.h
>>> new file mode 100644
>>> index 0000000..2bad1e7
>>> --- /dev/null
>>> +++ b/arch/nds32/include/uapi/asm/unistd.h
>>
>>> +
>>> +#define __ARCH_WANT_RENAMEAT
>>> +#define __ARCH_WANT_SYSCALL_OFF_T
>>
>> These two should not be here.
>>
>
> Thanks.
> But, I don't know I should move these two macro to which file.
> In asm-generic/unistd.h, these two are used to decide whether relative
> syscall number is defined or not.
> Therefore,  I put these two macros here in order that these two
> definitions are available in user space.

What I meant is that they should not be available to user space.

The C libraries implement the user space interfaces based
on the replacement system calls, e.g. an application calling
the glibc stat() function will end up in the sys_stat64() system
call entry point, not the older sys_newstat().

      Arnd
