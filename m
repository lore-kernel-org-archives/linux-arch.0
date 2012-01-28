From: Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH-RFC 06/10] mips: switch to GENERIC_PCI_IOMAP
Date: Sat, 28 Jan 2012 14:38:10 -0800
Message-ID: <CAJiQ=7BPzhWWzU3_nDv3j=ZB4f=iOzeyLyd2L0_3UFaMiLujpw@mail.gmail.com>
References: <cover.1322163031.git.mst@redhat.com>
        <66457f7750d7d14229fcf8d0b011aba63185a75d.1322163031.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <66457f7750d7d14229fcf8d0b011aba63185a75d.1322163031.git.mst@redhat.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Ralf Baechle <ralf@linux-mips.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Russell King <linux@arm.linux.org.uk>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Jonas Bonn <jonas@southpole.se>, Kyle McMartin <kyle@mcmartin.ca>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Chen Liqin <liqin.chen@sunplusct.com>, Lennox Wu <lennox.wu@gmail.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Nov 24, 2011 at 12:18 PM, Michael S. Tsirkin <mst@redhat.com> w=
rote:
> mips copied pci_iomap from generic code, probably to avoid
> pulling the rest of iomap.c in. =C2=A0Since that's in
> a separate file now, we can reuse the common implementation.

[snip]

> - =C2=A0 =C2=A0 =C2=A0 if (flags & IORESOURCE_IO)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ioport_map_=
pci(dev, start, len);

While investigating a new warning on the 3.3-rc1 MIPS build (unused
static function ioport_map_pci()), I noticed that this patch has shown
up in Linus' tree as commit eab90291d35438bcebf7c3dc85be66d0f24e3002.

I am not completely clear on the implications it has on mapping PCI I/O=
 regions:

Prior to this change, the MIPS version of pci_iomap() called a
MIPS-specific function, ioport_map_pci(), which tried to use the PCI
controller's io_map_base field to determine the base address of the
PCI I/O space.  It also had a fallback mechanism to deal with the case
where io_map_base is unset.

Now, in 3.3-rc1, the generic version of pci_iomap() is used instead.
This code just calls arch/mips/lib/iomap.c:ioport_map() on these
regions.  ioport_map() falls through to ioport_map_legacy(), which
always uses mips_io_port_base (not the PCI controller's io_map_base)
as the base address.  But on MIPS, it is still permissible to use
different I/O port bases for PCI devices and for legacy (ISA?)
devices.

Is this new behavior desirable, or are there any supported platforms
on which adverse effects might be seen?

As for my part, I don't use PCI I/O regions at all - just memory
regions.  I'm more worried about making sure my tree builds with 0
warnings.

If we do want to move ahead with the switch to GENERIC_PCI_IOMAP now,
I have patches to scrap iomap-pci.c entirely and squash the unused
function warning.

If we still want to support the case where io_map_base !=3D
mips_io_port_base, maybe it would be better to revert commit eab90291
for 3.3.

Might also want to take a look at SH since it also appears to have an
orphaned ioport_map_pci() function.

What are your thoughts?
