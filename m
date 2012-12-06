From: Michal Simek <michal.simek@xilinx.com>
Subject: Sharing PCIE driver between Microblaze and Arm zynq
Date: Thu, 6 Dec 2012 15:23:14 +0100
Message-ID: <CAHTX3dLxbVxn+D+AV7L0VsGYFOjas3AJ_3M_xncVfxp02FCy=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-arch@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Grant Likely <grant.likely@secretlab.ca>
Cc: John Linn <John.Linn@xilinx.com>, John Williams <jwilliams@xilinx.com>
List-Id: linux-arch.vger.kernel.org

Hi guys,

I have a question regarding to sharing generic OF pcie driver between
two architectures MB and ARM Zynq.
Is drivers/pci/pcie location good for it?
Make no sense to have the same driver in two locations.
Is using readl/writel IO functions in this driver the best option
which we can have?
Or is there any other recommendation?

Also just want to check if it is correct to use pcie device_type.
The rest should be the same with pci description:
(http://devicetree.org/MPC5200:PCI#PCI_Address_Translation).

Thanks,
Michal
