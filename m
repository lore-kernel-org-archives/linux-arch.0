From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 00/34] arch: barrier cleanup + __smp_XXX barriers for virt
Date: Wed, 30 Dec 2015 15:24:12 +0200
Message-ID: <1451473761-30019-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org
List-Id: linux-arch.vger.kernel.org

This is really trying to cleanup some virt code, as suggested by Peter, who
said
> You could of course go fix that instead of mutilating things into
> sort-of functional state.

This work is needed for virtio, so it's probably easiest to
merge it through my tree - is this fine by everyone?
Arnd, if you agree, could you ack this please?

Note to arch maintainers: please don't cherry-pick patches out of this patchset
as it's been structured in this order to avoid breaking bisect.
Please send acks instead!

Sometimes, virtualization is weird. For example, virtio does this (conceptually):

#ifdef CONFIG_SMP
                smp_mb();
#else
                mb();
#endif

Similarly, Xen calls mb() when it's not doing any MMIO at all.

Of course it's wrong in the sense that it's suboptimal. What we would really
like is to have, on UP, exactly the same barrier as on SMP.  This is because a
UP guest can run on an SMP host.

But Linux doesn't provide this ability: if CONFIG_SMP is not defined is
optimizes most barriers out to a compiler barrier.

Consider for example x86: what we want is xchg (NOT mfence - there's no real IO
going on here - just switching out of the VM - more like a function call
really) but if built without CONFIG_SMP smp_store_mb does not include this.

Virt in general is probably the only use-case, because this really is an
artifact of interfacing with an SMP host while running an UP kernel,
but since we have (at least) two users, it seems to make sense to
put these APIs in a central place.

In fact, smp_ barriers are stubs on !SMP, so they can be defined as follows:

arch/XXX/include/asm/barrier.h:

#define __smp_mb() DOSOMETHING

include/asm-generic/barrier.h:

#ifdef CONFIG_SMP
#define smp_mb() __smp_mb()
#else
#define smp_mb() barrier()
#endif

This has the benefit of cleaning out a bunch of duplicated
ifdefs on a bunch of architectures - this patchset brings
about a net reduction in LOC, compensated for by extra documentation :)

Then virt can use __smp_XXX when talking to an SMP host.

Touching all archs is a tad tedious, but its fairly straight forward.

The rest of the patchset is structured as follows:

-. Patch 1 documents the __smp APIs, and explains why they are
   useful for virt

-. Patches 2-7 makes sure barrier.h on ia64, powerpc, s390 and sparc
   includes asm-generic/barrier.h: this is safe because code there matches
   asm-generic/barrier.h almost verbatim.
   Minor code tweaks were required in a couple of places.
   Macros duplicated from asm-generic/barrier.h are dropped
   in the process.

   I compiled these arches before and after the changes,
   dumped the .text section (using objdump -O binary) and
   made sure that the object code is exactly identical
   before and after the change.


-. Patch 8 fixes up smp_store_mb in asm-generic/barrier.h:
   it should call smp_mb and not mb. Luckily only used
   in core kernel so we know no one misused it for an
   MMIO barrier (so far).
   This is the only patch that affects code behaviour
   outside virt, and that for !SMP only.
   Compile-tested on a bunch of architectures (x86
   hardware which I have is unaffected by this).
   It's very straightforward so I hope it's enough.
   Hoping for some acks on this architecture.

-. Patches 9-14 make sure barrier.h on all remaining
   architectures includes asm-generic/barrier.h:
   after the change in Patch 8, code there matches
   asm-generic/barrier.h almost verbatim.
   Macros duplicated from asm-generic/barrier.h are dropped
   in the process.

After all that preparatory work, we are getting to the actual change.

-. Patches 15 adds generic smp_XXX wrappers in asm-generic
   these select __smp_XXX or barrier() depending on CONFIG_SMP

-. Patches 16-28 change all architectures to
   define __smp_XXX macros; the generic code in asm-generic/barrier.h
   then defines smp_XXX macros

   I compiled the affected arches before and after the changes,
   dumped the .text section (using objdump -O binary) and
   made sure that the object code is exactly identical
   before and after the change.
   I couldn't fully build sh,tile,xtensa but I did this test
   kernel/rcu/tree.o kernel/sched/wait.o and
   kernel/futex.o and tested these instead.

Unfortunately, I don't have a metag cross-build toolset ready.
Hoping for some acks on this architecture.

Finally, the following patches put the __smp_XXX APIs to work for virt:

-. Patches 29-31 convert virtio and xen drivers to use the __smp_XXX APIs

   xen patches are untested
   virtio ones have been tested on x86

-. Patches 33-34 teach virtio to use
   __smp_load_acquire/__smp_store_release/__smp_store_mb
   This is what started all this work.

   tested on x86

The patchset has been in linux-next for a bit, so far without issues.

Michael S. Tsirkin (34):
  Documentation/memory-barriers.txt: document __smb_mb()
  asm-generic: guard smp_store_release/load_acquire
  ia64: rename nop->iosapic_nop
  ia64: reuse asm-generic/barrier.h
  powerpc: reuse asm-generic/barrier.h
  s390: reuse asm-generic/barrier.h
  sparc: reuse asm-generic/barrier.h
  asm-generic: smp_store_mb should use smp_mb
  arm: reuse asm-generic/barrier.h
  arm64: reuse asm-generic/barrier.h
  metag: reuse asm-generic/barrier.h
  mips: reuse asm-generic/barrier.h
  x86/um: reuse asm-generic/barrier.h
  x86: reuse asm-generic/barrier.h
  asm-generic: add __smp_XXX wrappers
  powerpc: define __smp_XXX
  arm64: define __smp_XXX
  arm: define __smp_XXX
  blackfin: define __smp_XXX
  ia64: define __smp_XXX
  metag: define __smp_XXX
  mips: define __smp_XXX
  s390: define __smp_XXX
  sh: define __smp_XXX, fix smp_store_mb for !SMP
  sparc: define __smp_XXX
  tile: define __smp_XXX
  xtensa: define __smp_XXX
  x86: define __smp_XXX
  Revert "virtio_ring: Update weak barriers to use dma_wmb/rmb"
  virtio_ring: update weak barriers to use __smp_XXX
  xenbus: use __smp_XXX barriers
  xen/io: use __smp_XXX barriers
  virtio: use __smp_load_acquire/__smp_store_release
  virtio_ring: use __smp_store_mb

 arch/arm/include/asm/barrier.h      | 35 ++------------
 arch/arm64/include/asm/barrier.h    | 19 +++-----
 arch/blackfin/include/asm/barrier.h |  4 +-
 arch/ia64/include/asm/barrier.h     | 24 +++-------
 arch/metag/include/asm/barrier.h    | 55 +++++++--------------
 arch/mips/include/asm/barrier.h     | 51 +++++++-------------
 arch/powerpc/include/asm/barrier.h  | 33 ++++---------
 arch/s390/include/asm/barrier.h     | 25 +++++-----
 arch/sh/include/asm/barrier.h       |  3 +-
 arch/sparc/include/asm/barrier_32.h |  1 -
 arch/sparc/include/asm/barrier_64.h | 29 +++--------
 arch/sparc/include/asm/processor.h  |  3 --
 arch/tile/include/asm/barrier.h     |  9 ++--
 arch/x86/include/asm/barrier.h      | 36 ++++++--------
 arch/x86/um/asm/barrier.h           |  9 +---
 arch/xtensa/include/asm/barrier.h   |  4 +-
 include/asm-generic/barrier.h       | 95 +++++++++++++++++++++++++++++++++----
 include/linux/virtio_ring.h         | 48 ++++++++++++++++---
 include/xen/interface/io/ring.h     | 16 +++----
 arch/ia64/kernel/iosapic.c          |  6 +--
 drivers/virtio/virtio_ring.c        | 35 +++++++-------
 drivers/xen/xenbus/xenbus_comms.c   |  8 ++--
 Documentation/memory-barriers.txt   | 33 +++++++++++--
 23 files changed, 292 insertions(+), 289 deletions(-)

-- 
MST
