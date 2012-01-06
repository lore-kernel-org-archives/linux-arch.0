From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [GIT PATCH] driver core merge for 3.3
Date: Fri, 6 Jan 2012 22:38:41 +0100
Message-ID: <CAMuHMdVdTcJFePA2tf-jqnLGW_2i7rJLqAX521SM+rz0YzXJNg@mail.gmail.com>
References: <20120106201126.GA7239@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:60755 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714Ab2AFVim convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 6 Jan 2012 16:38:42 -0500
In-Reply-To: <20120106201126.GA7239@kroah.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>, Linux-Arch <linux-arch@vger.kernel.org>

On Fri, Jan 6, 2012 at 21:11, Greg KH <gregkh@suse.de> wrote:
> Ben Hutchings (1):
> =C2=A0 =C2=A0 =C2=A0topology: Provide CPU topology in sysfs in !SMP c=
onfigurations

=46WIW, as reported before, I can confirm that 3.2.0-next-20120106 cras=
hes
on m68k during boot:

Console: switching to colour frame buffer device 80x30
fb0: frame buffer device, using 304K of video memory
Non-volatile memory driver v1.3
Unable to handle kernel NULL pointer dereference at virtual address 000=
00020
Oops: 00000000
Modules linked in:
PC: [<000c3f72>] internal_create_group+0x20/0x1ba
SR: 2304  SP: 00c07f10  a2: 00c05c00
d0: 00000000    d1: fffff24b    d2: 00000000    d3: 00000000
d4: 00000000    d5: 002f0a28    a0: 00000008    a1: 002e306e
Process swapper (pid: 1, task=3D00c05c00)
=46rame format=3D7 eff addr=3D00000020 ssw=3D0505 faddr=3D00000020
wb 1 stat/addr/data: 0000 00000000 00000000
wb 2 stat/addr/data: 0000 00000000 00000000
wb 3 stat/addr/data: 0000 00000020 00000000
push data: 00000000 00000000 00000000 00000000
Stack from 00c07f78:
        00000000 00000000 00000000 00000000 00000000 0033d5f0 0033641e =
00326632
        00000000 002e1ff8 000c4130 00000008 00000000 002f0a28 00336436 =
00000008
        002f0a28 00000000 0000210c 00000000 00000000 00000000 00000000 =
00000000
        00000000 0033d5f0 00002008 00326632 0031dae2 0033641e 0031da66 =
000249b6
        00002f04 00000000
Call Trace: [<0033641e>] topology_sysfs_init+0x0/0x1e
 [<00326632>] __alloc_bootmem+0x0/0x1a
 [<000c4130>] sysfs_create_group+0xe/0x14
 [<00336436>] topology_sysfs_init+0x18/0x1e
 [<0000210c>] do_one_initcall+0x104/0x19a
 [<00002008>] do_one_initcall+0x0/0x19a
 [<00326632>] __alloc_bootmem+0x0/0x1a
 [<0031dae2>] kernel_init+0x7c/0x11c
 [<0033641e>] topology_sysfs_init+0x0/0x1e
 [<0031da66>] kernel_init+0x0/0x11c
 [<000249b6>] printk+0x0/0x1a
 [<00002f04>] kernel_thread+0x3a/0x4e

Code: 2a2e 0010 4a86 6700 0162 4a84 660a 2046 <4aa8> 0018 6700 0154
4a84 6600 0122 2045 2010 6700 0128 486e fffc 2f00 2f06 61ff
Disabling lock debugging due to kernel taint
Kernel panic - not syncing: Attempted to kill init!

Reverting the above commit (ccbc60d3e19a1b6ae66ca0d89b3da02dde62088b)
fixes it.

So to preserve bisectability, you may want to drop this ommit until the
UP-only archs have been fixed.

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
