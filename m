From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch 00/41] cpu alloc / cpu ops v3: Optimize per cpu access
Date: Fri, 30 May 2008 11:11:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0805301109120.14564@schroedinger.engr.sgi.com>
References: <20080530035620.587204923@sgi.com> <1212138752.12349.227.camel@twins>
 <20080530091847.GA26563@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from relay1.sgi.com ([192.48.171.29]:46283 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752576AbYE3SLF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 May 2008 14:11:05 -0400
In-Reply-To: <20080530091847.GA26563@elte.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zijlstra <peterz@infradead.org>, akpm@linux-foundation.org, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>

On Fri, 30 May 2008, Ingo Molnar wrote:

> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > What this does is make a strong connection between data and 
> > concurrency control. Your proposed scheme weakens the 
> > data<->concurrency relation instead of making it stronger.
> 
> and that's not just an issue for -rt but also for general kernel 
> maintainability: opaque APIs weaken our data structures because it's not 
> apparent what is done exactly why. In that sense a 
> spin_lock(&data->lock) is as clear as it gets.

The intent of these CPU_OPS is to avoid synchronization by having atomic 
per cpu ops that do not require preempt or interrupt disable to function 
properly. F.e. it allows the updating of per cpu statistics without 
get_cpu/put_cpu or preempt_enable/disable etc etc. This should help -rt 
quite a bit by avoiding numerous of these things in hot vm paths.
