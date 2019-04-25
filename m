From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 3/5] kernel/cpu: Allow non-zero CPU to be primary for
 suspend / kexec freeze
Date: Thu, 25 Apr 2019 14:02:21 +0200
Message-ID: <20190425120221.GR4038@hirez.programming.kicks-ass.net>
References: <20190411033448.20842-1-npiggin@gmail.com>
 <20190411033448.20842-4-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190411033448.20842-4-npiggin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

On Thu, Apr 11, 2019 at 01:34:46PM +1000, Nicholas Piggin wrote:
> This patch provides an arch option, ARCH_SUSPEND_NONZERO_CPU, to
> opt-in to allowing suspend to occur on one of the housekeeping CPUs
> rather than hardcoded CPU0.
> 
> This will allow CPU0 to be a nohz_full CPU with a later change.
> 
> It may be possible for platforms with hardware/firmware restrictions
> on suspend/wake effectively support this by handing off the final
> stage to CPU0 when kernel housekeeping is no longer required. Another
> option is to make housekeeping / nohz_full mask dynamic at runtime,
> but the complexity could not be justified at this time.

Should we not tie this into whatever already allows an achitecture to
hotplug CPU-0? For instance, x86 default disallows this but has
cpu0_hotpluggable to allow this.

Presumably POWER already allows hotplugging CPU-0 ?
