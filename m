Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sun, 27 Feb 2005 19:27:20 +0000
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Changing  update_mmu_cache()
Message-ID: <20050227192720.B5471@flint.arm.linux.org.uk>
References: <1109047997.5327.70.camel@gaston> <20050222090741.B16786@flint.arm.linux.org.uk> <20050222100858.27d05a86.davem@davemloft.net> <20050225201538.B27842@flint.arm.linux.org.uk> <20050225170905.4d98d934.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050225170905.4d98d934.davem@davemloft.net>; from davem@davemloft.net on Fri, Feb 25, 2005 at 05:09:05PM -0800
Sender: Russell King <rmk@arm.linux.org.uk>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, Feb 25, 2005 at 05:09:05PM -0800, David S. Miller wrote:
> On Fri, 25 Feb 2005 20:15:38 +0000
> Russell King <rmk@arm.linux.org.uk> wrote:
> > The item I was referring to was my flush_cache_page() changes from
> > January 11th (attached), posted to both linux-arch and lkml, and
> > previous to that in November some time, along with Linus' reply,
> > and my somewhat later reply.
> 
> Awesome, thanks.

Thanks David - I appreciate your help with this.  I owe you something
for this... beer?

> I'll push this off to Linus when 2.6.12 opens up.  If folks could
> build test this against current 2.6.x and report any failures that
> need fixing, I would appreciate that.

Once this is in, I can follow it up with the ARM-arch changes for the
VIPT caches on ARMv6.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
