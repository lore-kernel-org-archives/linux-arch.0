Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:57379 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161435AbXDKX2w (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Apr 2007 19:28:52 -0400
Subject: Re: + expose-range-checking-functions-from-arch-specific.patch
	added to -mm tree
From: Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <20070411112452.6979414c.akpm@linux-foundation.org>
References: <20070410194834.b688ce55.akpm@linux-foundation.org>
	 <200704062127.l36LRMA7019394@shell0.pdx.osdl.net>
	 <6632.1176200270@redhat.com>
	 <1176257950.26372.50.camel@localhost.localdomain>
	 <14926.1176288559@redhat.com>
	 <20070411112452.6979414c.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Thu, 12 Apr 2007 09:28:33 +1000
Message-Id: <1176334113.14322.130.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>, linux-arch@vger.kernel.org, randy.dunlap@oracle.com
List-ID: <linux-arch.vger.kernel.org>

On Wed, 2007-04-11 at 11:24 -0700, Andrew Morton wrote:
> Also, as a start on the generic range-checking toolkit I'd suggest that
> range_within() should be implemented in linux/range.h, not in
> linux/kernel.h.
> 
> range_within() isn't terribly well documented.  Does it return true only if
> range1 is wholly within range2?  What if the two overlap?  What are the
> boundary cases?

Actually, I think it's brilliantly documented.  Defining base as the
first valid value and limit as the first invalid value makes it pretty
clear, IMHO.

Anyway, I just want range_under_limit(start, len, limit).  Beyond that
gets confusing.  See below.

> bool range_within(unsigned long outer_range_start,
> 		unsigned long outer_range_len,
> 		unsigned long inner_range_start,
> 		unsigned long inner_range_len)

This *is* nicer, because noone will get confused about whether limit is
inclusive or exclusive.  I think the outer and inner arg order should be
swapped.

> bool range_overlaps(range1_start, range1_len, range2_start, range2_len)

I assume this means "range1 intersects range2"?

> bool range_wholly_less_than(lesser_range_start, lesser_range_len,
> 			greater_range_start, greater_range_len)

This means "lesser range does not intersect greater range, and is closer
to 0"?

In which case, the greater_range_len seems redundant, but isn't (because
greater_range_len could make the range wrap)?

Erk,
Rusty.

