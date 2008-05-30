From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch 05/41] cpu alloc: Percpu_counter conversion
Date: Fri, 30 May 2008 10:54:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0805301051530.14564@schroedinger.engr.sgi.com>
References: <20080530035620.587204923@sgi.com> <20080530040012.011711936@sgi.com>
 <200805301647.36198.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:32908 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752111AbYE3RyC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 May 2008 13:54:02 -0400
In-Reply-To: <200805301647.36198.rusty@rustcorp.com.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>, Mike Travis <travis@sgi.com>

On Fri, 30 May 2008, Rusty Russell wrote:

> On Friday 30 May 2008 13:56:25 Christoph Lameter wrote:
> > Use cpu_alloc instead of allocpercpu.
> 
> These patches seem like useless churn.
> 
> Plus, the new code is uglier than the old code :(

It drastically reduces the memory size f.e. 4 byte allocations require 
SLAB f.e. to allocate a 32 byte chunk. This reduces memory requirements by
32/4 = 8 times.

Plus the per cpu counters allocated in order are likely placed in the same 
cacheline (whereas the slab allocators avoid placing multiple objects in 
the same cacheline). Reduces cache footprint.
