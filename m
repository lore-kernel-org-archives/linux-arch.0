Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: =?iso-8859-1?Q?Re:_pci:_Arch_hook_to_determine_config_space_size?=
From: <arndb@onlinehome.de>
Message-Id: <26879984$110721275641feb9d4b0ac20.24786725@config18.schlund.de>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Date: Tue,  1 Feb 2005 00:22:02 +0100
To: brking@us.ibm.com
Cc: =?iso-8859-1?Q?Arnd_Bergmann?= <arnd@arndb.de>, =?iso-8859-1?Q?Matthew_Wilcox?= <matthew@wil.cx>, =?iso-8859-1?Q?Greg_KH?= <greg@kroah.com>, =?iso-8859-1?Q?Christoph_Hellwig?= <hch@infradead.org>, linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-arch@vger.kernel.org, paulus@samba.org
List-ID: <linux-arch.vger.kernel.org>


Brian King <brking@us.ibm.com> schrieb am 31.01.2005, 23:43:30:

> > Isn't the config space size a property of the PCI device instead of the
> > host bridge? For a PCI device behind a PCIe host bridge, this could
> > still lead to an incorrect config space accesses.
> 
> It is a property of both. Accessing config space beyond the first 256 
> bytes will only work if both the PCI device and the host bridge support 
> it. The problem I ran into was generic pci code issuing a config read to 
> offset 256 after checking that the device supports it when the host 
> bridge did not support it.

If I interpret the spec correctly, the firmware should always store the
value we need in the property for every device node, which means that
you should look at the host bridge config-space-type attribute only
when you want to look at the bridge itself. If the device claims to
support a PCIe config space and the bridge doesn't, that sounds to
me like a firmware bug.

      Arnd <><
