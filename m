From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 3/5] kernel/cpu: Allow non-zero CPU to be primary for
 suspend / kexec freeze
Date: Fri, 26 Apr 2019 14:32:56 +1000
Message-ID: <1556252469.19vbob4hqp.astroid@bobo.none>
References: <20190411033448.20842-1-npiggin@gmail.com>
        <20190411033448.20842-4-npiggin@gmail.com>
        <20190425120221.GR4038@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190425120221.GR4038@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

Peter Zijlstra's on April 25, 2019 10:02 pm:
> On Thu, Apr 11, 2019 at 01:34:46PM +1000, Nicholas Piggin wrote:
>> This patch provides an arch option, ARCH_SUSPEND_NONZERO_CPU, to
>> opt-in to allowing suspend to occur on one of the housekeeping CPUs
>> rather than hardcoded CPU0.
>>=20
>> This will allow CPU0 to be a nohz_full CPU with a later change.
>>=20
>> It may be possible for platforms with hardware/firmware restrictions
>> on suspend/wake effectively support this by handing off the final
>> stage to CPU0 when kernel housekeeping is no longer required. Another
>> option is to make housekeeping / nohz_full mask dynamic at runtime,
>> but the complexity could not be justified at this time.
>=20
> Should we not tie this into whatever already allows an achitecture to
> hotplug CPU-0? For instance, x86 default disallows this but has
> cpu0_hotpluggable to allow this.
=20
I didn't know about that option, but I see it still has the suspend
/ hibernate restriction though, which is what this patch is breaking
from.

If we are to prevent suspend completely at boot time, then it's no
problem to run cpu0 with nohz_full, but TPTB decided that's a bad
thing.

But I have no problem with an arch adding another boot time option
or hook into cpu0_hotpluggable that allows you to force nohz_full.

> Presumably POWER already allows hotplugging CPU-0 ?

Yeah it does. Suspend in pseries is actually really just used for
some proprietary hypervisor partition migration scheme where you
suspend, image gets saved, then resume it somewhere else. So that's
easy, it's just a hypercall that appears to return exactly as it was
called. No restriction on CPU number.

Thanks,
Nick
=
