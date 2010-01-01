From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [RFC] improve alignf() calling convention in allocate_resource()
Date: Fri, 1 Jan 2010 17:38:11 +0100
Message-ID: <20100101163811.GA8124@comet.dominikbrodowski.net>
References: <20091220095001.GA6029@comet.dominikbrodowski.net>
 <alpine.LFD.2.00.0912201026570.3712@localhost.localdomain>
 <20091221084031.GB1648@isilmar.linta.de>
 <alpine.LFD.2.00.0912210801260.21722@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0912210801260.21722@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Yinghai Lu <yhlu.kernel@gmail.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Dec 21, 2009 at 08:03:02AM -0800, Linus Torvalds wrote:
> > What about taking my patch for 2.6.33, and deferring the change to the
> > calling convention to the 2.6.34 merge window? (I'll try to cook something
> > up and get it into linux-next during the next few weeks).

Based on the previous discussion, I've prepared two patches which change the
calling convention of alignf() to

resource_size_t (*alignf)(void *data,
			  const struct resource *new,
			  resource_size_t size,
			  resource_size_t align)

. Any feedback is welcome.

 arch/alpha/kernel/pci.c                 |    6 +++---
 arch/arm/kernel/bios32.c                |    8 +++++---
 arch/cris/arch-v32/drivers/pci/bios.c   |   16 +++++++---------
 arch/frv/mb93090-mb00/pci-frv.c         |   16 +++++++---------
 arch/ia64/pci/pci.c                     |    5 +++--
 arch/mips/pci/pci.c                     |    6 +++---
 arch/mips/pmc-sierra/yosemite/ht.c      |   10 +++++-----
 arch/mn10300/unit-asb2305/pci-asb2305.c |   16 +++++++---------
 arch/parisc/kernel/pci.c                |   10 +++++-----
 arch/powerpc/kernel/pci-common.c        |   13 ++++++-------
 arch/sh/drivers/pci/pci.c               |    6 +++---
 arch/sparc/kernel/pci.c                 |    5 +++--
 arch/sparc/kernel/pcic.c                |    5 +++--
 arch/x86/pci/i386.c                     |   14 ++++++--------
 arch/xtensa/kernel/pci.c                |   15 +++++++--------
 drivers/pci/bus.c                       |    6 ++++--
 drivers/pcmcia/rsrc_mgr.c               |   13 +++++++------
 drivers/pcmcia/rsrc_nonstatic.c         |   22 ++++++++++++----------
 include/linux/ioport.h                  |    6 ++++--
 include/linux/pci.h                     |    9 ++++++---
 kernel/resource.c                       |   14 +++++++++-----
 21 files changed, 115 insertions(+), 106 deletions(-)


Best,
	Dominik
