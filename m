From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 00/41] cpu alloc / cpu ops v3: Optimize per cpu access
Date: Fri, 30 May 2008 20:40:34 +0200
Message-ID: <1212172834.24826.22.camel@lappy.programming.kicks-ass.net>
References: <20080530035620.587204923@sgi.com>
	 <1212138752.12349.227.camel@twins> <20080530091847.GA26563@elte.hu>
	 <Pine.LNX.4.64.0805301109120.14564@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:43267 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbYE3SmY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 May 2008 14:42:24 -0400
In-Reply-To: <Pine.LNX.4.64.0805301109120.14564@schroedinger.engr.sgi.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>

On Fri, 2008-05-30 at 11:11 -0700, Christoph Lameter wrote:
> On Fri, 30 May 2008, Ingo Molnar wrote:
> 
> > 
> > * Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > What this does is make a strong connection between data and 
> > > concurrency control. Your proposed scheme weakens the 
> > > data<->concurrency relation instead of making it stronger.
> > 
> > and that's not just an issue for -rt but also for general kernel 
> > maintainability: opaque APIs weaken our data structures because it's not 
> > apparent what is done exactly why. In that sense a 
> > spin_lock(&data->lock) is as clear as it gets.
> 
> The intent of these CPU_OPS is to avoid synchronization by having atomic 
> per cpu ops that do not require preempt or interrupt disable to function 
> properly. F.e. it allows the updating of per cpu statistics without 
> get_cpu/put_cpu or preempt_enable/disable etc etc. This should help -rt 
> quite a bit by avoiding numerous of these things in hot vm paths.

Yes, I get that, but for instance kmem_cache_cpu usage would require
horrible long preempt off sections, hence we add a lock and manage
consistency using that lock instead of strict per-cpu and preempt
disable.
