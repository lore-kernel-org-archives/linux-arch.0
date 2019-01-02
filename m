From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC 0/4] barriers using data dependency
Date: Wed, 2 Jan 2019 15:57:45 -0500
Message-ID: <20190102205715.14054-1-mst@redhat.com>
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
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, linux-arch@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Daniel Lustig <dlustig@nvidia.com>, Akira Yokosawa <akiyks@gmail.com>, Will Deacon <will.deacon@arm.com>, Nicholas Piggin <npiggin@gmail.com>, virtualization@lists.linux-foundation.org, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, netdev@vger.kernel.org, Luc Maranget <luc.maranget@inria.fr>, Jade Alglave <j.alglave@ucl.ac.uk>, Boqun Feng <boqun.feng@gmail.com>
List-Id: linux-arch.vger.kernel.org

So as explained in Documentation/memory-barriers.txt e.g.
a load followed by a store require a full memory barrier,
to avoid store being ordered before the load.
Similarly load-load requires a read memory barrier.

Thinking about it, we can actually create a data dependency
by mixing the first loaded value into the pointer being
accessed.

This adds an API for this and uses it in virtio.

Written over the holiday and build tested only so far.

This patchset is also suboptimal on e.g. x86 where e.g. smp_rmb is a nop.

Sending out for early feedback/flames.

Michael S. Tsirkin (4):
  include/linux/compiler*.h: fix OPTIMIZER_HIDE_VAR
  include/linux/compiler.h: allow memory operands
  barriers: convert a control to a data dependency
  virtio: use dependent_ptr_mb

 Documentation/memory-barriers.txt | 20 ++++++++++++++++++++
 arch/alpha/include/asm/barrier.h  |  1 +
 drivers/virtio/virtio_ring.c      |  6 ++++--
 include/asm-generic/barrier.h     | 18 ++++++++++++++++++
 include/linux/compiler-clang.h    |  5 ++---
 include/linux/compiler-gcc.h      |  4 ----
 include/linux/compiler-intel.h    |  4 +---
 include/linux/compiler.h          |  8 +++++++-
 8 files changed, 53 insertions(+), 13 deletions(-)

-- 
MST
