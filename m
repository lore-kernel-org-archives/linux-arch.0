From: Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 07/36] nds32: Exception handling
Date: Wed, 24 Jan 2018 18:53:59 +0800
Message-ID: <CAJsyPhx1B75GJCD2a_=m92ipq3oYsXxMGq9Bg9eCw_ALavWKMg@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <28c2c9da4da4c8b07473e97cd4a6cb953f4b507c.1515766253.git.green.hu@gmail.com>
 <CAK8P3a1ZZsB7MVZ8sEPzkVcNUJh3-MB_ApmPi+DUF1rc9h8pXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAK8P3a1ZZsB7MVZ8sEPzkVcNUJh3-MB_ApmPi+DUF1rc9h8pXg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greentime <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Networking <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, DTML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert.uytterhoeven-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Guo Ren <ren_guo-Y+KPrCd2zL4AvxtiuMwx3w@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

2018-01-18 18:14 GMT+08:00 Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>:
> On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> From: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
>>
>> This patch includes the exception/interrupt entries, pt_reg structure an=
d
>> related accessors.
>>
>> Signed-off-by: Vincent Chen <vincentc-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
>> Signed-off-by: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
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
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
