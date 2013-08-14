From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC][PATCH 0/5] preempt_count rework
Date: Wed, 14 Aug 2013 09:48:27 -0700
Message-ID: <20130814164827.GN23412@tassilo.jf.intel.com>
References: <20130814131539.790947874@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130814131539.790947874@chello.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Peter Anvin <hpa@zytor.com>, Mike Galbraith <bitbucket@online.de>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Aug 14, 2013 at 03:15:39PM +0200, Peter Zijlstra wrote:
> These patches optimize preempt_enable by firstly folding the preempt and
> need_resched tests into one -- this should work for all architectures. And
> secondly by providing per-arch preempt_count implementations; with x86 using
> per-cpu preempt_count for fastest access.
> 
> These patches have so far only been compiled for defconfig-x86_64 +
> CONFIG_PREEMPT=y and boot tested with kvm -smp 4 upto wanting to mount root.
> 
> It still needs asm volatile("call preempt_schedule": : :"memory"); as per
> Andi's other patches to avoid the C calling convention cluttering the
> preempt_enable() sites.

FWIW I removed the user_schedule in v2 because I don't need it anymore.
Feel free to pick it up from v1 though.

It needs two patches: the one adding SAVE_ALL for 32bit and
the parts of the put_user() patch adding user_schedule

When it's not used in user_ anymore it should probably 
be renamed too, to preempt_schedule or somesuch,
and probably moved to a different file.

-Andi
