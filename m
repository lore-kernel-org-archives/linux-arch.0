Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:60005 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754292Ab2JEVpL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 5 Oct 2012 17:45:11 -0400
Date: Fri, 05 Oct 2012 17:45:08 -0400 (EDT)
Message-ID: <20121005.174508.1624534294642226949.davem@davemloft.net>
Subject: Re: [PATCH v2 0/8] THP support for Sparc64
From: David Miller <davem@davemloft.net>
In-Reply-To: <20121005143644.abb14c2b.akpm@linux-foundation.org>
References: <20121004.154624.923241475790311926.davem@davemloft.net>
	<20121005143644.abb14c2b.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, aarcange@redhat.com, hannes@cmpxchg.org, mingo@elte.hu, a.p.zijlstra@chello.nl, torvalds@linux-foundation.org
Message-ID: <20121005214508.a2hatBJcjajoAMjpbE_egoKrfMujRt40BZ1qg0EkZVw@z>

From: Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 5 Oct 2012 14:36:44 -0700

> David, I don't know what to do until there's some clarity on the
> numa/sched changes.  Andrea has a new autonuma patchset, Peter's code
> is in -next and I don't know if it's planned for 3.7 merging.  And I
> suspect (hope) that it won't be merged if that is indeed planned.

It doesn't matter from a sparc64 perspective.

If you remove the autonuma patch, I'll still compile and work.
I just provide an unused interface. 

Please do something instead of stalling these changes further.

Thanks.
