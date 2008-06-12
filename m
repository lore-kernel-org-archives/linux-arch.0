From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [patch 04/41] cpu ops: Core piece for generic atomic per cpu operations
Date: Thu, 12 Jun 2008 13:40:28 +1000
Message-ID: <200806121340.29366.nickpiggin@yahoo.com.au>
References: <20080530035620.587204923@sgi.com> <200806121058.02125.nickpiggin@yahoo.com.au> <200806121244.12173.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp112.mail.mud.yahoo.com ([209.191.84.65]:27914 "HELO
	smtp112.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751777AbYFLDkg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Jun 2008 23:40:36 -0400
In-Reply-To: <200806121244.12173.rusty@rustcorp.com.au>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Christoph Lameter <clameter@sgi.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>, Mike Travis <travis@sgi.com>, Martin Peschke <mp3@de.ibm.com>

On Thursday 12 June 2008 12:44, Rusty Russell wrote:
> On Thursday 12 June 2008 10:58:01 Nick Piggin wrote:
> > On Thursday 12 June 2008 09:39, Christoph Lameter wrote:
> > > On Wed, 11 Jun 2008, Rusty Russell wrote:
> > > > > 4. The modeling of local_t on atomic_t limits it to 32bit!
> > > >
> > > > Again wrong.  And adding an exclamation mark doesn't make it true.
> > >
> > > Ewww ... Its atomic_long_t ahh. Ok then there no 32 bit support. What
> > > about pointers?
> >
> > sizeof(long) == sizeof(void *) in Linux, right?
> >
> > If you were to support just a single data type, long would probably
> > be the most useful. Still, it might be more consistent to support
> > int and long, same as atomic.
>
> Sure, but in practice these tend to be simple counters: that could well
> change when dynamic percpu allocs become first class citizens, but let's
> not put the cart before the horse...

Right, I was just responding to Christoph's puzzling question.


> Per-cpu seems to be particularly prone to over-engineering: see commit
> 7ff6f08295d90ab20d25200ef485ebb45b1b8d71 from almost two years ago. 
> Grepping here reveals that this infrastructure is still not used.

Hmm. Something like that needs the question asked "who uses this?"
before it is merged I guess. If it were a trivial patch maybe not,
but something like this that sits untested for so long is almost
broken by definition ;)
