Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: Changing  update_mmu_cache()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20050222090741.B16786@flint.arm.linux.org.uk>
References: <1109047997.5327.70.camel@gaston>
	 <20050222090741.B16786@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Wed, 23 Feb 2005 07:51:36 +1100
Message-Id: <1109105496.5327.124.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Arch list <linux-arch@vger.kernel.org>, "David S. Miller" <davem@redhat.com>
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2005-02-22 at 09:07 +0000, Russell King wrote:
> On Tue, Feb 22, 2005 at 03:53:17PM +1100, Benjamin Herrenschmidt wrote:
> > Is that ok with everybody ?
> 
> On the grounds that I can't get my MM changes past Linus which I need
> for newer ARM CPUs, so I don't see why this change which adds extra code
> (which is the complaint against my changes) should be considered.
> 
> Sorry if I'm getting cranky in my old age.

You are, since it's not adding extra code, just moving a function around
and changing the parameters :) Ok well, the extra parameter may be extra
code if you don't inline ... bugger... ;)

Ben.
