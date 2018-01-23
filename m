From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 22/36] nds32: Debugging support
Date: Tue, 23 Jan 2018 09:21:45 +0100
Message-ID: <CAK8P3a0mm3iEa5T8d0D0BwxxafeYEXAkkCBco5ZrCX8zBmYu5Q@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <65ae3b5b7eabe8680857b1821c72127f611c950b.1515766253.git.green.hu@gmail.com>
 <CAK8P3a2HKWHxmkcx5Lf3VFT6yErppXY+brmGr7k2KBLeXgvuFw@mail.gmail.com> <CAJsyPhwPsgMoReEaijkL6SAM6Q_fTL3BK9opa3yTaLtEE1PNTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJsyPhwPsgMoReEaijkL6SAM6Q_fTL3BK9opa3yTaLtEE1PNTA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent Chen <deanbo422@gmail.com>
Cc: Greentime Hu <green.hu@gmail.com>, Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Jan 23, 2018 at 8:28 AM, Vincent Chen <deanbo422@gmail.com> wrote:
> 2018-01-18 18:37 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>> On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu@gmail.com> wrote:
>>> From: Greentime Hu <greentime@andestech.com>

>>
>> It appears that you are implementing the old-style ptrace handling
>> with architecture specific commands. Please have a look at how
>> this is done in risc-v or arm64. If this takes more too much time
>> to address, I'd suggest using an empty stub function for sys_ptrace
>> and adding it back at a later point, but not send the current version
>> upstream.
>>
>
> After referring to risc-v and arm64, I realize that PTRACE_GETREGSET
> and PTRACE_SETREGSET is used to replace arch specific command.
> The needed port for the two ptrace commands had done in current
> version patch.
>
> Could I keep them and just removing the code for old-style ptrace
> handling in the next version patch?

The important part is to not merge a user space interface into the upstream
kernel that we still want to change. It's clear that it takes some time to
update gdb and other programs using the ptrace interface, so I'd suggest
to simply not have any ptrace interface submitted for inclusion until that
is complete.

In the meantime, you can keep the existing version as an add-on kernel
patch, you probably have other patches that are not ready to get merged
yet, so just keep this one in the same tree as the others.

     Arnd
