From: Christoph Hellwig <hch@lst.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Date: Thu, 29 Nov 2018 18:03:02 +0100
Message-ID: <20181129170302.GB27951@lst.de>
References: <20181114082314.8965-1-hch@lst.de> <20181127074253.GB30186@lst.de> <87zhttfonk.fsf@concordia.ellerman.id.au> <535776df-dea3-eb26-6bf3-83f225e977df@xenosoft.de> <20181128213510.543259e3@kitsune.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181128213510.543259e3@kitsune.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>, Michael Ellerman <mpe@ellerman.id.au>, Christoph Hellwig <hch@lst.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

> > Please don't apply the new DMA mapping code if you don't be sure if it 
> > works on all supported PowerPC machines. Is the new DMA mapping code 
> > really necessary? It's not really nice, to rewrote code if the old code 
> > works perfect. We must not forget, that we work for the end users. Does 
> > the end user have advantages with this new code? Is it faster? The old 
> > code works without any problems. 
> 
> There is another service provided to the users as well: new code that is
> cleaner and simpler which allows easier bug fixes and new features.
> Without being familiar with the DMA mapping code I cannot really say if
> that's the case here.

Yes, the main point is to move all architecturs to common code for the
dma direct mapping code.  This means we have one code bases that sees
bugs fixed and features introduced the same way for everyone.
