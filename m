From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC patch 08/18] cnt32_to_63 should use smp_rmb()
Date: Fri, 07 Nov 2008 10:01:01 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811070952150.13034@xanadu.home>
References: <20081107003816.9b0f947a.akpm@linux-foundation.org>
 <20081107052336.652868737@polymtl.ca> <20081107053349.861709786@polymtl.ca>
 <20081106220530.5b0e3a96.akpm@linux-foundation.org>
 <alpine.LFD.2.00.0811070256450.13034@xanadu.home> <25363.1226056819@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754304AbYKGPBX@vger.kernel.org>
In-reply-to: <25363.1226056819@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, benh@kernel.crashing.org, paulus@samba.org, David Miller <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, 7 Nov 2008, David Howells wrote:

> Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > As I said in the text which you deleted and ignored, this would be
> > better if it was implemented as a C function which requires that the
> > caller explicitly pass in a reference to the state storage.

The whole purpose of that thing is to be utterly fast and lightweight.  
Having an out of line C call would trash the major advantage of this 
code.

> I'd be quite happy if it was:
> 
> 	static inline u64 cnt32_to_63(u32 cnt_lo, u32 *__m_cnt_hi)
> 	{
> 		union cnt32_to_63 __x;
> 		__x.hi = *__m_cnt_hi;
> 		__x.lo = cnt_lo;
> 		if (unlikely((s32)(__x.hi ^ __x.lo) < 0))
> 			*__m_cnt_hi =
> 				__x.hi = (__x.hi ^ 0x80000000) + (__x.hi >> 31);
> 		return __x.val;
> 	}
> 
> I imagine this would compile pretty much the same as the macro.

Depends.  As everybody has noticed now, the read ordering is important, 
and if gcc decides to not inline this for whatever reason then the 
ordering is lost.  This is why this was a macro to start with.

> I think it
> would make it more obvious about the independence of the storage.

I don't think having the associated storage be outside the macro make 
any sense either.  There is simply no valid reason for having it shared 
between multiple invokations of the macro, as well as making its 
interface more complex for no gain.

> Alternatively, perhaps Nicolas just needs to mention this in the comment more
> clearly.

I wrote that code so to me it is cristal clear already.  Any suggestions 
as to how this could be improved?


Nicolas
