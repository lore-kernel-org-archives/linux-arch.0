Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from [194.90.237.34] ([194.90.237.34]:44607 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S1945909AbWBOMLc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Feb 2006 07:11:32 -0500
Date: Wed, 15 Feb 2006 14:12:58 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: [Fwd: Re: [PATCH] madvise MADV_DONTFORK/MADV_DOFORK]
Message-ID: <20060215121258.GQ12974@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <43F2C7B6.3020102@yahoo.com.au> <20060215081002.GB10026@mellanox.co.il> <43F2E38C.5030602@yahoo.com.au> <43F2EB15.5080402@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F2EB15.5080402@yahoo.com.au>
Sender: linux-arch-owner@vger.kernel.org
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Roland Dreier <rdreier@cisco.com>, Hugh Dickins <hugh@veritas.com>
List-ID: <linux-arch.vger.kernel.org>

Quoting r. Nick Piggin <nickpiggin@yahoo.com.au>:
> Subject: Re: [Fwd: Re: [PATCH] madvise MADV_DONTFORK/MADV_DOFORK]
> 
> Nick Piggin wrote:
> 
> >All I'm saying is that we can easily wait a few days until arch
> >maintainers have had a chance to comment (you didn't think you
> >were missing anything last time, either).
> >
> >We can afford to be a little bit careful about changing user APIs.
> >
> 
> If it is a good idea to keep the common MADV_ parameters in synch
> over all architectures, why not make 0x00 - 0xff the legacy space,
> then 0x100 - 0xfff can be for arch specific parameters, and
> 0x1000 - ... can be for common/generic parameters?

Sounds good to me.
How about we change MADV_REMOVE to fall in this range too, then?

-- 
Michael S. Tsirkin
Staff Engineer, Mellanox Technologies
