Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-4-out.sgi.com ([192.48.171.29]:60295 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030302AbXDTQKe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 20 Apr 2007 12:10:34 -0400
Date: Fri, 20 Apr 2007 09:10:32 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
Subject: Re: Better local_t implementation needed
In-Reply-To: <200704201256.13008.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0704200903130.20232@schroedinger.engr.sgi.com>
References: <200704201256.13008.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 20 Apr 2007, Andi Kleen wrote:

> This is unfortunate because if one wants to use local_t for 
> per CPU counters it will be a full atomic operation which is probably
> slow at least on all architectures that support MP.

Right.

> Using local_t for per cpu counters is nice because then
> one can use cpu_local_add() etc. and that generates very good 
> code at least on x86 and a few other architectures. That would
> then allow very cheap per CPU statistics, which are useful
> in a number of subsystems (like networking or MM code)

Is the per cpu access fixed on x86? Last I checked it was not atomic.

i.e. inc(per_cpu_var) would

1. Calculate the per_cpu_var address by determining the processor id
   and then the address.

2. Increment that address.

This would mean that preemption needs to be disabled otherwise we can
get into trouble between 1 and 2.

What should be happening is that per_cpu_var does not require the use
of processor id but simply increments an address. Thus no preemption 
problems and less code.

I vaguely recall that there were issues with a segment register and the 
linker?

> e.g. on x86 with some of the pending per cpu patches we could
> in the end implement cpu_local_add as a single non atomic instruction.
> This would compare very favourably to the complicated
> code sequences that right now are generated for some of the
> statistics counters.

Right. I'd like to see that.
 
> There used to be a portable implementation of local.h 
> that instead defines local_t as a two value array 
> indexed by in_interrupt(). I'm considering to add that back.

Uhhh.... Yuck.

> Drawback will be larger code. 

Fix the per cpu area access instead?

> Comments?

Right now local_t is in many areas to complicated to handle and generates 
bad code. Fixing the per cpu area acces on x86_64 etc would make some 
progress here. I also do not think that atomic operations are that big an 
issue. We are writing a cacheline in any scenario which requires exclusive 
owernership. That is the major cost.

