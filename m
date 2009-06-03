From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Ksummit-2009-discuss] Representing Embedded Architectures at
 the Kernel Summit
Date: Wed, 3 Jun 2009 11:43:44 -0700
Message-ID: <20090603114344.bf852654.akpm@linux-foundation.org>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com>
	<1244034286.24482.84.camel@pc1117.cambridge.arm.com>
	<1244045997.21423.303.camel@mulgrave.site>
	<20090603170925.GA8330@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-embedded-owner@vger.kernel.org>
In-Reply-To: <20090603170925.GA8330@flint.arm.linux.org.uk>
Sender: linux-embedded-owner@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: James.Bottomley@HansenPartnership.com, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org, ksummit-2009-discuss@lists.linux-foundation.org
List-Id: linux-arch.vger.kernel.org

On Wed, 3 Jun 2009 18:09:25 +0100
Russell King <rmk@arm.linux.org.uk> wrote:

> In
> fact, on ARM the DMA mask is exactly that - it's a 100% proper mask.  It's
> not a bunch of zeros in the MSB followed by a bunch of ones down to the
> LSB.  It can be a bunch of ones, a bunch of zeros, followed by a bunch of
> ones.
> 
> The way we occasionally have to deal with this is to trial an allocation,
> see if the physical address fits, if not free the page and try again with
> GFP_DMA set.

A couple of times I've suggested that we have the ability to allocate
one zone per address bit, so a 32-bit machine with 4k pages would end
up having 20 zones.  Then, your funny DMA mask can be directly passed
into the page allocator as a zone mask and voila, I think.

> There's many stories I've heard on what is supposed to take care of the
> coherency that I now just close my ears to the problem and chant "it
> doesn't exist, people aren't seeing it, mainline folk just don't give
> a damn".  Really.  It is a problem on _some_ ARM devices and has been
> for several years now, and I've 100% given up caring about it.

I wasn't even aware that there was an issue here.  Please don't blame
"mainline folk" for something they weren't told about!
