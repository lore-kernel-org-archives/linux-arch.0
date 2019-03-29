Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57650 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728550AbfC2Kas (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 29 Mar 2019 06:30:48 -0400
Date: Fri, 29 Mar 2019 10:30:40 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v13 04/20] mm, arm64: untag user pointers passed to
 memory syscalls
Message-ID: <20190329103039.GA44339@arrakis.emea.arm.com>
References: <cover.1553093420.git.andreyknvl@google.com>
 <44ad2d0c55dbad449edac23ae46d151a04102a1d.1553093421.git.andreyknvl@google.com>
 <20190322114357.GC13384@arrakis.emea.arm.com>
 <CAAeHK+xE-ywfpVHRhBJVGiqOe0+BYW9awUa10ZP4P6Ggc8nxMg@mail.gmail.com>
 <20190328141934.38960af0@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328141934.38960af0@gandalf.local.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrey Konovalov <andreyknvl@google.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Jens Wiklander <jens.wiklander@linaro.org>, Alex Williamson <alex.williamson@redhat.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Memory Management List <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, Evgeniy Stepanov <eugenis@google.com>, Lee Smith <Lee.Smith@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dave Martin <Dave.Martin@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Message-ID: <20190329103040.PQXqhjCA9x0RtcZTdsl2zEhadEy4bLys2j0gVUNdIY8@z>

(I trimmed down the cc list a bit since it's always bouncing)

On Thu, Mar 28, 2019 at 02:19:34PM -0400, Steven Rostedt wrote:
> On Thu, 28 Mar 2019 19:10:07 +0100
> Andrey Konovalov <andreyknvl@google.com> wrote:
> 
> > > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > > ---
> > > >  ipc/shm.c      | 2 ++
> > > >  mm/madvise.c   | 2 ++
> > > >  mm/mempolicy.c | 5 +++++
> > > >  mm/migrate.c   | 1 +
> > > >  mm/mincore.c   | 2 ++
> > > >  mm/mlock.c     | 5 +++++
> > > >  mm/mmap.c      | 7 +++++++
> > > >  mm/mprotect.c  | 1 +
> > > >  mm/mremap.c    | 2 ++
> > > >  mm/msync.c     | 2 ++
> > > >  10 files changed, 29 insertions(+)  
> > >
> > > I wonder whether it's better to keep these as wrappers in the arm64
> > > code.  
> > 
> > I don't think I understand what you propose, could you elaborate?
> 
> I believe Catalin is saying that instead of placing things like:
> 
> @@ -1593,6 +1593,7 @@ SYSCALL_DEFINE3(shmat, int, shmid, char __user *, shmaddr, int, shmflg)
>  	unsigned long ret;
>  	long err;
>  
> +	shmaddr = untagged_addr(shmaddr);
> 
> To instead have the shmaddr set to the untagged_addr() before calling
> the system call, and passing the untagged addr to the system call, as
> that goes through the arm64 architecture specific code first.

Indeed. For example, we already have a SYSCALL_DEFINE6(mmap, ...) in
arch/arm64/kernel/sys.c, just add the untagging there. We could do
something similar for the other syscalls. I don't mind doing this in the
generic code but if it's only needed for arm64, I'd rather keep the
generic changes to a minimum.

(I had a hack overriding __SC_CAST to do this automatically for pointer
arguments but this wouldn't work on mmap() and friends as the argument
is unsigned long)

-- 
Catalin
