Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:56616 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965044AbXDKCsx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 10 Apr 2007 22:48:53 -0400
Date: Tue, 10 Apr 2007 19:48:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: + expose-range-checking-functions-from-arch-specific.patch
 added to -mm tree
Message-Id: <20070410194834.b688ce55.akpm@linux-foundation.org>
In-Reply-To: <1176257950.26372.50.camel@localhost.localdomain>
References: <200704062127.l36LRMA7019394@shell0.pdx.osdl.net>
	<6632.1176200270@redhat.com>
	<1176257950.26372.50.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: David Howells <dhowells@redhat.com>, linux-arch@vger.kernel.org, randy.dunlap@oracle.com
List-ID: <linux-arch.vger.kernel.org>

On Wed, 11 Apr 2007 12:19:10 +1000 Rusty Russell <rusty@rustcorp.com.au> wrote:

> On Tue, 2007-04-10 at 11:17 +0100, David Howells wrote:
> > akpm@linux-foundation.org wrote:
> > 
> > > + * @limit: the first invalid value
> > 
> > If this is the case, ...
> > 
> > > + *
> > > + * Like val + len > limit, except with overflow checking.
> > > + */
> > > +static inline bool val_outside(unsigned long val, unsigned long len,
> > > +			       unsigned long limit)
> > > +
> > > +{
> > > +	return val + len > limit || val + len < val;
> > 
> > ... then shouldn't that be "val + len >= limit"?
> 
> You're the second one to ask this.  I'm pretty sure it's still right
> (and it's what the old code used to do).
> 
> Consider the case where limit is 0xC0000000, val is 0xBFFFFFFF and len
> is 1.
> 

I probably shouldn't look at this after a glass of red, but otoh, perhaps
that's a good way of ensuring that we have a built-in margin.


I find this function incomprehensible.  I'd just avoid using the sorry
thing, personally.


To me, "val_outside" means "true if the value is outside":

bool val_outside(val, start, len)
{
	return val < start || val > (start+len-1);
}

that's what my function does.  I don't have a clue what yours does.

For starters, wtf is a "limit"?  A length?  Or an offset relative to "len"?
And wtf is "len" anyway?  Absolute?  Relative?

<reworks it>

	return val > (limit - len) || val < (val - len);

nope, that didn't help.



The consequences of people getting this wrong are oopses, memory
corruption, root holes and other such pleasantry, in rare (or deliberately
invoked) circumstances.  Can we try to make it easier for them?

