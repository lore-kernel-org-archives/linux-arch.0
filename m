Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 22 Feb 2005 10:08:58 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: Changing  update_mmu_cache()
Message-Id: <20050222100858.27d05a86.davem@davemloft.net>
In-Reply-To: <20050222090741.B16786@flint.arm.linux.org.uk>
References: <1109047997.5327.70.camel@gaston>
	<20050222090741.B16786@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Russell King <rmk@arm.linux.org.uk>
Cc: benh@kernel.crashing.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 22 Feb 2005 09:07:41 +0000
Russell King <rmk@arm.linux.org.uk> wrote:

> On Tue, Feb 22, 2005 at 03:53:17PM +1100, Benjamin Herrenschmidt wrote:
> > Is that ok with everybody ?
> 
> On the grounds that I can't get my MM changes past Linus which I need
> for newer ARM CPUs, so I don't see why this change which adds extra code
> (which is the complaint against my changes) should be considered.

It doesn't add extra code:

1) the pte gets deref'd currently anyways
2) platforms not using the pte pointer arg will simply get that
   argument optimized away

Russell, send me what you're having trouble merging under seperate
cover and I'll give you a hand, from one old man to another :-)
