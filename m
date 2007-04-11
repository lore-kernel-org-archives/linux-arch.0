Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:55350 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753540AbXDKSZc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Apr 2007 14:25:32 -0400
Date: Wed, 11 Apr 2007 11:24:52 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: + expose-range-checking-functions-from-arch-specific.patch
 added to -mm tree
Message-Id: <20070411112452.6979414c.akpm@linux-foundation.org>
In-Reply-To: <14926.1176288559@redhat.com>
References: <20070410194834.b688ce55.akpm@linux-foundation.org>
	<200704062127.l36LRMA7019394@shell0.pdx.osdl.net>
	<6632.1176200270@redhat.com>
	<1176257950.26372.50.camel@localhost.localdomain>
	<14926.1176288559@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-arch@vger.kernel.org, randy.dunlap@oracle.com
List-ID: <linux-arch.vger.kernel.org>

On Wed, 11 Apr 2007 11:49:19 +0100
David Howells <dhowells@redhat.com> wrote:

> Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > To me, "val_outside" means "true if the value is outside":
> > 
> > bool val_outside(val, start, len)
> > {
> > 	return val < start || val > (start+len-1);
> > }
> > 
> > that's what my function does.
> 
> Seconded.  Again, I would suggest calling it something like limit_check() or
> range_check().
> 

I suspect we would benefit from a proper suite of tools for comparing a
single number against a range, and for comparing ranges.  As you say, it's
something which we do an awful lot of, and we regularly get it wrong <looks
at a great pile of coverity-derived bugfixes.  It's like using time_after()
instead of open-coding it and then screwing it up.

But considerable thought, review and documentation would need to go into
that.  I'd then spend the next two years buried in cleanup patches <looks
at a great pile of ARRAY_SIZE and ROUND_UP patches>.

However Rusty's patch is merely a modest code consolidation.  And it's a
per-arch thing, which I suspect is inappropriate for a general
compare-a-number-with-a-range toolkit.  So I guess the above is out of
scope.

But I do thing we should continue to pile on about the val_outside() naming
and documentation ;)

Also, as a start on the generic range-checking toolkit I'd suggest that
range_within() should be implemented in linux/range.h, not in
linux/kernel.h.

range_within() isn't terribly well documented.  Does it return true only if
range1 is wholly within range2?  What if the two overlap?  What are the
boundary cases?

And the naming start, len, base, limit is hard to follow.  Wouldn't it be
better to have

bool range_within(unsigned long outer_range_start,
		unsigned long outer_range_len,
		unsigned long inner_range_start,
		unsigned long inner_range_len)

or similar?

then we go on to 

bool range_overlaps(range1_start, range1_len, range2_start, range2_len)
bool range_wholly_less_than(lesser_range_start, lesser_range_len,
			greater_range_start, greater_range_len)

and on and on...

