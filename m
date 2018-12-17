From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: use generic DMA mapping code in powerpc V4
Date: Mon, 17 Dec 2018 12:14:47 +1100
Message-ID: <87d0q1uf7c.fsf@concordia.ellerman.id.au>
References: <20181114082314.8965-1-hch@lst.de> <20181216165157.GA14652@lst.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181216165157.GA14652@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> FYI, given that we are one week before the expected 4.20 release
> date and I haven't found the bug plaging Christians setups I think
> we need to defer most of this to the next merge window.

OK, sorry I couldn't help. I tried powering up my pasemi board last week
but it just gives me a couple of status leds and nothing else, the fan
never spins up.

> I'd still like to get a few bits in earlier, which I will send out
> separately now.

OK.

cheers
