From: Christoph Hellwig <hch@lst.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Date: Fri, 1 Feb 2019 09:04:56 +0100
Message-ID: <20190201080456.GA15456@lst.de>
References: <4d8d4854-dac9-a78e-77e5-0455e8ca56c4@xenosoft.de> <1dec2fbe-f654-dac7-392a-93a5d20e3602@xenosoft.de> <20190128070422.GA2772@lst.de> <20190128162256.GA11737@lst.de> <D64B1ED5-46F9-43CF-9B21-FABB2807289B@xenosoft.de> <6f2d6bc9-696b-2cb1-8a4e-df3da2bd6c0a@xenosoft.de> <20190129161411.GA14022@lst.de> <20190129163415.GA14529@lst.de> <F4AB3D9A-97EC-45D7-9061-A750D0934C3C@xenosoft.de> <96762cd2-65fc-bce5-8c5b-c03bc3baf0a1@xenosoft.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <96762cd2-65fc-bce5-8c5b-c03bc3baf0a1@xenosoft.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>, linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

On Thu, Jan 31, 2019 at 01:48:26PM +0100, Christian Zigotzky wrote:
> Hi Christoph,
>
> I compiled kernels for the X5000 and X1000 from your branch 'powerpc-dma.6' 
> today.
>
> Gitweb: 
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.6
>
> git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.6 a
>
> The X1000 and X5000 boot but unfortunately the P.A. Semi Ethernet doesn't 
> work.

Oh.  Can you try with just the next one and then two patches applied
over the working setup?  That is first:

http://git.infradead.org/users/hch/misc.git/commitdiff/b50f42f0fe12965ead395c76bcb6a14f00cdf65b

then also with:

http://git.infradead.org/users/hch/misc.git/commitdiff/21fe52470a483afbb1726741118abef8602dde4d
