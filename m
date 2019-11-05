Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.81]:24547 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387954AbfKEIIc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Nov 2019 03:08:32 -0500
Subject: Bug 205201 - overflow of DMA mask and bus mask
From: Christian Zigotzky <chzigotzky@xenosoft.de>
References: <2242B4B2-6311-492E-BFF9-6740E36EC6D4@xenosoft.de>
 <84558d7f-5a7f-5219-0c3a-045e6b4c494f@xenosoft.de>
 <20181213091021.GA2106@lst.de>
 <835bd119-081e-a5ea-1899-189d439c83d6@xenosoft.de>
 <76bc684a-b4d2-1d26-f18d-f5c9ba65978c@xenosoft.de>
 <20181213112511.GA4574@lst.de>
 <e109de27-f4af-147d-dc0e-067c8bafb29b@xenosoft.de>
 <ad5a5a8a-d232-d523-a6f7-e9377fc3857b@xenosoft.de>
 <e60d6ca3-860c-f01d-8860-c5e022ec7179@xenosoft.de>
 <008c981e-bdd2-21a7-f5f7-c57e4850ae9a@xenosoft.de>
 <20190103073622.GA24323@lst.de>
 <71A251A5-FA06-4019-B324-7AED32F7B714@xenosoft.de>
 <1b0c5c21-2761-d3a3-651b-3687bb6ae694@xenosoft.de>
 <3504ee70-02de-049e-6402-2d530bf55a84@xenosoft.de>
Message-ID: <46025f1b-db20-ac23-7dcd-10bc43bbb6ee@xenosoft.de>
Date: Tue, 5 Nov 2019 08:56:27 +0100
MIME-Version: 1.0
In-Reply-To: <3504ee70-02de-049e-6402-2d530bf55a84@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Olof Johansson <olof@lixom.net>
Message-ID: <20191105075627.sAkwWP6atAjw3dqnAUHt_2Eb9IreAg1MiwAwE9RAmCk@z>

Hi All,

We still have DMA problems with some PCI devices. Since the PowerPC 
updates 4.21-1 [1] we need to decrease the RAM to 3500MB (mem=3500M) if 
we want to work with our PCI devices. The FSL P5020 and P5040 have these 
problems currently.

Error message:

[   25.654852] bttv 1000:04:05.0: overflow 0x00000000fe077000+4096 of 
DMA mask ffffffff bus mask df000000

All 5.x Linux kernels can't initialize a SCSI PCI card anymore so 
booting of a Linux userland isn't possible.

PLEASE check the DMA changes in the PowerPC updates 4.21-1 [1]. The 
kernel 4.20 works with all PCI devices without limitation of RAM.

We created a bug report a month ago. [2]

Thanks,
Christian

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8d6973327ee84c2f40dd9efd8928d4a1186c96e2
[2] https://bugzilla.kernel.org/show_bug.cgi?id=205201
