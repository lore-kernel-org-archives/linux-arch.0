Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 22 Feb 2005 09:07:41 +0000
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Changing  update_mmu_cache()
Message-ID: <20050222090741.B16786@flint.arm.linux.org.uk>
References: <1109047997.5327.70.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109047997.5327.70.camel@gaston>; from benh@kernel.crashing.org on Tue, Feb 22, 2005 at 03:53:17PM +1100
Sender: Russell King <rmk@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Arch list <linux-arch@vger.kernel.org>, "David S. Miller" <davem@redhat.com>
List-ID: <linux-arch.vger.kernel.org>

On Tue, Feb 22, 2005 at 03:53:17PM +1100, Benjamin Herrenschmidt wrote:
> Is that ok with everybody ?

On the grounds that I can't get my MM changes past Linus which I need
for newer ARM CPUs, so I don't see why this change which adds extra code
(which is the complaint against my changes) should be considered.

Sorry if I'm getting cranky in my old age.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
