From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Early crash (was: Re: module: show version information for
 built-in modules in sysfs)
Date: Wed, 2 Feb 2011 15:48:50 +0100
Message-ID: <AANLkTikWVt8NEyHN+=yD4EWSXUQt0gt5nLJtKQDw397M@mail.gmail.com>
References: <AANLkTin4gOnEMruLDM=TkNYsNf5S370WqbcDVJzT7_Z4@mail.gmail.com>
	<20110201210944.GA12348@dtor-ws.eng.vmware.com>
	<AANLkTimv=KqtuR36dMNa+=OMi0mgd8JK4qsb_SpmKmhs@mail.gmail.com>
	<20110201222637.GA17521@dtor-ws.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63246 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753101Ab1BBOsw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 2 Feb 2011 09:48:52 -0500
In-Reply-To: <20110201222637.GA17521@dtor-ws.eng.vmware.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dmitry Torokhov <dtor@vmware.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

On Tue, Feb 1, 2011 at 23:26, Dmitry Torokhov <dtor@vmware.com> wrote:
> On Tue, Feb 01, 2011 at 02:03:23PM -0800, Geert Uytterhoeven wrote:
>> On Tue, Feb 1, 2011 at 22:09, Dmitry Torokhov <dtor@vmware.com> wrot=
e:
>> > On Tue, Feb 01, 2011 at 12:33:29PM -0800, Geert Uytterhoeven wrote=
:
>> >> On Mon, Jan 24, 2011 at 11:59, Linux Kernel Mailing List
>> >> <linux-kernel@vger.kernel.org> wrote:
>> >> > Gitweb: =C2=A0 =C2=A0 http://git.kernel.org/linus/e94965ed5beb2=
3c6fabf7ed31f625e66d7ff28de
>> >>
>> >> > =C2=A0 =C2=A0module: show version information for built-in modu=
les in sysfs
>> >> >
>> >> > =C2=A0 =C2=A0Currently only drivers that are built as modules h=
ave their versions
>> >> > =C2=A0 =C2=A0shown in /sys/module/<module_name>/version, but th=
is information might
>> >> > =C2=A0 =C2=A0also be useful for built-in drivers as well. This =
especially important
>> >> > =C2=A0 =C2=A0for drivers that do not define any parameters - su=
ch drivers, if
>> >> > =C2=A0 =C2=A0built-in, are completely invisible from userspace.
>> >> >
>> >> > =C2=A0 =C2=A0This patch changes MODULE_VERSION() macro so that =
in case when we are
>> >> > =C2=A0 =C2=A0compiling built-in module, version information is =
stored in a separate
>> >> > =C2=A0 =C2=A0section. Kernel then uses this data to create 'ver=
sion' sysfs attribute
>> >> > =C2=A0 =C2=A0in the same fashion it creates attributes for modu=
le parameters.
>> >>
>> >> This commit causes the crash below on m68k (ARAnyM).
>> >> Reverting this commit and its dependency
>> >> 3b90a5b292321b2acac3921f77046ae195aef53f
>> >> ("module: fix linker error for MODULE_VERSION when !MODULE and CO=
NFIG_SYSFS=3Dn")
>> >> makes it boot again.
>> >>
>> >
>> > Hi Geert,
>> >
>> > Does the follwing help by any chance?
>> >
>> > From d6fd4a6e0fc2d3f0a74962d4a6f663a46d230ecd Mon Sep 17 00:00:00 =
2001
>> > diff --git a/arch/m68knommu/kernel/vmlinux.lds.S b/arch/m68knommu/=
kernel/vmlinux.lds.S
>> > index ef33213..47e15eb 100644
>> > --- a/arch/m68knommu/kernel/vmlinux.lds.S
>> > +++ b/arch/m68knommu/kernel/vmlinux.lds.S
>>
>> The crash happened on m68k with MMU, not m68knommu.
>>
>
> Hmm, OK then. Could you please see if the crash happens if you return
> early in kernel/params.c::version_sysfs_builtin() ? Also, do you see

It does not crash if version_sysfs_builtin() returns early.

> anything in __modev section of your build?

"objdump -h" says:

| Sections:
| Idx Name          Size      VMA       LMA       File off  Algn
|   7 __modver      0000007c  002e0f84  002e0f84  002e0f84  2**2
|                   CONTENTS, ALLOC, LOAD, DATA

"nm vmlinux | grep __modver" says:

| 002e0f84 d __modver_version_attr
| 002e0fa8 d __modver_version_attr
| 00039026 T __modver_version_show
| 002e0f84 D __start___modver
| 002e0fca D __stop___modver

The section size (0x7c) is larger than __stop___modver -
__start___modver (0x46)?

Adding some debugging code (which increases the section size even more?=
) shows:

vattr =3D 002e1004
vattr->module_name =3D xz_dec
    mk =3D 00c2ee50
    err =3D 0
    kobject_uevent done
    kobject_put done
vattr =3D 002e1026
vattr->module_name =3D (null)
Unable to handle kernel NULL pointer dereference at virtual address 000=
0002c

So the second module in the list has no name. Why?
Aha, it's not NULL, but just < PAGE_SIZE (0x2c).

sizeof(struct module_version_attribute) =3D 34, which you can see from
the 2 consecutive vattr
pointers above. But the "aligned(sizeof(void *))" in the definition of
MODULE_VERSION() puts
the next module_version_attribute struct in the array at offset 36,
not offset 34!
On m68k, the alignment of 32-bit integrals is 2 bytes, not 4.

Removing the alignment, cfr. this (gmail-pasted hence
whitespace-corrupted) patch
fixes it:

--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -176,7 +176,7 @@ extern struct module __this_module;
                                             struct module *, char *); =
 \
        static struct module_version_attribute __modver_version_attr   =
 \
        __used                                                         =
 \
-    __attribute__ ((__section__ ("__modver"),aligned(sizeof(void *))))=
 \
+    __attribute__ ((__section__ ("__modver"))) \
        =3D {                                                          =
   \
                .mattr  =3D {                                          =
   \
                        .attr   =3D {                                  =
   \

Why is the explicit alignment there? Can it be removed?
If not, you can move the alignment into the definition of struct
module_version_attribute,
so it will be honoured everywhere.

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
