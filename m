From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch 04/41] cpu ops: Core piece for generic atomic per cpu
 operations
Date: Wed, 11 Jun 2008 16:39:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0806111635350.27184@schroedinger.engr.sgi.com>
References: <20080530035620.587204923@sgi.com> <200806021200.41652.rusty@rustcorp.com.au>
 <Pine.LNX.4.64.0806101034480.17131@schroedinger.engr.sgi.com>
 <200806112110.56805.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:38285 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753526AbYFKXjH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 11 Jun 2008 19:39:07 -0400
In-Reply-To: <200806112110.56805.rusty@rustcorp.com.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>, Mike Travis <travis@sgi.com>

On Wed, 11 Jun 2008, Rusty Russell wrote:

> > 4. The modeling of local_t on atomic_t limits it to 32bit!
> 
> Again wrong.  And adding an exclamation mark doesn't make it true.

Ewww ... Its atomic_long_t ahh. Ok then there no 32 bit support. What about pointers?
