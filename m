Return-Path: <peterz@infradead.org>
Date: Thu, 24 Oct 2019 19:40:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 08/17] x86/entry: Move syscall irq tracing to C code
Message-ID: <20191024174044.GJ4114@hirez.programming.kicks-ass.net>
References: <20191023122705.198339581@linutronix.de>
 <20191023123118.386844979@linutronix.de>
 <CALCETrWLk9LKV4+_mrOKDc3GUvXbCjqA5R6cdpqq02xoRCBOHw@mail.gmail.com>
 <CALCETrV79pw7-nisp4VdEkQ4=fr2nfJFOMCtyKmWZR6PG3=oWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrV79pw7-nisp4VdEkQ4=fr2nfJFOMCtyKmWZR6PG3=oWg@mail.gmail.com>
To: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm list <kvm@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Miroslav Benes <mbenes@suse.cz>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191024174044.QS6o6sLSAwIOX0gVTEhEgLOfAJm1gED3GyKAkMVoIAo@z>

On Thu, Oct 24, 2019 at 09:24:13AM -0700, Andy Lutomirski wrote:
> On Wed, Oct 23, 2019 at 2:30 PM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Wed, Oct 23, 2019 at 5:31 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >
> > > Interrupt state tracing can be safely done in C code. The few stack
> > > operations in assembly do not need to be covered.
> > >
> > > Remove the now pointless indirection via .Lsyscall_32_done and jump to
> > > swapgs_restore_regs_and_return_to_usermode directly.
> >
> > This doesn't look right.
> 
> Well, I feel a bit silly.  I read this:
> 
> >
> > >  #define SYSCALL_EXIT_WORK_FLAGS                                \
> > > @@ -279,6 +282,9 @@ static void syscall_slow_exit_work(struc
> 
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> and I applied the diff in my head to the wrong function, and I didn't
> notice that it didn't really apply there.  Oddly, gitweb gets this

I had the same when reviewing these patches; I was almost going to ask
tglx about it on IRC when the penny dropped.
