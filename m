From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 03/15] Provide atomic_t functions implemented with
 ISO-C++11 atomics
Date: Thu, 19 May 2016 13:33:29 +0200
Message-ID: <20160519113329.GM3205@twins.programming.kicks-ass.net>
References: <20160518173218.GE3206@twins.programming.kicks-ass.net>
 <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
 <146358425972.8596.7418861336334796772.stgit@warthog.procyon.org.uk>
 <10546.1463651539@warthog.procyon.org.uk>
 <20160519105000.GV3193@twins.programming.kicks-ass.net>
 <20160519113116.GL3205@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:39050 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754231AbcESLdh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 May 2016 07:33:37 -0400
Content-Disposition: inline
In-Reply-To: <20160519113116.GL3205@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, ramana.radhakrishnan@arm.com, paulmck@linux.vnet.ibm.com, dwmw2@infradead.org

On Thu, May 19, 2016 at 01:31:16PM +0200, Peter Zijlstra wrote:
> Where the __special_marker__ marks the whole { } scope as being the
> inside of LL/SC and all variables must be in registers before we start.
> If the compiler is not able to guarantee this, it must generate a
> compile time error etc..

And note that all LL/SC archs I've checked have very similar constraints
on what can go inside them. And simply taking the most constrained
across the board will work fine.
