From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [patch 04/41] cpu ops: Core piece for generic atomic per cpu operations
Date: Thu, 12 Jun 2008 10:58:01 +1000
Message-ID: <200806121058.02125.nickpiggin@yahoo.com.au>
References: <20080530035620.587204923@sgi.com> <200806112110.56805.rusty@rustcorp.com.au> <Pine.LNX.4.64.0806111635350.27184@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:44936 "HELO
	smtp108.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751411AbYFLA6M (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Jun 2008 20:58:12 -0400
In-Reply-To: <Pine.LNX.4.64.0806111635350.27184@schroedinger.engr.sgi.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>, Mike Travis <travis@sgi.com>

On Thursday 12 June 2008 09:39, Christoph Lameter wrote:
> On Wed, 11 Jun 2008, Rusty Russell wrote:
> > > 4. The modeling of local_t on atomic_t limits it to 32bit!
> >
> > Again wrong.  And adding an exclamation mark doesn't make it true.
>
> Ewww ... Its atomic_long_t ahh. Ok then there no 32 bit support. What about
> pointers?

sizeof(long) == sizeof(void *) in Linux, right?

If you were to support just a single data type, long would probably
be the most useful. Still, it might be more consistent to support
int and long, same as atomic.
