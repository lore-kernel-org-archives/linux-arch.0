Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.80]:19133 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfAEQD7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 5 Jan 2019 11:03:59 -0500
Subject: Re: use generic DMA mapping code in powerpc V4
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
Message-ID: <1b0c5c21-2761-d3a3-651b-3687bb6ae694@xenosoft.de>
Date: Sat, 5 Jan 2019 17:03:52 +0100
MIME-Version: 1.0
In-Reply-To: <71A251A5-FA06-4019-B324-7AED32F7B714@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>, linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
Message-ID: <20190105160352.vb6YUr5--ku7F-MSHEGJ95kLgJcxfm1Nk3V5Siu7ff8@z>

Next step: c446404b041130fbd9d1772d184f24715cf2362f (powerpc/dma: remove 
dma_nommu_mmap_coherent)

git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.6 a

git checkout c446404b041130fbd9d1772d184f24715cf2362f

Output:

Note: checking out 'c446404b041130fbd9d1772d184f24715cf2362f'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by performing another checkout.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -b with the checkout command again. Example:

   git checkout -b <new-branch-name>

HEAD is now at c446404... powerpc/dma: remove dma_nommu_mmap_coherent

-----

Link to the Git: 
http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.6

Result: PASEMI onboard ethernet works and the X5000 (P5020 board) boots.

-- Christian
