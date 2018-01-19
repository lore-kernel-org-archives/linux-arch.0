From: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 03/36] sparc: io: To use the define of
 ioremap_[nocache|wc|wb] in asm-generic/io.h
Date: Fri, 19 Jan 2018 20:50:50 +0800
Message-ID: <CAEbi=3dR1wc3NY6aaUw+gzMUp_Z7Fk2E_eEfJq6J22DPaaMjkQ@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <790e05e9b9675b3f6ef41693a794d1f09795c151.1515766253.git.green.hu@gmail.com>
 <CAK8P3a2qx5pZmE-=QM5Bwrsib4XcfVac7RQr-QMzEseQ_oBPEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAK8P3a2qx5pZmE-=QM5Bwrsib4XcfVac7RQr-QMzEseQ_oBPEA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Greentime <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Networking <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, DTML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert.uytterhoeven-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Guo Ren <ren_guo-Y+KPrCd2zL4@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

2018-01-18 17:56 GMT+08:00 Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>:
> On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> From: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
>>
>> It will be built failed if commit id: d25ea659 is selected. This patch
>> can fix this build error.
>>
>> Signed-off-by: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
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

Signed-off-by: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
