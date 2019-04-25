From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/5] Allow CPU0 to be nohz full
Date: Thu, 25 Apr 2019 14:04:27 +0200
Message-ID: <20190425120427.GS4038@hirez.programming.kicks-ass.net>
References: <20190411033448.20842-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190411033448.20842-1-npiggin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

On Thu, Apr 11, 2019 at 01:34:43PM +1000, Nicholas Piggin wrote:
> Since last time, I added a compile time option to opt-out of this
> if the platform does not support suspend on non-zero, and tried to
> improve legibility of changelogs and explain the justification
> better.
> 
> I have been testing this on powerpc/pseries and it seems to work
> fine (the firmware call to suspend can be called on any CPU and
> resumes where it left off), but not included here because the
> code has some bitrot unrelated to this series which I hacked to
> fix. I will discuss it and either send an acked patch to go with
> this series if it is small, or fix it in powerpc tree.
> 

Rafael, Frederic, any comments?
