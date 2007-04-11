Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:48051 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161142AbXDKCTN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 10 Apr 2007 22:19:13 -0400
Subject: Re: + expose-range-checking-functions-from-arch-specific.patch
	added to -mm tree
From: Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <6632.1176200270@redhat.com>
References: <200704062127.l36LRMA7019394@shell0.pdx.osdl.net>
	 <6632.1176200270@redhat.com>
Content-Type: text/plain
Date: Wed, 11 Apr 2007 12:19:10 +1000
Message-Id: <1176257950.26372.50.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: akpm@linux-foundation.org, mm-commits@vger.kernel.org, linux-arch@vger.kernel.org, randy.dunlap@oracle.com
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2007-04-10 at 11:17 +0100, David Howells wrote:
> akpm@linux-foundation.org wrote:
> 
> > + * @limit: the first invalid value
> 
> If this is the case, ...
> 
> > + *
> > + * Like val + len > limit, except with overflow checking.
> > + */
> > +static inline bool val_outside(unsigned long val, unsigned long len,
> > +			       unsigned long limit)
> > +
> > +{
> > +	return val + len > limit || val + len < val;
> 
> ... then shouldn't that be "val + len >= limit"?

You're the second one to ask this.  I'm pretty sure it's still right
(and it's what the old code used to do).

Consider the case where limit is 0xC0000000, val is 0xBFFFFFFF and len
is 1.

Hope that helps,
Rusty.

