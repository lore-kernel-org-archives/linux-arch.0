Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:10833 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751068AbWBOKAj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Feb 2006 05:00:39 -0500
Message-ID: <43F2E38C.5030602@yahoo.com.au>
Date: Wed, 15 Feb 2006 19:17:16 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: [Fwd: Re: [PATCH] madvise MADV_DONTFORK/MADV_DOFORK]
References: <43F2C7B6.3020102@yahoo.com.au> <20060215081002.GB10026@mellanox.co.il>
In-Reply-To: <20060215081002.GB10026@mellanox.co.il>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Roland Dreier <rdreier@cisco.com>, Hugh Dickins <hugh@veritas.com>
List-ID: <linux-arch.vger.kernel.org>

Michael S. Tsirkin wrote:
> Quoting r. Nick Piggin <nickpiggin@yahoo.com.au>:
> 
>>Subject: [Fwd: Re: [PATCH] madvise MADV_DONTFORK/MADV_DOFORK]
>>
>>Forwarding to linux-arch. Please pipe up on lkml, or send patches
>>to fix your arch (either way, before 2.6.16!!) if you disagree.
> 
> 
> I plan to move them to 9, 10 as Roland suggested.
> 
> 
>>To me it would be more logical if the numbering was made densely
>>packed on all architectures even if that means MADV_DONTFORK /
>>DOFORK aren't consistently numbered throughout (why should they
>>get special treatment?).
> 
> 
> Making the values identical on all architectures makes it possible
> to write a portable application even before distributions update
> their headers. Thats important to me.
> 
> I assume that the values are different on different architectures
> because of legacy/backward compatibility concerns, but I dont see
> compelling reasons to mess up new values.
> Why is it important to keep the MADV_ numbers densely packed?  We have 32 bit
> for these, dont we?
> 
> What am I missing?
> 

All I'm saying is that we can easily wait a few days until arch
maintainers have had a chance to comment (you didn't think you
were missing anything last time, either).

We can afford to be a little bit careful about changing user APIs.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
