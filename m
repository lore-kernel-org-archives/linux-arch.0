Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from alephnull.demon.nl ([83.160.184.112]:50048 "EHLO
	xi.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223AbYCGKr3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Mar 2008 05:47:29 -0500
Date: Fri, 7 Mar 2008 11:19:13 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: [PATCH 0/7][RFC] Move Marvell MBUS window handling into drivers
Message-ID: <20080307101913.GA11918@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Saeed Bishara <saeed@marvell.com>, Dale Farnsworth <dale@farnsworth.org>, Russell King <linux@arm.linux.org.uk>, Tzachi Perelstein <tzachi@marvell.com>, Nicolas Pitre <nico@cam.org>
Message-ID: <20080307101913.K-zp1fOV03o8Bs9fOrO9sH5jdZM6c5M7X3sfRO545d4@z>

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
