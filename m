Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 17 Mar 2005 21:33:33 +0000
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Consolidation of asm/unaligned.h
Message-ID: <20050317213333.C15653@flint.arm.linux.org.uk>
References: <20050317104744.4be7e550.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050317104744.4be7e550.davem@davemloft.net>; from davem@davemloft.net on Thu, Mar 17, 2005 at 10:47:44AM -0800
Sender: Russell King <rmk@arm.linux.org.uk>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Mar 17, 2005 at 10:47:44AM -0800, David S. Miller wrote:
> 1) ARM is trying to be incredibly clever, and open codes the shifts
>    and ors.  I think it would be better if it used something similar
>    to the packed structure technique.

I agree with your sentiment, though I'd like to compare the produced
code to ensure that there isn't something unexpected somewhere.

Thanks Dave, this looks interesting.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
