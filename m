Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:15511 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751174AbWBORzq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Feb 2006 12:55:46 -0500
Message-ID: <43F31F27.6070908@yahoo.com.au>
Date: Wed, 15 Feb 2006 23:31:35 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: [Fwd: Re: [PATCH] madvise MADV_DONTFORK/MADV_DOFORK]
References: <43F2C7B6.3020102@yahoo.com.au> <20060215081002.GB10026@mellanox.co.il> <43F2E38C.5030602@yahoo.com.au> <20060215101837.GE21003@flint.arm.linux.org.uk>
In-Reply-To: <20060215101837.GE21003@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Roland Dreier <rdreier@cisco.com>, Hugh Dickins <hugh@veritas.com>
List-ID: <linux-arch.vger.kernel.org>

Russell King wrote:
> On Wed, Feb 15, 2006 at 07:17:16PM +1100, Nick Piggin wrote:
> 
>>All I'm saying is that we can easily wait a few days until arch
>>maintainers have had a chance to comment (you didn't think you
>>were missing anything last time, either).
>>
>>We can afford to be a little bit careful about changing user APIs.
> 
> 
> The new numbers only appeared very recently for ARM (iow, came in
> with this mornings git update), so changing them sooner rather than
> later would be preferred - cuts down the number of potential kernel
> patches/tarballs which have the "wrong" numbers.
> 

I just mean, to get an agreement (or at least nobody complaining)
before renumbering it again.

I don't think it should be too much of a problem unless it hits 2.6.16
(2.6.16-rc4 would be undesirable too I guess).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
