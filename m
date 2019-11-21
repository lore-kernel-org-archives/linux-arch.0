Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:47423 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfKUR0l (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 21 Nov 2019 12:26:41 -0500
Date: Thu, 21 Nov 2019 18:26:37 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: Bug 205201 - overflow of DMA mask and bus mask
Message-ID: <20191121172637.GC2932@lst.de>
References: <ad5a5a8a-d232-d523-a6f7-e9377fc3857b@xenosoft.de> <e60d6ca3-860c-f01d-8860-c5e022ec7179@xenosoft.de> <008c981e-bdd2-21a7-f5f7-c57e4850ae9a@xenosoft.de> <20190103073622.GA24323@lst.de> <71A251A5-FA06-4019-B324-7AED32F7B714@xenosoft.de> <1b0c5c21-2761-d3a3-651b-3687bb6ae694@xenosoft.de> <3504ee70-02de-049e-6402-2d530bf55a84@xenosoft.de> <46025f1b-db20-ac23-7dcd-10bc43bbb6ee@xenosoft.de> <20191105162856.GA15402@lst.de> <8b239ba6-29f3-9483-8696-ddfba2a49a49@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b239ba6-29f3-9483-8696-ddfba2a49a49@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Zigotzky <chzigotzky@xenosoft.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org
Message-ID: <20191121172637.0yavtFWrVPl6-h7ZK_9Lqu2CPeIKHywaeq2S_NAGfRU@z>

On Wed, Nov 06, 2019 at 02:09:26PM +0000, Robin Murphy wrote:
> Hmm, that bus mask looks pretty wacky - are you able to figure out where 
> that's coming from?

arch/powerpc/sysdev/fsl_pci.c:pci_dma_dev_setup_swiotlb().
