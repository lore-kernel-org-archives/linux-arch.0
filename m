From: David Miller <davem@davemloft.net>
Subject: Re: perf_arch_fetch_caller_regs...
Date: Thu, 18 Mar 2010 21:47:04 -0700 (PDT)
Message-ID: <20100318.214704.116395963.davem@davemloft.net>
References: <20100318.210241.179917441.davem@davemloft.net>
	<20100319042414.GA23574@nowhere>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:45521
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751087Ab0CSEqm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 19 Mar 2010 00:46:42 -0400
In-Reply-To: <20100319042414.GA23574@nowhere>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: fweisbec@gmail.com
Cc: mingo@elte.hu, paulus@samba.org, linux-arch@vger.kernel.org

From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Fri, 19 Mar 2010 05:24:16 +0100

> On Thu, Mar 18, 2010 at 09:02:41PM -0700, David Miller wrote:
>> 
>> Can we please remove the CALLER_ADDR0 et al. evaluations at the top
>> level in perf_fetch_caller_regs()?
>> 
>> I take great pains to avoid having to flush the register windows on
>> sparc64 even when fetching callchains et al and any
>> __builtin_return_address() with an argument greater than zero is going
>> to force a register window flush to get emitted by gcc undoing all of
>> my hard work :-)
> 
> 
> Ah. But does that really cause bad things? I mean you don't need
> to save all the ix/ox/lx registers, only the instruction pointer,
> frame pointer, flags, and something that can help user_mode() to
> return 0.
> 
> I don't know deeply this area, but the frame pointer is
> part of the window in the ix things, right? And the CALLER
> thing screws up the frame pointer and makes it hard to rewind
> precisely?

It causes bad things, as in performance is rediculiously bad if
GCC emits that register window flush.  That's the whole point of
my mail, it undoes all of the hard work I do to avoid the register
window flushes.

I fix the performance problems by doing it by hand, walking up the
unflushed register windows and storing only the frame pointer and
return PC into the stack frame.

> Yeah, ok if this is that a burden/useless for archs then I'm going to
> remove it.

Thanks.
