Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:35733 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752645AbXDKNSQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Apr 2007 09:18:16 -0400
Subject: Re: + expose-range-checking-functions-from-arch-specific.patch
	added to -mm tree
From: Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <20070410194834.b688ce55.akpm@linux-foundation.org>
References: <200704062127.l36LRMA7019394@shell0.pdx.osdl.net>
	 <6632.1176200270@redhat.com>
	 <1176257950.26372.50.camel@localhost.localdomain>
	 <20070410194834.b688ce55.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Wed, 11 Apr 2007 23:17:58 +1000
Message-Id: <1176297479.14322.69.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>, linux-arch@vger.kernel.org, randy.dunlap@oracle.com
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2007-04-10 at 19:48 -0700, Andrew Morton wrote:
> On Wed, 11 Apr 2007 12:19:10 +1000 Rusty Russell <rusty@rustcorp.com.au> wrote:
> > > > + * Like val + len > limit, except with overflow checking.
> > > > + */
> > > > +static inline bool val_outside(unsigned long val, unsigned long len,
> > > > +			       unsigned long limit)
> > > > +
> > > > +{
> > > > +	return val + len > limit || val + len < val;

> I probably shouldn't look at this after a glass of red, but otoh, perhaps
> that's a good way of ensuring that we have a built-in margin.

> I find this function incomprehensible.  I'd just avoid using the sorry
> thing, personally.

No, you're absolutely right.  Naming is vital, and something I criticise
others for regularly.  We don't say "that is incomprehensible" anywhere
near often enough 8(

Is this clearer?

static inline bool range_over_limit(unsigned long start,
				    unsigned long len,
				    unsigned long limit)
{
	return start + len > limit || start + len < start;
}

Cheers,
Rusty.
PS.  Previously this identical function was called __range_ok() (and
returned 0 if it was not ok...)

