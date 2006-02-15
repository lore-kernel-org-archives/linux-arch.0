Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:42760 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751037AbWBOKSv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Feb 2006 05:18:51 -0500
Date: Wed, 15 Feb 2006 10:18:38 +0000
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [Fwd: Re: [PATCH] madvise MADV_DONTFORK/MADV_DOFORK]
Message-ID: <20060215101837.GE21003@flint.arm.linux.org.uk>
References: <43F2C7B6.3020102@yahoo.com.au> <20060215081002.GB10026@mellanox.co.il> <43F2E38C.5030602@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F2E38C.5030602@yahoo.com.au>
Sender: linux-arch-owner@vger.kernel.org
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Roland Dreier <rdreier@cisco.com>, Hugh Dickins <hugh@veritas.com>
List-ID: <linux-arch.vger.kernel.org>

On Wed, Feb 15, 2006 at 07:17:16PM +1100, Nick Piggin wrote:
> All I'm saying is that we can easily wait a few days until arch
> maintainers have had a chance to comment (you didn't think you
> were missing anything last time, either).
> 
> We can afford to be a little bit careful about changing user APIs.

The new numbers only appeared very recently for ARM (iow, came in
with this mornings git update), so changing them sooner rather than
later would be preferred - cuts down the number of potential kernel
patches/tarballs which have the "wrong" numbers.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
