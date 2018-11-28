From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Date: Wed, 28 Nov 2018 21:35:10 +0100
Message-ID: <20181128213510.543259e3@kitsune.suse.cz>
References: <20181114082314.8965-1-hch@lst.de>
        <20181127074253.GB30186@lst.de>
        <87zhttfonk.fsf@concordia.ellerman.id.au>
        <535776df-dea3-eb26-6bf3-83f225e977df@xenosoft.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <535776df-dea3-eb26-6bf3-83f225e977df@xenosoft.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Christoph Hellwig <hch@lst.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, 28 Nov 2018 16:55:30 +0100
Christian Zigotzky <chzigotzky@xenosoft.de> wrote:

> On 28 November 2018 at 12:05PM, Michael Ellerman wrote:
> > Nothing specific yet.
> >
> > I'm a bit worried it might break one of the many old obscure platforms
> > we have that aren't well tested.
> >  
> Please don't apply the new DMA mapping code if you don't be sure if it 
> works on all supported PowerPC machines. Is the new DMA mapping code 
> really necessary? It's not really nice, to rewrote code if the old code 
> works perfect. We must not forget, that we work for the end users. Does 
> the end user have advantages with this new code? Is it faster? The old 
> code works without any problems. 

There is another service provided to the users as well: new code that is
cleaner and simpler which allows easier bug fixes and new features.
Without being familiar with the DMA mapping code I cannot really say if
that's the case here.

> I am also worried about this code. How 
> can I test this new DMA mapping code?

I suppose if your machine works it works for you.

Thanks

Michal
