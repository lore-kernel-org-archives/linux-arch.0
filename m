From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/3] module: deal with alignment issues in built-in module versions
Date: Mon, 21 Feb 2011 08:38:46 +0100
Message-ID: <AANLkTinFgma3F7ETwC8Mho7wdDK4V2b+Ao__npJNAW8j@mail.gmail.com>
References: <AANLkTi=nQ4c6fgk9_-974QOu=kQkJiGpdzpOa_U6ZZcs@mail.gmail.com>
	<20110217.140119.39175251.davem@davemloft.net>
	<20110217221957.GA11244@dtor-ws.eng.vmware.com>
	<20110217.142320.102554706.davem@davemloft.net>
	<AANLkTinMfTss+9K7fPQbxoMD7d-U_AyCc29_RRPRija3@mail.gmail.com>
	<AANLkTikd-OBhe6-wK7-Xvv-asNSeVKs+0-a0d3FF2KVu@mail.gmail.com>
	<1298074455.2460.85.camel@pasglop>
	<87pqqmrq9q.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36228 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751Ab1BUHis convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 21 Feb 2011 02:38:48 -0500
In-Reply-To: <87pqqmrq9q.fsf@rustcorp.com.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, dtor@vmware.com, linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org, linux-arch@vger.kernel.org

On Mon, Feb 21, 2011 at 05:00, Rusty Russell <rusty@rustcorp.com.au> wr=
ote:
>> Except that .long is 32-bit on ppc64 :-( You need .llong for 64-bit.
>
> OK, all options suck. =C2=A0Do we want the workaround or not?

We can discuss about that until someone gets bitten by that.

But please fix the "aligned(sizeof(void *))"-in-one-place-only issue.

> Cheers,
> Rusty.
>
> Subject: module: deal with alignment issues in built-in module versio=
ns
> Date: Mon, 7 Feb 2011 16:02:25 -0800
> From: Dmitry Torokhov <dtor@vmware.com>
>
> On m68k natural alignment is 2-byte boundary but we are trying to
> align structures in __modver section on sizeof(void *) boundary.
> This causes trouble when we try to access elements in this section
> in array-like fashion when create "version" attributes for built-in
> modules.
>
> Moreover, as DaveM said, we can't reliably put structures into
> independent objects, put them into a special section, and then expect
> array access over them (via the section boundaries) after linking the
> objects together to just "work" due to variable alignment choices in
> different situations. The only solution that seems to work reliably
> is to make an array of plain pointers to the objects in question and
> put those pointers in the special section.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Dmitry Torokhov <dtor@vmware.com>
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> ---
> =C2=A0include/linux/module.h | =C2=A0 10 +++++-----
> =C2=A0kernel/params.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A09 +++=
+++---
> =C2=A02 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 9bdf27c..9b7081a 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -174,10 +174,7 @@ extern struct module __this_module;
> =C2=A0#define MODULE_VERSION(_version) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0extern ssize_t __modver_version_show(struc=
t module_attribute *, \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 struct module *, char *); =C2=A0\
> - =C2=A0 =C2=A0 =C2=A0 static struct module_version_attribute __modve=
r_version_attr =C2=A0 =C2=A0\
> - =C2=A0 =C2=A0 =C2=A0 __used =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0\
> - =C2=A0 =C2=A0__attribute__ ((__section__ ("__modver"),aligned(sizeo=
f(void *)))) \
> - =C2=A0 =C2=A0 =C2=A0 =3D { =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 \
> + =C2=A0 =C2=A0 =C2=A0 static struct module_version_attribute ___modv=
er_attr =3D { =C2=A0 =C2=A0 =C2=A0 \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.mattr =C2=A0=3D=
 { =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0.attr =C2=A0 =3D { =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =C2=A0 =3D "version", =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> @@ -187,7 +184,10 @@ extern struct module __this_module;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}, =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.module_name =C2=
=A0 =C2=A0=3D KBUILD_MODNAME, =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.version =C2=A0=
 =C2=A0 =C2=A0 =C2=A0=3D _version, =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> - =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 }; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0\
> + =C2=A0 =C2=A0 =C2=A0 static const struct module_version_attribute =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> + =C2=A0 =C2=A0 =C2=A0 __used __attribute__ ((__section__ ("__modver"=
))) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> + =C2=A0 =C2=A0 =C2=A0 * __moduleparam_const __modver_attr =3D &___mo=
dver_attr
> =C2=A0#endif
>
> =C2=A0/* Optional firmware file (or files) needed by the module
> diff --git a/kernel/params.c b/kernel/params.c
> index 0da1411..09a08cb 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -821,15 +821,18 @@ ssize_t __modver_version_show(struct module_att=
ribute *mattr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return sprintf(buf, "%s\n", vattr->version=
);
> =C2=A0}
>
> -extern struct module_version_attribute __start___modver[], __stop___=
modver[];
> +extern const struct module_version_attribute *__start___modver[];
> +extern const struct module_version_attribute *__stop___modver[];
>
> =C2=A0static void __init version_sysfs_builtin(void)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 const struct module_version_attribute *vattr;
> + =C2=A0 =C2=A0 =C2=A0 const struct module_version_attribute **p;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct module_kobject *mk;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int err;
>
> - =C2=A0 =C2=A0 =C2=A0 for (vattr =3D __start___modver; vattr < __sto=
p___modver; vattr++) {
> + =C2=A0 =C2=A0 =C2=A0 for (p =3D __start___modver; p < __stop___modv=
er; p++) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct modul=
e_version_attribute *vattr =3D *p;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mk =3D locate_=
module_kobject(vattr->module_name);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (mk) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0err =3D sysfs_create_file(&mk->kobj, &vattr->mattr.attr);

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
