Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:45203 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751200AbeASMvc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Jan 2018 07:51:32 -0500
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2qx5pZmE-=QM5Bwrsib4XcfVac7RQr-QMzEseQ_oBPEA@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <790e05e9b9675b3f6ef41693a794d1f09795c151.1515766253.git.green.hu@gmail.com>
 <CAK8P3a2qx5pZmE-=QM5Bwrsib4XcfVac7RQr-QMzEseQ_oBPEA@mail.gmail.com>
From: Greentime Hu <green.hu@gmail.com>
Date: Fri, 19 Jan 2018 20:50:50 +0800
Message-ID: <CAEbi=3dR1wc3NY6aaUw+gzMUp_Z7Fk2E_eEfJq6J22DPaaMjkQ@mail.gmail.com>
Subject: Re: [PATCH v6 03/36] sparc: io: To use the define of
 ioremap_[nocache|wc|wb] in asm-generic/io.h
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.com>, Randy Dunlap <rdunlap@infradead.org>, David Miller <davem@davemloft.net>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>
Message-ID: <20180119125050.LvGAio87wv1ALN58hLpJEiuGfn63WgRD78DbdkVy-NA@z>

2018-01-18 17:56 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu@gmail.com> wrote:
>> From: Greentime Hu <greentime@andestech.com>
>>
>> It will be built failed if commit id: d25ea659 is selected. This patch
>> can fix this build error.
>>
>> Signed-off-by: Greentime Hu <greentime@andestech.com>
>
> The change is fine, but the reference to commit 'd25ea659' is not for
> two reasons:
>
> - when you rebase the tree, you will get a different ID
> - the recommended format for referring to another commit is to list it wi=
th
>   12 digits and the one-line summary like this:
>
>    commit d25ea659bc37 ("asm-generic/io.h: move
>   ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_=E2=80=A6")
>
> - Ideally you use a 'Fixes:' tag in the patch description.
>
> You can add these lines in your .gitconfig to help you here
>
> [alias]
>         fixes =3D show --format=3D'Fixes: %h (\"%s\")' -s
> [core]
>         abbrev =3D 12
>
> That will give you a 'git fixes' command to output the Fixes: line
> in the correct format for future bug fixes. For this particular change,
> I would actually just merge the two patches into one patch that
> then doesn't break anything in the first place.
>

Hi, Arnd:

Thank you for your comments and teaching me how to add these messages.
I will update the commit messages and my .gitconfig.

Since the commit id will be changed after rebasing, I will update the
messages like this.

sparc: io: To use the define of ioremap_[nocache|wc|wb] in asm-generic/io.h

A commit for the nds32 architecture bootstrap("asm-generic/io.h: move
ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt out of ifndef CONFIG_MMU")
will move the ioremap_nocache out of the CONFIG_MMU ifdef. This means that
in order to suppress re-definition errors we need to remove the #define
in io_32.h.

Also, the change adds a prototype for ioremap where size is size_t and
offset is phys_addr_t so fix that as well.

Signed-off-by: Greentime Hu <greentime@andestech.com>
