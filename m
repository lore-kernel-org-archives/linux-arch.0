From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 03/15] Provide atomic_t functions implemented with
 ISO-C++11 atomics
Date: Thu, 19 May 2016 09:45:36 +0200
Message-ID: <20160519074536.GR3193@twins.programming.kicks-ass.net>
References: <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
 <146358425972.8596.7418861336334796772.stgit@warthog.procyon.org.uk>
 <20160518173218.GE3206@twins.programming.kicks-ass.net>
 <1463643409.6885.5.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:38898 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbcESHpq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 May 2016 03:45:46 -0400
Content-Disposition: inline
In-Reply-To: <1463643409.6885.5.camel@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: David Howells <dhowells@redhat.com>, linux-arch@vger.kernel.org, x86@kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, ramana.radhakrishnan@arm.com, paulmck@linux.vnet.ibm.com

On Thu, May 19, 2016 at 08:36:49AM +0100, David Woodhouse wrote:
> On Wed, 2016-05-18 at 19:32 +0200, Peter Zijlstra wrote:
> > 
> > Does this generate 'sane' code for LL/SC archs? That is, a single LL/SC
> > loop and not a loop around an LL/SC cmpxchg.
> 
> The whole point of using compiler intrinsics and letting the compiler
> actually see what's going on... is that it bloody well should :)

Should and does be two different things of course ;-)
