From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v9 0/3] arm64 tagged address ABI
Date: Wed, 21 Aug 2019 17:47:27 +0100
Message-ID: <20190821164730.47450-1-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, Szabolcs Nagy <szabolcs.nagy@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Dave Hansen <dave.hansen@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>, Dave P Martin <Dave.Martin@arm.com>
List-Id: linux-arch.vger.kernel.org

Hi,

This series is an update to the arm64 tagged address ABI documentation
patches v8, posted here:

http://lkml.kernel.org/r/20190815154403.16473-1-catalin.marinas@arm.com

From v8, I dropped patches 2 and 3 as they've been queued by Will via
the arm64 tree. Reposting patch 1 (unmodified) as it should be merged
via the mm tree.

Changes in v9:

- Replaced the emphasized/bold font with a typewriter one for
  function/constant names

- Simplified the mmap/brk bullet points when describing the tagged
  pointer origin

- Reworded expected syscall behaviour with valid tagged pointers

- Reworded the prctl/ioctl restrictions to clarify the allowed tagged
  pointers w.r.t. user data access by the kernel


Catalin Marinas (1):
  mm: untag user pointers in mmap/munmap/mremap/brk

Vincenzo Frascino (2):
  arm64: Define Documentation/arm64/tagged-address-abi.rst
  arm64: Relax Documentation/arm64/tagged-pointers.rst

 Documentation/arm64/tagged-address-abi.rst | 156 +++++++++++++++++++++
 Documentation/arm64/tagged-pointers.rst    |  23 ++-
 mm/mmap.c                                  |   5 +
 mm/mremap.c                                |   6 +-
 4 files changed, 178 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/arm64/tagged-address-abi.rst
