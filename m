From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 07/36] nds32: Exception handling
Date: Wed, 24 Jan 2018 12:09:02 +0100
Message-ID: <CAK8P3a1mwKLi2Cj43EQvwodPCQVwWfW5gjNtf+DLdyb8T49OWw@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <28c2c9da4da4c8b07473e97cd4a6cb953f4b507c.1515766253.git.green.hu@gmail.com>
 <CAK8P3a1ZZsB7MVZ8sEPzkVcNUJh3-MB_ApmPi+DUF1rc9h8pXg@mail.gmail.com> <CAJsyPhx1B75GJCD2a_=m92ipq3oYsXxMGq9Bg9eCw_ALavWKMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:41068 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933062AbeAXLJE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jan 2018 06:09:04 -0500
In-Reply-To: <CAJsyPhx1B75GJCD2a_=m92ipq3oYsXxMGq9Bg9eCw_ALavWKMg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincent Chen <deanbo422@gmail.com>
Cc: Greentime Hu <green.hu@gmail.com>, Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.com>

On Wed, Jan 24, 2018 at 11:53 AM, Vincent Chen <deanbo422@gmail.com> wrote:
> 2018-01-18 18:14 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>> On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu@gmail.com> wrote=
:
>>> From: Greentime Hu <greentime@andestech.com>
>>>
>>> This patch includes the exception/interrupt entries, pt_reg structure a=
nd
>>> related accessors.
>>>
>>> Signed-off-by: Vincent Chen <vincentc@andestech.com>
>>> Signed-off-by: Greentime Hu <greentime@andestech.com>
>>
>> Here it would be good to have a more detailed explanation about the alig=
nment
>> trap handling. I remember discussing it with you before, but don't remem=
ber
>> the exact outcome. In particular you should explain here why you need to
>> handle alignment traps in the first place, and what the expected default=
s
>> are (e.g. always disabled unless a user requests it, or always enabled) =
and
>> what kind of code runs into the traps (e.g. buggy kernel code, correct
>> kernel code, buggy user space code etc).
>>
>>        Arnd
>
>
> Dear Arnd:
>
> I am plans to add the following description in the git commit's comment
>
> Andes processors cannot load/store information which is not naturally ali=
gned
> on the bus, i.e., loading a 4 byte data whose start address must be divis=
ible
> by 4. If unaligned data accessing is happened, data unaligned exception w=
ill be
> triggered and user will get SIGSEGV or kernel oops according to the unali=
gned
> address. In order to make user able to load/store data from an unaligned
> address, software load /store emulation is implemented in
> arch/nds32/mm/alignment.c to handle data unaligned exception.
>
> Unaligned accessing handling is disable by default because of it is not
> a normal case. User can follow the steps below to enable this feature.
>
> A. Compile time:
>     1. Enable kernel config CONFIG_ALIGNMENT_TRAP
> B. Run time:
>     1. Enter /proc/sys/nds32/unaligned_acess folder
>     2.
>         a. Write =E2=80=981=E2=80=99 to file enable_mode to enable unalig=
ned accessing handling
>             for user space
>         b. Write =E2=80=982=E2=80=99 to file enable_mode to enable unalig=
ned accessing handling
>             for kernel space
>         c. Write =E2=80=983=E2=80=99 to file enable_mode to enable unalig=
ned accessing handling
>             for user and kernel space
>         d. Write '0' to file enable_mode to disable all unaligned
> accessing handling
>     3.
>         a. Write =E2=80=981=E2=80=99 to file debug to show which unaligne=
d address is addressed
>         b. Write =E2=80=980=E2=80=99 to file debug to disable all informa=
tion
>
> However, unaligned accessing handler can=E2=80=99t work on following cond=
itions.
> A. The corresponding mode for unaligned address is not enabled.
> B. This unaligned address is not accessible such as protection violation.
> On these conditions, the default behaviors for data unaligned
> exception still happen.

Ok. I still wonder about the kernel part of this though: is it a good idea
for user space to configure whether the kernel does unaligned
accesses? I would think that the kernel should just be fixed in such
a case.

     Arnd
