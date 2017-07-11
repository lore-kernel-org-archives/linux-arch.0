From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 8/9] RISC-V: User-facing API
Date: Tue, 11 Jul 2017 10:28:13 -0700 (PDT)
Message-ID: <mhng-f86a45af-0ddf-4834-a6ab-2efcc72543d4@palmer-si-x1c4>
References: <20170711135528.GA11417@infradead.org>
Mime-Version: 1.0 (MHng)
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170711135528.GA11417@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: will.deacon@arm.com, hch@infradead.org, peterz@infradead.org, mingo@redhat.com, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, tklauser@distanz.ch, james.hogan@imgtec.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mathieu.desnoyers@efficios.com
List-Id: linux-arch.vger.kernel.org

On Tue, 11 Jul 2017 06:55:28 PDT (-0700), hch@infradead.org wrote:
> On Tue, Jul 11, 2017 at 02:22:15PM +0100, Will Deacon wrote:
>> The problem is that by supporting these hypothetical designs that can't do
>> atomics, you hurt sensible designs that *can* do the atomics because you
>> force them to take an additional indirection that could otherwise be
>> avoided.
>
> Agreed.  But the new patchset seems to remove it already, so I guess
> we're fine on the kernel side.  Now we just need to make sure the
> glibc API doesn't use any indirections.
>
> Note that it might make sense to emit these for very low end nommu
> designs.  Maybe even running Linux, but in that case they'll just need
> a special non-standard ABI for very limited use cases.

glibc has never used these calls on machines with the A extension.  They're
only used in one specific header file to emulate cmpxchg, and they're guarded
by something like "#ifdef riscv_atomic".  Here's the glibc code (from a
slightly older version, glibc is also in submission so everything's a bit of a
mess there too) for reference

  /* If the A (atomic) extension is not present, we need help from the
     kernel to do atomic accesses.  Linux provides two system calls for
     this purpose.  RISCV_ATOMIC_CMPXCHG will perform an atomic compare
     and exchange operation for a 32-bit value.  RISCV_ATOMIC_CMPXCHG64
     will do the same for a 64-bit value. */

  #include <sys/syscall.h>
  #include <sysdep.h>

  #define __HAVE_64B_ATOMICS (__riscv_xlen >= 64)
  #define USE_ATOMIC_COMPILER_BUILTINS 0

  #define __arch_compare_and_exchange_val_8_acq(mem, newval, oldval) \
    (abort (), (__typeof (*mem)) 0)

  #define __arch_compare_and_exchange_val_16_acq(mem, newval, oldval) \
    (abort (), (__typeof (*mem)) 0)

  /* The only basic operation needed is compare and exchange.  */
  #define __arch_compare_and_exchange_val_32_acq(mem, newval, oldval) \
    ({									      \
      INTERNAL_SYSCALL_DECL (__err);					      \
      (__typeof (*mem)) INTERNAL_SYSCALL (sysriscv, __err, 4,		      \
  		      RISCV_ATOMIC_CMPXCHG, mem, oldval, newval);	      \
    })

  #define __arch_compare_and_exchange_val_64_acq(mem, newval, oldval) \
    ({									      \
      INTERNAL_SYSCALL_DECL (__err);					      \
      (__typeof (*mem)) INTERNAL_SYSCALL (sysriscv, __err, 4,		      \
  		      RISCV_ATOMIC_CMPXCHG64, mem, oldval, newval);	      \
    })

We originally had these as a special Kconfig option, but then it was pointed
out that user binaries built on non-A systems wouldn't run on A systems.  That
seemed like a bad idea, so we just enabled it everywhere.

I think we should just table this discussion for now: we can always add the
system calls back in if people build non-A Linux systems.  We'll mark our glibc
port as requiring the A extension and delete the dead code there so nothing
knows about the syscalls.

Thanks!
