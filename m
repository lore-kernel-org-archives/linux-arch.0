From: Will Deacon <will.deacon@arm.com>
Subject: Behaviour of smp_mb__{before,after}_spin* and acquire/release
Date: Tue, 13 Jan 2015 16:33:54 +0000
Message-ID: <20150113163353.GE31784@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: paulmck@linux.vnet.ibm.com, peterz@infradead.org
Cc: torvalds@linux-foundation.org, oleg@redhat.com, benh@kernel.crashing.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi Paul,

I started dusting off a series I've been working to implement a relaxed
atomic API in Linux (i.e. things like atomic_read(v, ACQUIRE)) but I'm
having trouble making sense of the ordering semantics we have in mainline
today:

  1. Does smp_mb__before_spinlock actually have to order prior loads
     against later loads and stores? Documentation/memory-barriers.txt
     says it does, but that doesn't match the comment (or implementation)
     in include/linux/spinlock.h

  2. Does smp_mb__after_unlock_lock order smp_store_release against
     smp_load_acquire? Again, Documentation/memory-barriers.txt puts
     these operations into the RELEASE and ACQUIRE classes respectively,
     but since smp_mb__after_unlock_lock is a NOP everywhere other than
     PowerPC, I don't think this is enforced by the current code. Most
     architectures follow the pattern used by asm-generic/barrier.h:

       release: smp_mb(); STORE
       acquire: LOAD; smp_mb();

     which doesn't provide any release -> acquire ordering afaict.

My plan for the atomics was to add acquire, release, acquire + release
and unordered variants, where the acquire/release semantics would
actually be sequentially consistent. That allows us to implement the
existing atomics easily in terms of the new API, but it's different
to what we're doing for the smp_load_acquire and smp_store_release
functions above.

Cheers,

Will
