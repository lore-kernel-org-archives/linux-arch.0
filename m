Return-Path: <willy@www.linux.org.uk>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33221 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261681AbUCKTnN
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 11 Mar 2004 14:43:13 -0500
Date: Thu, 11 Mar 2004 19:43:10 +0000
From: Matthew Wilcox <willy@debian.org>
Subject: PCI config space accessors
Message-ID: <20040311194310.GL2148@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: <willy@www.linux.org.uk>
To: linux-arch@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
List-ID: <linux-arch.vger.kernel.org>


Couple of changes are coming...

First, the PCI core may start trying to access config space above
byte 255.  This is to support PCI Express and PCI-X 2.0 which define a
4096 byte config space.  It will only try these accesses if the device
is marked as being PCI Express or PCI-X mode 2 capable, so no currently
shipping hardware should be affected, until someone plugs in a PCI-E
or PCI-X2 card.  So you'll probably want to go through all your pci
root drivers and do something like:

--- a/arch/alpha/kernel/core_apecs.c    17 Feb 2004 12:51:43 -0000      1.2
+++ b/arch/alpha/kernel/core_apecs.c    11 Mar 2004 19:16:01 -0000
@@ -278,6 +278,9 @@ apecs_read_config(struct pci_bus *bus, u
        long mask;
        int shift;
 
+       if ((bus->number > 255) || (devfn > 255) || (where > 255))
+               return -EINVAL;
+
        if (mk_conf_addr(bus, devfn, where, &pci_addr, &type1))
                return PCIBIOS_DEVICE_NOT_FOUND;
 
@@ -295,6 +298,9 @@ apecs_write_config(struct pci_bus *bus, 
        unsigned long addr, pci_addr;
        unsigned char type1;
        long mask;
+
+       if ((bus->number > 255) || (devfn > 255) || (where > 255))
+               return -EINVAL;
 
        if (mk_conf_addr(bus, devfn, where, &pci_addr, &type1))
                return PCIBIOS_DEVICE_NOT_FOUND;

There's a lot of these to do, and some of them are a bit strange, so
I hope you'll forgive me for not doing them myself.

Secondly, and more subtly, there's a growing demand for faster PCI config
space accesses.  tg3 (amongst others) does config space accesses extremely
frequently.  We'd like to remove the spinlock from drivers/pci/access.c
so we can have multiple simultaneous config space accesses.  Does your
architecture rely on this?  If so, you'll want to put some kind of
spinlock in your arch code.  x86, x86-64 and ia64 are already either
spinlocked or safely spinlock-free.

Note this spinlock is currently _irqsave -- ie all the uniprocessor
architectures that have been ignoring this up till now need to consider
whether they need to disable interrupts inside their config accessors.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
