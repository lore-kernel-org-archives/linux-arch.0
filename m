From: Martin Peschke <mp3@de.ibm.com>
Subject: Re: [patch 04/41] cpu ops: Core piece for generic atomic per cpu
	operations
Date: Thu, 12 Jun 2008 11:37:49 +0200
Message-ID: <1213263470.25502.6.camel@kitka.ibm.com>
References: <20080530035620.587204923@sgi.com>
	 <200806121058.02125.nickpiggin@yahoo.com.au>
	 <200806121244.12173.rusty@rustcorp.com.au>
	 <200806121340.29366.nickpiggin@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:61355 "EHLO
	mtagate3.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192AbYFLJiG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 12 Jun 2008 05:38:06 -0400
In-Reply-To: <200806121340.29366.nickpiggin@yahoo.com.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Christoph Lameter <clameter@sgi.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>, Mike Travis <travis@sgi.com>

On Thu, 2008-06-12 at 13:40 +1000, Nick Piggin wrote:
> On Thursday 12 June 2008 12:44, Rusty Russell wrote:
> > On Thursday 12 June 2008 10:58:01 Nick Piggin wrote:
> > > On Thursday 12 June 2008 09:39, Christoph Lameter wrote:
> > > > On Wed, 11 Jun 2008, Rusty Russell wrote:
> > > > > > 4. The modeling of local_t on atomic_t limits it to 32bit!
> > > > >
> > > > > Again wrong.  And adding an exclamation mark doesn't make it true.
> > > >
> > > > Ewww ... Its atomic_long_t ahh. Ok then there no 32 bit support. What
> > > > about pointers?
> > >
> > > sizeof(long) == sizeof(void *) in Linux, right?
> > >
> > > If you were to support just a single data type, long would probably
> > > be the most useful. Still, it might be more consistent to support
> > > int and long, same as atomic.
> >
> > Sure, but in practice these tend to be simple counters: that could well
> > change when dynamic percpu allocs become first class citizens, but let's
> > not put the cart before the horse...
> 
> Right, I was just responding to Christoph's puzzling question.
> 
> 
> > Per-cpu seems to be particularly prone to over-engineering: see commit
> > 7ff6f08295d90ab20d25200ef485ebb45b1b8d71 from almost two years ago. 
> > Grepping here reveals that this infrastructure is still not used.
> 
> Hmm. Something like that needs the question asked "who uses this?"
> before it is merged I guess. If it were a trivial patch maybe not,
> but something like this that sits untested for so long is almost
> broken by definition ;)

Some code of mine which didn't make it beyond -mm used this small
per-cpu extension. So the commit you refer to was tested.
