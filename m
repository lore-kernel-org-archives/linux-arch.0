From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 00/15] Provide atomics and bitops implemented with
 ISO C++11 atomics
Date: Wed, 18 May 2016 19:45:06 +0200
Message-ID: <20160518174506.GH3206@twins.programming.kicks-ass.net>
References: <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:38419 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932340AbcERRpN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 18 May 2016 13:45:13 -0400
Content-Disposition: inline
In-Reply-To: <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, ramana.radhakrishnan@arm.com, paulmck@linux.vnet.ibm.com, dwmw2@infradead.org

On Wed, May 18, 2016 at 04:10:37PM +0100, David Howells wrote:
>  (3) I've added cmpxchg_return() and try_cmpxchg() to replace cmpxchg().
>      I've also provided atomicX_t variants of these.  These return the
>      boolean return value from the __atomic_compare_exchange_n() function
>      (which is carried in the Z flag on x86).  Should this be rolled out
>      even without the ISO atomic implementation?

I suppose we could, esp. with GCC-6.1 having cc-output using the Z flag
should result in nicer code.
