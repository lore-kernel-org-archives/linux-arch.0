Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 17 Mar 2005 13:51:37 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: Consolidation of asm/unaligned.h
Message-Id: <20050317135137.4ee5eaca.davem@davemloft.net>
In-Reply-To: <20050317213333.C15653@flint.arm.linux.org.uk>
References: <20050317104744.4be7e550.davem@davemloft.net>
	<20050317213333.C15653@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 17 Mar 2005 21:33:33 +0000
Russell King <rmk@arm.linux.org.uk> wrote:

> I agree with your sentiment, though I'd like to compare the produced
> code to ensure that there isn't something unexpected somewhere.
> 
> Thanks Dave, this looks interesting.

No problem.  I didn't convert ARM, so you can just do so when you
have determined that such a change is appropriate.
