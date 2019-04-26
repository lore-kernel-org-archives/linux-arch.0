Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfDZORv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 Apr 2019 10:17:51 -0400
Date: Fri, 26 Apr 2019 15:17:42 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v13 04/20] mm, arm64: untag user pointers passed to
 memory syscalls
Message-ID: <20190426141742.GB54863@arrakis.emea.arm.com>
References: <cover.1553093420.git.andreyknvl@google.com>
 <44ad2d0c55dbad449edac23ae46d151a04102a1d.1553093421.git.andreyknvl@google.com>
 <20190322114357.GC13384@arrakis.emea.arm.com>
 <CAAeHK+xE-ywfpVHRhBJVGiqOe0+BYW9awUa10ZP4P6Ggc8nxMg@mail.gmail.com>
 <20190328141934.38960af0@gandalf.local.home>
 <20190329103039.GA44339@arrakis.emea.arm.com>
 <CAAeHK+xe-zWn8WpCxUxBB2tXL8oiLkshkPi1J3Ly87mACaA4-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+xe-zWn8WpCxUxBB2tXL8oiLkshkPi1J3Ly87mACaA4-A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Jens Wiklander <jens.wiklander@linaro.org>, Alex Williamson <alex.williamson@redhat.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Memory Management List <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, Evgeniy Stepanov <eugenis@google.com>, Lee Smith <Lee.Smith@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dave Martin <Dave.Martin@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Message-ID: <20190426141742.i4DDw9qHkJOJDZQiMdPz8s78rR8ffLtbCvnBZM1p59o@z>

On Tue, Apr 02, 2019 at 02:47:34PM +0200, Andrey Konovalov wrote:
> On Fri, Mar 29, 2019 at 11:30 AM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > On Thu, Mar 28, 2019 at 02:19:34PM -0400, Steven Rostedt wrote:
> > > On Thu, 28 Mar 2019 19:10:07 +0100
> > > Andrey Konovalov <andreyknvl@google.com> wrote:
> > >
> > > > > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > > > > ---
> > > > > >  ipc/shm.c      | 2 ++
> > > > > >  mm/madvise.c   | 2 ++
> > > > > >  mm/mempolicy.c | 5 +++++
> > > > > >  mm/migrate.c   | 1 +
> > > > > >  mm/mincore.c   | 2 ++
> > > > > >  mm/mlock.c     | 5 +++++
> > > > > >  mm/mmap.c      | 7 +++++++
> > > > > >  mm/mprotect.c  | 1 +
> > > > > >  mm/mremap.c    | 2 ++
> > > > > >  mm/msync.c     | 2 ++
> > > > > >  10 files changed, 29 insertions(+)
> > > > >
> > > > > I wonder whether it's better to keep these as wrappers in the arm64
> > > > > code.
> > > >
> > > > I don't think I understand what you propose, could you elaborate?
> > >
> > > I believe Catalin is saying that instead of placing things like:
> > >
> > > @@ -1593,6 +1593,7 @@ SYSCALL_DEFINE3(shmat, int, shmid, char __user *, shmaddr, int, shmflg)
> > >       unsigned long ret;
> > >       long err;
> > >
> > > +     shmaddr = untagged_addr(shmaddr);
> > >
> > > To instead have the shmaddr set to the untagged_addr() before calling
> > > the system call, and passing the untagged addr to the system call, as
> > > that goes through the arm64 architecture specific code first.
> >
> > Indeed. For example, we already have a SYSCALL_DEFINE6(mmap, ...) in
> > arch/arm64/kernel/sys.c, just add the untagging there. We could do
> > something similar for the other syscalls. I don't mind doing this in the
> > generic code but if it's only needed for arm64, I'd rather keep the
> > generic changes to a minimum.
> 
> Do I understand correctly, that I'll need to add ksys_ wrappers for
> each of the memory syscalls, and then redefine them in
> arch/arm64/kernel/sys.c with arm64_ prefix, like it is done for the
> personality syscall right now? This will require generic changes as
> well.

Yes. My aim is to keep the number of untagged_addr() calls in the
generic code to a minimum (rather than just keeping the generic code
changes small).

-- 
Catalin
