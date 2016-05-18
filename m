From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 00/15] Provide atomics and bitops implemented with
 ISO C++11 atomics
Date: Wed, 18 May 2016 19:22:58 +0200
Message-ID: <20160518172258.GB3206@twins.programming.kicks-ass.net>
References: <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:38386 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753069AbcERRXF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 18 May 2016 13:23:05 -0400
Content-Disposition: inline
In-Reply-To: <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, ramana.radhakrishnan@arm.com, paulmck@linux.vnet.ibm.com, dwmw2@infradead.org

On Wed, May 18, 2016 at 04:10:37PM +0100, David Howells wrote:
> There are some advantages to using ISO C++11 atomics:
> 
>  (1) The compiler can make use of extra information, such as condition
>      flags, that are tricky to get out of inline assembly in an efficient
>      manner.  This should reduce the number of instructions required in
>      some cases - such as in x86 where we use SETcc to store the condition
>      inside the inline asm and then CMP outside to put it back again.
> 
>      Whilst this can be alleviated by the use of asm-goto constructs, this
>      adds mandatory conditional jumps where the use of CMOVcc and SETcc
>      might be better.

Supposedly gcc-6.1 has cc-output which makes this go away.
