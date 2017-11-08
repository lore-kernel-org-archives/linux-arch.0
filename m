From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 16/31] nds32: VDSO support
Date: Wed, 8 Nov 2017 21:06:58 +0100
Message-ID: <CAK8P3a0HkSx6QsLuKk_7Ht+zDbt4bHv0Wk2SwN+eAo2O+_i+FQ@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <0911917e908c7648d25b33663afc88f5aca6bb4d.1510118606.git.green.hu@gmail.com>
 <CAK8P3a2BDfCLg6J5qmAFD86ZoxzXLNrXO8UTfkvScws=R-T5jw@mail.gmail.com> <CABeXuvoJyQxXaCGyu-9fw-E32hHMgpZ0x1njbM1O5znCr1audA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABeXuvoJyQxXaCGyu-9fw-E32hHMgpZ0x1njbM1O5znCr1audA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Greentime Hu <green.hu@gmail.com>, Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>, Palmer Dabbelt <palmer@dabbelt.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Nov 8, 2017 at 9:00 PM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> On Wed, Nov 8, 2017 at 1:37 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Wed, Nov 8, 2017 at 6:55 AM, Greentime Hu <green.hu@gmail.com> wrote:
>>

>>
>> I need some insight from Deepa and Palmer here: to prepare for 64-bit
>> time_t in the
>> future, would it make sense to define the vdso to use 64-bit seconds numbers
>> consistently, and provide vdso symbols that return 64-bit times, having the
>> glibc convert that to normal timespec values, or should we leave it for now?
>
> Other architectures also have a similar way of defining these as u32
> (eg: x86) I think for performance reasons on 32 bit systems.
> u32 still works until 2106 as the timekeeping structures are s64. I
> was planning to leave it that way for x86.

Right, good point.

> If this architecture can live with u64, then it will be better to use it here.

As long as we don't need a division, using u64 is probably cheap enough,
we already need the retry loop.

>> For the normal syscalls I think we are better off keeping things consistent
>> between architectures, but the vdso is architecture specific by definition, so
>> we may as well use 64-bit times there now (same for risc-v, which still
>> has time to modify this before the 4.15 release and glibc merge).
>
> But, I don't think this vdso can return 64 bit times without syscalls
> for the architecture also supporting that. The problem is that all
> fallback paths depend on syscalls directly.
> Also I couldn't find any arch specific handling of vdso interfaces in
> glibc. I think they expect the vdso wrappers in the kernel to handle
> this part.

Do applications call into the vdso directly and expect to get a timespec
out? If they always go through the C library as an intermediate, then
the glibc clock_gettime() could do the conversion.

       Arnd
