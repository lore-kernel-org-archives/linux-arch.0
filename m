From: Szabolcs Nagy <szabolcs.nagy@arm.com>
Subject: Re: [PATCH v7 29/29] arm64: mte: Add Memory Tagging Extension
 documentation
Date: Tue, 28 Jul 2020 15:53:51 +0100
Message-ID: <20200728145350.GR7127@arm.com>
References: <20200715170844.30064-1-catalin.marinas@arm.com>
 <20200715170844.30064-30-catalin.marinas@arm.com>
 <20200727163634.GO7127@arm.com>
 <20200728110758.GA21941@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vi1eur05on2081.outbound.protection.outlook.com ([40.107.21.81]:16385
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730455AbgG1OyE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Jul 2020 10:54:04 -0400
Content-Disposition: inline
In-Reply-To: <20200728110758.GA21941@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-arch@vger.kernel.org, Peter Collingbourne <pcc@google.com>, Andrey Konovalov <andreyknvl@google.com>, Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, nd@arm.com

The 07/28/2020 12:08, Dave Martin wrote:
> On Mon, Jul 27, 2020 at 05:36:35PM +0100, Szabolcs Nagy wrote:
> > The 07/15/2020 18:08, Catalin Marinas wrote:
> > > +The user can select the above modes, per thread, using the
> > > +``prctl(PR_SET_TAGGED_ADDR_CTRL, flags, 0, 0, 0)`` system call where
> > > +``flags`` contain one of the following values in the ``PR_MTE_TCF_MASK``
> > > +bit-field:
> > > +
> > > +- ``PR_MTE_TCF_NONE``  - *Ignore* tag check faults
> > > +- ``PR_MTE_TCF_SYNC``  - *Synchronous* tag check fault mode
> > > +- ``PR_MTE_TCF_ASYNC`` - *Asynchronous* tag check fault mode
> > > +
> > > +The current tag check fault mode can be read using the
> > > +``prctl(PR_GET_TAGGED_ADDR_CTRL, 0, 0, 0, 0)`` system call.
> > 
> > we discussed the need for per process prctl off list, i will
> > try to summarize the requirement here:
> > 
> > - it cannot be guaranteed in general that a library initializer
> > or first call into a library happens when the process is still
> > single threaded.
> > 
> > - user code currently has no way to call prctl in all threads of
> > a process and even within the c runtime doing so is problematic
> > (it has to signal all threads, which requires a reserved signal
> > and dealing with exiting threads and signal masks, such mechanism
> > can break qemu user and various other userspace tooling).
> 
> When working on the SVE support, I came to the conclusion that this
> kind of thing would normally either be done by the runtime itself, or in
> close cooperation with the runtime.  However, for SVE it never makes
> sense for one thread to asynchronously change the vector length of
> another thread -- that's different from the MTE situation.

currently there is libc mechanism to do some operation
in all threads (e.g. for set*id) but this is fragile
and not something that can be exposed to user code.
(on the kernel side it should be much simpler to do)

> > - we don't yet have defined contract in userspace about how user
> > code may enable mte (i.e. use the prctl call), but it seems that
> > there will be use cases for it: LD_PRELOADing malloc for heap
> > tagging is one such case, but any library or custom allocator
> > that wants to use mte will have this issue: when it enables mte
> > it wants to enable it for all threads in the process. (or at
> > least all threads managed by the c runtime).
> 
> What are the situations where we anticipate a need to twiddle MTE in
> multiple threads simultaneously, other than during process startup?
> 
> > - even if user code is not allowed to call the prctl directly,
> > i.e. the prctl settings are owned by the libc, there will be
> > cases when the settings have to be changed in a multithreaded
> > process (e.g. dlopening a library that requires a particular
> > mte state).
> 
> Could be avoided by refusing to dlopen a library that is incompatible
> with the current process.
> 
> dlopen()ing a library that doesn't support tagged addresses, in a
> process that does use tagged addresses, seems undesirable even if tag
> checking is currently turned off.

yes but it can go the other way too:

at startup the libc does not enable tag checks
for performance reasons, but at dlopen time a
library is detected to use mte (e.g. stack
tagging or custom allocator).

then libc or the dlopened library has to ensure
that checks are enabled in all threads. (in case
of stack tagging the libc has to mark existing
stacks with PROT_MTE too, there is mechanism for
this in glibc to deal with dlopened libraries
that require executable stack and only reject
the dlopen if this cannot be performed.)

another usecase is that the libc is mte-safe
(it accepts tagged pointers and memory in its
interfaces), but it does not enable mte (this
will be the case with glibc 2.32) and user
libraries have to enable mte to use it (custom
allocator or malloc interposition are examples).

and i think this is necessary if userpsace wants
to turn async tag check into sync tag check at
runtime when a failure is detected.

> > a solution is to introduce a flag like SECCOMP_FILTER_FLAG_TSYNC
> > that means the prctl is for all threads in the process not just
> > for the current one. however the exact semantics is not obvious
> > if there are inconsistent settings in different threads or user
> > code tries to use the prctl concurrently: first checking then
> > setting the mte state via separate prctl calls is racy. but if
> > the userspace contract for enabling mte limits who and when can
> > call the prctl then i think the simple sync flag approach works.
> > 
> > (the sync flag should apply to all prctl settings: tagged addr
> > syscall abi, mte check fault mode, irg tag excludes. ideally it
> > would work for getting the process wide state and it would fail
> > in case of inconsistent settings.)
> 
> If going down this route, perhaps we could have sets of settings:
> so for each setting we have a process-wide value and a per-thread
> value, with defines rules about how they combine.
> 
> Since MTE is a debugging feature, we might be able to be less aggressive
> about synchronisation than in the SECCOMP case.

separate process-wide and per-thread value
works for me and i expect most uses will
be process wide settings.

i don't think mte is less of a security
feature than seccomp.

if linux does not want to add a per process
setting then only libc will be able to opt-in
to mte and only at very early in the startup
process (before executing any user code that
may start threads). this is not out of question,
but i think it limits the usage and deployment
options.

> > we may need to document some memory ordering details when
> > memory accesses in other threads are affected, but i think
> > that can be something simple that leaves it unspecified
> > what happens with memory accesses that are not synchrnized
> > with the prctl call.
> 
> Hmmm...

e.g. it may be enough if the spec only works if
there is no PROT_MTE memory mapped yet, and no
tagged addresses are present in the multi-threaded
process when the prctl is called.
