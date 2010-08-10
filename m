From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: asm/vga.h (was: Re: drm: Add support for platform devices to register
	as DRM devices)
Date: Tue, 10 Aug 2010 22:35:27 +0200
Message-ID: <AANLkTik44qbia+7w9=83cboTMLbvQDcH-60dHuAnd9ax@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:35485 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757843Ab0HJUfb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Aug 2010 16:35:31 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: dri-devel@lists.freedesktop.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org

On Fri, Aug 6, 2010 at 01:59, Linux Kernel Mailing List
<linux-kernel@vger.kernel.org> wrote:
> Gitweb: =C2=A0 =C2=A0 http://git.kernel.org/linus/dcdb167402cbdca1d02=
1bdfa5f63995ee0a79317
> Commit: =C2=A0 =C2=A0 dcdb167402cbdca1d021bdfa5f63995ee0a79317
> Parent: =C2=A0 =C2=A0 01d73a6967f12fe6c4bbde1834a9fe662264a2eb
> Author: =C2=A0 =C2=A0 Jordan Crouse <jcrouse@codeaurora.org>
> AuthorDate: Thu May 27 13:40:25 2010 -0600
> Committer: =C2=A0Dave Airlie <airlied@redhat.com>
> CommitDate: Tue Jun 1 10:07:39 2010 +1000
>
> =C2=A0 =C2=A0drm: Add support for platform devices to register as DRM=
 devices

> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -6,7 +6,7 @@
> =C2=A0#
> =C2=A0menuconfig DRM
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tristate "Direct Rendering Manager (XFree8=
6 4.1.0 and higher DRI support)"
> - =C2=A0 =C2=A0 =C2=A0 depends on (AGP || AGP=3Dn) && PCI && !EMULATE=
D_CMPXCHG && MMU
> + =C2=A0 =C2=A0 =C2=A0 depends on (AGP || AGP=3Dn) && !EMULATED_CMPXC=
HG && MMU

Since this change, I can enable DRM on m68k, but it fails with:

| In file included from drivers/gpu/drm/drm_irq.c:42:
| include/linux/vgaarb.h:34:21: error: asm/vga.h: No such file or direc=
tory

Now, do we really need <asm/vga.h>? It seems I can make it build and bo=
ot using:

--- a/include/linux/vgaarb.h
+++ b/include/linux/vgaarb.h
@@ -31,7 +31,9 @@
 #ifndef LINUX_VGA_H
 #define LINUX_VGA_H

+#ifdef CONFIG_VGA_ARB
 #include <asm/vga.h>
+#endif

 /* Legacy VGA regions */
 #define VGA_RSRC_NONE         0x00

Alternatively, I can provide an empty <asm/vga.h> (cfr. frv, mn10300,
parisc, sh)
or a simple (probably incorrect) one that includes <asm-generic/vga.h>
(cfr. microblaze).
But so far we never needed <asm/vga.h> on m68k.

=46or the record, this "problem" has been visible in linux-next (see
m68k/allmodconfig)
since July 9...

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
