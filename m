Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:43326 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932953AbeAXKyB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jan 2018 05:54:01 -0500
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1ZZsB7MVZ8sEPzkVcNUJh3-MB_ApmPi+DUF1rc9h8pXg@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <28c2c9da4da4c8b07473e97cd4a6cb953f4b507c.1515766253.git.green.hu@gmail.com>
 <CAK8P3a1ZZsB7MVZ8sEPzkVcNUJh3-MB_ApmPi+DUF1rc9h8pXg@mail.gmail.com>
From: Vincent Chen <deanbo422@gmail.com>
Date: Wed, 24 Jan 2018 18:53:59 +0800
Message-ID: <CAJsyPhx1B75GJCD2a_=m92ipq3oYsXxMGq9Bg9eCw_ALavWKMg@mail.gmail.com>
Subject: Re: [PATCH v6 07/36] nds32: Exception handling
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greentime Hu <green.hu@gmail.com>, Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.com>, Randy Dunlap <rdunlap@infradead.org>, David Miller <davem@davemloft.net>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, Vincent Chen <vincentc@andestech.com>
Message-ID: <20180124105359.h0df3Nrpwah3ZoP1xcrCmDSYtulqWKT7v7g1eEfDCfs@z>

2018-01-18 18:14 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu@gmail.com> wrote:
>> From: Greentime Hu <greentime@andestech.com>
>>
>> This patch includes the exception/interrupt entries, pt_reg structure an=
d
>> related accessors.
>>
>> Signed-off-by: Vincent Chen <vincentc@andestech.com>
>> Signed-off-by: Greentime Hu <greentime@andestech.com>
>
> Here it would be good to have a more detailed explanation about the align=
ment
> trap handling. I remember discussing it with you before, but don't rememb=
er
> the exact outcome. In particular you should explain here why you need to
> handle alignment traps in the first place, and what the expected defaults
> are (e.g. always disabled unless a user requests it, or always enabled) a=
nd
> what kind of code runs into the traps (e.g. buggy kernel code, correct
> kernel code, buggy user space code etc).
>
>        Arnd


Dear Arnd:

I am plans to add the following description in the git commit's comment

Andes processors cannot load/store information which is not naturally align=
ed
on the bus, i.e., loading a 4 byte data whose start address must be divisib=
le
by 4. If unaligned data accessing is happened, data unaligned exception wil=
l be
triggered and user will get SIGSEGV or kernel oops according to the unalign=
ed
address. In order to make user able to load/store data from an unaligned
address, software load /store emulation is implemented in
arch/nds32/mm/alignment.c to handle data unaligned exception.

Unaligned accessing handling is disable by default because of it is not
a normal case. User can follow the steps below to enable this feature.

A. Compile time:
    1. Enable kernel config CONFIG_ALIGNMENT_TRAP
B. Run time:
    1. Enter /proc/sys/nds32/unaligned_acess folder
    2.
        a. Write =E2=80=981=E2=80=99 to file enable_mode to enable unaligne=
d accessing handling
            for user space
        b. Write =E2=80=982=E2=80=99 to file enable_mode to enable unaligne=
d accessing handling
            for kernel space
        c. Write =E2=80=983=E2=80=99 to file enable_mode to enable unaligne=
d accessing handling
            for user and kernel space
        d. Write '0' to file enable_mode to disable all unaligned
accessing handling
    3.
        a. Write =E2=80=981=E2=80=99 to file debug to show which unaligned =
address is addressed
        b. Write =E2=80=980=E2=80=99 to file debug to disable all informati=
on

However, unaligned accessing handler can=E2=80=99t work on following condit=
ions.
A. The corresponding mode for unaligned address is not enabled.
B. This unaligned address is not accessible such as protection violation.
On these conditions, the default behaviors for data unaligned
exception still happen.



Thanks

Vincent
