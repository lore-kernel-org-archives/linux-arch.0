From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 2/9] RISC-V: Atomic and Locking Code
Date: Mon, 10 Jul 2017 13:39:48 -0700 (PDT)
Message-ID: <mhng-0db73539-1462-456a-a6e2-63bb04c8e7e5@palmer-si-x1c4>
References: <20170707080819.krtmzeqlyrl6c35p@hirez.programming.kicks-ass.net>
Mime-Version: 1.0 (MHng)
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170707080819.krtmzeqlyrl6c35p@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org
Cc: mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com, patches@groups.riscv.org
List-Id: linux-arch.vger.kernel.org

On Fri, 07 Jul 2017 01:08:19 PDT (-0700), peterz@infradead.org wrote:
> On Thu, Jul 06, 2017 at 06:04:13PM -0700, Palmer Dabbelt wrote:
>>   +/*
>>   + * TODO_RISCV_MEMORY_MODEL: I don't think RISC-V is allowed to perform a
>>   + * speculative load, but we're going to wait on a formal memory model in order
>>   + * to ensure this is safe to elide.
>>   + */
>>   +#define smp_acquire__after_ctrl_dep()  smp_mb()
>
> So typically a control dependency already provides read->write ordering,
> by virtue of speculative writes being BAD.
>
> So a control dependency only needs to provide read->read ordering in
> addition to the existing read->write ordering and hence this barrier is
> typically a smp_rmb().
>
> See the definition in asm-generic/barrier.h.
>
> Having to use a full barrier here would imply your architecture does not
> respect control dependencies, which would be BAD because we actually
> rely on them.
>
> So either the normal definition is good and you don't need to do
> anything, or you prohibit read speculation in which case you have a
> special case like TILE does.

I'd be very surprised (and very unhappy) if we ended up with speculative
writes, as that would be a huge mess.

Thanks!
