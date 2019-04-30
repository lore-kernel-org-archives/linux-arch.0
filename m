From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/5] Allow CPU0 to be nohz full
Date: Tue, 30 Apr 2019 14:07:40 +0200
Message-ID: <20190430120740.GU2623@hirez.programming.kicks-ass.net>
References: <20190411033448.20842-1-npiggin@gmail.com>
 <20190425120427.GS4038@hirez.programming.kicks-ass.net>
 <1556592099.38esq4uhhz.astroid@bobo.none>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1556592099.38esq4uhhz.astroid@bobo.none>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On Tue, Apr 30, 2019 at 12:46:40PM +1000, Nicholas Piggin wrote:
> Peter Zijlstra's on April 25, 2019 10:04 pm:
> > On Thu, Apr 11, 2019 at 01:34:43PM +1000, Nicholas Piggin wrote:
> >> Since last time, I added a compile time option to opt-out of this
> >> if the platform does not support suspend on non-zero, and tried to
> >> improve legibility of changelogs and explain the justification
> >> better.
> >> 
> >> I have been testing this on powerpc/pseries and it seems to work
> >> fine (the firmware call to suspend can be called on any CPU and
> >> resumes where it left off), but not included here because the
> >> code has some bitrot unrelated to this series which I hacked to
> >> fix. I will discuss it and either send an acked patch to go with
> >> this series if it is small, or fix it in powerpc tree.
> >> 
> > 
> > Rafael, Frederic, any comments?
> > 
> 
> Sorry to ping again, I guess people are probably busy after vacation.
> Any chance we could get this in next merge window? Peter are you okay
> with the config option as it is, then we can look at adapting it to
> what x86 needs as a follow up (e.g., allow nohz CPU0 for
> cpu0_hotpluggable case)?

Yeah, let me just queue these here patches. Not sure they'll still make
the upcoming merge window, but we can try.
