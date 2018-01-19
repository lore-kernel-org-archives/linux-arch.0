From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] Automate memory-barriers.txt; provide Linux-kernel
 memory model
Date: Fri, 19 Jan 2018 09:12:11 -0800
Message-ID: <20180119171211.GA13636@linux.vnet.ibm.com>
References: <20180119035855.GA29296@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180119035855.GA29296@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr
Cc: linux-kernel@vger.kernel.org, elena.reshetova@intel.com, mhocko@suse.com, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Jan 18, 2018 at 07:58:55PM -0800, Paul E. McKenney wrote:
> Hello!
> 
> There is some reason to believe that Documentation/memory-barriers.txt
> could use some help, and a major purpose of this patch is to provide
> that help in the form of a design-time tool that can produce all valid
> executions of a small fragment of concurrent Linux-kernel code, which is
> called a "litmus test".  This tool's functionality is roughly similar to
> a full state-space search.  Please note that this is a design-time tool,
> not useful for regression testing.  However, we hope that the underlying
> Linux-kernel memory model will be incorporated into other tools capable
> of analyzing large bodies of code for regression-testing purposes.
> 
> The main tool is herd7, together with the linux-kernel.bell,
> linux-kernel.cat, linux-kernel.cfg, linux-kernel.def, and lock.cat files
> added by this patch.  The herd7 executable takes the other files as input,
> and all of these files collectively define the Linux-kernel memory memory
> model.  A brief description of each of these other files is provided
> in the README file.  Although this tool does have its limitations,
> which are documented in the README file, it does improve on the version
> reported on in the LWN series (https://lwn.net/Articles/718628/ and
> https://lwn.net/Articles/720550/) by supporting locking and arithmetic,
> including a much wider variety of read-modify-write atomic operations.
> Please note that herd7 is not part of this submission, but is freely
> available from http://diy.inria.fr/sources/index.html (and via "git"
> at https://github.com/herd/herdtools7).

Please note that the latest version of herd is necessary for this version
of the memory model.  With older versions, you will get error messages
like the following:

File "./linux-kernel.def", line 44, characters 29-30: unexpected '-' (in macros)

Many thanks to Andrea for spotting this one!

							Thanx, Paul

> A second tool is klitmus7, which converts litmus tests to loadable
> kernel modules for direct testing.  As with herd7, the klitmus7
> code is freely available from http://diy.inria.fr/sources/index.html
> (and via "git" at https://github.com/herd/herdtools7).
> 
> Of course, litmus tests are not always the best way to fully understand a
> memory model, so this patch also includes Documentation/explanation.txt,
> which describes the memory model in detail.  In addition,
> Documentation/recipes.txt provides example known-good and known-bad use
> cases for those who prefer working by example.
> 
> This patch also includes a few sample litmus tests, and a great many
> more litmus tests are available at https://github.com/paulmckrcu/litmus.
> 
> This patch was the result of a most excellent collaboration founded
> by Jade Alglave and also including Alan Stern, Andrea Parri, and Luc
> Maranget.  For more details on the history of this collaboration, please
> refer to the Linux-kernel memory model presentations at 2016 LinuxCon EU,
> 2016 Kernel Summit, 2016 Linux Plumbers Conference, 2017 linux.conf.au,
> or 2017 Linux Plumbers Conference microconference.  However, one aspect
> of the history does bear repeating due to weak copyright tracking earlier
> in this project, which extends back to early 2015.  This weakness came
> to light in late 2017 after an LKMM presentation by Paul in which an
> audience member noted the similarity of some LKMM code to code in early
> published papers.  This prompted a copyright review.
> 
> From Alan Stern:
> 
> 	To say that the model was mine is not entirely accurate.
> 	Pieces of it (especially the Scpv and Atomic axioms) were taken
> 	directly from Jade's models.  And of course the Happens-before
> 	and Propagation relations and axioms were heavily based on
> 	Jade and Luc's work, even though they weren't identical to the
> 	earlier versions.  Only the RCU portion was completely original.
> 
> 	. . .
> 
> 	One can make a much better case that I wrote the bulk of lock.cat.
> 	However, it was inspired by Luc's earlier version (and still
> 	shares some elements in common), and of course it benefited from
> 	feedback and testing from all members of our group.
> 
> The model prior to Alan's was Luc Maranget's.  From Luc:
> 
> 	 I totally agree on Alan Stern's account of the linux kernel model
> 	 genesis.  I thank him for his acknowledgments of my participation
> 	 to previous model drafts.  I'd like to complete Alan Stern's
> 	 statement: any bell cat code I have written has its roots in
> 	 discussions with Jade Alglave and Paul McKenney. Moreover I
> 	 have borrowed cat and bell code written by Jade Alglave freely.
> 
> This copyright review therefore resulted in late adds to the copyright
> statements of several files.
> 
> Discussion of v1 has raised several issues, which we do not believe should
> block acceptance given that this level of change will be ongoing, just
> as it has been with memory-barriers.txt:
> 
> o	Under what conditions should ordering provided by pure locking
> 	be seen by CPUs not holding the relevant lock(s)?  In particular,
> 	should the message-passing pattern be forbidden?
> 
> o	Should examples involving C11 release sequences be forbidden?
> 	Note that this C11 is still a moving target for this issue:
> 	http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2017/p0735r0.html
> 
> o	Some details of the handling of internal dependencies for atomic
> 	read-modify-write atomic operations are still subject to debate.
> 
> o	Changes recently accepted into mainline greatly reduce the need
> 	to handle DEC Alpha as a special case.  If these changes stick,
> 	the memory model can be simplified accordingly.
> 
> o	Will changes be required to accommodate RISC-V?
> 
> Differences from v1:
> 	(http://lkml.kernel.org/r/20171113184031.GA26302@linux.vnet.ibm.com)
> 
> o	Add SPDX notations to .bell and .cat files, replacing
> 	textual license statements.
> 
> o	Add reference to upcoming ASPLOS paper to .bell and .cat files.
> 
> o	Updated identifier names in .bell and .cat files to match those
> 	used in the ASPLOS paper.
> 
> o	Updates to READMEs and other documentation based on review
> 	feedback.
> 
> o	Added a memory-ordering cheatsheet.
> 
> o	Update sigs to new Co-Developed-by and add acks and
> 	reviewed-bys.
> 
> o	Simplify rules detecting nested RCU read-side critical sections.
> 
> o	Update copyright statements as noted above.
> 
> Co-Developed-by: Alan Stern <stern@rowland.harvard.edu>
> Co-Developed-by: Andrea Parri <parri.andrea@gmail.com>
> Co-Developed-by: Jade Alglave <j.alglave@ucl.ac.uk>
> Co-Developed-by: Luc Maranget <luc.maranget@inria.fr>
> Co-Developed-by: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> Signed-off-by: Jade Alglave <j.alglave@ucl.ac.uk>
> Signed-off-by: Luc Maranget <luc.maranget@inria.fr>
> Signed-off-by: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> Acked-by: Peter Zijlstra <peterz@infradead.org>
> Acked-by: Nicholas Piggin <npiggin@gmail.com>
> Acked-by: David Howells <dhowells@redhat.com>
> Acked-by: "Reshetova, Elena" <elena.reshetova@intel.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Cc: <linux-arch@vger.kernel.org>
> ---
>  Documentation/cheatsheet.txt                                          |   30 
>  Documentation/explanation.txt                                         | 1840 ++++++++++
>  Documentation/recipes.txt                                             |  570 +++
>  Documentation/references.txt                                          |  107 
>  MAINTAINERS                                                           |   15 
>  README                                                                |  220 +
>  linux-kernel.bell                                                     |   53 
>  linux-kernel.cat                                                      |  124 
>  linux-kernel.cfg                                                      |   21 
>  linux-kernel.def                                                      |  108 
>  litmus-tests/CoRR+poonceonce+Once.litmus                              |   19 
>  litmus-tests/CoRW+poonceonce+Once.litmus                              |   18 
>  litmus-tests/CoWR+poonceonce+Once.litmus                              |   18 
>  litmus-tests/CoWW+poonceonce.litmus                                   |   11 
>  litmus-tests/IRIW+mbonceonces+OnceOnce.litmus                         |   35 
>  litmus-tests/IRIW+poonceonces+OnceOnce.litmus                         |   33 
>  litmus-tests/ISA2+poonceonces.litmus                                  |   28 
>  litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus |   28 
>  litmus-tests/LB+ctrlonceonce+mbonceonce.litmus                        |   23 
>  litmus-tests/LB+poacquireonce+pooncerelease.litmus                    |   21 
>  litmus-tests/LB+poonceonces.litmus                                    |   21 
>  litmus-tests/MP+onceassign+derefonce.litmus                           |   25 
>  litmus-tests/MP+polocks.litmus                                        |   24 
>  litmus-tests/MP+poonceonces.litmus                                    |   20 
>  litmus-tests/MP+pooncerelease+poacquireonce.litmus                    |   20 
>  litmus-tests/MP+porevlocks.litmus                                     |   24 
>  litmus-tests/MP+wmbonceonce+rmbonceonce.litmus                        |   22 
>  litmus-tests/R+mbonceonces.litmus                                     |   21 
>  litmus-tests/R+poonceonces.litmus                                     |   19 
>  litmus-tests/README                                                   |  125 
>  litmus-tests/S+poonceonces.litmus                                     |   19 
>  litmus-tests/S+wmbonceonce+poacquireonce.litmus                       |   20 
>  litmus-tests/SB+mbonceonces.litmus                                    |   23 
>  litmus-tests/SB+poonceonces.litmus                                    |   21 
>  litmus-tests/WRC+poonceonces+Once.litmus                              |   27 
>  litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus                |   28 
>  litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus               |   33 
>  litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus               |   32 
>  litmus-tests/Z6.0+pooncerelease+poacquirerelease+mbonceonce.litmus    |   28 
>  lock.cat                                                              |   99 
>  40 files changed, 3973 insertions(+)
> 
> diff --git a/tools/memory-model/Documentation/cheatsheet.txt b/tools/memory-model/Documentation/cheatsheet.txt
> new file mode 100644
> index 000000000000..1917712bce99
> --- /dev/null
> +++ b/tools/memory-model/Documentation/cheatsheet.txt
> @@ -0,0 +1,30 @@
> +                                  Prior Operation     Subsequent Operation
> +                                  ---------------  ---------------------------
> +                               C  Self  R  W  RWM  Self  R  W  DR  DW  RMW  SV
> +                              __  ----  -  -  ---  ----  -  -  --  --  ---  --
> +
> +Store, e.g., WRITE_ONCE()            Y                                       Y
> +Load, e.g., READ_ONCE()              Y                              Y        Y
> +Unsuccessful RMW operation           Y                              Y        Y
> +smp_read_barrier_depends()              Y                       Y   Y
> +*_dereference()                      Y                          Y   Y        Y
> +Successful *_acquire()               R                   Y  Y   Y   Y    Y   Y
> +Successful *_release()         C        Y  Y    Y     W                      Y
> +smp_rmb()                               Y       R        Y      Y        R
> +smp_wmb()                                  Y    W           Y       Y    W
> +smp_mb() & synchronize_rcu()  CP        Y  Y    Y        Y  Y   Y   Y    Y
> +Successful full non-void RMW  CP     Y  Y  Y    Y     Y  Y  Y   Y   Y    Y   Y
> +smp_mb__before_atomic()       CP        Y  Y    Y        a  a   a   a    Y
> +smp_mb__after_atomic()        CP        a  a    Y        Y  Y   Y   Y
> +
> +
> +Key:	C:	Ordering is cumulative
> +	P:	Ordering propagates
> +	R:	Read, for example, READ_ONCE(), or read portion of RMW
> +	W:	Write, for example, WRITE_ONCE(), or write portion of RMW
> +	Y:	Provides ordering
> +	a:	Provides ordering given intervening RMW atomic operation
> +	DR:	Dependent read (address dependency)
> +	DW:	Dependent write (address, data, or control dependency)
> +	RMW:	Atomic read-modify-write operation
> +	SV	Same-variable access
> diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
> new file mode 100644
> index 000000000000..867e0ea69b6d
> --- /dev/null
> +++ b/tools/memory-model/Documentation/explanation.txt
> @@ -0,0 +1,1840 @@
> +Explanation of the Linux-Kernel Memory Model
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +:Author: Alan Stern <stern@rowland.harvard.edu>
> +:Created: October 2017
> +
> +.. Contents
> +
> +  1. INTRODUCTION
> +  2. BACKGROUND
> +  3. A SIMPLE EXAMPLE
> +  4. A SELECTION OF MEMORY MODELS
> +  5. ORDERING AND CYCLES
> +  6. EVENTS
> +  7. THE PROGRAM ORDER RELATION: po AND po-loc
> +  8. A WARNING
> +  9. DEPENDENCY RELATIONS: data, addr, and ctrl
> +  10. THE READS-FROM RELATION: rf, rfi, and rfe
> +  11. CACHE COHERENCE AND THE COHERENCE ORDER RELATION: co, coi, and coe
> +  12. THE FROM-READS RELATION: fr, fri, and fre
> +  13. AN OPERATIONAL MODEL
> +  14. PROPAGATION ORDER RELATION: cumul-fence
> +  15. DERIVATION OF THE LKMM FROM THE OPERATIONAL MODEL
> +  16. SEQUENTIAL CONSISTENCY PER VARIABLE
> +  17. ATOMIC UPDATES: rmw
> +  18. THE PRESERVED PROGRAM ORDER RELATION: ppo
> +  19. AND THEN THERE WAS ALPHA
> +  20. THE HAPPENS-BEFORE RELATION: hb
> +  21. THE PROPAGATES-BEFORE RELATION: pb
> +  22. RCU RELATIONS: link, gp-link, rscs-link, and rcu-path
> +  23. ODDS AND ENDS
> +
> +
> +
> +INTRODUCTION
> +------------
> +
> +The Linux-kernel memory model (LKMM) is rather complex and obscure.
> +This is particularly evident if you read through the linux-kernel.bell
> +and linux-kernel.cat files that make up the formal version of the
> +memory model; they are extremely terse and their meanings are far from
> +clear.
> +
> +This document describes the ideas underlying the LKMM.  It is meant
> +for people who want to understand how the memory model was designed.
> +It does not go into the details of the code in the .bell and .cat
> +files; rather, it explains in English what the code expresses
> +symbolically.
> +
> +Sections 2 (BACKGROUND) through 5 (ORDERING AND CYCLES) are aimed
> +toward beginners; they explain what memory models are and the basic
> +notions shared by all such models.  People already familiar with these
> +concepts can skim or skip over them.  Sections 6 (EVENTS) through 12
> +(THE FROM_READS RELATION) describe the fundamental relations used in
> +many memory models.  Starting in Section 13 (AN OPERATIONAL MODEL),
> +the workings of the LKMM itself are covered.
> +
> +Warning: The code examples in this document are not written in the
> +proper format for litmus tests.  They don't include a header line, the
> +initializations are not enclosed in braces, the global variables are
> +not passed by pointers, and they don't have an "exists" clause at the
> +end.  Converting them to the right format is left as an exercise for
> +the reader.
> +
> +
> +BACKGROUND
> +----------
> +
> +A memory consistency model (or just memory model, for short) is
> +something which predicts, given a piece of computer code running on a
> +particular kind of system, what values may be obtained by the code's
> +load instructions.  The LKMM makes these predictions for code running
> +as part of the Linux kernel.
> +
> +In practice, people tend to use memory models the other way around.
> +That is, given a piece of code and a collection of values specified
> +for the loads, the model will predict whether it is possible for the
> +code to run in such a way that the loads will indeed obtain the
> +specified values.  Of course, this is just another way of expressing
> +the same idea.
> +
> +For code running on a uniprocessor system, the predictions are easy:
> +Each load instruction must obtain the value written by the most recent
> +store instruction accessing the same location (we ignore complicating
> +factors such as DMA and mixed-size accesses.)  But on multiprocessor
> +systems, with multiple CPUs making concurrent accesses to shared
> +memory locations, things aren't so simple.
> +
> +Different architectures have differing memory models, and the Linux
> +kernel supports a variety of architectures.  The LKMM has to be fairly
> +permissive, in the sense that any behavior allowed by one of these
> +architectures also has to be allowed by the LKMM.
> +
> +
> +A SIMPLE EXAMPLE
> +----------------
> +
> +Here is a simple example to illustrate the basic concepts.  Consider
> +some code running as part of a device driver for an input device.  The
> +driver might contain an interrupt handler which collects data from the
> +device, stores it in a buffer, and sets a flag to indicate the buffer
> +is full.  Running concurrently on a different CPU might be a part of
> +the driver code being executed by a process in the midst of a read(2)
> +system call.  This code tests the flag to see whether the buffer is
> +ready, and if it is, copies the data back to userspace.  The buffer
> +and the flag are memory locations shared between the two CPUs.
> +
> +We can abstract out the important pieces of the driver code as follows
> +(the reason for using WRITE_ONCE() and READ_ONCE() instead of simple
> +assignment statements is discussed later):
> +
> +	int buf = 0, flag = 0;
> +
> +	P0()
> +	{
> +		WRITE_ONCE(buf, 1);
> +		WRITE_ONCE(flag, 1);
> +	}
> +
> +	P1()
> +	{
> +		int r1;
> +		int r2 = 0;
> +
> +		r1 = READ_ONCE(flag);
> +		if (r1)
> +			r2 = READ_ONCE(buf);
> +	}
> +
> +Here the P0() function represents the interrupt handler running on one
> +CPU and P1() represents the read() routine running on another.  The
> +value 1 stored in buf represents input data collected from the device.
> +Thus, P0 stores the data in buf and then sets flag.  Meanwhile, P1
> +reads flag into the private variable r1, and if it is set, reads the
> +data from buf into a second private variable r2 for copying to
> +userspace.  (Presumably if flag is not set then the driver will wait a
> +while and try again.)
> +
> +This pattern of memory accesses, where one CPU stores values to two
> +shared memory locations and another CPU loads from those locations in
> +the opposite order, is widely known as the "Message Passing" or MP
> +pattern.  It is typical of memory access patterns in the kernel.
> +
> +Please note that this example code is a simplified abstraction.  Real
> +buffers are usually larger than a single integer, real device drivers
> +usually use sleep and wakeup mechanisms rather than polling for I/O
> +completion, and real code generally doesn't bother to copy values into
> +private variables before using them.  All that is beside the point;
> +the idea here is simply to illustrate the overall pattern of memory
> +accesses by the CPUs.
> +
> +A memory model will predict what values P1 might obtain for its loads
> +from flag and buf, or equivalently, what values r1 and r2 might end up
> +with after the code has finished running.
> +
> +Some predictions are trivial.  For instance, no sane memory model would
> +predict that r1 = 42 or r2 = -7, because neither of those values ever
> +gets stored in flag or buf.
> +
> +Some nontrivial predictions are nonetheless quite simple.  For
> +instance, P1 might run entirely before P0 begins, in which case r1 and
> +r2 will both be 0 at the end.  Or P0 might run entirely before P1
> +begins, in which case r1 and r2 will both be 1.
> +
> +The interesting predictions concern what might happen when the two
> +routines run concurrently.  One possibility is that P1 runs after P0's
> +store to buf but before the store to flag.  In this case, r1 and r2
> +will again both be 0.  (If P1 had been designed to read buf
> +unconditionally then we would instead have r1 = 0 and r2 = 1.)
> +
> +However, the most interesting possibility is where r1 = 1 and r2 = 0.
> +If this were to occur it would mean the driver contains a bug, because
> +incorrect data would get sent to the user: 0 instead of 1.  As it
> +happens, the LKMM does predict this outcome can occur, and the example
> +driver code shown above is indeed buggy.
> +
> +
> +A SELECTION OF MEMORY MODELS
> +----------------------------
> +
> +The first widely cited memory model, and the simplest to understand,
> +is Sequential Consistency.  According to this model, systems behave as
> +if each CPU executed its instructions in order but with unspecified
> +timing.  In other words, the instructions from the various CPUs get
> +interleaved in a nondeterministic way, always according to some single
> +global order that agrees with the order of the instructions in the
> +program source for each CPU.  The model says that the value obtained
> +by each load is simply the value written by the most recently executed
> +store to the same memory location, from any CPU.
> +
> +For the MP example code shown above, Sequential Consistency predicts
> +that the undesired result r1 = 1, r2 = 0 cannot occur.  The reasoning
> +goes like this:
> +
> +	Since r1 = 1, P0 must store 1 to flag before P1 loads 1 from
> +	it, as loads can obtain values only from earlier stores.
> +
> +	P1 loads from flag before loading from buf, since CPUs execute
> +	their instructions in order.
> +
> +	P1 must load 0 from buf before P0 stores 1 to it; otherwise r2
> +	would be 1 since a load obtains its value from the most recent
> +	store to the same address.
> +
> +	P0 stores 1 to buf before storing 1 to flag, since it executes
> +	its instructions in order.
> +
> +	Since an instruction (in this case, P1's store to flag) cannot
> +	execute before itself, the specified outcome is impossible.
> +
> +However, real computer hardware almost never follows the Sequential
> +Consistency memory model; doing so would rule out too many valuable
> +performance optimizations.  On ARM and PowerPC architectures, for
> +instance, the MP example code really does sometimes yield r1 = 1 and
> +r2 = 0.
> +
> +x86 and SPARC follow yet a different memory model: TSO (Total Store
> +Ordering).  This model predicts that the undesired outcome for the MP
> +pattern cannot occur, but in other respects it differs from Sequential
> +Consistency.  One example is the Store Buffer (SB) pattern, in which
> +each CPU stores to its own shared location and then loads from the
> +other CPU's location:
> +
> +	int x = 0, y = 0;
> +
> +	P0()
> +	{
> +		int r0;
> +
> +		WRITE_ONCE(x, 1);
> +		r0 = READ_ONCE(y);
> +	}
> +
> +	P1()
> +	{
> +		int r1;
> +
> +		WRITE_ONCE(y, 1);
> +		r1 = READ_ONCE(x);
> +	}
> +
> +Sequential Consistency predicts that the outcome r0 = 0, r1 = 0 is
> +impossible.  (Exercise: Figure out the reasoning.)  But TSO allows
> +this outcome to occur, and in fact it does sometimes occur on x86 and
> +SPARC systems.
> +
> +The LKMM was inspired by the memory models followed by PowerPC, ARM,
> +x86, Alpha, and other architectures.  However, it is different in
> +detail from each of them.
> +
> +
> +ORDERING AND CYCLES
> +-------------------
> +
> +Memory models are all about ordering.  Often this is temporal ordering
> +(i.e., the order in which certain events occur) but it doesn't have to
> +be; consider for example the order of instructions in a program's
> +source code.  We saw above that Sequential Consistency makes an
> +important assumption that CPUs execute instructions in the same order
> +as those instructions occur in the code, and there are many other
> +instances of ordering playing central roles in memory models.
> +
> +The counterpart to ordering is a cycle.  Ordering rules out cycles:
> +It's not possible to have X ordered before Y, Y ordered before Z, and
> +Z ordered before X, because this would mean that X is ordered before
> +itself.  The analysis of the MP example under Sequential Consistency
> +involved just such an impossible cycle:
> +
> +	W: P0 stores 1 to flag   executes before
> +	X: P1 loads 1 from flag  executes before
> +	Y: P1 loads 0 from buf   executes before
> +	Z: P0 stores 1 to buf    executes before
> +	W: P0 stores 1 to flag.
> +
> +In short, if a memory model requires certain accesses to be ordered,
> +and a certain outcome for the loads in a piece of code can happen only
> +if those accesses would form a cycle, then the memory model predicts
> +that outcome cannot occur.
> +
> +The LKMM is defined largely in terms of cycles, as we will see.
> +
> +
> +EVENTS
> +------
> +
> +The LKMM does not work directly with the C statements that make up
> +kernel source code.  Instead it considers the effects of those
> +statements in a more abstract form, namely, events.  The model
> +includes three types of events:
> +
> +	Read events correspond to loads from shared memory, such as
> +	calls to READ_ONCE(), smp_load_acquire(), or
> +	rcu_dereference().
> +
> +	Write events correspond to stores to shared memory, such as
> +	calls to WRITE_ONCE(), smp_store_release(), or atomic_set().
> +
> +	Fence events correspond to memory barriers (also known as
> +	fences), such as calls to smp_rmb() or rcu_read_lock().
> +
> +These categories are not exclusive; a read or write event can also be
> +a fence.  This happens with functions like smp_load_acquire() or
> +spin_lock().  However, no single event can be both a read and a write.
> +Atomic read-modify-write accesses, such as atomic_inc() or xchg(),
> +correspond to a pair of events: a read followed by a write.  (The
> +write event is omitted for executions where it doesn't occur, such as
> +a cmpxchg() where the comparison fails.)
> +
> +Other parts of the code, those which do not involve interaction with
> +shared memory, do not give rise to events.  Thus, arithmetic and
> +logical computations, control-flow instructions, or accesses to
> +private memory or CPU registers are not of central interest to the
> +memory model.  They only affect the model's predictions indirectly.
> +For example, an arithmetic computation might determine the value that
> +gets stored to a shared memory location (or in the case of an array
> +index, the address where the value gets stored), but the memory model
> +is concerned only with the store itself -- its value and its address
> +-- not the computation leading up to it.
> +
> +Events in the LKMM can be linked by various relations, which we will
> +describe in the following sections.  The memory model requires certain
> +of these relations to be orderings, that is, it requires them not to
> +have any cycles.
> +
> +
> +THE PROGRAM ORDER RELATION: po AND po-loc
> +-----------------------------------------
> +
> +The most important relation between events is program order (po).  You
> +can think of it as the order in which statements occur in the source
> +code after branches are taken into account and loops have been
> +unrolled.  A better description might be the order in which
> +instructions are presented to a CPU's execution unit.  Thus, we say
> +that X is po-before Y (written as "X ->po Y" in formulas) if X occurs
> +before Y in the instruction stream.
> +
> +This is inherently a single-CPU relation; two instructions executing
> +on different CPUs are never linked by po.  Also, it is by definition
> +an ordering so it cannot have any cycles.
> +
> +po-loc is a sub-relation of po.  It links two memory accesses when the
> +first comes before the second in program order and they access the
> +same memory location (the "-loc" suffix).
> +
> +Although this may seem straightforward, there is one subtle aspect to
> +program order we need to explain.  The LKMM was inspired by low-level
> +architectural memory models which describe the behavior of machine
> +code, and it retains their outlook to a considerable extent.  The
> +read, write, and fence events used by the model are close in spirit to
> +individual machine instructions.  Nevertheless, the LKMM describes
> +kernel code written in C, and the mapping from C to machine code can
> +be extremely complex.
> +
> +Optimizing compilers have great freedom in the way they translate
> +source code to object code.  They are allowed to apply transformations
> +that add memory accesses, eliminate accesses, combine them, split them
> +into pieces, or move them around.  Faced with all these possibilities,
> +the LKMM basically gives up.  It insists that the code it analyzes
> +must contain no ordinary accesses to shared memory; all accesses must
> +be performed using READ_ONCE(), WRITE_ONCE(), or one of the other
> +atomic or synchronization primitives.  These primitives prevent a
> +large number of compiler optimizations.  In particular, it is
> +guaranteed that the compiler will not remove such accesses from the
> +generated code (unless it can prove the accesses will never be
> +executed), it will not change the order in which they occur in the
> +code (within limits imposed by the C standard), and it will not
> +introduce extraneous accesses.
> +
> +This explains why the MP and SB examples above used READ_ONCE() and
> +WRITE_ONCE() rather than ordinary memory accesses.  Thanks to this
> +usage, we can be certain that in the MP example, P0's write event to
> +buf really is po-before its write event to flag, and similarly for the
> +other shared memory accesses in the examples.
> +
> +Private variables are not subject to this restriction.  Since they are
> +not shared between CPUs, they can be accessed normally without
> +READ_ONCE() or WRITE_ONCE(), and there will be no ill effects.  In
> +fact, they need not even be stored in normal memory at all -- in
> +principle a private variable could be stored in a CPU register (hence
> +the convention that these variables have names starting with the
> +letter 'r').
> +
> +
> +A WARNING
> +---------
> +
> +The protections provided by READ_ONCE(), WRITE_ONCE(), and others are
> +not perfect; and under some circumstances it is possible for the
> +compiler to undermine the memory model.  Here is an example.  Suppose
> +both branches of an "if" statement store the same value to the same
> +location:
> +
> +	r1 = READ_ONCE(x);
> +	if (r1) {
> +		WRITE_ONCE(y, 2);
> +		...  /* do something */
> +	} else {
> +		WRITE_ONCE(y, 2);
> +		...  /* do something else */
> +	}
> +
> +For this code, the LKMM predicts that the load from x will always be
> +executed before either of the stores to y.  However, a compiler could
> +lift the stores out of the conditional, transforming the code into
> +something resembling:
> +
> +	r1 = READ_ONCE(x);
> +	WRITE_ONCE(y, 2);
> +	if (r1) {
> +		...  /* do something */
> +	} else {
> +		...  /* do something else */
> +	}
> +
> +Given this version of the code, the LKMM would predict that the load
> +from x could be executed after the store to y.  Thus, the memory
> +model's original prediction could be invalidated by the compiler.
> +
> +Another issue arises from the fact that in C, arguments to many
> +operators and function calls can be evaluated in any order.  For
> +example:
> +
> +	r1 = f(5) + g(6);
> +
> +The object code might call f(5) either before or after g(6); the
> +memory model cannot assume there is a fixed program order relation
> +between them.  (In fact, if the functions are inlined then the
> +compiler might even interleave their object code.)
> +
> +
> +DEPENDENCY RELATIONS: data, addr, and ctrl
> +------------------------------------------
> +
> +We say that two events are linked by a dependency relation when the
> +execution of the second event depends in some way on a value obtained
> +from memory by the first.  The first event must be a read, and the
> +value it obtains must somehow affect what the second event does.
> +There are three kinds of dependencies: data, address (addr), and
> +control (ctrl).
> +
> +A read and a write event are linked by a data dependency if the value
> +obtained by the read affects the value stored by the write.  As a very
> +simple example:
> +
> +	int x, y;
> +
> +	r1 = READ_ONCE(x);
> +	WRITE_ONCE(y, r1 + 5);
> +
> +The value stored by the WRITE_ONCE obviously depends on the value
> +loaded by the READ_ONCE.  Such dependencies can wind through
> +arbitrarily complicated computations, and a write can depend on the
> +values of multiple reads.
> +
> +A read event and another memory access event are linked by an address
> +dependency if the value obtained by the read affects the location
> +accessed by the other event.  The second event can be either a read or
> +a write.  Here's another simple example:
> +
> +	int a[20];
> +	int i;
> +
> +	r1 = READ_ONCE(i);
> +	r2 = READ_ONCE(a[r1]);
> +
> +Here the location accessed by the second READ_ONCE() depends on the
> +index value loaded by the first.  Pointer indirection also gives rise
> +to address dependencies, since the address of a location accessed
> +through a pointer will depend on the value read earlier from that
> +pointer.
> +
> +Finally, a read event and another memory access event are linked by a
> +control dependency if the value obtained by the read affects whether
> +the second event is executed at all.  Simple example:
> +
> +	int x, y;
> +
> +	r1 = READ_ONCE(x);
> +	if (r1)
> +		WRITE_ONCE(y, 1984);
> +
> +Execution of the WRITE_ONCE() is controlled by a conditional expression
> +which depends on the value obtained by the READ_ONCE(); hence there is
> +a control dependency from the load to the store.
> +
> +It should be pretty obvious that events can only depend on reads that
> +come earlier in program order.  Symbolically, if we have R ->data X,
> +R ->addr X, or R ->ctrl X (where R is a read event), then we must also
> +have R ->po X.  It wouldn't make sense for a computation to depend
> +somehow on a value that doesn't get loaded from shared memory until
> +later in the code!
> +
> +
> +THE READS-FROM RELATION: rf, rfi, and rfe
> +-----------------------------------------
> +
> +The reads-from relation (rf) links a write event to a read event when
> +the value loaded by the read is the value that was stored by the
> +write.  In colloquial terms, the load "reads from" the store.  We
> +write W ->rf R to indicate that the load R reads from the store W.  We
> +further distinguish the cases where the load and the store occur on
> +the same CPU (internal reads-from, or rfi) and where they occur on
> +different CPUs (external reads-from, or rfe).
> +
> +For our purposes, a memory location's initial value is treated as
> +though it had been written there by an imaginary initial store that
> +executes on a separate CPU before the program runs.
> +
> +Usage of the rf relation implicitly assumes that loads will always
> +read from a single store.  It doesn't apply properly in the presence
> +of load-tearing, where a load obtains some of its bits from one store
> +and some of them from another store.  Fortunately, use of READ_ONCE()
> +and WRITE_ONCE() will prevent load-tearing; it's not possible to have:
> +
> +	int x = 0;
> +
> +	P0()
> +	{
> +		WRITE_ONCE(x, 0x1234);
> +	}
> +
> +	P1()
> +	{
> +		int r1;
> +
> +		r1 = READ_ONCE(x);
> +	}
> +
> +and end up with r1 = 0x1200 (partly from x's initial value and partly
> +from the value stored by P0).
> +
> +On the other hand, load-tearing is unavoidable when mixed-size
> +accesses are used.  Consider this example:
> +
> +	union {
> +		u32	w;
> +		u16	h[2];
> +	} x;
> +
> +	P0()
> +	{
> +		WRITE_ONCE(x.h[0], 0x1234);
> +		WRITE_ONCE(x.h[1], 0x5678);
> +	}
> +
> +	P1()
> +	{
> +		int r1;
> +
> +		r1 = READ_ONCE(x.w);
> +	}
> +
> +If r1 = 0x56781234 (little-endian!) at the end, then P1 must have read
> +from both of P0's stores.  It is possible to handle mixed-size and
> +unaligned accesses in a memory model, but the LKMM currently does not
> +attempt to do so.  It requires all accesses to be properly aligned and
> +of the location's actual size.
> +
> +
> +CACHE COHERENCE AND THE COHERENCE ORDER RELATION: co, coi, and coe
> +------------------------------------------------------------------
> +
> +Cache coherence is a general principle requiring that in a
> +multi-processor system, the CPUs must share a consistent view of the
> +memory contents.  Specifically, it requires that for each location in
> +shared memory, the stores to that location must form a single global
> +ordering which all the CPUs agree on (the coherence order), and this
> +ordering must be consistent with the program order for accesses to
> +that location.
> +
> +To put it another way, for any variable x, the coherence order (co) of
> +the stores to x is simply the order in which the stores overwrite one
> +another.  The imaginary store which establishes x's initial value
> +comes first in the coherence order; the store which directly
> +overwrites the initial value comes second; the store which overwrites
> +that value comes third, and so on.
> +
> +You can think of the coherence order as being the order in which the
> +stores reach x's location in memory (or if you prefer a more
> +hardware-centric view, the order in which the stores get written to
> +x's cache line).  We write W ->co W' if W comes before W' in the
> +coherence order, that is, if the value stored by W gets overwritten,
> +directly or indirectly, by the value stored by W'.
> +
> +Coherence order is required to be consistent with program order.  This
> +requirement takes the form of four coherency rules:
> +
> +	Write-write coherence: If W ->po-loc W' (i.e., W comes before
> +	W' in program order and they access the same location), where W
> +	and W' are two stores, then W ->co W'.
> +
> +	Write-read coherence: If W ->po-loc R, where W is a store and R
> +	is a load, then R must read from W or from some other store
> +	which comes after W in the coherence order.
> +
> +	Read-write coherence: If R ->po-loc W, where R is a load and W
> +	is a store, then the store which R reads from must come before
> +	W in the coherence order.
> +
> +	Read-read coherence: If R ->po-loc R', where R and R' are two
> +	loads, then either they read from the same store or else the
> +	store read by R comes before the store read by R' in the
> +	coherence order.
> +
> +This is sometimes referred to as sequential consistency per variable,
> +because it means that the accesses to any single memory location obey
> +the rules of the Sequential Consistency memory model.  (According to
> +Wikipedia, sequential consistency per variable and cache coherence
> +mean the same thing except that cache coherence includes an extra
> +requirement that every store eventually becomes visible to every CPU.)
> +
> +Any reasonable memory model will include cache coherence.  Indeed, our
> +expectation of cache coherence is so deeply ingrained that violations
> +of its requirements look more like hardware bugs than programming
> +errors:
> +
> +	int x;
> +
> +	P0()
> +	{
> +		WRITE_ONCE(x, 17);
> +		WRITE_ONCE(x, 23);
> +	}
> +
> +If the final value stored in x after this code ran was 17, you would
> +think your computer was broken.  It would be a violation of the
> +write-write coherence rule: Since the store of 23 comes later in
> +program order, it must also come later in x's coherence order and
> +thus must overwrite the store of 17.
> +
> +	int x = 0;
> +
> +	P0()
> +	{
> +		int r1;
> +
> +		r1 = READ_ONCE(x);
> +		WRITE_ONCE(x, 666);
> +	}
> +
> +If r1 = 666 at the end, this would violate the read-write coherence
> +rule: The READ_ONCE() load comes before the WRITE_ONCE() store in
> +program order, so it must not read from that store but rather from one
> +coming earlier in the coherence order (in this case, x's initial
> +value).
> +
> +	int x = 0;
> +
> +	P0()
> +	{
> +		WRITE_ONCE(x, 5);
> +	}
> +
> +	P1()
> +	{
> +		int r1, r2;
> +
> +		r1 = READ_ONCE(x);
> +		r2 = READ_ONCE(x);
> +	}
> +
> +If r1 = 5 (reading from P0's store) and r2 = 0 (reading from the
> +imaginary store which establishes x's initial value) at the end, this
> +would violate the read-read coherence rule: The r1 load comes before
> +the r2 load in program order, so it must not read from a store that
> +comes later in the coherence order.
> +
> +(As a minor curiosity, if this code had used normal loads instead of
> +READ_ONCE() in P1, on Itanium it sometimes could end up with r1 = 5
> +and r2 = 0!  This results from parallel execution of the operations
> +encoded in Itanium's Very-Long-Instruction-Word format, and it is yet
> +another motivation for using READ_ONCE() when accessing shared memory
> +locations.)
> +
> +Just like the po relation, co is inherently an ordering -- it is not
> +possible for a store to directly or indirectly overwrite itself!  And
> +just like with the rf relation, we distinguish between stores that
> +occur on the same CPU (internal coherence order, or coi) and stores
> +that occur on different CPUs (external coherence order, or coe).
> +
> +On the other hand, stores to different memory locations are never
> +related by co, just as instructions on different CPUs are never
> +related by po.  Coherence order is strictly per-location, or if you
> +prefer, each location has its own independent coherence order.
> +
> +
> +THE FROM-READS RELATION: fr, fri, and fre
> +-----------------------------------------
> +
> +The from-reads relation (fr) can be a little difficult for people to
> +grok.  It describes the situation where a load reads a value that gets
> +overwritten by a store.  In other words, we have R ->fr W when the
> +value that R reads is overwritten (directly or indirectly) by W, or
> +equivalently, when R reads from a store which comes earlier than W in
> +the coherence order.
> +
> +For example:
> +
> +	int x = 0;
> +
> +	P0()
> +	{
> +		int r1;
> +
> +		r1 = READ_ONCE(x);
> +		WRITE_ONCE(x, 2);
> +	}
> +
> +The value loaded from x will be 0 (assuming cache coherence!), and it
> +gets overwritten by the value 2.  Thus there is an fr link from the
> +READ_ONCE() to the WRITE_ONCE().  If the code contained any later
> +stores to x, there would also be fr links from the READ_ONCE() to
> +them.
> +
> +As with rf, rfi, and rfe, we subdivide the fr relation into fri (when
> +the load and the store are on the same CPU) and fre (when they are on
> +different CPUs).
> +
> +Note that the fr relation is determined entirely by the rf and co
> +relations; it is not independent.  Given a read event R and a write
> +event W for the same location, we will have R ->fr W if and only if
> +the write which R reads from is co-before W.  In symbols,
> +
> +	(R ->fr W) := (there exists W' with W' ->rf R and W' ->co W).
> +
> +
> +AN OPERATIONAL MODEL
> +--------------------
> +
> +The LKMM is based on various operational memory models, meaning that
> +the models arise from an abstract view of how a computer system
> +operates.  Here are the main ideas, as incorporated into the LKMM.
> +
> +The system as a whole is divided into the CPUs and a memory subsystem.
> +The CPUs are responsible for executing instructions (not necessarily
> +in program order), and they communicate with the memory subsystem.
> +For the most part, executing an instruction requires a CPU to perform
> +only internal operations.  However, loads, stores, and fences involve
> +more.
> +
> +When CPU C executes a store instruction, it tells the memory subsystem
> +to store a certain value at a certain location.  The memory subsystem
> +propagates the store to all the other CPUs as well as to RAM.  (As a
> +special case, we say that the store propagates to its own CPU at the
> +time it is executed.)  The memory subsystem also determines where the
> +store falls in the location's coherence order.  In particular, it must
> +arrange for the store to be co-later than (i.e., to overwrite) any
> +other store to the same location which has already propagated to CPU C.
> +
> +When a CPU executes a load instruction R, it first checks to see
> +whether there are any as-yet unexecuted store instructions, for the
> +same location, that come before R in program order.  If there are, it
> +uses the value of the po-latest such store as the value obtained by R,
> +and we say that the store's value is forwarded to R.  Otherwise, the
> +CPU asks the memory subsystem for the value to load and we say that R
> +is satisfied from memory.  The memory subsystem hands back the value
> +of the co-latest store to the location in question which has already
> +propagated to that CPU.
> +
> +(In fact, the picture needs to be a little more complicated than this.
> +CPUs have local caches, and propagating a store to a CPU really means
> +propagating it to the CPU's local cache.  A local cache can take some
> +time to process the stores that it receives, and a store can't be used
> +to satisfy one of the CPU's loads until it has been processed.  On
> +most architectures, the local caches process stores in
> +First-In-First-Out order, and consequently the processing delay
> +doesn't matter for the memory model.  But on Alpha, the local caches
> +have a partitioned design that results in non-FIFO behavior.  We will
> +discuss this in more detail later.)
> +
> +Note that load instructions may be executed speculatively and may be
> +restarted under certain circumstances.  The memory model ignores these
> +premature executions; we simply say that the load executes at the
> +final time it is forwarded or satisfied.
> +
> +Executing a fence (or memory barrier) instruction doesn't require a
> +CPU to do anything special other than informing the memory subsystem
> +about the fence.  However, fences do constrain the way CPUs and the
> +memory subsystem handle other instructions, in two respects.
> +
> +First, a fence forces the CPU to execute various instructions in
> +program order.  Exactly which instructions are ordered depends on the
> +type of fence:
> +
> +	Strong fences, including smp_mb() and synchronize_rcu(), force
> +	the CPU to execute all po-earlier instructions before any
> +	po-later instructions;
> +
> +	smp_rmb() forces the CPU to execute all po-earlier loads
> +	before any po-later loads;
> +
> +	smp_wmb() forces the CPU to execute all po-earlier stores
> +	before any po-later stores;
> +
> +	Acquire fences, such as smp_load_acquire(), force the CPU to
> +	execute the load associated with the fence (e.g., the load
> +	part of an smp_load_acquire()) before any po-later
> +	instructions;
> +
> +	Release fences, such as smp_store_release(), force the CPU to
> +	execute all po-earlier instructions before the store
> +	associated with the fence (e.g., the store part of an
> +	smp_store_release()).
> +
> +Second, some types of fence affect the way the memory subsystem
> +propagates stores.  When a fence instruction is executed on CPU C:
> +
> +	For each other CPU C', smb_wmb() forces all po-earlier stores
> +	on C to propagate to C' before any po-later stores do.
> +
> +	For each other CPU C', any store which propagates to C before
> +	a release fence is executed (including all po-earlier
> +	stores executed on C) is forced to propagate to C' before the
> +	store associated with the release fence does.
> +
> +	Any store which propagates to C before a strong fence is
> +	executed (including all po-earlier stores on C) is forced to
> +	propagate to all other CPUs before any instructions po-after
> +	the strong fence are executed on C.
> +
> +The propagation ordering enforced by release fences and strong fences
> +affects stores from other CPUs that propagate to CPU C before the
> +fence is executed, as well as stores that are executed on C before the
> +fence.  We describe this property by saying that release fences and
> +strong fences are A-cumulative.  By contrast, smp_wmb() fences are not
> +A-cumulative; they only affect the propagation of stores that are
> +executed on C before the fence (i.e., those which precede the fence in
> +program order).
> +
> +smp_read_barrier_depends(), rcu_read_lock(), rcu_read_unlock(), and
> +synchronize_rcu() fences have other properties which we discuss later.
> +
> +
> +PROPAGATION ORDER RELATION: cumul-fence
> +---------------------------------------
> +
> +The fences which affect propagation order (i.e., strong, release, and
> +smp_wmb() fences) are collectively referred to as cumul-fences, even
> +though smp_wmb() isn't A-cumulative.  The cumul-fence relation is
> +defined to link memory access events E and F whenever:
> +
> +	E and F are both stores on the same CPU and an smp_wmb() fence
> +	event occurs between them in program order; or
> +
> +	F is a release fence and some X comes before F in program order,
> +	where either X = E or else E ->rf X; or
> +
> +	A strong fence event occurs between some X and F in program
> +	order, where either X = E or else E ->rf X.
> +
> +The operational model requires that whenever W and W' are both stores
> +and W ->cumul-fence W', then W must propagate to any given CPU
> +before W' does.  However, for different CPUs C and C', it does not
> +require W to propagate to C before W' propagates to C'.
> +
> +
> +DERIVATION OF THE LKMM FROM THE OPERATIONAL MODEL
> +-------------------------------------------------
> +
> +The LKMM is derived from the restrictions imposed by the design
> +outlined above.  These restrictions involve the necessity of
> +maintaining cache coherence and the fact that a CPU can't operate on a
> +value before it knows what that value is, among other things.
> +
> +The formal version of the LKMM is defined by five requirements, or
> +axioms:
> +
> +	Sequential consistency per variable: This requires that the
> +	system obey the four coherency rules.
> +
> +	Atomicity: This requires that atomic read-modify-write
> +	operations really are atomic, that is, no other stores can
> +	sneak into the middle of such an update.
> +
> +	Happens-before: This requires that certain instructions are
> +	executed in a specific order.
> +
> +	Propagation: This requires that certain stores propagate to
> +	CPUs and to RAM in a specific order.
> +
> +	Rcu: This requires that RCU read-side critical sections and
> +	grace periods obey the rules of RCU, in particular, the
> +	Grace-Period Guarantee.
> +
> +The first and second are quite common; they can be found in many
> +memory models (such as those for C11/C++11).  The "happens-before" and
> +"propagation" axioms have analogs in other memory models as well.  The
> +"rcu" axiom is specific to the LKMM.
> +
> +Each of these axioms is discussed below.
> +
> +
> +SEQUENTIAL CONSISTENCY PER VARIABLE
> +-----------------------------------
> +
> +According to the principle of cache coherence, the stores to any fixed
> +shared location in memory form a global ordering.  We can imagine
> +inserting the loads from that location into this ordering, by placing
> +each load between the store that it reads from and the following
> +store.  This leaves the relative positions of loads that read from the
> +same store unspecified; let's say they are inserted in program order,
> +first for CPU 0, then CPU 1, etc.
> +
> +You can check that the four coherency rules imply that the rf, co, fr,
> +and po-loc relations agree with this global ordering; in other words,
> +whenever we have X ->rf Y or X ->co Y or X ->fr Y or X ->po-loc Y, the
> +X event comes before the Y event in the global ordering.  The LKMM's
> +"coherence" axiom expresses this by requiring the union of these
> +relations not to have any cycles.  This means it must not be possible
> +to find events
> +
> +	X0 -> X1 -> X2 -> ... -> Xn -> X0,
> +
> +where each of the links is either rf, co, fr, or po-loc.  This has to
> +hold if the accesses to the fixed memory location can be ordered as
> +cache coherence demands.
> +
> +Although it is not obvious, it can be shown that the converse is also
> +true: This LKMM axiom implies that the four coherency rules are
> +obeyed.
> +
> +
> +ATOMIC UPDATES: rmw
> +-------------------
> +
> +What does it mean to say that a read-modify-write (rmw) update, such
> +as atomic_inc(&x), is atomic?  It means that the memory location (x in
> +this case) does not get altered between the read and the write events
> +making up the atomic operation.  In particular, if two CPUs perform
> +atomic_inc(&x) concurrently, it must be guaranteed that the final
> +value of x will be the initial value plus two.  We should never have
> +the following sequence of events:
> +
> +	CPU 0 loads x obtaining 13;
> +					CPU 1 loads x obtaining 13;
> +	CPU 0 stores 14 to x;
> +					CPU 1 stores 14 to x;
> +
> +where the final value of x is wrong (14 rather than 15).
> +
> +In this example, CPU 0's increment effectively gets lost because it
> +occurs in between CPU 1's load and store.  To put it another way, the
> +problem is that the position of CPU 0's store in x's coherence order
> +is between the store that CPU 1 reads from and the store that CPU 1
> +performs.
> +
> +The same analysis applies to all atomic update operations.  Therefore,
> +to enforce atomicity the LKMM requires that atomic updates follow this
> +rule: Whenever R and W are the read and write events composing an
> +atomic read-modify-write and W' is the write event which R reads from,
> +there must not be any stores coming between W' and W in the coherence
> +order.  Equivalently,
> +
> +	(R ->rmw W) implies (there is no X with R ->fr X and X ->co W),
> +
> +where the rmw relation links the read and write events making up each
> +atomic update.  This is what the LKMM's "atomic" axiom says.
> +
> +
> +THE PRESERVED PROGRAM ORDER RELATION: ppo
> +-----------------------------------------
> +
> +There are many situations where a CPU is obligated to execute two
> +instructions in program order.  We amalgamate them into the ppo (for
> +"preserved program order") relation, which links the po-earlier
> +instruction to the po-later instruction and is thus a sub-relation of
> +po.
> +
> +The operational model already includes a description of one such
> +situation: Fences are a source of ppo links.  Suppose X and Y are
> +memory accesses with X ->po Y; then the CPU must execute X before Y if
> +any of the following hold:
> +
> +	A strong (smp_mb() or synchronize_rcu()) fence occurs between
> +	X and Y;
> +
> +	X and Y are both stores and an smp_wmb() fence occurs between
> +	them;
> +
> +	X and Y are both loads and an smp_rmb() fence occurs between
> +	them;
> +
> +	X is also an acquire fence, such as smp_load_acquire();
> +
> +	Y is also a release fence, such as smp_store_release().
> +
> +Another possibility, not mentioned earlier but discussed in the next
> +section, is:
> +
> +	X and Y are both loads, X ->addr Y (i.e., there is an address
> +	dependency from X to Y), and an smp_read_barrier_depends()
> +	fence occurs between them.
> +
> +Dependencies can also cause instructions to be executed in program
> +order.  This is uncontroversial when the second instruction is a
> +store; either a data, address, or control dependency from a load R to
> +a store W will force the CPU to execute R before W.  This is very
> +simply because the CPU cannot tell the memory subsystem about W's
> +store before it knows what value should be stored (in the case of a
> +data dependency), what location it should be stored into (in the case
> +of an address dependency), or whether the store should actually take
> +place (in the case of a control dependency).
> +
> +Dependencies to load instructions are more problematic.  To begin with,
> +there is no such thing as a data dependency to a load.  Next, a CPU
> +has no reason to respect a control dependency to a load, because it
> +can always satisfy the second load speculatively before the first, and
> +then ignore the result if it turns out that the second load shouldn't
> +be executed after all.  And lastly, the real difficulties begin when
> +we consider address dependencies to loads.
> +
> +To be fair about it, all Linux-supported architectures do execute
> +loads in program order if there is an address dependency between them.
> +After all, a CPU cannot ask the memory subsystem to load a value from
> +a particular location before it knows what that location is.  However,
> +the split-cache design used by Alpha can cause it to behave in a way
> +that looks as if the loads were executed out of order (see the next
> +section for more details).  For this reason, the LKMM does not include
> +address dependencies between read events in the ppo relation unless an
> +smp_read_barrier_depends() fence is present.
> +
> +On the other hand, dependencies can indirectly affect the ordering of
> +two loads.  This happens when there is a dependency from a load to a
> +store and a second, po-later load reads from that store:
> +
> +	R ->dep W ->rfi R',
> +
> +where the dep link can be either an address or a data dependency.  In
> +this situation we know it is possible for the CPU to execute R' before
> +W, because it can forward the value that W will store to R'.  But it
> +cannot execute R' before R, because it cannot forward the value before
> +it knows what that value is, or that W and R' do access the same
> +location.  However, if there is merely a control dependency between R
> +and W then the CPU can speculatively forward W to R' before executing
> +R; if the speculation turns out to be wrong then the CPU merely has to
> +restart or abandon R'.
> +
> +(In theory, a CPU might forward a store to a load when it runs across
> +an address dependency like this:
> +
> +	r1 = READ_ONCE(ptr);
> +	WRITE_ONCE(*r1, 17);
> +	r2 = READ_ONCE(*r1);
> +
> +because it could tell that the store and the second load access the
> +same location even before it knows what the location's address is.
> +However, none of the architectures supported by the Linux kernel do
> +this.)
> +
> +Two memory accesses of the same location must always be executed in
> +program order if the second access is a store.  Thus, if we have
> +
> +	R ->po-loc W
> +
> +(the po-loc link says that R comes before W in program order and they
> +access the same location), the CPU is obliged to execute W after R.
> +If it executed W first then the memory subsystem would respond to R's
> +read request with the value stored by W (or an even later store), in
> +violation of the read-write coherence rule.  Similarly, if we had
> +
> +	W ->po-loc W'
> +
> +and the CPU executed W' before W, then the memory subsystem would put
> +W' before W in the coherence order.  It would effectively cause W to
> +overwrite W', in violation of the write-write coherence rule.
> +(Interestingly, an early ARMv8 memory model, now obsolete, proposed
> +allowing out-of-order writes like this to occur.  The model avoided
> +violating the write-write coherence rule by requiring the CPU not to
> +send the W write to the memory subsystem at all!)
> +
> +There is one last example of preserved program order in the LKMM: when
> +a load-acquire reads from an earlier store-release.  For example:
> +
> +	smp_store_release(&x, 123);
> +	r1 = smp_load_acquire(&x);
> +
> +If the smp_load_acquire() ends up obtaining the 123 value that was
> +stored by the smp_store_release(), the LKMM says that the load must be
> +executed after the store; the store cannot be forwarded to the load.
> +This requirement does not arise from the operational model, but it
> +yields correct predictions on all architectures supported by the Linux
> +kernel, although for differing reasons.
> +
> +On some architectures, including x86 and ARMv8, it is true that the
> +store cannot be forwarded to the load.  On others, including PowerPC
> +and ARMv7, smp_store_release() generates object code that starts with
> +a fence and smp_load_acquire() generates object code that ends with a
> +fence.  The upshot is that even though the store may be forwarded to
> +the load, it is still true that any instruction preceding the store
> +will be executed before the load or any following instructions, and
> +the store will be executed before any instruction following the load.
> +
> +
> +AND THEN THERE WAS ALPHA
> +------------------------
> +
> +As mentioned above, the Alpha architecture is unique in that it does
> +not appear to respect address dependencies to loads.  This means that
> +code such as the following:
> +
> +	int x = 0;
> +	int y = -1;
> +	int *ptr = &y;
> +
> +	P0()
> +	{
> +		WRITE_ONCE(x, 1);
> +		smp_wmb();
> +		WRITE_ONCE(ptr, &x);
> +	}
> +
> +	P1()
> +	{
> +		int *r1;
> +		int r2;
> +
> +		r1 = READ_ONCE(ptr);
> +		r2 = READ_ONCE(*r1);
> +	}
> +
> +can malfunction on Alpha systems.  It is quite possible that r1 = &x
> +and r2 = 0 at the end, in spite of the address dependency.
> +
> +At first glance this doesn't seem to make sense.  We know that the
> +smp_wmb() forces P0's store to x to propagate to P1 before the store
> +to ptr does.  And since P1 can't execute its second load
> +until it knows what location to load from, i.e., after executing its
> +first load, the value x = 1 must have propagated to P1 before the
> +second load executed.  So why doesn't r2 end up equal to 1?
> +
> +The answer lies in the Alpha's split local caches.  Although the two
> +stores do reach P1's local cache in the proper order, it can happen
> +that the first store is processed by a busy part of the cache while
> +the second store is processed by an idle part.  As a result, the x = 1
> +value may not become available for P1's CPU to read until after the
> +ptr = &x value does, leading to the undesirable result above.  The
> +final effect is that even though the two loads really are executed in
> +program order, it appears that they aren't.
> +
> +This could not have happened if the local cache had processed the
> +incoming stores in FIFO order.  In constrast, other architectures
> +maintain at least the appearance of FIFO order.
> +
> +In practice, this difficulty is solved by inserting an
> +smp_read_barrier_depends() fence between P1's two loads.  The effect
> +of this fence is to cause the CPU not to execute any po-later
> +instructions until after the local cache has finished processing all
> +the stores it has already received.  Thus, if the code was changed to:
> +
> +	P1()
> +	{
> +		int *r1;
> +		int r2;
> +
> +		r1 = READ_ONCE(ptr);
> +		smp_read_barrier_depends();
> +		r2 = READ_ONCE(*r1);
> +	}
> +
> +then we would never get r1 = &x and r2 = 0.  By the time P1 executed
> +its second load, the x = 1 store would already be fully processed by
> +the local cache and available for satisfying the read request.
> +
> +The LKMM requires that smp_rmb(), acquire fences, and strong fences
> +share this property with smp_read_barrier_depends(): They do not allow
> +the CPU to execute any po-later instructions (or po-later loads in the
> +case of smp_rmb()) until all outstanding stores have been processed by
> +the local cache.  In the case of a strong fence, the CPU first has to
> +wait for all of its po-earlier stores to propagate to every other CPU
> +in the system; then it has to wait for the local cache to process all
> +the stores received as of that time -- not just the stores received
> +when the strong fence began.
> +
> +And of course, none of this matters for any architecture other than
> +Alpha.
> +
> +
> +THE HAPPENS-BEFORE RELATION: hb
> +-------------------------------
> +
> +The happens-before relation (hb) links memory accesses that have to
> +execute in a certain order.  hb includes the ppo relation and two
> +others, one of which is rfe.
> +
> +W ->rfe R implies that W and R are on different CPUs.  It also means
> +that W's store must have propagated to R's CPU before R executed;
> +otherwise R could not have read the value stored by W.  Therefore W
> +must have executed before R, and so we have W ->hb R.
> +
> +The equivalent fact need not hold if W ->rfi R (i.e., W and R are on
> +the same CPU).  As we have already seen, the operational model allows
> +W's value to be forwarded to R in such cases, meaning that R may well
> +execute before W does.
> +
> +It's important to understand that neither coe nor fre is included in
> +hb, despite their similarities to rfe.  For example, suppose we have
> +W ->coe W'.  This means that W and W' are stores to the same location,
> +they execute on different CPUs, and W comes before W' in the coherence
> +order (i.e., W' overwrites W).  Nevertheless, it is possible for W' to
> +execute before W, because the decision as to which store overwrites
> +the other is made later by the memory subsystem.  When the stores are
> +nearly simultaneous, either one can come out on top.  Similarly,
> +R ->fre W means that W overwrites the value which R reads, but it
> +doesn't mean that W has to execute after R.  All that's necessary is
> +for the memory subsystem not to propagate W to R's CPU until after R
> +has executed, which is possible if W executes shortly before R.
> +
> +The third relation included in hb is like ppo, in that it only links
> +events that are on the same CPU.  However it is more difficult to
> +explain, because it arises only indirectly from the requirement of
> +cache coherence.  The relation is called prop, and it links two events
> +on CPU C in situations where a store from some other CPU comes after
> +the first event in the coherence order and propagates to C before the
> +second event executes.
> +
> +This is best explained with some examples.  The simplest case looks
> +like this:
> +
> +	int x;
> +
> +	P0()
> +	{
> +		int r1;
> +
> +		WRITE_ONCE(x, 1);
> +		r1 = READ_ONCE(x);
> +	}
> +
> +	P1()
> +	{
> +		WRITE_ONCE(x, 8);
> +	}
> +
> +If r1 = 8 at the end then P0's accesses must have executed in program
> +order.  We can deduce this from the operational model; if P0's load
> +had executed before its store then the value of the store would have
> +been forwarded to the load, so r1 would have ended up equal to 1, not
> +8.  In this case there is a prop link from P0's write event to its read
> +event, because P1's store came after P0's store in x's coherence
> +order, and P1's store propagated to P0 before P0's load executed.
> +
> +An equally simple case involves two loads of the same location that
> +read from different stores:
> +
> +	int x = 0;
> +
> +	P0()
> +	{
> +		int r1, r2;
> +
> +		r1 = READ_ONCE(x);
> +		r2 = READ_ONCE(x);
> +	}
> +
> +	P1()
> +	{
> +		WRITE_ONCE(x, 9);
> +	}
> +
> +If r1 = 0 and r2 = 9 at the end then P0's accesses must have executed
> +in program order.  If the second load had executed before the first
> +then the x = 9 store must have been propagated to P0 before the first
> +load executed, and so r1 would have been 9 rather than 0.  In this
> +case there is a prop link from P0's first read event to its second,
> +because P1's store overwrote the value read by P0's first load, and
> +P1's store propagated to P0 before P0's second load executed.
> +
> +Less trivial examples of prop all involve fences.  Unlike the simple
> +examples above, they can require that some instructions are executed
> +out of program order.  This next one should look familiar:
> +
> +	int buf = 0, flag = 0;
> +
> +	P0()
> +	{
> +		WRITE_ONCE(buf, 1);
> +		smp_wmb();
> +		WRITE_ONCE(flag, 1);
> +	}
> +
> +	P1()
> +	{
> +		int r1;
> +		int r2;
> +
> +		r1 = READ_ONCE(flag);
> +		r2 = READ_ONCE(buf);
> +	}
> +
> +This is the MP pattern again, with an smp_wmb() fence between the two
> +stores.  If r1 = 1 and r2 = 0 at the end then there is a prop link
> +from P1's second load to its first (backwards!).  The reason is
> +similar to the previous examples: The value P1 loads from buf gets
> +overwritten by P0's store to buf, the fence guarantees that the store
> +to buf will propagate to P1 before the store to flag does, and the
> +store to flag propagates to P1 before P1 reads flag.
> +
> +The prop link says that in order to obtain the r1 = 1, r2 = 0 result,
> +P1 must execute its second load before the first.  Indeed, if the load
> +from flag were executed first, then the buf = 1 store would already
> +have propagated to P1 by the time P1's load from buf executed, so r2
> +would have been 1 at the end, not 0.  (The reasoning holds even for
> +Alpha, although the details are more complicated and we will not go
> +into them.)
> +
> +But what if we put an smp_rmb() fence between P1's loads?  The fence
> +would force the two loads to be executed in program order, and it
> +would generate a cycle in the hb relation: The fence would create a ppo
> +link (hence an hb link) from the first load to the second, and the
> +prop relation would give an hb link from the second load to the first.
> +Since an instruction can't execute before itself, we are forced to
> +conclude that if an smp_rmb() fence is added, the r1 = 1, r2 = 0
> +outcome is impossible -- as it should be.
> +
> +The formal definition of the prop relation involves a coe or fre link,
> +followed by an arbitrary number of cumul-fence links, ending with an
> +rfe link.  You can concoct more exotic examples, containing more than
> +one fence, although this quickly leads to diminishing returns in terms
> +of complexity.  For instance, here's an example containing a coe link
> +followed by two fences and an rfe link, utilizing the fact that
> +release fences are A-cumulative:
> +
> +	int x, y, z;
> +
> +	P0()
> +	{
> +		int r0;
> +
> +		WRITE_ONCE(x, 1);
> +		r0 = READ_ONCE(z);
> +	}
> +
> +	P1()
> +	{
> +		WRITE_ONCE(x, 2);
> +		smp_wmb();
> +		WRITE_ONCE(y, 1);
> +	}
> +
> +	P2()
> +	{
> +		int r2;
> +
> +		r2 = READ_ONCE(y);
> +		smp_store_release(&z, 1);
> +	}
> +
> +If x = 2, r0 = 1, and r2 = 1 after this code runs then there is a prop
> +link from P0's store to its load.  This is because P0's store gets
> +overwritten by P1's store since x = 2 at the end (a coe link), the
> +smp_wmb() ensures that P1's store to x propagates to P2 before the
> +store to y does (the first fence), the store to y propagates to P2
> +before P2's load and store execute, P2's smp_store_release()
> +guarantees that the stores to x and y both propagate to P0 before the
> +store to z does (the second fence), and P0's load executes after the
> +store to z has propagated to P0 (an rfe link).
> +
> +In summary, the fact that the hb relation links memory access events
> +in the order they execute means that it must not have cycles.  This
> +requirement is the content of the LKMM's "happens-before" axiom.
> +
> +The LKMM defines yet another relation connected to times of
> +instruction execution, but it is not included in hb.  It relies on the
> +particular properties of strong fences, which we cover in the next
> +section.
> +
> +
> +THE PROPAGATES-BEFORE RELATION: pb
> +----------------------------------
> +
> +The propagates-before (pb) relation capitalizes on the special
> +features of strong fences.  It links two events E and F whenever some
> +store is coherence-later than E and propagates to every CPU and to RAM
> +before F executes.  The formal definition requires that E be linked to
> +F via a coe or fre link, an arbitrary number of cumul-fences, an
> +optional rfe link, a strong fence, and an arbitrary number of hb
> +links.  Let's see how this definition works out.
> +
> +Consider first the case where E is a store (implying that the sequence
> +of links begins with coe).  Then there are events W, X, Y, and Z such
> +that:
> +
> +	E ->coe W ->cumul-fence* X ->rfe? Y ->strong-fence Z ->hb* F,
> +
> +where the * suffix indicates an arbitrary number of links of the
> +specified type, and the ? suffix indicates the link is optional (Y may
> +be equal to X).  Because of the cumul-fence links, we know that W will
> +propagate to Y's CPU before X does, hence before Y executes and hence
> +before the strong fence executes.  Because this fence is strong, we
> +know that W will propagate to every CPU and to RAM before Z executes.
> +And because of the hb links, we know that Z will execute before F.
> +Thus W, which comes later than E in the coherence order, will
> +propagate to every CPU and to RAM before F executes.
> +
> +The case where E is a load is exactly the same, except that the first
> +link in the sequence is fre instead of coe.
> +
> +The existence of a pb link from E to F implies that E must execute
> +before F.  To see why, suppose that F executed first.  Then W would
> +have propagated to E's CPU before E executed.  If E was a store, the
> +memory subsystem would then be forced to make E come after W in the
> +coherence order, contradicting the fact that E ->coe W.  If E was a
> +load, the memory subsystem would then be forced to satisfy E's read
> +request with the value stored by W or an even later store,
> +contradicting the fact that E ->fre W.
> +
> +A good example illustrating how pb works is the SB pattern with strong
> +fences:
> +
> +	int x = 0, y = 0;
> +
> +	P0()
> +	{
> +		int r0;
> +
> +		WRITE_ONCE(x, 1);
> +		smp_mb();
> +		r0 = READ_ONCE(y);
> +	}
> +
> +	P1()
> +	{
> +		int r1;
> +
> +		WRITE_ONCE(y, 1);
> +		smp_mb();
> +		r1 = READ_ONCE(x);
> +	}
> +
> +If r0 = 0 at the end then there is a pb link from P0's load to P1's
> +load: an fre link from P0's load to P1's store (which overwrites the
> +value read by P0), and a strong fence between P1's store and its load.
> +In this example, the sequences of cumul-fence and hb links are empty.
> +Note that this pb link is not included in hb as an instance of prop,
> +because it does not start and end on the same CPU.
> +
> +Similarly, if r1 = 0 at the end then there is a pb link from P1's load
> +to P0's.  This means that if both r1 and r2 were 0 there would be a
> +cycle in pb, which is not possible since an instruction cannot execute
> +before itself.  Thus, adding smp_mb() fences to the SB pattern
> +prevents the r0 = 0, r1 = 0 outcome.
> +
> +In summary, the fact that the pb relation links events in the order
> +they execute means that it cannot have cycles.  This requirement is
> +the content of the LKMM's "propagation" axiom.
> +
> +
> +RCU RELATIONS: link, gp-link, rscs-link, and rcu-path
> +-----------------------------------------------------
> +
> +RCU (Read-Copy-Update) is a powerful synchronization mechanism.  It
> +rests on two concepts: grace periods and read-side critical sections.
> +
> +A grace period is the span of time occupied by a call to
> +synchronize_rcu().  A read-side critical section (or just critical
> +section, for short) is a region of code delimited by rcu_read_lock()
> +at the start and rcu_read_unlock() at the end.  Critical sections can
> +be nested, although we won't make use of this fact.
> +
> +As far as memory models are concerned, RCU's main feature is its
> +Grace-Period Guarantee, which states that a critical section can never
> +span a full grace period.  In more detail, the Guarantee says:
> +
> +	If a critical section starts before a grace period then it
> +	must end before the grace period does.  In addition, every
> +	store that propagates to the critical section's CPU before the
> +	end of the critical section must propagate to every CPU before
> +	the end of the grace period.
> +
> +	If a critical section ends after a grace period ends then it
> +	must start after the grace period does.  In addition, every
> +	store that propagates to the grace period's CPU before the
> +	start of the grace period must propagate to every CPU before
> +	the start of the critical section.
> +
> +Here is a simple example of RCU in action:
> +
> +	int x, y;
> +
> +	P0()
> +	{
> +		rcu_read_lock();
> +		WRITE_ONCE(x, 1);
> +		WRITE_ONCE(y, 1);
> +		rcu_read_unlock();
> +	}
> +
> +	P1()
> +	{
> +		int r1, r2;
> +
> +		r1 = READ_ONCE(x);
> +		synchronize_rcu();
> +		r2 = READ_ONCE(y);
> +	}
> +
> +The Grace Period Guarantee tells us that when this code runs, it will
> +never end with r1 = 1 and r2 = 0.  The reasoning is as follows.  r1 = 1
> +means that P0's store to x propagated to P1 before P1 called
> +synchronize_rcu(), so P0's critical section must have started before
> +P1's grace period.  On the other hand, r2 = 0 means that P0's store to
> +y, which occurs before the end of the critical section, did not
> +propagate to P1 before the end of the grace period, violating the
> +Guarantee.
> +
> +In the kernel's implementations of RCU, the business about stores
> +propagating to every CPU is realized by placing strong fences at
> +suitable places in the RCU-related code.  Thus, if a critical section
> +starts before a grace period does then the critical section's CPU will
> +execute an smp_mb() fence after the end of the critical section and
> +some time before the grace period's synchronize_rcu() call returns.
> +And if a critical section ends after a grace period does then the
> +synchronize_rcu() routine will execute an smp_mb() fence at its start
> +and some time before the critical section's opening rcu_read_lock()
> +executes.
> +
> +What exactly do we mean by saying that a critical section "starts
> +before" or "ends after" a grace period?  Some aspects of the meaning
> +are pretty obvious, as in the example above, but the details aren't
> +entirely clear.  The LKMM formalizes this notion by means of a
> +relation with the unfortunately generic name "link".  It is a very
> +general relation; among other things, X ->link Z includes cases where
> +X happens-before or is equal to some event Y which is equal to or
> +comes before Z in the coherence order.  Taking Y = Z, this says that
> +X ->rfe Z implies X ->link Z, and taking Y = X, it says that X ->fr Z
> +and X ->co Z each imply X ->link Z.
> +
> +The formal definition of the link relation is more than a little
> +obscure, and we won't give it here.  It is closely related to the pb
> +relation, and the details don't matter unless you want to comb through
> +a somewhat lengthy formal proof.  Pretty much all you need to know
> +about link is the information in the preceding paragraph.
> +
> +The LKMM goes on to define the gp-link and rscs-link relations.  They
> +bring grace periods and read-side critical sections into the picture,
> +in the following way:
> +
> +	E ->gp-link F means there is a synchronize_rcu() fence event S
> +	and an event X such that E ->po S, either S ->po X or S = X,
> +	and X ->link F.  In other words, E and F are connected by a
> +	grace period followed by an instance of link.
> +
> +	E ->rscs-link F means there is a critical section delimited by
> +	an rcu_read_lock() fence L and an rcu_read_unlock() fence U,
> +	and an event X such that E ->po U, either L ->po X or L = X,
> +	and X ->link F.  Roughly speaking, this says that some event
> +	in the same critical section as E is connected by link to F.
> +
> +If we think of the link relation as standing for an extended "before",
> +then E ->gp-link F says that E executes before a grace period which
> +ends before F executes.  (In fact it says more than this, because it
> +includes cases where E executes before a grace period and some store
> +propagates to F's CPU before F executes and doesn't propagate to some
> +other CPU until after the grace period ends.)  Similarly,
> +E ->rscs-link F says that E is part of (or before the start of) a
> +critical section which starts before F executes.
> +
> +Putting this all together, the LKMM expresses the Grace Period
> +Guarantee by requiring that there are no cycles consisting of gp-link
> +and rscs-link connections in which the number of gp-link instances is
> +>= the number of rscs-link instances.  It does this by defining the
> +rcu-path relation to link events E and F whenever it is possible to
> +pass from E to F by a sequence of gp-link and rscs-link connections
> +with at least as many of the former as the latter.  The LKMM's "rcu"
> +axiom then says that there are no events E such that E ->rcu-path E.
> +
> +Justifying this axiom takes some intellectual effort, but it is in
> +fact a valid formalization of the Grace Period Guarantee.  We won't
> +attempt to go through the detailed argument, but the following
> +analysis gives a taste of what is involved.  Suppose we have a
> +violation of the first part of the Guarantee: A critical section
> +starts before a grace period, and some store propagates to the
> +critical section's CPU before the end of the critical section but
> +doesn't propagate to some other CPU until after the end of the grace
> +period.
> +
> +Putting symbols to these ideas, let L and U be the rcu_read_lock() and
> +rcu_read_unlock() fence events delimiting the critical section in
> +question, and let S be the synchronize_rcu() fence event for the grace
> +period.  Saying that the critical section starts before S means there
> +are events E and F where E is po-after L (which marks the start of the
> +critical section), E is "before" F in the sense of the link relation,
> +and F is po-before the grace period S:
> +
> +	L ->po E ->link F ->po S.
> +
> +Let W be the store mentioned above, let Z come before the end of the
> +critical section and witness that W propagates to the critical
> +section's CPU by reading from W, and let Y on some arbitrary CPU be a
> +witness that W has not propagated to that CPU, where Y happens after
> +some event X which is po-after S.  Symbolically, this amounts to:
> +
> +	S ->po X ->hb* Y ->fr W ->rf Z ->po U.
> +
> +The fr link from Y to W indicates that W has not propagated to Y's CPU
> +at the time that Y executes.  From this, it can be shown (see the
> +discussion of the link relation earlier) that X and Z are connected by
> +link, yielding:
> +
> +	S ->po X ->link Z ->po U.
> +
> +These formulas say that S is po-between F and X, hence F ->gp-link Z
> +via X.  They also say that Z comes before the end of the critical
> +section and E comes after its start, hence Z ->rscs-link F via E.  But
> +now we have a forbidden cycle: F ->gp-link Z ->rscs-link F.  Thus the
> +"rcu" axiom rules out this violation of the Grace Period Guarantee.
> +
> +For something a little more down-to-earth, let's see how the axiom
> +works out in practice.  Consider the RCU code example from above, this
> +time with statement labels added to the memory access instructions:
> +
> +	int x, y;
> +
> +	P0()
> +	{
> +		rcu_read_lock();
> +		W: WRITE_ONCE(x, 1);
> +		X: WRITE_ONCE(y, 1);
> +		rcu_read_unlock();
> +	}
> +
> +	P1()
> +	{
> +		int r1, r2;
> +
> +		Y: r1 = READ_ONCE(x);
> +		synchronize_rcu();
> +		Z: r2 = READ_ONCE(y);
> +	}
> +
> +
> +If r2 = 0 at the end then P0's store at X overwrites the value
> +that P1's load at Z reads from, so we have Z ->fre X and thus
> +Z ->link X.  In addition, there is a synchronize_rcu() between Y and
> +Z, so therefore we have Y ->gp-link X.
> +
> +If r1 = 1 at the end then P1's load at Y reads from P0's store at W,
> +so we have W ->link Y.  In addition, W and X are in the same critical
> +section, so therefore we have X ->rscs-link Y.
> +
> +This gives us a cycle, Y ->gp-link X ->rscs-link Y, with one gp-link
> +and one rscs-link, violating the "rcu" axiom.  Hence the outcome is
> +not allowed by the LKMM, as we would expect.
> +
> +For contrast, let's see what can happen in a more complicated example:
> +
> +	int x, y, z;
> +
> +	P0()
> +	{
> +		int r0;
> +
> +		rcu_read_lock();
> +		W: r0 = READ_ONCE(x);
> +		X: WRITE_ONCE(y, 1);
> +		rcu_read_unlock();
> +	}
> +
> +	P1()
> +	{
> +		int r1;
> +
> +		Y: r1 = READ_ONCE(y);
> +		synchronize_rcu();
> +		Z: WRITE_ONCE(z, 1);
> +	}
> +
> +	P2()
> +	{
> +		int r2;
> +
> +		rcu_read_lock();
> +		U: r2 = READ_ONCE(z);
> +		V: WRITE_ONCE(x, 1);
> +		rcu_read_unlock();
> +	}
> +
> +If r0 = r1 = r2 = 1 at the end, then similar reasoning to before shows
> +that W ->rscs-link Y via X, Y ->gp-link U via Z, and U ->rscs-link W
> +via V.  And just as before, this gives a cycle:
> +
> +	W ->rscs-link Y ->gp-link U ->rscs-link W.
> +
> +However, this cycle has fewer gp-link instances than rscs-link
> +instances, and consequently the outcome is not forbidden by the LKMM.
> +The following instruction timing diagram shows how it might actually
> +occur:
> +
> +P0			P1			P2
> +--------------------	--------------------	--------------------
> +rcu_read_lock()
> +X: WRITE_ONCE(y, 1)
> +			Y: r1 = READ_ONCE(y)
> +			synchronize_rcu() starts
> +			.			rcu_read_lock()
> +			.			V: WRITE_ONCE(x, 1)
> +W: r0 = READ_ONCE(x)	.
> +rcu_read_unlock()	.
> +			synchronize_rcu() ends
> +			Z: WRITE_ONCE(z, 1)
> +						U: r2 = READ_ONCE(z)
> +						rcu_read_unlock()
> +
> +This requires P0 and P2 to execute their loads and stores out of
> +program order, but of course they are allowed to do so.  And as you
> +can see, the Grace Period Guarantee is not violated: The critical
> +section in P0 both starts before P1's grace period does and ends
> +before it does, and the critical section in P2 both starts after P1's
> +grace period does and ends after it does.
> +
> +
> +ODDS AND ENDS
> +-------------
> +
> +This section covers material that didn't quite fit anywhere in the
> +earlier sections.
> +
> +The descriptions in this document don't always match the formal
> +version of the LKMM exactly.  For example, the actual formal
> +definition of the prop relation makes the initial coe or fre part
> +optional, and it doesn't require the events linked by the relation to
> +be on the same CPU.  These differences are very unimportant; indeed,
> +instances where the coe/fre part of prop is missing are of no interest
> +because all the other parts (fences and rfe) are already included in
> +hb anyway, and where the formal model adds prop into hb, it includes
> +an explicit requirement that the events being linked are on the same
> +CPU.
> +
> +Another minor difference has to do with events that are both memory
> +accesses and fences, such as those corresponding to smp_load_acquire()
> +calls.  In the formal model, these events aren't actually both reads
> +and fences; rather, they are read events with an annotation marking
> +them as acquires.  (Or write events annotated as releases, in the case
> +smp_store_release().)  The final effect is the same.
> +
> +Although we didn't mention it above, the instruction execution
> +ordering provided by the smp_rmb() fence doesn't apply to read events
> +that are part of a non-value-returning atomic update.  For instance,
> +given:
> +
> +	atomic_inc(&x);
> +	smp_rmb();
> +	r1 = READ_ONCE(y);
> +
> +it is not guaranteed that the load from y will execute after the
> +update to x.  This is because the ARMv8 architecture allows
> +non-value-returning atomic operations effectively to be executed off
> +the CPU.  Basically, the CPU tells the memory subsystem to increment
> +x, and then the increment is carried out by the memory hardware with
> +no further involvement from the CPU.  Since the CPU doesn't ever read
> +the value of x, there is nothing for the smp_rmb() fence to act on.
> +
> +The LKMM defines a few extra synchronization operations in terms of
> +things we have already covered.  In particular, rcu_dereference() and
> +lockless_dereference() are both treated as a READ_ONCE() followed by
> +smp_read_barrier_depends() -- which also happens to be how they are
> +defined in include/linux/rcupdate.h and include/linux/compiler.h,
> +respectively.
> +
> +There are a few oddball fences which need special treatment:
> +smp_mb__before_atomic(), smp_mb__after_atomic(), and
> +smp_mb__after_spinlock().  The LKMM uses fence events with special
> +annotations for them; they act as strong fences just like smp_mb()
> +except for the sets of events that they order.  Instead of ordering
> +all po-earlier events against all po-later events, as smp_mb() does,
> +they behave as follows:
> +
> +	smp_mb__before_atomic() orders all po-earlier events against
> +	po-later atomic updates and the events following them;
> +
> +	smp_mb__after_atomic() orders po-earlier atomic updates and
> +	the events preceding them against all po-later events;
> +
> +	smp_mb_after_spinlock() orders po-earlier lock acquisition
> +	events and the events preceding them against all po-later
> +	events.
> +
> +The LKMM includes locking.  In fact, there is special code for locking
> +in the formal model, added in order to make tools run faster.
> +However, this special code is intended to be exactly equivalent to
> +concepts we have already covered.  A spinlock_t variable is treated
> +the same as an int, and spin_lock(&s) is treated the same as:
> +
> +	while (cmpxchg_acquire(&s, 0, 1) != 0)
> +		cpu_relax();
> +
> +which waits until s is equal to 0 and then atomically sets it to 1,
> +and where the read part of the atomic update is also an acquire fence.
> +An alternate way to express the same thing would be:
> +
> +	r = xchg_acquire(&s, 1);
> +
> +along with a requirement that at the end, r = 0.  spin_unlock(&s) is
> +treated the same as:
> +
> +	smp_store_release(&s, 0);
> +
> +Interestingly, RCU and locking each introduce the possibility of
> +deadlock.  When faced with code sequences such as:
> +
> +	spin_lock(&s);
> +	spin_lock(&s);
> +	spin_unlock(&s);
> +	spin_unlock(&s);
> +
> +or:
> +
> +	rcu_read_lock();
> +	synchronize_rcu();
> +	rcu_read_unlock();
> +
> +what does the LKMM have to say?  Answer: It says there are no allowed
> +executions at all, which makes sense.  But this can also lead to
> +misleading results, because if a piece of code has multiple possible
> +executions, some of which deadlock, the model will report only on the
> +non-deadlocking executions.  For example:
> +
> +	int x, y;
> +
> +	P0()
> +	{
> +		int r0;
> +
> +		WRITE_ONCE(x, 1);
> +		r0 = READ_ONCE(y);
> +	}
> +
> +	P1()
> +	{
> +		rcu_read_lock();
> +		if (READ_ONCE(x) > 0) {
> +			WRITE_ONCE(y, 36);
> +			synchronize_rcu();
> +		}
> +		rcu_read_unlock();
> +	}
> +
> +Is it possible to end up with r0 = 36 at the end?  The LKMM will tell
> +you it is not, but the model won't mention that this is because P1
> +will self-deadlock in the executions where it stores 36 in y.
> diff --git a/tools/memory-model/Documentation/recipes.txt b/tools/memory-model/Documentation/recipes.txt
> new file mode 100644
> index 000000000000..ee4309a87fc4
> --- /dev/null
> +++ b/tools/memory-model/Documentation/recipes.txt
> @@ -0,0 +1,570 @@
> +This document provides "recipes", that is, litmus tests for commonly
> +occurring situations, as well as a few that illustrate subtly broken but
> +attractive nuisances.  Many of these recipes include example code from
> +v4.13 of the Linux kernel.
> +
> +The first section covers simple special cases, the second section
> +takes off the training wheels to cover more involved examples,
> +and the third section provides a few rules of thumb.
> +
> +
> +Simple special cases
> +====================
> +
> +This section presents two simple special cases, the first being where
> +there is only one CPU or only one memory location is accessed, and the
> +second being use of that old concurrency workhorse, locking.
> +
> +
> +Single CPU or single memory location
> +------------------------------------
> +
> +If there is only one CPU on the one hand or only one variable
> +on the other, the code will execute in order.  There are (as
> +usual) some things to be careful of:
> +
> +1.	Some aspects of the C language are unordered.  For example,
> +	in the expression "f(x) + g(y)", the order in which f and g are
> +	called is not defined; the object code is allowed to use either
> +	order or even to interleave the computations.
> +
> +2.	Compilers are permitted to use the "as-if" rule.  That is, a
> +	compiler can emit whatever code it likes for normal accesses,
> +	as long as the results of a single-threaded execution appear
> +	just as if the compiler had followed all the relevant rules.
> +	To see this, compile with a high level of optimization and run
> +	the debugger on the resulting binary.
> +
> +3.	If there is only one variable but multiple CPUs, that variable
> +	must be properly aligned and all accesses to that variable must
> +	be full sized.	Variables that straddle cachelines or pages void
> +	your full-ordering warranty, as do undersized accesses that load
> +	from or store to only part of the variable.
> +
> +4.	If there are multiple CPUs, accesses to shared variables should
> +	use READ_ONCE() and WRITE_ONCE() or stronger to prevent load/store
> +	tearing, load/store fusing, and invented loads and stores.
> +	There are exceptions to this rule, including:
> +
> +	i.	When there is no possibility of a given shared variable
> +		being updated by some other CPU, for example, while
> +		holding the update-side lock, reads from that variable
> +		need not use READ_ONCE().
> +
> +	ii.	When there is no possibility of a given shared variable
> +		being either read or updated by other CPUs, for example,
> +		when running during early boot, reads from that variable
> +		need not use READ_ONCE() and writes to that variable
> +		need not use WRITE_ONCE().
> +
> +
> +Locking
> +-------
> +
> +Locking is well-known and straightforward, at least if you don't think
> +about it too hard.  And the basic rule is indeed quite simple: Any CPU that
> +has acquired a given lock sees any changes previously seen or made by any
> +CPU before it released that same lock.  Note that this statement is a bit
> +stronger than "Any CPU holding a given lock sees all changes made by any
> +CPU during the time that CPU was holding this same lock".  For example,
> +consider the following pair of code fragments:
> +
> +	/* See MP+polocks.litmus. */
> +	void CPU0(void)
> +	{
> +		WRITE_ONCE(x, 1);
> +		spin_lock(&mylock);
> +		WRITE_ONCE(y, 1);
> +		spin_unlock(&mylock);
> +	}
> +
> +	void CPU1(void)
> +	{
> +		spin_lock(&mylock);
> +		r0 = READ_ONCE(y);
> +		spin_unlock(&mylock);
> +		r1 = READ_ONCE(x);
> +	}
> +
> +The basic rule guarantees that if CPU0() acquires mylock before CPU1(),
> +then both r0 and r1 must be set to the value 1.  This also has the
> +consequence that if the final value of r0 is equal to 1, then the final
> +value of r1 must also be equal to 1.  In contrast, the weaker rule would
> +say nothing about the final value of r1.
> +
> +The converse to the basic rule also holds, as illustrated by the
> +following litmus test:
> +
> +	/* See MP+porevlocks.litmus. */
> +	void CPU0(void)
> +	{
> +		r0 = READ_ONCE(y);
> +		spin_lock(&mylock);
> +		r1 = READ_ONCE(x);
> +		spin_unlock(&mylock);
> +	}
> +
> +	void CPU1(void)
> +	{
> +		spin_lock(&mylock);
> +		WRITE_ONCE(x, 1);
> +		spin_unlock(&mylock);
> +		WRITE_ONCE(y, 1);
> +	}
> +
> +This converse to the basic rule guarantees that if CPU0() acquires
> +mylock before CPU1(), then both r0 and r1 must be set to the value 0.
> +This also has the consequence that if the final value of r1 is equal
> +to 0, then the final value of r0 must also be equal to 0.  In contrast,
> +the weaker rule would say nothing about the final value of r0.
> +
> +These examples show only a single pair of CPUs, but the effects of the
> +locking basic rule extend across multiple acquisitions of a given lock
> +across multiple CPUs.
> +
> +However, it is not necessarily the case that accesses ordered by
> +locking will be seen as ordered by CPUs not holding that lock.
> +Consider this example:
> +
> +	/* See Z6.0+pooncelock+pooncelock+pombonce.litmus. */
> +	void CPU0(void)
> +	{
> +		spin_lock(&mylock);
> +		WRITE_ONCE(x, 1);
> +		WRITE_ONCE(y, 1);
> +		spin_unlock(&mylock);
> +	}
> +
> +	void CPU1(void)
> +	{
> +		spin_lock(&mylock);
> +		r0 = READ_ONCE(y);
> +		WRITE_ONCE(z, 1);
> +		spin_unlock(&mylock);
> +	}
> +
> +	void CPU2(void)
> +	{
> +		WRITE_ONCE(z, 2);
> +		smp_mb();
> +		r1 = READ_ONCE(x);
> +	}
> +
> +Counter-intuitive though it might be, it is quite possible to have
> +the final value of r0 be 1, the final value of z be 2, and the final
> +value of r1 be 0.  The reason for this surprising outcome is that
> +CPU2() never acquired the lock, and thus did not benefit from the
> +lock's ordering properties.
> +
> +Ordering can be extended to CPUs not holding the lock by careful use
> +of smp_mb__after_spinlock():
> +
> +	/* See Z6.0+pooncelock+poonceLock+pombonce.litmus. */
> +	void CPU0(void)
> +	{
> +		spin_lock(&mylock);
> +		WRITE_ONCE(x, 1);
> +		WRITE_ONCE(y, 1);
> +		spin_unlock(&mylock);
> +	}
> +
> +	void CPU1(void)
> +	{
> +		spin_lock(&mylock);
> +		smp_mb__after_spinlock();
> +		r0 = READ_ONCE(y);
> +		WRITE_ONCE(z, 1);
> +		spin_unlock(&mylock);
> +	}
> +
> +	void CPU2(void)
> +	{
> +		WRITE_ONCE(z, 2);
> +		smp_mb();
> +		r1 = READ_ONCE(x);
> +	}
> +
> +This addition of smp_mb__after_spinlock() strengthens the lock acquisition
> +sufficiently to rule out the counter-intuitive outcome.
> +
> +
> +Taking off the training wheels
> +==============================
> +
> +This section looks at more complex examples, including message passing,
> +load buffering, release-acquire chains, store buffering.
> +Many classes of litmus tests have abbreviated names, which may be found
> +here: https://www.cl.cam.ac.uk/~pes20/ppc-supplemental/test6.pdf
> +
> +
> +Message passing (MP)
> +--------------------
> +
> +The MP pattern has one CPU execute a pair of stores to a pair of variables
> +and another CPU execute a pair of loads from this same pair of variables,
> +but in the opposite order.  The goal is to avoid the counter-intuitive
> +outcome in which the first load sees the value written by the second store
> +but the second load does not see the value written by the first store.
> +In the absence of any ordering, this goal may not be met, as can be seen
> +in the MP+poonceonces.litmus litmus test.  This section therefore looks at
> +a number of ways of meeting this goal.
> +
> +
> +Release and acquire
> +~~~~~~~~~~~~~~~~~~~
> +
> +Use of smp_store_release() and smp_load_acquire() is one way to force
> +the desired MP ordering.  The general approach is shown below:
> +
> +	/* See MP+pooncerelease+poacquireonce.litmus. */
> +	void CPU0(void)
> +	{
> +		WRITE_ONCE(x, 1);
> +		smp_store_release(&y, 1);
> +	}
> +
> +	void CPU1(void)
> +	{
> +		r0 = smp_load_acquire(&y);
> +		r1 = READ_ONCE(x);
> +	}
> +
> +The smp_store_release() macro orders any prior accesses against the
> +store, while the smp_load_acquire macro orders the load against any
> +subsequent accesses.  Therefore, if the final value of r0 is the value 1,
> +the final value of r1 must also be the value 1.
> +
> +The init_stack_slab() function in lib/stackdepot.c uses release-acquire
> +in this way to safely initialize of a slab of the stack.  Working out
> +the mutual-exclusion design is left as an exercise for the reader.
> +
> +
> +Assign and dereference
> +~~~~~~~~~~~~~~~~~~~~~~
> +
> +Use of rcu_assign_pointer() and rcu_dereference() is quite similar to the
> +use of smp_store_release() and smp_load_acquire(), except that both
> +rcu_assign_pointer() and rcu_dereference() operate on RCU-protected
> +pointers.  The general approach is shown below:
> +
> +	/* See MP+onceassign+derefonce.litmus. */
> +	int z;
> +	int *y = &z;
> +	int x;
> +
> +	void CPU0(void)
> +	{
> +		WRITE_ONCE(x, 1);
> +		rcu_assign_pointer(y, &x);
> +	}
> +
> +	void CPU1(void)
> +	{
> +		rcu_read_lock();
> +		r0 = rcu_dereference(y);
> +		r1 = READ_ONCE(*r0);
> +		rcu_read_unlock();
> +	}
> +
> +In this example, if the final value of r0 is &x then the final value of
> +r1 must be 1.
> +
> +The rcu_assign_pointer() macro has the same ordering properties as does
> +smp_store_release(), but the rcu_dereference() macro orders the load only
> +against later accesses that depend on the value loaded.  A dependency
> +is present if the value loaded determines the address of a later access
> +(address dependency, as shown above), the value written by a later store
> +(data dependency), or whether or not a later store is executed in the
> +first place (control dependency).  Note that the term "data dependency"
> +is sometimes casually used to cover both address and data dependencies.
> +
> +In lib/prime_numbers.c, the expand_to_next_prime() function invokes
> +rcu_assign_pointer(), and the next_prime_number() function invokes
> +rcu_dereference().  This combination mediates access to a bit vector
> +that is expanded as additional primes are needed.
> +
> +
> +Write and read memory barriers
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +It is usually better to use smp_store_release() instead of smp_wmb()
> +and to use smp_load_acquire() instead of smp_rmb().  However, the older
> +smp_wmb() and smp_rmb() APIs are still heavily used, so it is important
> +to understand their use cases.  The general approach is shown below:
> +
> +	/* See MP+wmbonceonce+rmbonceonce.litmus. */
> +	void CPU0(void)
> +	{
> +		WRITE_ONCE(x, 1);
> +		smp_wmb();
> +		WRITE_ONCE(y, 1);
> +	}
> +
> +	void CPU1(void)
> +	{
> +		r0 = READ_ONCE(y);
> +		smp_rmb();
> +		r1 = READ_ONCE(x);
> +	}
> +
> +The smp_wmb() macro orders prior stores against later stores, and the
> +smp_rmb() macro orders prior loads against later loads.  Therefore, if
> +the final value of r0 is 1, the final value of r1 must also be 1.
> +
> +The the xlog_state_switch_iclogs() function in fs/xfs/xfs_log.c contains
> +the following write-side code fragment:
> +
> +	log->l_curr_block -= log->l_logBBsize;
> +	ASSERT(log->l_curr_block >= 0);
> +	smp_wmb();
> +	log->l_curr_cycle++;
> +
> +And the xlog_valid_lsn() function in fs/xfs/xfs_log_priv.h contains
> +the corresponding read-side code fragment:
> +
> +	cur_cycle = ACCESS_ONCE(log->l_curr_cycle);
> +	smp_rmb();
> +	cur_block = ACCESS_ONCE(log->l_curr_block);
> +
> +Alternatively, consider the following comment in function
> +perf_output_put_handle() in kernel/events/ring_buffer.c:
> +
> +	 *   kernel				user
> +	 *
> +	 *   if (LOAD ->data_tail) {		LOAD ->data_head
> +	 *			(A)		smp_rmb()	(C)
> +	 *	STORE $data			LOAD $data
> +	 *	smp_wmb()	(B)		smp_mb()	(D)
> +	 *	STORE ->data_head		STORE ->data_tail
> +	 *   }
> +
> +The B/C pairing is an example of the MP pattern using smp_wmb() on the
> +write side and smp_rmb() on the read side.
> +
> +Of course, given that smp_mb() is strictly stronger than either smp_wmb()
> +or smp_rmb(), any code fragment that would work with smp_rmb() and
> +smp_wmb() would also work with smp_mb() replacing either or both of the
> +weaker barriers.
> +
> +
> +Load buffering (LB)
> +-------------------
> +
> +The LB pattern has one CPU load from one variable and then store to a
> +second, while another CPU loads from the second variable and then stores
> +to the first.  The goal is to avoid the counter-intuitive situation where
> +each load reads the value written by the other CPU's store.  In the
> +absence of any ordering it is quite possible that this may happen, as
> +can be seen in the LB+poonceonces.litmus litmus test.
> +
> +One way of avoiding the counter-intuitive outcome is through the use of a
> +control dependency paired with a full memory barrier:
> +
> +	/* See LB+ctrlonceonce+mbonceonce.litmus. */
> +	void CPU0(void)
> +	{
> +		r0 = READ_ONCE(x);
> +		if (r0)
> +			WRITE_ONCE(y, 1);
> +	}
> +
> +	void CPU1(void)
> +	{
> +		r1 = READ_ONCE(y);
> +		smp_mb();
> +		WRITE_ONCE(x, 1);
> +	}
> +
> +This pairing of a control dependency in CPU0() with a full memory
> +barrier in CPU1() prevents r0 and r1 from both ending up equal to 1.
> +
> +The A/D pairing from the ring-buffer use case shown earlier also
> +illustrates LB.  Here is a repeat of the comment in
> +perf_output_put_handle() in kernel/events/ring_buffer.c, showing a
> +control dependency on the kernel side and a full memory barrier on
> +the user side:
> +
> +	 *   kernel				user
> +	 *
> +	 *   if (LOAD ->data_tail) {		LOAD ->data_head
> +	 *			(A)		smp_rmb()	(C)
> +	 *	STORE $data			LOAD $data
> +	 *	smp_wmb()	(B)		smp_mb()	(D)
> +	 *	STORE ->data_head		STORE ->data_tail
> +	 *   }
> +	 *
> +	 * Where A pairs with D, and B pairs with C.
> +
> +The kernel's control dependency between the load from ->data_tail
> +and the store to data combined with the user's full memory barrier
> +between the load from data and the store to ->data_tail prevents
> +the counter-intuitive outcome where the kernel overwrites the data
> +before the user gets done loading it.
> +
> +
> +Release-acquire chains
> +----------------------
> +
> +Release-acquire chains are a low-overhead, flexible, and easy-to-use
> +method of maintaining order.  However, they do have some limitations that
> +need to be fully understood.  Here is an example that maintains order:
> +
> +	/* See ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus. */
> +	void CPU0(void)
> +	{
> +		WRITE_ONCE(x, 1);
> +		smp_store_release(&y, 1);
> +	}
> +
> +	void CPU1(void)
> +	{
> +		r0 = smp_load_acquire(y);
> +		smp_store_release(&z, 1);
> +	}
> +
> +	void CPU2(void)
> +	{
> +		r1 = smp_load_acquire(z);
> +		r2 = READ_ONCE(x);
> +	}
> +
> +In this case, if r0 and r1 both have final values of 1, then r2 must
> +also have a final value of 1.
> +
> +The ordering in this example is stronger than it needs to be.  For
> +example, ordering would still be preserved if CPU1()'s smp_load_acquire()
> +invocation was replaced with READ_ONCE().
> +
> +It is tempting to assume that CPU0()'s store to x is globally ordered
> +before CPU1()'s store to z, but this is not the case:
> +
> +	/* See Z6.0+pooncerelease+poacquirerelease+mbonceonce.litmus. */
> +	void CPU0(void)
> +	{
> +		WRITE_ONCE(x, 1);
> +		smp_store_release(&y, 1);
> +	}
> +
> +	void CPU1(void)
> +	{
> +		r0 = smp_load_acquire(y);
> +		smp_store_release(&z, 1);
> +	}
> +
> +	void CPU2(void)
> +	{
> +		WRITE_ONCE(z, 2);
> +		smp_mb();
> +		r1 = READ_ONCE(x);
> +	}
> +
> +One might hope that if the final value of r0 is 1 and the final value
> +of z is 2, then the final value of r1 must also be 1, but it really is
> +possible for r1 to have the final value of 0.  The reason, of course,
> +is that in this version, CPU2() is not part of the release-acquire chain.
> +This situation is accounted for in the rules of thumb below.
> +
> +Despite this limitation, release-acquire chains are low-overhead as
> +well as simple and powerful, at least as memory-ordering mechanisms go.
> +
> +
> +Store buffering
> +---------------
> +
> +Store buffering can be thought of as upside-down load buffering, so
> +that one CPU first stores to one variable and then loads from a second,
> +while another CPU stores to the second variable and then loads from the
> +first.  Preserving order requires nothing less than full barriers:
> +
> +	/* See SB+mbonceonces.litmus. */
> +	void CPU0(void)
> +	{
> +		WRITE_ONCE(x, 1);
> +		smp_mb();
> +		r0 = READ_ONCE(y);
> +	}
> +
> +	void CPU1(void)
> +	{
> +		WRITE_ONCE(y, 1);
> +		smp_mb();
> +		r1 = READ_ONCE(x);
> +	}
> +
> +Omitting either smp_mb() will allow both r0 and r1 to have final
> +values of 0, but providing both full barriers as shown above prevents
> +this counter-intuitive outcome.
> +
> +This pattern most famously appears as part of Dekker's locking
> +algorithm, but it has a much more practical use within the Linux kernel
> +of ordering wakeups.  The following comment taken from waitqueue_active()
> +in include/linux/wait.h shows the canonical pattern:
> +
> + *      CPU0 - waker                    CPU1 - waiter
> + *
> + *                                      for (;;) {
> + *      @cond = true;                     prepare_to_wait(&wq_head, &wait, state);
> + *      smp_mb();                         // smp_mb() from set_current_state()
> + *      if (waitqueue_active(wq_head))         if (@cond)
> + *        wake_up(wq_head);                      break;
> + *                                        schedule();
> + *                                      }
> + *                                      finish_wait(&wq_head, &wait);
> +
> +On CPU0, the store is to @cond and the load is in waitqueue_active().
> +On CPU1, prepare_to_wait() contains both a store to wq_head and a call
> +to set_current_state(), which contains an smp_mb() barrier; the load is
> +"if (@cond)".  The full barriers prevent the undesirable outcome where
> +CPU1 puts the waiting task to sleep and CPU0 fails to wake it up.
> +
> +Note that use of locking can greatly simplify this pattern.
> +
> +
> +Rules of thumb
> +==============
> +
> +There might seem to be no pattern governing what ordering primitives are
> +needed in which situations, but this is not the case.  There is a pattern
> +based on the relation between the accesses linking successive CPUs in a
> +given litmus test.  There are three types of linkage:
> +
> +1.	Write-to-read, where the next CPU reads the value that the
> +	previous CPU wrote.  The LB litmus-test patterns contain only
> +	this type of relation.	In formal memory-modeling texts, this
> +	relation is called "reads-from" and is usually abbreviated "rf".
> +
> +2.	Read-to-write, where the next CPU overwrites the value that the
> +	previous CPU read.  The SB litmus test contains only this type
> +	of relation.  In formal memory-modeling texts, this relation is
> +	often called "from-reads" and is sometimes abbreviated "fr".
> +
> +3.	Write-to-write, where the next CPU overwrites the value written
> +	by the previous CPU.  The Z6.0 litmus test pattern contains a
> +	write-to-write relation between the last access of CPU1() and
> +	the first access of CPU2().  In formal memory-modeling texts,
> +	this relation is often called "coherence order" and is sometimes
> +	abbreviated "co".  In the C++ standard, it is instead called
> +	"modification order" and often abbreviated "mo".
> +
> +The strength of memory ordering required for a given litmus test to
> +avoid a counter-intuitive outcome depends on the types of relations
> +linking the memory accesses for the outcome in question:
> +
> +o	If all links are write-to-read links, then the weakest
> +	possible ordering within each CPU suffices.  For example, in
> +	the LB litmus test, a control dependency was enough to do the
> +	job.
> +
> +o	If all but one of the links are write-to-read links, then a
> +	release-acquire chain suffices.  Both the MP and the ISA2
> +	litmus tests illustrate this case.
> +
> +o	If more than one of the links are something other than
> +	write-to-read links, then a full memory barrier is required
> +	between each successive pair of non-write-to-read links.  This
> +	case is illustrated by the Z6.0 litmus tests, both in the
> +	locking and in the release-acquire sections.
> +
> +However, if you find yourself having to stretch these rules of thumb
> +to fit your situation, you should consider creating a litmus test and
> +running it on the model.
> diff --git a/tools/memory-model/Documentation/references.txt b/tools/memory-model/Documentation/references.txt
> new file mode 100644
> index 000000000000..ba2e34c2ec3f
> --- /dev/null
> +++ b/tools/memory-model/Documentation/references.txt
> @@ -0,0 +1,107 @@
> +This document provides background reading for memory models and related
> +tools.  These documents are aimed at kernel hackers who are interested
> +in memory models.
> +
> +
> +Hardware manuals and models
> +===========================
> +
> +o	SPARC International Inc. (Ed.). 1994. "The SPARC Architecture
> +	Reference Manual Version 9". SPARC International Inc.
> +
> +o	Compaq Computer Corporation (Ed.). 2002. "Alpha Architecture
> +	Reference Manual".  Compaq Computer Corporation.
> +
> +o	Intel Corporation (Ed.). 2002. "A Formal Specification of Intel
> +	Itanium Processor Family Memory Ordering". Intel Corporation.
> +
> +o	Intel Corporation (Ed.). 2002. "Intel 64 and IA-32 Architectures
> +	Software Developer’s Manual". Intel Corporation.
> +
> +o	Peter Sewell, Susmit Sarkar, Scott Owens, Francesco Zappa Nardelli,
> +	and Magnus O. Myreen. 2010. "x86-TSO: A Rigorous and Usable
> +	Programmer's Model for x86 Multiprocessors". Commun. ACM 53, 7
> +	(July, 2010), 89-97. http://doi.acm.org/10.1145/1785414.1785443
> +
> +o	IBM Corporation (Ed.). 2009. "Power ISA Version 2.06". IBM
> +	Corporation.
> +
> +o	ARM Ltd. (Ed.). 2009. "ARM Barrier Litmus Tests and Cookbook".
> +	ARM Ltd.
> +
> +o	Susmit Sarkar, Peter Sewell, Jade Alglave, Luc Maranget, and
> +	Derek Williams.  2011. "Understanding POWER Multiprocessors". In
> +	Proceedings of the 32Nd ACM SIGPLAN Conference on Programming
> +	Language Design and Implementation (PLDI ’11). ACM, New York,
> +	NY, USA, 175–186.
> +
> +o	Susmit Sarkar, Kayvan Memarian, Scott Owens, Mark Batty,
> +	Peter Sewell, Luc Maranget, Jade Alglave, and Derek Williams.
> +	2012. "Synchronising C/C++ and POWER". In Proceedings of the 33rd
> +	ACM SIGPLAN Conference on Programming Language Design and
> +	Implementation (PLDI '12). ACM, New York, NY, USA, 311-322.
> +
> +o	ARM Ltd. (Ed.). 2014. "ARM Architecture Reference Manual (ARMv8,
> +	for ARMv8-A architecture profile)". ARM Ltd.
> +
> +o	Imagination Technologies, LTD. 2015. "MIPS(R) Architecture
> +	For Programmers, Volume II-A: The MIPS64(R) Instruction,
> +	Set Reference Manual". Imagination Technologies,
> +	LTD. https://imgtec.com/?do-download=4302.
> +
> +o	Shaked Flur, Kathryn E. Gray, Christopher Pulte, Susmit
> +	Sarkar, Ali Sezgin, Luc Maranget, Will Deacon, and Peter
> +	Sewell. 2016. "Modelling the ARMv8 Architecture, Operationally:
> +	Concurrency and ISA". In Proceedings of the 43rd Annual ACM
> +	SIGPLAN-SIGACT Symposium on Principles of Programming Languages
> +	(POPL ’16). ACM, New York, NY, USA, 608–621.
> +
> +o	Shaked Flur, Susmit Sarkar, Christopher Pulte, Kyndylan Nienhuis,
> +	Luc Maranget, Kathryn E. Gray, Ali Sezgin, Mark Batty, and Peter
> +	Sewell. 2017. "Mixed-size Concurrency: ARM, POWER, C/C++11,
> +	and SC". In Proceedings of the 44th ACM SIGPLAN Symposium on
> +	Principles of Programming Languages (POPL 2017). ACM, New York,
> +	NY, USA, 429–442.
> +
> +
> +Linux-kernel memory model
> +=========================
> +
> +o	Andrea Parri, Alan Stern, Luc Maranget, Paul E. McKenney,
> +	and Jade Alglave.  2017. "A formal model of
> +	Linux-kernel memory ordering - companion webpage".
> +	http://moscova.inria.fr/∼maranget/cats7/linux/. (2017). [Online;
> +	accessed 30-January-2017].
> +
> +o	Jade Alglave, Luc Maranget, Paul E. McKenney, Andrea Parri, and
> +	Alan Stern.  2017.  "A formal kernel memory-ordering model (part 1)"
> +	Linux Weekly News.  https://lwn.net/Articles/718628/
> +
> +o	Jade Alglave, Luc Maranget, Paul E. McKenney, Andrea Parri, and
> +	Alan Stern.  2017.  "A formal kernel memory-ordering model (part 2)"
> +	Linux Weekly News.  https://lwn.net/Articles/720550/
> +
> +
> +Memory-model tooling
> +====================
> +
> +o	Daniel Jackson. 2002. "Alloy: A Lightweight Object Modelling
> +	Notation". ACM Trans. Softw. Eng. Methodol. 11, 2 (April 2002),
> +	256–290. http://doi.acm.org/10.1145/505145.505149
> +
> +o	Jade Alglave, Luc Maranget, and Michael Tautschnig. 2014. "Herding
> +	Cats: Modelling, Simulation, Testing, and Data Mining for Weak
> +	Memory". ACM Trans. Program. Lang. Syst. 36, 2, Article 7 (July
> +	2014), 7:1–7:74 pages.
> +
> +o	Jade Alglave, Patrick Cousot, and Luc Maranget. 2016. "Syntax and
> +	semantics of the weak consistency model specification language
> +	cat". CoRR abs/1608.07531 (2016). http://arxiv.org/abs/1608.07531
> +
> +
> +Memory-model comparisons
> +========================
> +
> +o	Paul E. McKenney, Ulrich Weigand, Andrea Parri, and Boqun
> +	Feng. 2016. "Linux-Kernel Memory Model". (6 June 2016).
> +	http://open-std.org/JTC1/SC22/WG21/docs/papers/2016/p0124r2.html.
> diff --git a/tools/memory-model/MAINTAINERS b/tools/memory-model/MAINTAINERS
> new file mode 100644
> index 000000000000..711cbe72d606
> --- /dev/null
> +++ b/tools/memory-model/MAINTAINERS
> @@ -0,0 +1,15 @@
> +LINUX KERNEL MEMORY MODEL
> +M:	Alan Stern <stern@rowland.harvard.edu>
> +M:	Andrea Parri <parri.andrea@gmail.com>
> +M:	Will Deacon <will.deacon@arm.com>
> +M:	Peter Zijlstra <peterz@infradead.org>
> +M:	Boqun Feng <boqun.feng@gmail.com>
> +M:	Nicholas Piggin <npiggin@gmail.com>
> +M:	David Howells <dhowells@redhat.com>
> +M:	Jade Alglave <j.alglave@ucl.ac.uk>
> +M:	Luc Maranget <luc.maranget@inria.fr>
> +M:	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> +L:	linux-kernel@vger.kernel.org
> +S:	Supported
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> +F:	tools/memory-model/
> diff --git a/tools/memory-model/README b/tools/memory-model/README
> new file mode 100644
> index 000000000000..1c1c855f91f4
> --- /dev/null
> +++ b/tools/memory-model/README
> @@ -0,0 +1,220 @@
> +			=========================
> +			LINUX KERNEL MEMORY MODEL
> +			=========================
> +
> +============
> +INTRODUCTION
> +============
> +
> +This directory contains the memory model of the Linux kernel, written
> +in the "cat" language and executable by the (externally provided)
> +"herd7" simulator, which exhaustively explores the state space of
> +small litmus tests.
> +
> +In addition, the "klitmus7" tool (also externally provided) may be used
> +to convert a litmus test to a Linux kernel module, which in turn allows
> +that litmus test to be exercised within the Linux kernel.
> +
> +
> +============
> +REQUIREMENTS
> +============
> +
> +The "herd7" and "klitmus7" tools must be downloaded separately:
> +
> +  https://github.com/herd/herdtools7
> +
> +See "herdtools7/INSTALL.md" for installation instructions.
> +
> +Alternatively, Abhishek Bhardwaj has kindly provided a Docker image
> +of these tools at "abhishek40/memory-model".  Abhishek suggests the
> +following commands to install and use this image:
> +
> +  - Users should install Docker for their distribution.
> +  - docker run -itd abhishek40/memory-model
> +  - docker attach <id-emitted-from-the-previous-command>
> +
> +Gentoo users might wish to make use of Patrick McLean's package:
> +
> +  https://gitweb.gentoo.org/repo/gentoo.git/tree/dev-util/herdtools7
> +
> +These packages may not be up-to-date with respect to the GitHub
> +repository.
> +
> +
> +==================
> +BASIC USAGE: HERD7
> +==================
> +
> +The memory model is used, in conjunction with "herd7", to exhaustively
> +explore the state space of small litmus tests.
> +
> +For example, to run SB+mbonceonces.litmus against the memory model:
> +
> +  $ herd7 -conf linux-kernel.cfg litmus-tests/SB+mbonceonces.litmus
> +
> +Here is the corresponding output:
> +
> +  Test SB+mbonceonces Allowed
> +  States 3
> +  0:r0=0; 1:r0=1;
> +  0:r0=1; 1:r0=0;
> +  0:r0=1; 1:r0=1;
> +  No
> +  Witnesses
> +  Positive: 0 Negative: 3
> +  Condition exists (0:r0=0 /\ 1:r0=0)
> +  Observation SB+mbonceonces Never 0 3
> +  Time SB+mbonceonces 0.01
> +  Hash=d66d99523e2cac6b06e66f4c995ebb48
> +
> +The "Positive: 0 Negative: 3" and the "Never 0 3" each indicate that
> +this litmus test's "exists" clause can not be satisfied.
> +
> +See "herd7 -help" or "herdtools7/doc/" for more information.
> +
> +
> +=====================
> +BASIC USAGE: KLITMUS7
> +=====================
> +
> +The "klitmus7" tool converts a litmus test into a Linux kernel module,
> +which may then be loaded and run.
> +
> +For example, to run SB+mbonceonces.litmus against hardware:
> +
> +  $ mkdir mymodules
> +  $ klitmus7 -o mymodules litmus-tests/SB+mbonceonces.litmus
> +  $ cd mymodules ; make
> +  $ sudo sh run.sh
> +
> +The corresponding output includes:
> +
> +  Test SB+mbonceonces Allowed
> +  Histogram (3 states)
> +  644580  :>0:r0=1; 1:r0=0;
> +  644328  :>0:r0=0; 1:r0=1;
> +  711092  :>0:r0=1; 1:r0=1;
> +  No
> +  Witnesses
> +  Positive: 0, Negative: 2000000
> +  Condition exists (0:r0=0 /\ 1:r0=0) is NOT validated
> +  Hash=d66d99523e2cac6b06e66f4c995ebb48
> +  Observation SB+mbonceonces Never 0 2000000
> +  Time SB+mbonceonces 0.16
> +
> +The "Positive: 0 Negative: 2000000" and the "Never 0 2000000" indicate
> +that during two million trials, the state specified in this litmus
> +test's "exists" clause was not reached.
> +
> +And, as with "herd7", please see "klitmus7 -help" or "herdtools7/doc/"
> +for more information.
> +
> +
> +====================
> +DESCRIPTION OF FILES
> +====================
> +
> +Documentation/cheatsheet.txt
> +	Quick-reference guide to the Linux-kernel memory model.
> +	
> +Documentation/explanation.txt
> +	Describes the memory model in detail.
> +	
> +Documentation/recipes.txt
> +	Lists common memory-ordering patterns.
> +	
> +Documentation/references.txt
> +	Provides background reading.
> +
> +linux-kernel.bell
> +	Categorizes the relevant instructions, including memory
> +	references, memory barriers, atomic read-modify-write operations,
> +	lock acquisition/release, and RCU operations.
> +
> +	More formally, this file (1) lists the subtypes of the various
> +	event types used by the memory model and (2) performs RCU
> +	read-side critical section nesting analysis.
> +
> +linux-kernel.cat
> +	Specifies what reorderings are forbidden by memory references,
> +	memory barriers, atomic read-modify-write operations, and RCU.
> +
> +	More formally, this file specifies what executions are forbidden
> +	by the memory model.  Allowed executions are those which
> +	satisfy the model's "coherence", "atomic", "happens-before",
> +	"propagation", and "rcu" axioms, which are defined in the file.
> +
> +linux-kernel.cfg
> +	Convenience file that gathers the common-case herd7 command-line
> +	arguments.
> +
> +linux-kernel.def
> +	Maps from C-like syntax to herd7's internal litmus-test
> +	instruction-set architecture.
> +
> +litmus-tests
> +	Directory containing a few representative litmus tests, which
> +	are listed in litmus-tests/README.  A great deal more litmus
> +	tests are available at https://github.com/paulmckrcu/litmus.
> +
> +lock.cat
> +	Provides a front-end analysis of lock acquisition and release,
> +	for example, associating a lock acquisition with the preceding
> +	and following releases and checking for self-deadlock.
> +
> +	More formally, this file defines a performance-enhanced scheme
> +	for generation of the possible reads-from and coherence order
> +	relations on the locking primitives.
> +
> +README
> +	This file.
> +
> +
> +===========
> +LIMITATIONS
> +===========
> +
> +The Linux-kernel memory model has the following limitations:
> +
> +1.	Compiler optimizations are not modeled.  Of course, the use
> +	of READ_ONCE() and WRITE_ONCE() limits the compiler's ability
> +	to optimize, but there is Linux-kernel code that uses bare C
> +	memory accesses.  Handling this code is on the to-do list.
> +	For more information, see Documentation/explanation.txt (in
> +	particular, the "THE PROGRAM ORDER RELATION: po AND po-loc"
> +	and "A WARNING" sections).
> +
> +2.	Multiple access sizes for a single variable are not supported,
> +	and neither are misaligned or partially overlapping accesses.
> +
> +3.	Exceptions and interrupts are not modeled.  In some cases,
> +	this limitation can be overcome by modeling the interrupt or
> +	exception with an additional process.
> +
> +4.	I/O such as MMIO or DMA is not supported.
> +
> +5.	Self-modifying code (such as that found in the kernel's
> +	alternatives mechanism, function tracer, Berkeley Packet Filter
> +	JIT compiler, and module loader) is not supported.
> +
> +6.	Complete modeling of all variants of atomic read-modify-write
> +	operations, locking primitives, and RCU is not provided.
> +	For example, call_rcu() and rcu_barrier() are not supported.
> +	However, a substantial amount of support is provided for these
> +	operations, as shown in the linux-kernel.def file.
> +
> +The "herd7" tool has some additional limitations of its own, apart from
> +the memory model:
> +
> +1.	Non-trivial data structures such as arrays or structures are
> +	not supported.	However, pointers are supported, allowing trivial
> +	linked lists to be constructed.
> +
> +2.	Dynamic memory allocation is not supported, although this can
> +	be worked around in some cases by supplying multiple statically
> +	allocated variables.
> +
> +Some of these limitations may be overcome in the future, but others are
> +more likely to be addressed by incorporating the Linux-kernel memory model
> +into other tools.
> diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
> new file mode 100644
> index 000000000000..57112505f5e0
> --- /dev/null
> +++ b/tools/memory-model/linux-kernel.bell
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +(*
> + * Copyright (C) 2015 Jade Alglave <j.alglave@ucl.ac.uk>,
> + * Copyright (C) 2016 Luc Maranget <luc.maranget@inria.fr> for Inria
> + * Copyright (C) 2017 Alan Stern <stern@rowland.harvard.edu>,
> + *                    Andrea Parri <parri.andrea@gmail.com>
> + *
> + * An earlier version of this file appears in the companion webpage for
> + * "Frightening small children and disconcerting grown-ups: Concurrency
> + * in the Linux kernel" by Alglave, Maranget, McKenney, Parri, and Stern,
> + * which is to appear in ASPLOS 2018.
> + *)
> +
> +"Linux kernel memory model"
> +
> +enum Accesses = 'once (*READ_ONCE,WRITE_ONCE,ACCESS_ONCE*) ||
> +		'release (*smp_store_release*) ||
> +		'acquire (*smp_load_acquire*) ||
> +		'noreturn (* R of non-return RMW *)
> +instructions R[{'once,'acquire,'noreturn}]
> +instructions W[{'once,'release}]
> +instructions RMW[{'once,'acquire,'release}]
> +
> +enum Barriers = 'wmb (*smp_wmb*) ||
> +		'rmb (*smp_rmb*) ||
> +		'mb (*smp_mb*) ||
> +		'rb_dep (*smp_read_barrier_depends*) ||
> +		'rcu-lock (*rcu_read_lock*)  ||
> +		'rcu-unlock (*rcu_read_unlock*) ||
> +		'sync-rcu (*synchronize_rcu*) ||
> +		'before_atomic (*smp_mb__before_atomic*) ||
> +		'after_atomic (*smp_mb__after_atomic*) ||
> +		'after_spinlock (*smp_mb__after_spinlock*)
> +instructions F[Barriers]
> +
> +(* Compute matching pairs of nested Rcu-lock and Rcu-unlock *)
> +let matched = let rec
> +	    unmatched-locks = Rcu-lock \ domain(matched)
> +	and unmatched-unlocks = Rcu-unlock \ range(matched)
> +	and unmatched = unmatched-locks | unmatched-unlocks
> +	and unmatched-po = [unmatched] ; po ; [unmatched]
> +	and unmatched-locks-to-unlocks =
> +		[unmatched-locks] ; po ; [unmatched-unlocks]
> +	and matched = matched | (unmatched-locks-to-unlocks \
> +		(unmatched-po ; unmatched-po))
> +	in matched
> +
> +(* Validate nesting *)
> +flag ~empty Rcu-lock \ domain(matched) as unbalanced-rcu-locking
> +flag ~empty Rcu-unlock \ range(matched) as unbalanced-rcu-locking
> +
> +(* Outermost level of nesting only *)
> +let crit = matched \ (po^-1 ; matched ; po^-1)
> diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> new file mode 100644
> index 000000000000..15b7a5dd8a9a
> --- /dev/null
> +++ b/tools/memory-model/linux-kernel.cat
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +(*
> + * Copyright (C) 2015 Jade Alglave <j.alglave@ucl.ac.uk>,
> + * Copyright (C) 2016 Luc Maranget <luc.maranget@inria.fr> for Inria
> + * Copyright (C) 2017 Alan Stern <stern@rowland.harvard.edu>,
> + *                    Andrea Parri <parri.andrea@gmail.com>
> + *
> + * An earlier version of this file appears in the companion webpage for
> + * "Frightening small children and disconcerting grown-ups: Concurrency
> + * in the Linux kernel" by Alglave, Maranget, McKenney, Parri, and Stern,
> + * which is to appear in ASPLOS 2018.
> + *)
> +
> +"Linux kernel memory model"
> +
> +(*
> + * File "lock.cat" handles locks and is experimental.
> + * It can be replaced by include "cos.cat" for tests that do not use locks.
> + *)
> +
> +include "lock.cat"
> +
> +(*******************)
> +(* Basic relations *)
> +(*******************)
> +
> +(* Fences *)
> +let rb-dep = [R] ; fencerel(Rb_dep) ; [R]
> +let rmb = [R \ Noreturn] ; fencerel(Rmb) ; [R \ Noreturn]
> +let wmb = [W] ; fencerel(Wmb) ; [W]
> +let mb = ([M] ; fencerel(Mb) ; [M]) |
> +	([M] ; fencerel(Before_atomic) ; [RMW] ; po? ; [M]) |
> +	([M] ; po? ; [RMW] ; fencerel(After_atomic) ; [M]) |
> +	([M] ; po? ; [LKW] ; fencerel(After_spinlock) ; [M])
> +let gp = po ; [Sync-rcu] ; po?
> +
> +let strong-fence = mb | gp
> +
> +(* Release Acquire *)
> +let acq-po = [Acquire] ; po ; [M]
> +let po-rel = [M] ; po ; [Release]
> +let rfi-rel-acq = [Release] ; rfi ; [Acquire]
> +
> +(**********************************)
> +(* Fundamental coherence ordering *)
> +(**********************************)
> +
> +(* Sequential Consistency Per Variable *)
> +let com = rf | co | fr
> +acyclic po-loc | com as coherence
> +
> +(* Atomic Read-Modify-Write *)
> +empty rmw & (fre ; coe) as atomic
> +
> +(**********************************)
> +(* Instruction execution ordering *)
> +(**********************************)
> +
> +(* Preserved Program Order *)
> +let dep = addr | data
> +let rwdep = (dep | ctrl) ; [W]
> +let overwrite = co | fr
> +let to-w = rwdep | (overwrite & int)
> +let rrdep = addr | (dep ; rfi)
> +let strong-rrdep = rrdep+ & rb-dep
> +let to-r = strong-rrdep | rfi-rel-acq
> +let fence = strong-fence | wmb | po-rel | rmb | acq-po
> +let ppo = rrdep* ; (to-r | to-w | fence)
> +
> +(* Propagation: Ordering from release operations and strong fences. *)
> +let A-cumul(r) = rfe? ; r
> +let cumul-fence = A-cumul(strong-fence | po-rel) | wmb
> +let prop = (overwrite & ext)? ; cumul-fence* ; rfe?
> +
> +(*
> + * Happens Before: Ordering from the passage of time.
> + * No fences needed here for prop because relation confined to one process.
> + *)
> +let hb = ppo | rfe | ((prop \ id) & int)
> +acyclic hb as happens-before
> +
> +(****************************************)
> +(* Write and fence propagation ordering *)
> +(****************************************)
> +
> +(* Propagation: Each non-rf link needs a strong fence. *)
> +let pb = prop ; strong-fence ; hb*
> +acyclic pb as propagation
> +
> +(*******)
> +(* RCU *)
> +(*******)
> +
> +(*
> + * Effect of read-side critical section proceeds from the rcu_read_lock()
> + * onward on the one hand and from the rcu_read_unlock() backwards on the
> + * other hand.
> + *)
> +let rscs = po ; crit^-1 ; po?
> +
> +(*
> + * The synchronize_rcu() strong fence is special in that it can order not
> + * one but two non-rf relations, but only in conjunction with an RCU
> + * read-side critical section.
> + *)
> +let link = hb* ; pb* ; prop
> +
> +(* Chains that affect the RCU grace-period guarantee *)
> +let gp-link = gp ; link
> +let rscs-link = rscs ; link
> +
> +(*
> + * A cycle containing at least as many grace periods as RCU read-side
> + * critical sections is forbidden.
> + *)
> +let rec rcu-path =
> +	gp-link |
> +	(gp-link ; rscs-link) |
> +	(rscs-link ; gp-link) |
> +	(rcu-path ; rcu-path) |
> +	(gp-link ; rcu-path ; rscs-link) |
> +	(rscs-link ; rcu-path ; gp-link)
> +
> +irreflexive rcu-path as rcu
> diff --git a/tools/memory-model/linux-kernel.cfg b/tools/memory-model/linux-kernel.cfg
> new file mode 100644
> index 000000000000..3c8098e99f41
> --- /dev/null
> +++ b/tools/memory-model/linux-kernel.cfg
> @@ -0,0 +1,21 @@
> +macros linux-kernel.def
> +bell linux-kernel.bell
> +model linux-kernel.cat
> +graph columns
> +squished true
> +showevents noregs
> +movelabel true
> +fontsize 8
> +xscale 2.0
> +yscale 1.5
> +arrowsize 0.8
> +showinitrf false
> +showfinalrf false
> +showinitwrites false
> +splines spline
> +pad 0.1
> +edgeattr hb,color,indigo
> +edgeattr co,color,blue
> +edgeattr mb,color,darkgreen
> +edgeattr wmb,color,darkgreen
> +edgeattr rmb,color,darkgreen
> diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
> new file mode 100644
> index 000000000000..a397387f77cc
> --- /dev/null
> +++ b/tools/memory-model/linux-kernel.def
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +//
> +// An earlier version of this file appears in the companion webpage for
> +// "Frightening small children and disconcerting grown-ups: Concurrency
> +// in the Linux kernel" by Alglave, Maranget, McKenney, Parri, and Stern,
> +// which is to appear in ASPLOS 2018.
> +
> +// ONCE
> +READ_ONCE(X) __load{once}(X)
> +WRITE_ONCE(X,V) { __store{once}(X,V); }
> +
> +// Release Acquire and friends
> +smp_store_release(X,V) { __store{release}(*X,V); }
> +smp_load_acquire(X) __load{acquire}(*X)
> +rcu_assign_pointer(X,V) { __store{release}(X,V); }
> +lockless_dereference(X) __load{lderef}(X)
> +rcu_dereference(X) __load{deref}(X)
> +
> +// Fences
> +smp_mb() { __fence{mb} ; }
> +smp_rmb() { __fence{rmb} ; }
> +smp_wmb() { __fence{wmb} ; }
> +smp_read_barrier_depends() { __fence{rb_dep}; }
> +smp_mb__before_atomic() { __fence{before_atomic} ; }
> +smp_mb__after_atomic() { __fence{after_atomic} ; }
> +smp_mb__after_spinlock() { __fence{after_spinlock} ; }
> +
> +// Exchange
> +xchg(X,V)  __xchg{mb}(X,V)
> +xchg_relaxed(X,V) __xchg{once}(X,V)
> +xchg_release(X,V) __xchg{release}(X,V)
> +xchg_acquire(X,V) __xchg{acquire}(X,V)
> +cmpxchg(X,V,W) __cmpxchg{mb}(X,V,W)
> +cmpxchg_relaxed(X,V,W) __cmpxchg{once}(X,V,W)
> +cmpxchg_acquire(X,V,W) __cmpxchg{acquire}(X,V,W)
> +cmpxchg_release(X,V,W) __cmpxchg{release}(X,V,W)
> +
> +// Spinlocks
> +spin_lock(X) { __lock(X) ; }
> +spin_unlock(X) { __unlock(X) ; }
> +spin_trylock(X) __trylock(X)
> +
> +// RCU
> +rcu_read_lock() { __fence{rcu-lock}; }
> +rcu_read_unlock() { __fence{rcu-unlock};}
> +synchronize_rcu() { __fence{sync-rcu}; }
> +synchronize_rcu_expedited() { __fence{sync-rcu}; }
> +
> +// Atomic
> +atomic_read(X) READ_ONCE(*X)
> +atomic_set(X,V) { WRITE_ONCE(*X,V) ; }
> +atomic_read_acquire(X) smp_load_acquire(X)
> +atomic_set_release(X,V) { smp_store_release(X,V); }
> +
> +atomic_add(V,X) { __atomic_op(X,+,V) ; }
> +atomic_sub(V,X) { __atomic_op(X,-,V) ; }
> +atomic_inc(X)   { __atomic_op(X,+,1) ; }
> +atomic_dec(X)   { __atomic_op(X,-,1) ; }
> +
> +atomic_add_return(V,X) __atomic_op_return{mb}(X,+,V)
> +atomic_add_return_relaxed(V,X) __atomic_op_return{once}(X,+,V)
> +atomic_add_return_acquire(V,X) __atomic_op_return{acquire}(X,+,V)
> +atomic_add_return_release(V,X) __atomic_op_return{release}(X,+,V)
> +atomic_fetch_add(V,X) __atomic_fetch_op{mb}(X,+,V)
> +atomic_fetch_add_relaxed(V,X) __atomic_fetch_op{once}(X,+,V)
> +atomic_fetch_add_acquire(V,X) __atomic_fetch_op{acquire}(X,+,V)
> +atomic_fetch_add_release(V,X) __atomic_fetch_op{release}(X,+,V)
> +
> +atomic_inc_return(X) __atomic_op_return{mb}(X,+,1)
> +atomic_inc_return_relaxed(X) __atomic_op_return{once}(X,+,1)
> +atomic_inc_return_acquire(X) __atomic_op_return{acquire}(X,+,1)
> +atomic_inc_return_release(X) __atomic_op_return{release}(X,+,1)
> +atomic_fetch_inc(X) __atomic_fetch_op{mb}(X,+,1)
> +atomic_fetch_inc_relaxed(X) __atomic_fetch_op{once}(X,+,1)
> +atomic_fetch_inc_acquire(X) __atomic_fetch_op{acquire}(X,+,1)
> +atomic_fetch_inc_release(X) __atomic_fetch_op{release}(X,+,1)
> +
> +atomic_sub_return(V,X) __atomic_op_return{mb}(X,-,V)
> +atomic_sub_return_relaxed(V,X) __atomic_op_return{once}(X,-,V)
> +atomic_sub_return_acquire(V,X) __atomic_op_return{acquire}(X,-,V)
> +atomic_sub_return_release(V,X) __atomic_op_return{release}(X,-,V)
> +atomic_fetch_sub(V,X) __atomic_fetch_op{mb}(X,-,V)
> +atomic_fetch_sub_relaxed(V,X) __atomic_fetch_op{once}(X,-,V)
> +atomic_fetch_sub_acquire(V,X) __atomic_fetch_op{acquire}(X,-,V)
> +atomic_fetch_sub_release(V,X) __atomic_fetch_op{release}(X,-,V)
> +
> +atomic_dec_return(X) __atomic_op_return{mb}(X,-,1)
> +atomic_dec_return_relaxed(X) __atomic_op_return{once}(X,-,1)
> +atomic_dec_return_acquire(X) __atomic_op_return{acquire}(X,-,1)
> +atomic_dec_return_release(X) __atomic_op_return{release}(X,-,1)
> +atomic_fetch_dec(X) __atomic_fetch_op{mb}(X,-,1)
> +atomic_fetch_dec_relaxed(X) __atomic_fetch_op{once}(X,-,1)
> +atomic_fetch_dec_acquire(X) __atomic_fetch_op{acquire}(X,-,1)
> +atomic_fetch_dec_release(X) __atomic_fetch_op{release}(X,-,1)
> +
> +atomic_xchg(X,V) __xchg{mb}(X,V)
> +atomic_xchg_relaxed(X,V) __xchg{once}(X,V)
> +atomic_xchg_release(X,V) __xchg{release}(X,V)
> +atomic_xchg_acquire(X,V) __xchg{acquire}(X,V)
> +atomic_cmpxchg(X,V,W) __cmpxchg{mb}(X,V,W)
> +atomic_cmpxchg_relaxed(X,V,W) __cmpxchg{once}(X,V,W)
> +atomic_cmpxchg_acquire(X,V,W) __cmpxchg{acquire}(X,V,W)
> +atomic_cmpxchg_release(X,V,W) __cmpxchg{release}(X,V,W)
> +
> +atomic_sub_and_test(V,X) __atomic_op_return{mb}(X,-,V) == 0
> +atomic_dec_and_test(X)  __atomic_op_return{mb}(X,-,1) == 0
> +atomic_inc_and_test(X)  __atomic_op_return{mb}(X,+,1) == 0
> +atomic_add_negative(V,X) __atomic_op_return{mb}(X,+,V) < 0
> diff --git a/tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus b/tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus
> new file mode 100644
> index 000000000000..5b83d57f6ac5
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus
> @@ -0,0 +1,19 @@
> +C CoRR+poonceonce+Once
> +
> +{}
> +
> +P0(int *x)
> +{
> +	WRITE_ONCE(*x, 1);
> +}
> +
> +P1(int *x)
> +{
> +	int r0;
> +	int r1;
> +
> +	r0 = READ_ONCE(*x);
> +	r1 = READ_ONCE(*x);
> +}
> +
> +exists (1:r0=1 /\ 1:r1=0)
> diff --git a/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus b/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus
> new file mode 100644
> index 000000000000..fab91c13d52c
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus
> @@ -0,0 +1,18 @@
> +C CoRW+poonceonce+Once
> +
> +{}
> +
> +P0(int *x)
> +{
> +	int r0;
> +
> +	r0 = READ_ONCE(*x);
> +	WRITE_ONCE(*x, 1);
> +}
> +
> +P1(int *x)
> +{
> +	WRITE_ONCE(*x, 2);
> +}
> +
> +exists (x=2 /\ 0:r0=2)
> diff --git a/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus b/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus
> new file mode 100644
> index 000000000000..6a35ec2042ea
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus
> @@ -0,0 +1,18 @@
> +C CoWR+poonceonce+Once
> +
> +{}
> +
> +P0(int *x)
> +{
> +	int r0;
> +
> +	WRITE_ONCE(*x, 1);
> +	r0 = READ_ONCE(*x);
> +}
> +
> +P1(int *x)
> +{
> +	WRITE_ONCE(*x, 2);
> +}
> +
> +exists (x=1 /\ 0:r0=2)
> diff --git a/tools/memory-model/litmus-tests/CoWW+poonceonce.litmus b/tools/memory-model/litmus-tests/CoWW+poonceonce.litmus
> new file mode 100644
> index 000000000000..32a96b832021
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/CoWW+poonceonce.litmus
> @@ -0,0 +1,11 @@
> +C CoWW+poonceonce
> +
> +{}
> +
> +P0(int *x)
> +{
> +	WRITE_ONCE(*x, 1);
> +	WRITE_ONCE(*x, 2);
> +}
> +
> +exists (x=1)
> diff --git a/tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus b/tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus
> new file mode 100644
> index 000000000000..7eba2c68992b
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus
> @@ -0,0 +1,35 @@
> +C IRIW+mbonceonces+OnceOnce
> +
> +{}
> +
> +P0(int *x)
> +{
> +	WRITE_ONCE(*x, 1);
> +}
> +
> +P1(int *x, int *y)
> +{
> +	int r0;
> +	int r1;
> +
> +	r0 = READ_ONCE(*x);
> +	smp_mb();
> +	r1 = READ_ONCE(*y);
> +}
> +
> +P2(int *y)
> +{
> +	WRITE_ONCE(*y, 1);
> +}
> +
> +P3(int *x, int *y)
> +{
> +	int r0;
> +	int r1;
> +
> +	r0 = READ_ONCE(*y);
> +	smp_mb();
> +	r1 = READ_ONCE(*x);
> +}
> +
> +exists (1:r0=1 /\ 1:r1=0 /\ 3:r0=1 /\ 3:r1=0)
> diff --git a/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus b/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus
> new file mode 100644
> index 000000000000..b0556c6c75d4
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus
> @@ -0,0 +1,33 @@
> +C IRIW+poonceonces+OnceOnce
> +
> +{}
> +
> +P0(int *x)
> +{
> +	WRITE_ONCE(*x, 1);
> +}
> +
> +P1(int *x, int *y)
> +{
> +	int r0;
> +	int r1;
> +
> +	r0 = READ_ONCE(*x);
> +	r1 = READ_ONCE(*y);
> +}
> +
> +P2(int *y)
> +{
> +	WRITE_ONCE(*y, 1);
> +}
> +
> +P3(int *x, int *y)
> +{
> +	int r0;
> +	int r1;
> +
> +	r0 = READ_ONCE(*y);
> +	r1 = READ_ONCE(*x);
> +}
> +
> +exists (1:r0=1 /\ 1:r1=0 /\ 3:r0=1 /\ 3:r1=0)
> diff --git a/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus b/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus
> new file mode 100644
> index 000000000000..9a1a233d70c3
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus
> @@ -0,0 +1,28 @@
> +C ISA2+poonceonces
> +
> +{}
> +
> +P0(int *x, int *y)
> +{
> +	WRITE_ONCE(*x, 1);
> +	WRITE_ONCE(*y, 1);
> +}
> +
> +P1(int *y, int *z)
> +{
> +	int r0;
> +
> +	r0 = READ_ONCE(*y);
> +	WRITE_ONCE(*z, 1);
> +}
> +
> +P2(int *x, int *z)
> +{
> +	int r0;
> +	int r1;
> +
> +	r0 = READ_ONCE(*z);
> +	r1 = READ_ONCE(*x);
> +}
> +
> +exists (1:r0=1 /\ 2:r0=1 /\ 2:r1=0)
> diff --git a/tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus b/tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus
> new file mode 100644
> index 000000000000..235195e87d4e
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus
> @@ -0,0 +1,28 @@
> +C ISA2+pooncerelease+poacquirerelease+poacquireonce
> +
> +{}
> +
> +P0(int *x, int *y)
> +{
> +	WRITE_ONCE(*x, 1);
> +	smp_store_release(y, 1);
> +}
> +
> +P1(int *y, int *z)
> +{
> +	int r0;
> +
> +	r0 = smp_load_acquire(y);
> +	smp_store_release(z, 1);
> +}
> +
> +P2(int *x, int *z)
> +{
> +	int r0;
> +	int r1;
> +
> +	r0 = smp_load_acquire(z);
> +	r1 = READ_ONCE(*x);
> +}
> +
> +exists (1:r0=1 /\ 2:r0=1 /\ 2:r1=0)
> diff --git a/tools/memory-model/litmus-tests/LB+ctrlonceonce+mbonceonce.litmus b/tools/memory-model/litmus-tests/LB+ctrlonceonce+mbonceonce.litmus
> new file mode 100644
> index 000000000000..dd5ac3a8974a
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/LB+ctrlonceonce+mbonceonce.litmus
> @@ -0,0 +1,23 @@
> +C LB+ctrlonceonce+mbonceonce
> +
> +{}
> +
> +P0(int *x, int *y)
> +{
> +	int r0;
> +
> +	r0 = READ_ONCE(*x);
> +	if (r0)
> +		WRITE_ONCE(*y, 1);
> +}
> +
> +P1(int *x, int *y)
> +{
> +	int r0;
> +
> +	r0 = READ_ONCE(*y);
> +	smp_mb();
> +	WRITE_ONCE(*x, 1);
> +}
> +
> +exists (0:r0=1 /\ 1:r0=1)
> diff --git a/tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus b/tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus
> new file mode 100644
> index 000000000000..47bd61319d93
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus
> @@ -0,0 +1,21 @@
> +C LB+poacquireonce+pooncerelease
> +
> +{}
> +
> +P0(int *x, int *y)
> +{
> +	int r0;
> +
> +	r0 = READ_ONCE(*x);
> +	smp_store_release(y, 1);
> +}
> +
> +P1(int *x, int *y)
> +{
> +	int r0;
> +
> +	r0 = smp_load_acquire(y);
> +	WRITE_ONCE(*x, 1);
> +}
> +
> +exists (0:r0=1 /\ 1:r0=1)
> diff --git a/tools/memory-model/litmus-tests/LB+poonceonces.litmus b/tools/memory-model/litmus-tests/LB+poonceonces.litmus
> new file mode 100644
> index 000000000000..a5cdf027e34b
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/LB+poonceonces.litmus
> @@ -0,0 +1,21 @@
> +C LB+poonceonces
> +
> +{}
> +
> +P0(int *x, int *y)
> +{
> +	int r0;
> +
> +	r0 = READ_ONCE(*x);
> +	WRITE_ONCE(*y, 1);
> +}
> +
> +P1(int *x, int *y)
> +{
> +	int r0;
> +
> +	r0 = READ_ONCE(*y);
> +	WRITE_ONCE(*x, 1);
> +}
> +
> +exists (0:r0=1 /\ 1:r0=1)
> diff --git a/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus b/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
> new file mode 100644
> index 000000000000..1a2fe5830381
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
> @@ -0,0 +1,25 @@
> +C MP+onceassign+derefonce.litmus
> +
> +{
> +y=z;
> +z=0;
> +}
> +
> +P0(int *x, int **y)
> +{
> +	WRITE_ONCE(*x, 1);
> +	rcu_assign_pointer(*y, x);
> +}
> +
> +P1(int *x, int **y)
> +{
> +	int *r0;
> +	int r1;
> +
> +	rcu_read_lock();
> +	r0 = rcu_dereference(*y);
> +	r1 = READ_ONCE(*r0);
> +	rcu_read_unlock();
> +}
> +
> +exists (1:r0=x /\ 1:r1=0)
> diff --git a/tools/memory-model/litmus-tests/MP+polocks.litmus b/tools/memory-model/litmus-tests/MP+polocks.litmus
> new file mode 100644
> index 000000000000..5fe6f1e3c452
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/MP+polocks.litmus
> @@ -0,0 +1,24 @@
> +C MP+polocks
> +
> +{}
> +
> +P0(int *x, int *y, spinlock_t *mylock)
> +{
> +	WRITE_ONCE(*x, 1);
> +	spin_lock(mylock);
> +	WRITE_ONCE(*y, 1);
> +	spin_unlock(mylock);
> +}
> +
> +P1(int *x, int *y, spinlock_t *mylock)
> +{
> +	int r0;
> +	int r1;
> +
> +	spin_lock(mylock);
> +	r0 = READ_ONCE(*y);
> +	spin_unlock(mylock);
> +	r1 = READ_ONCE(*x);
> +}
> +
> +exists (1:r0=1 /\ 1:r1=0)
> diff --git a/tools/memory-model/litmus-tests/MP+poonceonces.litmus b/tools/memory-model/litmus-tests/MP+poonceonces.litmus
> new file mode 100644
> index 000000000000..46e1ac7ba126
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/MP+poonceonces.litmus
> @@ -0,0 +1,20 @@
> +C MP+poonceonces
> +
> +{}
> +
> +P0(int *x, int *y)
> +{
> +	WRITE_ONCE(*x, 1);
> +	WRITE_ONCE(*y, 1);
> +}
> +
> +P1(int *x, int *y)
> +{
> +	int r0;
> +	int r1;
> +
> +	r0 = READ_ONCE(*y);
> +	r1 = READ_ONCE(*x);
> +}
> +
> +exists (1:r0=1 /\ 1:r1=0)
> diff --git a/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus b/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus
> new file mode 100644
> index 000000000000..0b00cc7293ba
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus
> @@ -0,0 +1,20 @@
> +C MP+pooncerelease+poacquireonce
> +
> +{}
> +
> +P0(int *x, int *y)
> +{
> +	WRITE_ONCE(*x, 1);
> +	smp_store_release(y, 1);
> +}
> +
> +P1(int *x, int *y)
> +{
> +	int r0;
> +	int r1;
> +
> +	r0 = smp_load_acquire(y);
> +	r1 = READ_ONCE(*x);
> +}
> +
> +exists (1:r0=1 /\ 1:r1=0)
> diff --git a/tools/memory-model/litmus-tests/MP+porevlocks.litmus b/tools/memory-model/litmus-tests/MP+porevlocks.litmus
> new file mode 100644
> index 000000000000..90d011c34f33
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/MP+porevlocks.litmus
> @@ -0,0 +1,24 @@
> +C MP+porevlocks
> +
> +{}
> +
> +P0(int *x, int *y, spinlock_t *mylock)
> +{
> +	int r0;
> +	int r1;
> +
> +	r0 = READ_ONCE(*y);
> +	spin_lock(mylock);
> +	r1 = READ_ONCE(*x);
> +	spin_unlock(mylock);
> +}
> +
> +P1(int *x, int *y, spinlock_t *mylock)
> +{
> +	spin_lock(mylock);
> +	WRITE_ONCE(*x, 1);
> +	spin_unlock(mylock);
> +	WRITE_ONCE(*y, 1);
> +}
> +
> +exists (0:r0=1 /\ 0:r1=0)
> diff --git a/tools/memory-model/litmus-tests/MP+wmbonceonce+rmbonceonce.litmus b/tools/memory-model/litmus-tests/MP+wmbonceonce+rmbonceonce.litmus
> new file mode 100644
> index 000000000000..604ad41ea0c2
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/MP+wmbonceonce+rmbonceonce.litmus
> @@ -0,0 +1,22 @@
> +C MP+wmbonceonce+rmbonceonce
> +
> +{}
> +
> +P0(int *x, int *y)
> +{
> +	WRITE_ONCE(*x, 1);
> +	smp_wmb();
> +	WRITE_ONCE(*y, 1);
> +}
> +
> +P1(int *x, int *y)
> +{
> +	int r0;
> +	int r1;
> +
> +	r0 = READ_ONCE(*y);
> +	smp_rmb();
> +	r1 = READ_ONCE(*x);
> +}
> +
> +exists (1:r0=1 /\ 1:r1=0)
> diff --git a/tools/memory-model/litmus-tests/R+mbonceonces.litmus b/tools/memory-model/litmus-tests/R+mbonceonces.litmus
> new file mode 100644
> index 000000000000..e69b9e3e9436
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/R+mbonceonces.litmus
> @@ -0,0 +1,21 @@
> +C R+mbonceonces
> +
> +{}
> +
> +P0(int *x, int *y)
> +{
> +	WRITE_ONCE(*x, 1);
> +	smp_mb();
> +	WRITE_ONCE(*y, 1);
> +}
> +
> +P1(int *x, int *y)
> +{
> +	int r0;
> +
> +	WRITE_ONCE(*y, 2);
> +	smp_mb();
> +	r0 = READ_ONCE(*x);
> +}
> +
> +exists (y=2 /\ 1:r0=0)
> diff --git a/tools/memory-model/litmus-tests/R+poonceonces.litmus b/tools/memory-model/litmus-tests/R+poonceonces.litmus
> new file mode 100644
> index 000000000000..f7a12e00f82d
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/R+poonceonces.litmus
> @@ -0,0 +1,19 @@
> +C R+poonceonces
> +
> +{}
> +
> +P0(int *x, int *y)
> +{
> +	WRITE_ONCE(*x, 1);
> +	WRITE_ONCE(*y, 1);
> +}
> +
> +P1(int *x, int *y)
> +{
> +	int r0;
> +
> +	WRITE_ONCE(*y, 2);
> +	r0 = READ_ONCE(*x);
> +}
> +
> +exists (y=2 /\ 1:r0=0)
> diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
> new file mode 100644
> index 000000000000..42051b133085
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/README
> @@ -0,0 +1,125 @@
> +This directory contains the following litmus tests:
> +
> +CoRR+poonceonce+Once.litmus
> +	Test of read-read coherence, that is, whether or not two
> +	successive reads from the same variable are ordered.
> +
> +CoRW+poonceonce+Once.litmus
> +	Test of read-write coherence, that is, whether or not a read
> +	from a given variable followed by a write to that same variable
> +	are ordered.
> +
> +CoWR+poonceonce+Once.litmus
> +	Test of write-read coherence, that is, whether or not a write
> +	to a given variable followed by a read from that same variable
> +	are ordered.
> +
> +CoWW+poonceonce.litmus
> +	Test of write-write coherence, that is, whether or not two
> +	successive writes to the same variable are ordered.
> +
> +IRIW+mbonceonces+OnceOnce.litmus
> +	Test of independent reads from independent writes with smp_mb()
> +	between each pairs of reads.  In other words, is smp_mb()
> +	sufficient to cause two different reading processes to agree on
> +	the order of a pair of writes, where each write is to a different
> +	variable by a different process.
> +
> +IRIW+poonceonces+OnceOnce.litmus
> +	Test of independent reads from independent writes with nothing
> +	between each pairs of reads.  In other words, is anything at all
> +	needed to cause two different reading processes to agree on the
> +	order of a pair of writes, where each write is to a different
> +	variable by a different process.
> +
> +ISA2+poonceonces.litmus
> +	As below, but with store-release replaced with WRITE_ONCE()
> +	and load-acquire replaced with READ_ONCE().
> +
> +ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus
> +	Can a release-acquire chain order a prior store against
> +	a later load?
> +
> +LB+ctrlonceonce+mbonceonce.litmus
> +	Does a control dependency and an smp_mb() suffice for the
> +	load-buffering litmus test, where each process reads from one
> +	of two variables then writes to the other?
> +
> +LB+poacquireonce+pooncerelease.litmus
> +	Does a release-acquire pair suffice for the load-buffering
> +	litmus test, where each process reads from one of two variables then
> +	writes to the other?
> +
> +LB+poonceonces.litmus
> +	As above, but with store-release replaced with WRITE_ONCE()
> +	and load-acquire replaced with READ_ONCE().
> +
> +MP+onceassign+derefonce.litmus
> +	As below, but with rcu_assign_pointer() and an rcu_dereference().
> +
> +MP+polocks.litmus
> +	As below, but with the second access of the writer process
> +	and the first access of reader process protected by a lock.
> +
> +MP+poonceonces.litmus
> +	As below, but without the smp_rmb() and smp_wmb().
> +
> +MP+pooncerelease+poacquireonce.litmus
> +	As below, but with a release-acquire chain.
> +
> +MP+porevlocks.litmus
> +	As below, but with the first access of the writer process
> +	and the second access of reader process protected by a lock.
> +	
> +MP+wmbonceonce+rmbonceonce.litmus
> +	Does a smp_wmb() (between the stores) and an smp_rmb() (between
> +	the loads) suffice for the message-passing litmus test, where one
> +	process writes data and then a flag, and the other process reads
> +	the flag and then the data.  (This is similar to the ISA2 tests,
> +	but with two processes instead of three.)
> +
> +R+mbonceonces.litmus
> +	This is the fully ordered (via smp_mb()) version of one of
> +	the classic counterintuitive litmus tests that illustrates the
> +	effects of store propagation delays.
> +
> +R+poonceonces.litmus
> +	As above, but without the smp_mb() invocations.
> +
> +SB+mbonceonces.litmus
> +	This is the fully ordered (again, via smp_mb() version of store
> +	buffering, which forms the core of Dekker's mutual-exclusion
> +	algorithm.
> +
> +SB+poonceonces.litmus
> +	As above, but without the smp_mb() invocations.
> +
> +S+poonceonces.litmus
> +	As below, but without the smp_wmb() and acquire load.
> +
> +S+wmbonceonce+poacquireonce.litmus
> +	Can a smp_wmb(), instead of a release, and an acquire order
> +	a prior store against a subsequent store?
> +
> +WRC+poonceonces+Once.litmus
> +WRC+pooncerelease+rmbonceonce+Once.litmus
> +	These two are members of an extension of the MP litmus-test class
> +	in which the first write is moved to a separate process.
> +
> +Z6.0+pooncelock+pooncelock+pombonce.litmus
> +	Is the ordering provided by a spin_unlock() and a subsequent
> +	spin_lock() sufficient to make ordering apparent to accesses
> +	by a process not holding the lock?
> +
> +Z6.0+pooncelock+poonceLock+pombonce.litmus
> +	As above, but with smp_mb__after_spinlock() immediately
> +	following the spin_lock().
> +
> +Z6.0+pooncerelease+poacquirerelease+mbonceonce.litmus
> +	Is the ordering provided by a release-acquire chain sufficient
> +	to make ordering apparent to accesses by a process that does
> +	not participate in that release-acquire chain?
> +
> +A great many more litmus tests are available here:
> +
> +	https://github.com/paulmckrcu/litmus
> diff --git a/tools/memory-model/litmus-tests/S+poonceonces.litmus b/tools/memory-model/litmus-tests/S+poonceonces.litmus
> new file mode 100644
> index 000000000000..d0d541c8ec7d
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/S+poonceonces.litmus
> @@ -0,0 +1,19 @@
> +C S+poonceonces
> +
> +{}
> +
> +P0(int *x, int *y)
> +{
> +	WRITE_ONCE(*x, 2);
> +	WRITE_ONCE(*y, 1);
> +}
> +
> +P1(int *x, int *y)
> +{
> +	int r0;
> +
> +	r0 = READ_ONCE(*y);
> +	WRITE_ONCE(*x, 1);
> +}
> +
> +exists (x=2 /\ 1:r0=1)
> diff --git a/tools/memory-model/litmus-tests/S+wmbonceonce+poacquireonce.litmus b/tools/memory-model/litmus-tests/S+wmbonceonce+poacquireonce.litmus
> new file mode 100644
> index 000000000000..1d292d0d6603
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/S+wmbonceonce+poacquireonce.litmus
> @@ -0,0 +1,20 @@
> +C S+wmbonceonce+poacquireonce
> +
> +{}
> +
> +P0(int *x, int *y)
> +{
> +	WRITE_ONCE(*x, 2);
> +	smp_wmb();
> +	WRITE_ONCE(*y, 1);
> +}
> +
> +P1(int *x, int *y)
> +{
> +	int r0;
> +
> +	r0 = smp_load_acquire(y);
> +	WRITE_ONCE(*x, 1);
> +}
> +
> +exists (x=2 /\ 1:r0=1)
> diff --git a/tools/memory-model/litmus-tests/SB+mbonceonces.litmus b/tools/memory-model/litmus-tests/SB+mbonceonces.litmus
> new file mode 100644
> index 000000000000..b76caa5af1af
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/SB+mbonceonces.litmus
> @@ -0,0 +1,23 @@
> +C SB+mbonceonces
> +
> +{}
> +
> +P0(int *x, int *y)
> +{
> +	int r0;
> +
> +	WRITE_ONCE(*x, 1);
> +	smp_mb();
> +	r0 = READ_ONCE(*y);
> +}
> +
> +P1(int *x, int *y)
> +{
> +	int r0;
> +
> +	WRITE_ONCE(*y, 1);
> +	smp_mb();
> +	r0 = READ_ONCE(*x);
> +}
> +
> +exists (0:r0=0 /\ 1:r0=0)
> diff --git a/tools/memory-model/litmus-tests/SB+poonceonces.litmus b/tools/memory-model/litmus-tests/SB+poonceonces.litmus
> new file mode 100644
> index 000000000000..c1797e03807e
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/SB+poonceonces.litmus
> @@ -0,0 +1,21 @@
> +C SB+poonceonces
> +
> +{}
> +
> +P0(int *x, int *y)
> +{
> +	int r0;
> +
> +	WRITE_ONCE(*x, 1);
> +	r0 = READ_ONCE(*y);
> +}
> +
> +P1(int *x, int *y)
> +{
> +	int r0;
> +
> +	WRITE_ONCE(*y, 1);
> +	r0 = READ_ONCE(*x);
> +}
> +
> +exists (0:r0=0 /\ 1:r0=0)
> diff --git a/tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus b/tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus
> new file mode 100644
> index 000000000000..f5e7c92f61cc
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus
> @@ -0,0 +1,27 @@
> +C WRC+poonceonces+Once
> +
> +{}
> +
> +P0(int *x)
> +{
> +	WRITE_ONCE(*x, 1);
> +}
> +
> +P1(int *x, int *y)
> +{
> +	int r0;
> +
> +	r0 = READ_ONCE(*x);
> +	WRITE_ONCE(*y, 1);
> +}
> +
> +P2(int *x, int *y)
> +{
> +	int r0;
> +	int r1;
> +
> +	r0 = READ_ONCE(*y);
> +	r1 = READ_ONCE(*x);
> +}
> +
> +exists (1:r0=1 /\ 2:r0=1 /\ 2:r1=0)
> diff --git a/tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus b/tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus
> new file mode 100644
> index 000000000000..e3d0018025dd
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus
> @@ -0,0 +1,28 @@
> +C WRC+pooncerelease+rmbonceonce+Once
> +
> +{}
> +
> +P0(int *x)
> +{
> +	WRITE_ONCE(*x, 1);
> +}
> +
> +P1(int *x, int *y)
> +{
> +	int r0;
> +
> +	r0 = READ_ONCE(*x);
> +	smp_store_release(y, 1);
> +}
> +
> +P2(int *x, int *y)
> +{
> +	int r0;
> +	int r1;
> +
> +	r0 = READ_ONCE(*y);
> +	smp_rmb();
> +	r1 = READ_ONCE(*x);
> +}
> +
> +exists (1:r0=1 /\ 2:r0=1 /\ 2:r1=0)
> diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
> new file mode 100644
> index 000000000000..9c2cb53e6ef0
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
> @@ -0,0 +1,33 @@
> +C Z6.0+pooncelock+poonceLock+pombonce
> +
> +{}
> +
> +P0(int *x, int *y, spinlock_t *mylock)
> +{
> +	spin_lock(mylock);
> +	WRITE_ONCE(*x, 1);
> +	WRITE_ONCE(*y, 1);
> +	spin_unlock(mylock);
> +}
> +
> +P1(int *y, int *z, spinlock_t *mylock)
> +{
> +	int r0;
> +
> +	spin_lock(mylock);
> +	smp_mb__after_spinlock();
> +	r0 = READ_ONCE(*y);
> +	WRITE_ONCE(*z, 1);
> +	spin_unlock(mylock);
> +}
> +
> +P2(int *x, int *z)
> +{
> +	int r1;
> +
> +	WRITE_ONCE(*z, 2);
> +	smp_mb();
> +	r1 = READ_ONCE(*x);
> +}
> +
> +exists (1:r0=1 /\ z=2 /\ 2:r1=0)
> diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus
> new file mode 100644
> index 000000000000..c9a1f1a49ae1
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus
> @@ -0,0 +1,32 @@
> +C Z6.0+pooncelock+pooncelock+pombonce
> +
> +{}
> +
> +P0(int *x, int *y, spinlock_t *mylock)
> +{
> +	spin_lock(mylock);
> +	WRITE_ONCE(*x, 1);
> +	WRITE_ONCE(*y, 1);
> +	spin_unlock(mylock);
> +}
> +
> +P1(int *y, int *z, spinlock_t *mylock)
> +{
> +	int r0;
> +
> +	spin_lock(mylock);
> +	r0 = READ_ONCE(*y);
> +	WRITE_ONCE(*z, 1);
> +	spin_unlock(mylock);
> +}
> +
> +P2(int *x, int *z)
> +{
> +	int r1;
> +
> +	WRITE_ONCE(*z, 2);
> +	smp_mb();
> +	r1 = READ_ONCE(*x);
> +}
> +
> +exists (1:r0=1 /\ z=2 /\ 2:r1=0)
> diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+mbonceonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+mbonceonce.litmus
> new file mode 100644
> index 000000000000..25409a033514
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+mbonceonce.litmus
> @@ -0,0 +1,28 @@
> +C Z6.0+pooncerelease+poacquirerelease+mbonceonce
> +
> +{}
> +
> +P0(int *x, int *y)
> +{
> +	WRITE_ONCE(*x, 1);
> +	smp_store_release(y, 1);
> +}
> +
> +P1(int *y, int *z)
> +{
> +	int r0;
> +
> +	r0 = smp_load_acquire(y);
> +	smp_store_release(z, 1);
> +}
> +
> +P2(int *x, int *z)
> +{
> +	int r1;
> +
> +	WRITE_ONCE(*z, 2);
> +	smp_mb();
> +	r1 = READ_ONCE(*x);
> +}
> +
> +exists (1:r0=1 /\ z=2 /\ 2:r1=0)
> diff --git a/tools/memory-model/lock.cat b/tools/memory-model/lock.cat
> new file mode 100644
> index 000000000000..ba4a4ec6d313
> --- /dev/null
> +++ b/tools/memory-model/lock.cat
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +(*
> + * Copyright (C) 2016 Luc Maranget <luc.maranget@inria.fr> for Inria
> + * Copyright (C) 2017 Alan Stern <stern@rowland.harvard.edu>
> + *)
> +
> +(* Generate coherence orders and handle lock operations *)
> +
> +include "cross.cat"
> +
> +(* From lock reads to their partner lock writes *)
> +let lk-rmw = ([LKR] ; po-loc ; [LKW]) \ (po ; po)
> +let rmw = rmw | lk-rmw
> +
> +(*
> + * A paired LKR must always see an unlocked value; spin_lock() calls nested
> + * inside a critical section (for the same lock) always deadlock.
> + *)
> +empty ([LKW] ; po-loc ; [domain(lk-rmw)]) \ (po-loc ; [UL] ; po-loc)
> +	as lock-nest
> +
> +(* The litmus test is invalid if an LKW event is not part of an RMW pair *)
> +flag ~empty LKW \ range(lk-rmw) as unpaired-LKW
> +
> +(* This will be allowed if we implement spin_is_locked() *)
> +flag ~empty LKR \ domain(lk-rmw) as unpaired-LKR
> +
> +(* There should be no R or W accesses to spinlocks *)
> +let ALL-LOCKS = LKR | LKW | UL | LF
> +flag ~empty [M \ IW] ; loc ; [ALL-LOCKS] as mixed-lock-accesses
> +
> +(* The final value of a spinlock should not be tested *)
> +flag ~empty [FW] ; loc ; [ALL-LOCKS] as lock-final
> +
> +
> +(*
> + * Put lock operations in their appropriate classes, but leave UL out of W
> + * until after the co relation has been generated.
> + *)
> +let R = R | LKR | LF
> +let W = W | LKW
> +
> +let Release = Release | UL
> +let Acquire = Acquire | LKR
> +
> +
> +(* Match LKW events to their corresponding UL events *)
> +let critical = ([LKW] ; po-loc ; [UL]) \ (po-loc ; [LKW | UL] ; po-loc)
> +
> +flag ~empty UL \ range(critical) as unmatched-unlock
> +
> +(* Allow up to one unmatched LKW per location; more must deadlock *)
> +let UNMATCHED-LKW = LKW \ domain(critical)
> +empty ([UNMATCHED-LKW] ; loc ; [UNMATCHED-LKW]) \ id as unmatched-locks
> +
> +
> +(* rfi for LF events: link each LKW to the LF events in its critical section *)
> +let rfi-lf = ([LKW] ; po-loc ; [LF]) \ ([LKW] ; po-loc ; [UL] ; po-loc)
> +
> +(* rfe for LF events *)
> +let all-possible-rfe-lf =
> +  (*
> +   * Given an LF event r, compute the possible rfe edges for that event
> +   * (all those starting from LKW events in other threads),
> +   * and then convert that relation to a set of single-edge relations.
> +   *)
> +  let possible-rfe-lf r =
> +    let pair-to-relation p = p ++ 0
> +    in map pair-to-relation ((LKW * {r}) & loc & ext)
> +  (* Do this for each LF event r that isn't in rfi-lf *)
> +  in map possible-rfe-lf (LF \ range(rfi-lf))
> +
> +(* Generate all rf relations for LF events *)
> +with rfe-lf from cross(all-possible-rfe-lf)
> +let rf = rf | rfi-lf | rfe-lf
> +
> +
> +(* Generate all co relations, including LKW events but not UL *)
> +let co0 = co0 | ([IW] ; loc ; [LKW]) |
> +	(([LKW] ; loc ; [UNMATCHED-LKW]) \ [UNMATCHED-LKW])
> +include "cos-opt.cat"
> +let W = W | UL
> +let M = R | W
> +
> +(* Merge UL events into co *)
> +let co = (co | critical | (critical^-1 ; co))+
> +let coe = co & ext
> +let coi = co & int
> +
> +(* Merge LKR events into rf *)
> +let rf = rf | ([IW | UL] ; singlestep(co) ; lk-rmw^-1)
> +let rfe = rf & ext
> +let rfi = rf & int
> +
> +let fr = rf^-1 ; co
> +let fre = fr & ext
> +let fri = fr & int
> +
> +show co,rf,fr
