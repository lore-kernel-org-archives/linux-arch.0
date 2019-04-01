From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH 0/4] arm64: compat: Add kuser helpers config option
Date: Mon,  1 Apr 2019 12:20:21 +0100
Message-ID: <20190401112025.40807-1-vincenzo.frascino@arm.com>
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
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
List-Id: linux-arch.vger.kernel.org

Currently on arm64 compat kuser helper are enabled by default.

To be on pair with arm32, this patchset makes it possible to disable
the kuser helpers by adding a CONFIG_KUSER_HELPERS option which is
enabled by default to avoid compatibility issues.

When the config option is disabled:
 - The kuser helpers-related code is not compiled with the kernel.
 - The kuser helpers mapping, for any compat process, at 0xffff0000
   is not done.
 - Any attempt to use a kuser helper from a compat process will result
   in a segfault.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Vincenzo Frascino (4):
  arm64: compat: Alloc separate pages for vectors and sigpage
  arm64: compat: Split kuser32
  arm64: compat: Refactor aarch32_alloc_vdso_pages()
  arm64: compat: Add KUSER_HELPERS config option

 arch/arm64/Kconfig                 |  30 ++++++
 arch/arm64/include/asm/elf.h       |   6 +-
 arch/arm64/include/asm/processor.h |   4 +-
 arch/arm64/include/asm/signal32.h  |   2 -
 arch/arm64/kernel/Makefile         |   5 +-
 arch/arm64/kernel/kuser32.S        |  65 +------------
 arch/arm64/kernel/signal32.c       |   5 +-
 arch/arm64/kernel/sigreturn32.S    |  46 +++++++++
 arch/arm64/kernel/vdso.c           | 150 +++++++++++++++++++++++------
 9 files changed, 211 insertions(+), 102 deletions(-)
 create mode 100644 arch/arm64/kernel/sigreturn32.S

-- 
2.21.0
