From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 00/20] cpu/hotplug: Core infrastructure for cpu hotplug rework
Date: Fri, 26 Feb 2016 18:43:21 -0000
Message-ID: <20160226164321.657646833@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Peter Anvin <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Sebastian Siewior <bigeasy@linutronix.de>, Paul Turner <pjt@google.com>
List-Id: linux-arch.vger.kernel.org

Hi folks!

the following series contains the core infrastructure of our ongoing cpu
hotplug refactoring work. It's a follow up to the work I've done in 2013

	https://lwn.net/Articles/535764/

What's wrong with the current cpu hotplug infrastructure?

 - Asymmetry

   The hotplug notifier mechanism is asymmetric versus the bringup and
   teardown. This is mostly caused by the notifier mechanism.

 - Largely undocumented dependencies

   While some notifiers use explicitely defined notifier priorities, we have
   quite some notifiers which use numerical priorities to express
   dependencies without any documentation why.

 - Control processor driven

   Most of the bringup/teardown of a cpu is driven by a control
   processor. While it is understandable, that preperatory steps, like idle
   thread creation, memory allocation for and initialization of essential
   facilities needs to be done before a cpu can boot, there is no reason why
   everything else must run on a control processor. Todays bringup looks like
   this:

   Control CPU  	   	Booting CPU

   do preparatory steps
   kick cpu into life

				do low level init

   sync with booting cpu	sync with control cpu
   
   bring the rest up


 - All or nothing approach

   There is no way to do partial bringups. That's something which is really
   desired because we waste e.g. at boot substantial amount of time just busy
   waiting that the cpu comes to life. That's stupid as we could very well do
   preparatory steps and the initial IPI for other cpus and then go back and
   do the necessary low level synchronization with the freshly booted cpu.

 - Minimal debuggability

   Due to the notifier based design, it's impossible to switch between two
   stages of the bringup/teardown back and forth in order to test the
   correctness. So in many hotplug notifiers the cancel mechanisms are either
   not existant or completely untested.

 - Notifier [un]registering is tidious

   To [un]register notifiers we need to protect against hotplug at every
   callsite. There is no mechanism that bringup/teardown callbacks are issued
   on the online cpus, so every caller needs to do it itself. That also
   includes error rollback.


What's the new design?

   The base of the new design is a symmetric state machine, where both the
   control processor and the booting/dying cpu execute a well defined set of
   states. Each state is symmetric in the end, except for some well defined
   exceptions, and the bringup/teardown can be stopped and reversed at almost
   all states.

   So the bringup of a cpu will look like this in the future:

   Control CPU  	   	Booting CPU

   do preparatory steps
   kick cpu into life

				do low level init

   sync with booting cpu	sync with control cpu
   
				bring itself up

   The synchronization step does not require the control cpu to wait. That
   mechanism can be done asynchronously via a worker or some other mechanism.

   The teardown can be made very similar, so that the dying cpu cleans up and
   brings itself down. Cleanups which need to be done after the cpu is gone,
   can be scheduled asynchronously as well.

There is a long way to this, as we need to refactor the notion when a cpu is
available. Today we set the cpu online right after it comes out of the low
level bringup, which is not really correct.

The proper mechanism is to set it to available, i.e. cpu local threads, like
softirqd, hotplug thread etc. can be scheduled on that cpu, and once it
finished all booting steps, it's set to online, so general workloads can be
scheduled on it. The reverse happens on teardown. First thing to do is to
forbid scheduling of general workloads, then teardown all the per cpu
resources and finally shut it off completely.


The following patch series implements the basic infrastructure for this at the
core level. This includes the following:

 - Basic state machine implementation with well defined states, so ordering
   and prioritization can be expressed.

 - Interfaces to [un]register state callbacks

   This invokes the bringup/teardown callback on all online cpus with the
   proper protection in place and [un]installs the callbacks in the state
   machine array.

   For callbacks which have no particular ordering requirement we have a
   dynamic state space, so that drivers don't have to register an explicit
   hotplug state.

   If a callback fails, the code automatically does a rollback to the previous
   state.


 - Sysfs interface to drive the state machine to a particular step.

   This is only partially functional today. Full functionality and therefor
   testability will be achieved once we converted all existing hotplug
   notifiers over to the new scheme.


 - Run all CPU_ONLINE/DOWN_PREPARE notifiers on the booting/dying processor:

    Control CPU  	   	Booting CPU

    do preparatory steps
    kick cpu into life

				do low level init

    sync with booting cpu	sync with control cpu
    wait for boot     		
				bring itself up

    				Signal completion to control cpu
				
In a previous step of this work we've done a full tree mechanical conversion
of all hotplug notifiers to the new scheme. The balance is a net removal of
about 4000 lines of code.

This is not included in this post, as we decided to take a different
approach. Instead of mechanically converting everything over, we will do a
proper overhaul of the usage sites one by one so they nicely fit into the
symmetric callback scheme.

I decided to do that after I looked at the ugliness of some of the converted
sites and figured out that their hotplug mechanism is completely buggered
anyway. So there is no point to do a mechanical conversion first as we need to
go through the usage sites one by one again in order to achieve a full
symmetric and testable behaviour.

The lot is also available at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.hotplug

Thanks,

	tglx

---
 arch/ia64/kernel/smpboot.c        |    2 
 arch/metag/kernel/smp.c           |    2 
 arch/sparc/kernel/smp_32.c        |    2 
 arch/sparc/kernel/smp_64.c        |    2 
 arch/tile/kernel/smpboot.c        |    2 
 arch/x86/kernel/process.c         |   12 
 arch/x86/xen/smp.c                |    2 
 b/arch/alpha/kernel/smp.c         |    2 
 b/arch/arc/kernel/smp.c           |    2 
 b/arch/arm/kernel/smp.c           |    2 
 b/arch/arm64/kernel/smp.c         |    2 
 b/arch/blackfin/mach-common/smp.c |    2 
 b/arch/hexagon/kernel/smp.c       |    2 
 b/arch/m32r/kernel/smpboot.c      |    2 
 b/arch/mips/kernel/smp.c          |    2 
 b/arch/mn10300/kernel/smp.c       |    2 
 b/arch/parisc/kernel/smp.c        |    2 
 b/arch/powerpc/kernel/smp.c       |    2 
 b/arch/s390/kernel/smp.c          |    2 
 b/arch/sh/kernel/smp.c            |    2 
 b/arch/x86/kernel/smpboot.c       |    2 
 b/arch/xtensa/kernel/smp.c        |    2 
 b/include/linux/cpuhotplug.h      |   93 +++
 b/include/trace/events/cpuhp.h    |   66 ++
 include/linux/cpu.h               |   27 
 include/linux/notifier.h          |    2 
 include/linux/rcupdate.h          |    4 
 init/main.c                       |   16 
 kernel/cpu.c                      | 1099 +++++++++++++++++++++++++++++++++-----
 kernel/rcu/tree.c                 |   26 
 kernel/sched/core.c               |   10 
 kernel/sched/idle.c               |   24 
 kernel/smp.c                      |    1 
 kernel/smpboot.c                  |    6 
 kernel/smpboot.h                  |    6 
 lib/Kconfig.debug                 |   13 
 36 files changed, 1217 insertions(+), 230 deletions(-)







   

   
