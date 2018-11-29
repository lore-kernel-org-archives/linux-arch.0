From: Christoph Hellwig <hch@lst.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Date: Thu, 29 Nov 2018 18:03:51 +0100
Message-ID: <20181129170351.GC27951@lst.de>
References: <20181114082314.8965-1-hch@lst.de> <20181127074253.GB30186@lst.de> <87zhttfonk.fsf@concordia.ellerman.id.au> <4d4e3cdd-d1a9-affe-0f63-45b8c342bbd6@xenosoft.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4d4e3cdd-d1a9-affe-0f63-45b8c342bbd6@xenosoft.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Christoph Hellwig <hch@lst.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>
List-Id: linux-arch.vger.kernel.org

On Thu, Nov 29, 2018 at 01:05:23PM +0100, Christian Zigotzky wrote:
> I compiled a test kernel from the following Git today.
>
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.4
>
> Command: git clone git://git.infradead.org/users/hch/misc.git -b 
> powerpc-dma.4 a
>
> Unfortunately I get some DMA error messages and the PASEMI ethernet doesn't 
> work anymore.

What kind of machine is this (and your other one)?  Can you send me
(or point me to) the .config files?
