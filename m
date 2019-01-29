From: Christoph Hellwig <hch@lst.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Date: Tue, 29 Jan 2019 17:34:15 +0100
Message-ID: <20190129163415.GA14529@lst.de>
References: <20190119140452.GA25198@lst.de> <bfe4adcc-01c1-7b46-f40a-8e020ff77f58@xenosoft.de> <8434e281-eb85-51d9-106f-f4faa559e89c@xenosoft.de> <4d8d4854-dac9-a78e-77e5-0455e8ca56c4@xenosoft.de> <1dec2fbe-f654-dac7-392a-93a5d20e3602@xenosoft.de> <20190128070422.GA2772@lst.de> <20190128162256.GA11737@lst.de> <D64B1ED5-46F9-43CF-9B21-FABB2807289B@xenosoft.de> <6f2d6bc9-696b-2cb1-8a4e-df3da2bd6c0a@xenosoft.de> <20190129161411.GA14022@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190129161411.GA14022@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>, linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

On Tue, Jan 29, 2019 at 05:14:11PM +0100, Christoph Hellwig wrote:
> On Tue, Jan 29, 2019 at 04:03:32PM +0100, Christian Zigotzky wrote:
> > Hi Christoph,
> >
> > I compiled kernels for the X5000 and X1000 from your new branch 
> > 'powerpc-dma.6-debug.2' today. The kernels boot and the P.A. Semi Ethernet 
> > works!
> 
> Thanks for testing!  I'll prepare a new series that adds the other
> patches on top of this one.

And that was easier than I thought - we just had a few patches left
in powerpc-dma.6, so I've rebased that branch on top of
powerpc-dma.6-debug.2:

    git://git.infradead.org/users/hch/misc.git powerpc-dma.6

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.6

I hope the other patches are simple enough, so just testing the full
branch checkout should be fine for now.
