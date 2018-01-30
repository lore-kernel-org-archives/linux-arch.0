From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH v6 07/36] nds32: Exception handling
Date: Tue, 30 Jan 2018 22:49:32 +0800
Message-ID: <CAEbi=3ekWX9aA5CXf1r4WsqfwvjxED-1XXTb2w0ydWmnA6jfSA@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <28c2c9da4da4c8b07473e97cd4a6cb953f4b507c.1515766253.git.green.hu@gmail.com>
 <CAK8P3a1ZZsB7MVZ8sEPzkVcNUJh3-MB_ApmPi+DUF1rc9h8pXg@mail.gmail.com>
 <CAJsyPhx1B75GJCD2a_=m92ipq3oYsXxMGq9Bg9eCw_ALavWKMg@mail.gmail.com>
 <CAK8P3a1mwKLi2Cj43EQvwodPCQVwWfW5gjNtf+DLdyb8T49OWw@mail.gmail.com>
 <CAK8P3a3PxsmNXDqYbivfCTL8NmnR==M91yjv_VV0zXwjzLxHuA@mail.gmail.com>
 <CAJsyPhx090fPsdhkydoKDHDw+LwByT66JHJNT4Tb5N0s_O7MPw@mail.gmail.com> <CAK8P3a1iv=10_pfvtfvDwD9YH1HRAXwDy_m8SC=tV59HEDuSsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a1iv=10_pfvtfvDwD9YH1HRAXwDy_m8SC=tV59HEDuSsg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Vincent Chen <deanbo422@gmail.com>, Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.co>
List-Id: linux-arch.vger.kernel.org

Hi, Arnd:

2018-01-30 21:33 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Tue, Jan 30, 2018 at 11:01 AM, Vincent Chen <deanbo422@gmail.com> wrote:
>> 2018-01-24 19:10 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>>> On Wed, Jan 24, 2018 at 12:09 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>>> On Wed, Jan 24, 2018 at 11:53 AM, Vincent Chen <deanbo422@gmail.com> wrote:
>>>>> 2018-01-18 18:14 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>>>
>>>> Ok. I still wonder about the kernel part of this though: is it a good idea
>>>> for user space to configure whether the kernel does unaligned
>>>> accesses? I would think that the kernel should just be fixed in such
>>>> a case.
>>>
>>> To clarify: I'm asking only about unaligned accesses from kernel code itself,
>>> which is generally considered a bug when
>>> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is disabled.
>>>
>>>       Arnd
>>
>> Thanks for your comments.
>>
>> For performance, we decide always disable
>> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS even if hardware supports
>> unaligned accessing. Therefore, I will remove kernel unaligned accessing from
>> nds32/mm/alignment.c. In other words, alignment.c only addresses unaligned
>> accessing for user space.
>
> I'm not really following that logic, let's go through that again so I understand
> the situation better.
>
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS should be set if and
> only if you have a CPU that does not need to trap on unaligned accesses.
>
> What are the hardware capabilities on nds32? Do you have all three
> categories:
>
> a) some CPUs that always trap on unaligned access
> b) some CPUs that never trap on unaligned access
> c) some CPUs that can be configured to either trap or not trap by
>     the kernel?
>
We have type a and c.
We use CONFIG_ALIGNMENT_TRAP for a and
CONFIG_HW_SUPPORT_UNALIGNMENT_ACCESS for c.

Since unaligned access in kernel code itself should be considered as a
bug, we will remove the emulation code to handle the kernel code
unaligned accessed case.
We think CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS and
CONFIG_HW_SUPPORT_UNALIGNMENT_ACCESS have different purposes because
it will still be more efficient to access by byte even if hardware
support unaligned access.
CONFIG_HW_SUPPORT_UNALIGNMENT_ACCESS is used to prevent generating
unaligned access exception.

Thus, we will
1. treat unaligned access in kernel code itself as a bug
2. don't select CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
3. disable CONFIG_HW_SUPPORT_UNALIGNMENT_ACCESS as default
