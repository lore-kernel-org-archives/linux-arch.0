Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from [194.90.237.34] ([194.90.237.34]:52940 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S1751025AbWBOKTZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Feb 2006 05:19:25 -0500
Date: Wed, 15 Feb 2006 12:20:52 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: [Fwd: Re: [PATCH] madvise MADV_DONTFORK/MADV_DOFORK]
Message-ID: <20060215102052.GK12974@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <43F2C7B6.3020102@yahoo.com.au> <20060215081002.GB10026@mellanox.co.il> <43F2E38C.5030602@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F2E38C.5030602@yahoo.com.au>
Sender: linux-arch-owner@vger.kernel.org
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Roland Dreier <rdreier@cisco.com>, Hugh Dickins <hugh@veritas.com>
List-ID: <linux-arch.vger.kernel.org>

Quoting Nick Piggin <nickpiggin@yahoo.com.au>:
> All I'm saying is that we can easily wait a few days until arch
> maintainers have had a chance to comment (you didn't think you
> were missing anything last time, either).
> 
> We can afford to be a little bit careful about changing user APIs.

I agree. Most people dont seem to notice stuff until its in -mm, so it makes
sense for this code to stay in -mm for a few days.

Thanks,

-- 
Michael S. Tsirkin
Staff Engineer, Mellanox Technologies
