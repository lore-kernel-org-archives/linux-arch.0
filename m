From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] topology: Provide CPU topology in sysfs in !SMP configurations
Date: Tue, 3 Jan 2012 16:54:48 +0100
Message-ID: <CAMuHMdX6rcoyts=o5EEZTDb4CWHY-sYU=3dP4_f6U4o1LNk6vA@mail.gmail.com>
References: <1322118279.2839.255.camel@deadeye>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:48821 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753930Ab2ACPyt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 Jan 2012 10:54:49 -0500
In-Reply-To: <1322118279.2839.255.camel@deadeye>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Marcus Osdoba <marcus.osdoba@googlemail.com>, 649216@bugs.debian.org, Linux-Arch <linux-arch@vger.kernel.org>

On Thu, Nov 24, 2011 at 08:04, Ben Hutchings <ben@decadent.org.uk> wrot=
e:
> We should provide topology information to userland even if it's not
> very interesting. =C2=A0The current code appears to work properly for=
 !SMP
> (tested on i386).
>
> Reference: http://bugs.debian.org/649216
> Reported-by: Marcus Osdoba <marcus.osdoba@googlemail.com>
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
> =C2=A0drivers/base/Makefile | =C2=A0 =C2=A04 ++--
> =C2=A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/Makefile b/drivers/base/Makefile
> index 99a375a..1334d89 100644
> --- a/drivers/base/Makefile
> +++ b/drivers/base/Makefile
> @@ -3,7 +3,8 @@
> =C2=A0obj-y =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0:=3D core.o sys.o bus.o dd.o syscore.o \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 driver.o class.o platform.o \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 cpu.o firmware.o init.o map.o devres.o \
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0attribute_container.o transport_class.o
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0attribute_container.o transport_class.o \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0topology.o
> =C2=A0obj-$(CONFIG_DEVTMPFS) +=3D devtmpfs.o
> =C2=A0obj-y =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0+=3D power/
> =C2=A0obj-$(CONFIG_HAS_DMA) =C2=A0+=3D dma-mapping.o
> @@ -12,7 +13,6 @@ obj-$(CONFIG_ISA) =C2=A0 =C2=A0 +=3D isa.o
> =C2=A0obj-$(CONFIG_FW_LOADER) =C2=A0 =C2=A0 =C2=A0 =C2=A0+=3D firmwar=
e_class.o
> =C2=A0obj-$(CONFIG_NUMA) =C2=A0 =C2=A0 +=3D node.o
> =C2=A0obj-$(CONFIG_MEMORY_HOTPLUG_SPARSE) +=3D memory.o
> -obj-$(CONFIG_SMP) =C2=A0 =C2=A0 =C2=A0+=3D topology.o
> =C2=A0ifeq ($(CONFIG_SYSFS),y)
> =C2=A0obj-$(CONFIG_MODULES) =C2=A0+=3D module.o
> =C2=A0endif

Taking this to linux-arch with a follow up from Ben due to crashes
reported on the
debian-m68k mailing list:

> > My guess is that on m68k get_cpu_sysdev(0) returns NULL and thus
> > topology_add_dev() passes an invalid pointer into sysfs_create_grou=
p().
> > So either m68k (and maybe some other architectures with no SMP supp=
ort)
> > need to be fixed or the CPU topology code needs to allow for this.
>
> None of these architectures appears to call register_cpu():
>
>    c6x frv h8300 m68k microblaze openrisc score um xtensa
>
> and therefore they will all panic at boot following this change (comm=
it
> ccbc60d3e19a1b6ae66ca0d89b3da02dde62088b).  So either I can try to fi=
x
> them or else it must be reverted for now.

The commit mentioned above is in linux-next (and in Debian's 3.2-rc7).

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
