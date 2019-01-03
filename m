Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:60819 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfACHgY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 3 Jan 2019 02:36:24 -0500
Date: Thu, 3 Jan 2019 08:36:22 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Message-ID: <20190103073622.GA24323@lst.de>
References: <2242B4B2-6311-492E-BFF9-6740E36EC6D4@xenosoft.de> <84558d7f-5a7f-5219-0c3a-045e6b4c494f@xenosoft.de> <20181213091021.GA2106@lst.de> <835bd119-081e-a5ea-1899-189d439c83d6@xenosoft.de> <76bc684a-b4d2-1d26-f18d-f5c9ba65978c@xenosoft.de> <20181213112511.GA4574@lst.de> <e109de27-f4af-147d-dc0e-067c8bafb29b@xenosoft.de> <ad5a5a8a-d232-d523-a6f7-e9377fc3857b@xenosoft.de> <e60d6ca3-860c-f01d-8860-c5e022ec7179@xenosoft.de> <008c981e-bdd2-21a7-f5f7-c57e4850ae9a@xenosoft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <008c981e-bdd2-21a7-f5f7-c57e4850ae9a@xenosoft.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>, linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
Message-ID: <20190103073622.FkANH9x9o_4TLk2eXOx1yzFPQTpfjs_6rZK6PoS28gc@z>

Hi Christian,

happy new year and I hope you had a few restful deays off.

I've pushed a new tree to:

   git://git.infradead.org/users/hch/misc.git powerpc-dma.6

Gitweb:

   http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.6

Which has been rebased to the latests Linus tree, which has a lot of
changes, and has also changed the patch split a bit to aid bisection.

I think 

   http://git.infradead.org/users/hch/misc.git/commitdiff/c446404b041130fbd9d1772d184f24715cf2362f

might be a good commit to re-start testing, then bisecting up to the
last commit using git bisect.
