Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:30122 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751037AbWBOKxv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Feb 2006 05:53:51 -0500
Message-ID: <43F2EB15.5080402@yahoo.com.au>
Date: Wed, 15 Feb 2006 19:49:25 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: [Fwd: Re: [PATCH] madvise MADV_DONTFORK/MADV_DOFORK]
References: <43F2C7B6.3020102@yahoo.com.au> <20060215081002.GB10026@mellanox.co.il> <43F2E38C.5030602@yahoo.com.au>
In-Reply-To: <43F2E38C.5030602@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Roland Dreier <rdreier@cisco.com>, Hugh Dickins <hugh@veritas.com>
List-ID: <linux-arch.vger.kernel.org>

Nick Piggin wrote:

> All I'm saying is that we can easily wait a few days until arch
> maintainers have had a chance to comment (you didn't think you
> were missing anything last time, either).
> 
> We can afford to be a little bit careful about changing user APIs.
> 

If it is a good idea to keep the common MADV_ parameters in synch
over all architectures, why not make 0x00 - 0xff the legacy space,
then 0x100 - 0xfff can be for arch specific parameters, and
0x1000 - ... can be for common/generic parameters?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
