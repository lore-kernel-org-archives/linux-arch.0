From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [patch 04/41] cpu ops: Core piece for generic atomic per cpu operations
Date: Thu, 12 Jun 2008 21:21:09 +1000
Message-ID: <200806122121.09835.nickpiggin@yahoo.com.au>
References: <20080530035620.587204923@sgi.com> <200806121340.29366.nickpiggin@yahoo.com.au> <1213263470.25502.6.camel@kitka.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:22462 "HELO
	smtp105.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751709AbYFLLVR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 12 Jun 2008 07:21:17 -0400
In-Reply-To: <1213263470.25502.6.camel@kitka.ibm.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Martin Peschke <mp3@de.ibm.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Christoph Lameter <clameter@sgi.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>, Mike Travis <travis@sgi.com>

On Thursday 12 June 2008 19:37, Martin Peschke wrote:
> On Thu, 2008-06-12 at 13:40 +1000, Nick Piggin wrote:
> > On Thursday 12 June 2008 12:44, Rusty Russell wrote:

> > > Per-cpu seems to be particularly prone to over-engineering: see commit
> > > 7ff6f08295d90ab20d25200ef485ebb45b1b8d71 from almost two years ago.
> > > Grepping here reveals that this infrastructure is still not used.
> >
> > Hmm. Something like that needs the question asked "who uses this?"
> > before it is merged I guess. If it were a trivial patch maybe not,
> > but something like this that sits untested for so long is almost
> > broken by definition ;)
>
> Some code of mine which didn't make it beyond -mm used this small
> per-cpu extension. So the commit you refer to was tested.

Right, but it can easily rot after initial testing if it isn't
continually used.

Maybe this isn't the best example because maybe it still works
fine. But in general, unused, non-trivial code isn't good just
to leave around "just in case" IMO.
