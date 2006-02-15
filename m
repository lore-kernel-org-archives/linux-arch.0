Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from [194.90.237.34] ([194.90.237.34]:9089 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S1423030AbWBOIIg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Feb 2006 03:08:36 -0500
Date: Wed, 15 Feb 2006 10:10:02 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: [Fwd: Re: [PATCH] madvise MADV_DONTFORK/MADV_DOFORK]
Message-ID: <20060215081002.GB10026@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <43F2C7B6.3020102@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F2C7B6.3020102@yahoo.com.au>
Sender: linux-arch-owner@vger.kernel.org
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Roland Dreier <rdreier@cisco.com>, Hugh Dickins <hugh@veritas.com>
List-ID: <linux-arch.vger.kernel.org>

Quoting r. Nick Piggin <nickpiggin@yahoo.com.au>:
> Subject: [Fwd: Re: [PATCH] madvise MADV_DONTFORK/MADV_DOFORK]
> 
> Forwarding to linux-arch. Please pipe up on lkml, or send patches
> to fix your arch (either way, before 2.6.16!!) if you disagree.

I plan to move them to 9, 10 as Roland suggested.

> To me it would be more logical if the numbering was made densely
> packed on all architectures even if that means MADV_DONTFORK /
> DOFORK aren't consistently numbered throughout (why should they
> get special treatment?).

Making the values identical on all architectures makes it possible
to write a portable application even before distributions update
their headers. Thats important to me.

I assume that the values are different on different architectures
because of legacy/backward compatibility concerns, but I dont see
compelling reasons to mess up new values.
Why is it important to keep the MADV_ numbers densely packed?  We have 32 bit
for these, dont we?

What am I missing?

-- 
Michael S. Tsirkin
Staff Engineer, Mellanox Technologies
