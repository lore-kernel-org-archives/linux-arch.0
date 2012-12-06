Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:65012 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321Ab2LFOXP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 6 Dec 2012 09:23:15 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so3638080eek.19
        for <linux-arch@vger.kernel.org>; Thu, 06 Dec 2012 06:23:14 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 6 Dec 2012 15:23:14 +0100
Message-ID: <CAHTX3dLxbVxn+D+AV7L0VsGYFOjas3AJ_3M_xncVfxp02FCy=Q@mail.gmail.com>
Subject: Sharing PCIE driver between Microblaze and Arm zynq
From: Michal Simek <michal.simek@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-arch@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Grant Likely <grant.likely@secretlab.ca>
Cc: John Linn <John.Linn@xilinx.com>, John Williams <jwilliams@xilinx.com>
Message-ID: <20121206142314.q92cDB85PXXiqMG1BxLV0maCOv-uCWVWaMLFEKMsrgk@z>

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
