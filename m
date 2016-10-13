From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 0/3] THREAD_INFO_IN_TASK_STRUCT vs generic preemption code
Date: Thu, 13 Oct 2016 14:52:52 -0700
Message-ID: <CALCETrXL56+_Dus4vLAXrCdZCWgaC0rw6WF=Aqx8Jvu5gcPCeQ@mail.gmail.com>
References: <20161013115712.29517-1-heiko.carstens@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161013115712.29517-1-heiko.carstens@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Mark Rutland <mark.rutland@arm.com>, linux-arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Oct 13, 2016 at 4:57 AM, Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:
> Commit c65eacbe290b ("sched/core: Allow putting thread_info into
> task_struct") made struct thread_info a generic struct with only a
> single flags member if THREAD_INFO_IN_TASK_STRUCT is selected.
>
> This change however seems to be quite x86 centric, since at least the
> generic preemption code (asm-generic/preempt.h) assumes that struct
> thread_info also has a preempt_count member, which apparently was not
> true for x86.
>
> We could add a bit more ifdefs to solve this problem too, but it seems
> to be much simpler to make struct thread_info arch specific
> again. This also makes the conversion to THREAD_INFO_IN_TASK_STRUCT a
> bit easier for architectures that have a couple of arch specific stuff
> in their thread_info definition.

OK, I give in.

But can you coordinate with Mark, because I think I convinced him to
do it a little differently?  I might be changing my mind a bit for an
evil reason.  Specifically, on x86_64, we could do the following evil,
horrible thing:

union {
  u64 flags;
  struct {
    u32 atomic_flags;
    u32 nonatomic_flags;
  }
};

Then we could read and test the full set of flags (currently split
between "flags" and "status") with a single instruction, and we could
set them maximally efficiently.  I don't actually want to do this
right away, but making thread_info fully arch-controlled would allow
this.

--Andy
