From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] locking/pvqspinlock: Optionally store lock holder
 cpu into lock
Date: Mon, 13 Jul 2020 11:21:35 +0200
Message-ID: <20200713092135.GC10769@hirez.programming.kicks-ass.net>
References: <20200711182128.29130-1-longman@redhat.com>
 <20200711182128.29130-3-longman@redhat.com>
 <20200712173452.GB10769@hirez.programming.kicks-ass.net>
 <bed22603-e347-8bff-f586-072a18987946@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bed22603-e347-8bff-f586-072a18987946@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, Davidlohr Bueso <dave@stgolabs.net>
List-Id: linux-arch.vger.kernel.org

On Sun, Jul 12, 2020 at 07:05:36PM -0400, Waiman Long wrote:
> On 7/12/20 1:34 PM, Peter Zijlstra wrote:

> > And this kills it,.. if it doesn't make unconditional sense, we're not
> > going to do this. It's just too ugly.
> > 
> You mean it has to be unconditional, no option config if we want to do it.
> Right?

Yeah, the very last thing we need in this code is spurious complexity.
