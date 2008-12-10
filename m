From: "stephane eranian" <eranian@googlemail.com>
Subject: Re: [patch] Performance Counters for Linux, v2
Date: Wed, 10 Dec 2008 06:03:05 +0100
Message-ID: <7c86c4470812092103geca7df8ge9293de6de3f83ac@mail.gmail.com>
References: <20081208012211.GA23106@elte.hu>
	 <7c86c4470812082237ne58c814s7218cc663f3b49e9@mail.gmail.com>
	 <20081209134636.GA1926@elte.hu>
	 <18750.61143.101922.949701@cargo.ozlabs.ibm.com>
	 <87skoxc6qo.fsf@basil.nowhere.org>
	 <18751.18735.539555.111549@drongo.ozlabs.ibm.com>
Reply-To: eranian@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754784AbYLJFDY@vger.kernel.org>
In-Reply-To: <18751.18735.539555.111549@drongo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
Cc: Andi Kleen <andi@firstfloor.org>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet <dada1@cosmosbay.com>, Robert Richter <robert.richter@amd.com>, Arjan van de Veen <arjan@infradead.org>, Peter Anvin <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, David Miller <davem@davemloft.net>, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
List-Id: linux-arch.vger.kernel.org

Paul,

On Wed, Dec 10, 2008 at 5:44 AM, Paul Mackerras <paulus@samba.org> wrote:
> Andi Kleen writes:
>
>> When you say counting you should also include "event ring buffers with
>> metadata", like PEBS on Intel x86.
>
> I'm not familiar with PEBS.  Maybe it's something different again,
> neither sampling nor counting, but a third thing?
>
PEBS is an Intel only feature used for sampling. However, this time
the hardware (and microcode) does the sampling for you. You point
the CPU to a structure in memory, called DS, which then points to
a region of memory you can designate, i.e., the sampling buffer.
Buffer can be any size you want.

Then you program counter0 when an event and a sampling period.
When the counter overflows, there is no interrupt, the microcode
records the RIP and full machine state, and reloads the counter with
the period specified in DS. The OS gets an interrupt ONLY when the
buffer fills up. Overhead is thus minimized, but you have no control
over the format of the samples. The precision (P) comes from the fact
that the RIP is guaranteed to point the an instruction that is just after
an instruction which generated the event you're sampling on. The catch
is that no all events support PEBS, and only one counter works with PEBS
on Core 2. Nehalem is better, more events support PEBS, all 4 generic
counters do support PEBS. Furthermore,PEBS can now capture where
cache misses occur, very much like what Itanium can do.

Needless to say all of this is supported by perfmon.

Hope this helps.
