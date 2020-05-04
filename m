From: Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH 00/14] Move the ReST files from Documentation/*.txt
Date: Mon, 4 May 2020 18:25:51 +0900
Message-ID: <9f79e15a-4e36-3747-51fc-ca2d8ab616b7@gmail.com>
References: <cover.1588345503.git.mchehab+huawei@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <cover.1588345503.git.mchehab+huawei@kernel.org>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Joel Fernandes <joel@joelfernandes.org>, linux-arch@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, David Howells <dhowells@redhat.com>, Andrea Parri <parri.andrea@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Will Deacon <will@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Joe Perches <joe@perches.com>
List-Id: linux-arch.vger.kernel.org

(CC to documentation, get_maintainer, and LKMM maintainers)

Hi Mauro,

As I didn't receive "[PATCH 12/14] docs: move remaining stuff under
Documentation/*.txt to Documentation/staging", I'm replying to
[PATCH 00/14].

On Fri, 1 May 2020 17:37:44 +0200, Mauro Carvalho Chehab wrote:
> The main goal of this series is to cleanup the Documentation/
> directory.
> 
> Most of the files under Documentation/*.txt are already in ReST format.
> They just need to be moved to some place. So, most of the work here is
> to just move files for them to generate an output using the docs building
> system.
> 
> After this change, the  Documentation/ dir will contain:
> 
> - the main ReST file:
> 	- index.rst
> 
> - TUX and its copyright:
> 	- logo.gif and COPYING-logo
> 
> - Files required to do ReST builds:
> 	- .gitignore, Makefile,  conf.py,  docutils.conf,  Kconfig
> 
> - A pre-git file used to generate patches:
> 	- dontdiff
>   (I guess we should get rid of it, as I doubt this is useful those days).
> 
> -
> 
> Besides the above rightful files, the Documentation/ dir will also
> contain some left-overs:
> 
> - two somewhat new ReST files that should be moved to somewhere:
> 	- asm-annotations.rst and watch_queue.rst
> 
> - Two files that helps people looking for some well known documents
>   that are referenced at the web, pointing to their new location inside
>   the process/ dir:
> 	- SubmittingPatches and CodingStyle
> 
> - Three .txt files that weren't converted to ReST:
> 	- atomic_bitops.txt, memory-barriers.txt, atomic_t.txt
> 
> It should be noticed that I'm in doubt about the location of some files,
> and some stuff may well belong to a trash can. So, this series create
> a temporary place for orphaned documents in the form of a
> Documentation/staging directory.
> 
> This series is also on my development git tree, at:
> 
> 	https://git.linuxtv.org/mchehab/experimental.git/log/?h=rename-main-docs
> 
> The built output documentation on html format is at:
> 
> 	https://www.infradead.org/~mchehab/kernel_docs/
> 
> (it contains also other documents I converted to ReST)
> 
> 
> Mauro Carvalho Chehab (14):
>   docs: move DMA kAPI to Documentation/core-api
>   docs: add bus-virt-phys-mapping.txt to core-api
>   docs: fix references for DMA*.txt files
>   docs: move IPMI.txt to the driver API book
>   docs: fix references for ipmi.rst file
>   docs: debugging-via-ohci1394.txt: add it to the core-api book
>   docs: add IRQ documentation at the core-api book
>   docs: move kobject and kref docs into the core-api book
>   docs: move digsig docs to the security book
>   docs: move locking-specific documenta to locking/ directory
>   docs: move other kAPI documents to core-api
>   docs: move remaining stuff under Documentation/*.txt to
>     Documentation/staging
>   docs: staging: don't use literalinclude
>   docs: staging: use small font for literal includes
> 
>  Documentation/PCI/pci.rst                     |  6 +-
>  Documentation/admin-guide/hw-vuln/l1tf.rst    |  2 +-
>  .../admin-guide/kernel-parameters.txt         |  2 +-
>  .../admin-guide/kernel-per-CPU-kthreads.rst   |  2 +-
>  Documentation/admin-guide/sysctl/vm.rst       |  2 +-
>  Documentation/block/biodoc.rst                |  2 +-
>  .../bus-virt-phys-mapping.rst}                |  2 +-
>  .../debugging-via-ohci1394.rst}               |  0
>  .../dma-api-howto.rst}                        |  0
>  .../{DMA-API.txt => core-api/dma-api.rst}     |  6 +-
>  .../dma-attributes.rst}                       |  0
>  .../dma-isa-lpc.rst}                          |  2 +-
>  Documentation/core-api/index.rst              | 14 +++++
>  .../{IRQ.txt => core-api/irq/concepts.rst}    |  0
>  Documentation/core-api/irq/index.rst          | 11 ++++
>  .../irq/irq-affinity.rst}                     |  0
>  .../irq/irq-domain.rst}                       |  3 +-
>  .../irq/irqflags-tracing.rst}                 |  0
>  Documentation/core-api/kobject.rst            |  2 +-
>  Documentation/{kref.txt => core-api/kref.rst} |  0
>  .../{mailbox.txt => core-api/mailbox.rst}     |  0
>  .../nommu-mmap.rst}                           |  0
>  .../this_cpu_ops.rst}                         |  0
>  .../unaligned-memory-access.rst}              |  0
>  Documentation/driver-api/index.rst            |  1 +
>  .../{IPMI.txt => driver-api/ipmi.rst}         |  0
>  Documentation/driver-api/usb/dma.rst          |  6 +-
>  Documentation/gpu/drm-mm.rst                  |  2 +-
>  Documentation/ia64/irq-redir.rst              |  2 +-
>  Documentation/index.rst                       | 13 ++++
>  .../futex-requeue-pi.rst}                     |  0
>  .../hwspinlock.rst}                           |  0
>  Documentation/locking/index.rst               |  7 +++
>  .../percpu-rw-semaphore.rst}                  |  0
>  .../{pi-futex.txt => locking/pi-futex.rst}    |  0
>  .../preempt-locking.rst}                      |  0
>  .../robust-futex-ABI.rst}                     |  0
>  .../robust-futexes.rst}                       |  0
>  Documentation/locking/rt-mutex.rst            |  2 +-
>  Documentation/memory-barriers.txt             |  6 +-
>  Documentation/networking/scaling.rst          |  4 +-
>  .../{digsig.txt => security/digsig.rst}       |  0
>  Documentation/security/index.rst              |  1 +
>  .../{crc32.txt => staging/crc32.rst}          |  0
>  Documentation/staging/index.rst               | 59 +++++++++++++++++++
>  .../{kprobes.txt => staging/kprobes.rst}      |  0
>  Documentation/{lzo.txt => staging/lzo.rst}    |  0
>  .../remoteproc.rst}                           |  2 +-
>  .../{rpmsg.txt => staging/rpmsg.rst}          |  0
>  .../speculation.rst}                          |  8 ++-
>  .../static-keys.rst}                          |  0
>  Documentation/{tee.txt => staging/tee.rst}    |  1 +
>  Documentation/{xz.txt => staging/xz.rst}      |  0
>  Documentation/trace/kprobetrace.rst           |  2 +-
>  .../translations/ko_KR/memory-barriers.txt    |  6 +-
>  Documentation/translations/zh_CN/IRQ.txt      |  4 +-
>  MAINTAINERS                                   | 20 +++----
>  arch/Kconfig                                  |  2 +-
>  arch/ia64/hp/common/sba_iommu.c               | 12 ++--
>  arch/parisc/kernel/pci-dma.c                  |  2 +-
>  arch/x86/include/asm/dma-mapping.h            |  4 +-
>  arch/x86/kernel/amd_gart_64.c                 |  2 +-
>  drivers/char/ipmi/Kconfig                     |  2 +-
>  drivers/char/ipmi/ipmi_si_hotmod.c            |  2 +-
>  drivers/char/ipmi/ipmi_si_intf.c              |  2 +-
>  drivers/parisc/sba_iommu.c                    | 14 ++---
>  include/asm-generic/bitops/atomic.h           |  2 +-
>  include/linux/dma-mapping.h                   |  2 +-
>  include/linux/jump_label.h                    |  2 +-
>  include/media/videobuf-dma-sg.h               |  2 +-
>  init/Kconfig                                  |  2 +-
>  kernel/dma/debug.c                            |  2 +-
>  lib/Kconfig.debug                             |  2 +-
>  lib/crc32.c                                   |  2 +-
>  lib/lzo/lzo1x_decompress_safe.c               |  2 +-
>  lib/xz/Kconfig                                |  2 +-
>  mm/Kconfig                                    |  2 +-
>  mm/nommu.c                                    |  2 +-
>  samples/kprobes/kprobe_example.c              |  2 +-
>  samples/kprobes/kretprobe_example.c           |  2 +-
>  80 files changed, 191 insertions(+), 81 deletions(-)
>  rename Documentation/{bus-virt-phys-mapping.txt => core-api/bus-virt-phys-mapping.rst} (99%)
>  rename Documentation/{debugging-via-ohci1394.txt => core-api/debugging-via-ohci1394.rst} (100%)
>  rename Documentation/{DMA-API-HOWTO.txt => core-api/dma-api-howto.rst} (100%)
>  rename Documentation/{DMA-API.txt => core-api/dma-api.rst} (99%)
>  rename Documentation/{DMA-attributes.txt => core-api/dma-attributes.rst} (100%)
>  rename Documentation/{DMA-ISA-LPC.txt => core-api/dma-isa-lpc.rst} (98%)
>  rename Documentation/{IRQ.txt => core-api/irq/concepts.rst} (100%)
>  create mode 100644 Documentation/core-api/irq/index.rst
>  rename Documentation/{IRQ-affinity.txt => core-api/irq/irq-affinity.rst} (100%)
>  rename Documentation/{IRQ-domain.txt => core-api/irq/irq-domain.rst} (99%)
>  rename Documentation/{irqflags-tracing.txt => core-api/irq/irqflags-tracing.rst} (100%)
>  rename Documentation/{kref.txt => core-api/kref.rst} (100%)
>  rename Documentation/{mailbox.txt => core-api/mailbox.rst} (100%)
>  rename Documentation/{nommu-mmap.txt => core-api/nommu-mmap.rst} (100%)
>  rename Documentation/{this_cpu_ops.txt => core-api/this_cpu_ops.rst} (100%)
>  rename Documentation/{unaligned-memory-access.txt => core-api/unaligned-memory-access.rst} (100%)
>  rename Documentation/{IPMI.txt => driver-api/ipmi.rst} (100%)
>  rename Documentation/{futex-requeue-pi.txt => locking/futex-requeue-pi.rst} (100%)
>  rename Documentation/{hwspinlock.txt => locking/hwspinlock.rst} (100%)
>  rename Documentation/{percpu-rw-semaphore.txt => locking/percpu-rw-semaphore.rst} (100%)
>  rename Documentation/{pi-futex.txt => locking/pi-futex.rst} (100%)
>  rename Documentation/{preempt-locking.txt => locking/preempt-locking.rst} (100%)
>  rename Documentation/{robust-futex-ABI.txt => locking/robust-futex-ABI.rst} (100%)
>  rename Documentation/{robust-futexes.txt => locking/robust-futexes.rst} (100%)
>  rename Documentation/{digsig.txt => security/digsig.rst} (100%)
>  rename Documentation/{crc32.txt => staging/crc32.rst} (100%)
>  create mode 100644 Documentation/staging/index.rst
>  rename Documentation/{kprobes.txt => staging/kprobes.rst} (100%)
>  rename Documentation/{lzo.txt => staging/lzo.rst} (100%)
>  rename Documentation/{remoteproc.txt => staging/remoteproc.rst} (99%)
>  rename Documentation/{rpmsg.txt => staging/rpmsg.rst} (100%)
>  rename Documentation/{speculation.txt => staging/speculation.rst} (97%)
>  rename Documentation/{static-keys.txt => staging/static-keys.rst} (100%)
>  rename Documentation/{tee.txt => staging/tee.rst} (99%)
>  rename Documentation/{xz.txt => staging/xz.rst} (100%)
>

diff stat above shows you are not moving Documentation/atomic_bitops.txt in
this series. However, PATCH 12/14 contains the following hunks:

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1aa6e89e7424..8aa8f7c0db93 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
[...]
> @@ -9855,7 +9855,7 @@ L:	linux-kernel@vger.kernel.org
>  L:	linux-arch@vger.kernel.org
>  S:	Supported
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
> -F:	Documentation/atomic_bitops.txt
> +F:	Documentation/staging/atomic_bitops.txt
>  F:	Documentation/atomic_t.txt
>  F:	Documentation/core-api/atomic_ops.rst
>  F:	Documentation/core-api/refcount-vs-atomic.rst

[...]

> diff --git a/include/asm-generic/bitops/atomic.h b/include/asm-generic/bitops/atomic.h
> index dd90c9792909..edeeb8375006 100644
> --- a/include/asm-generic/bitops/atomic.h
> +++ b/include/asm-generic/bitops/atomic.h
> @@ -8,7 +8,7 @@
>  
>  /*
>   * Implementation of atomic bitops using atomic-fetch ops.
> - * See Documentation/atomic_bitops.txt for details.
> + * See Documentation/staging/atomic_bitops.txt for details.
>   */
>  
>  static inline void set_bit(unsigned int nr, volatile unsigned long *p)

Please drop them.

        Thanks, Akira
