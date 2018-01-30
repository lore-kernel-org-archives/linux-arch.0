From: Vincent Chen <deanbo422@gmail.com>
Subject: Re: [PATCH v6 07/36] nds32: Exception handling
Date: Tue, 30 Jan 2018 18:01:52 +0800
Message-ID: <CAJsyPhx090fPsdhkydoKDHDw+LwByT66JHJNT4Tb5N0s_O7MPw@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <28c2c9da4da4c8b07473e97cd4a6cb953f4b507c.1515766253.git.green.hu@gmail.com>
 <CAK8P3a1ZZsB7MVZ8sEPzkVcNUJh3-MB_ApmPi+DUF1rc9h8pXg@mail.gmail.com>
 <CAJsyPhx1B75GJCD2a_=m92ipq3oYsXxMGq9Bg9eCw_ALavWKMg@mail.gmail.com>
 <CAK8P3a1mwKLi2Cj43EQvwodPCQVwWfW5gjNtf+DLdyb8T49OWw@mail.gmail.com> <CAK8P3a3PxsmNXDqYbivfCTL8NmnR==M91yjv_VV0zXwjzLxHuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a3PxsmNXDqYbivfCTL8NmnR==M91yjv_VV0zXwjzLxHuA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greentime Hu <green.hu@gmail.com>, Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

2018-01-24 19:10 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Wed, Jan 24, 2018 at 12:09 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Wed, Jan 24, 2018 at 11:53 AM, Vincent Chen <deanbo422@gmail.com> wrote:
>>> 2018-01-18 18:14 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>
>> Ok. I still wonder about the kernel part of this though: is it a good idea
>> for user space to configure whether the kernel does unaligned
>> accesses? I would think that the kernel should just be fixed in such
>> a case.
>
> To clarify: I'm asking only about unaligned accesses from kernel code itself,
> which is generally considered a bug when
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is disabled.
>
>       Arnd

Thanks for your comments.

For performance, we decide always disable
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS even if hardware supports
unaligned accessing. Therefore, I will remove kernel unaligned accessing from
nds32/mm/alignment.c. In other words, alignment.c only addresses unaligned
accessing for user space.

Vincent
