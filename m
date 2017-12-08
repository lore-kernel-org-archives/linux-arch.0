Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:41137 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbdLHF1Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Dec 2017 00:27:24 -0500
MIME-Version: 1.0
In-Reply-To: <20171207164040.GD21978@ZenIV.linux.org.uk>
References: <cover.1511785528.git.green.hu@gmail.com> <ba92adae5d20d99c7c18e75146642a2ccbd5d047.1511785528.git.green.hu@gmail.com>
 <20171207164040.GD21978@ZenIV.linux.org.uk>
From: Greentime Hu <green.hu@gmail.com>
Date: Fri, 8 Dec 2017 13:26:42 +0800
Message-ID: <CAEbi=3fDHzLv4udGJxFXvb4yxNgs8j81Jm9vm_3e9swjq4hM8A@mail.gmail.com>
Subject: Re: [PATCH v2 06/35] nds32: MMU fault handling and page table management
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, netdev <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Vincent Chen <vincentc@andestech.com>
Message-ID: <20171208052642.U1piMzM_LRRUjnZ_2qj0PFhL1_aXxVI2sG9MoZdBo3U@z>

2017-12-08 0:40 GMT+08:00 Al Viro <viro@zeniv.linux.org.uk>:
> On Mon, Nov 27, 2017 at 08:27:53PM +0800, Greentime Hu wrote:
>> +void do_page_fault(unsigned long entry, unsigned long addr,
>> +                unsigned int error_code, struct pt_regs *regs)
> [snip]
>> +     /*
>> +      * If we're in an interrupt or have no user
>> +      * context, we must not take the fault..
>> +      */
>> +     if (unlikely(in_atomic() || !mm))
>
> Broken.  in_atomic() is wrong here - it should be faulthandler_disabled().

Thanks.
I will include <linux/uaccess.h> and replace in_atomic() with
faulthandler_disabled()
I will fix it in the next version patch.
