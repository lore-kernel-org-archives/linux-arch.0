From: Lennert Buytenhek <buytenh-OLH4Qvv75CYX/NnBR394Jw@public.gmane.org>
Subject: [PATCH 0/7][RFC] Move Marvell MBUS window handling into drivers
Date: Fri, 7 Mar 2008 11:19:13 +0100
Message-ID: <20080307101913.GA11918@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Saeed Bishara <saeed-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Dale Farnsworth <dale-1viX+2+OPRFcxvNqPlePQg@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Tzachi Perelstein <tzachi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nicolas Pitre <nico-mo2vmkxb4K0@public.gmane.org>

Hi all,

Various Marvell chips (ARM SoCs, MIPS/PPC northbridges,
standalone PCI/PCIe SATA/etc. controllers) use an on-chip bus
called MBUS.

An MBUS bus address consists of not only a 32/64-bit address, but
also of a target/attribute ID, which identify which of the connected
MBUS peripherals the access is intended for.  I.e., transactions are
routed explicitly, rather than implicitly based on their address.

Peripherals map DMA addresses (as handed to them via e.g. TX/RX
descriptors) to MBUS bus addresses via a set of programmable
per-peripheral address map windows.

In the typical ARM/PPC case, each DMA-capable MBUS peripheral is
programmed such that its entire DMA address range points to the
on-chip DRAM controller.  (But if you wanted, you could also map a
peripheral's entire DMA address range to e.g. the PCI MEM address
range of some on-chip PCI/PCIe controller.)

For things like PCIe SATA controllers, you don't need to worry
about setting these address windows, but on most of the ARM/PPC/MIPS
stuff, the mapping windows don't contain valid values after reset,
and the programming has to be done by the bootloader or the kernel.

While the MBUS address map registers are an integral part of each
peripheral's own register set, these MBUS address map windows are
currently programmed directly by platform code, leading to such
gems as arch/arm/mach-orion/addr-map.c and
arch/powerpc/platforms/chrp/pegasos_eth.c.

This patch set is an initial attempt at moving programming of the
MBUS register windows for the set of MBUS peripherals that we currently
have in-tree drivers for from platform code into drivers.

With these patches, info about DRAM target/attribute IDs is prepared
by the platform code as usual, but then passed into platform drivers
via platform device data, instead of programming that data into the
peripherals directly.

This avoids duplicating the window programming code across each
platform that wants to use these peripherals, and avoids exposing
internal peripheral register set details outside of their drivers.

Comments appreciated.


thanks,
Lennert
--
To unsubscribe from this list: send the line "unsubscribe linux-arch" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
