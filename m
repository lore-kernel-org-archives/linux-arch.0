From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 0/3] Ensure inX() is ordered wrt delay() routines
Date: Fri, 22 Feb 2019 18:04:51 +0000
Message-ID: <20190222180454.5992-1-will.deacon@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, andrew.murray@arm.com, arnd@arndb.de, catalin.marinas@arm.com, geert@linux-m68k.org, palmer@sifive.com, Will Deacon <will.deacon@arm.com>
List-Id: linux-arch.vger.kernel.org

Hi all,

This is version two of the patches I previously posted here:

  https://lore.kernel.org/lkml/20190211174544.4302-1-will.deacon@arm.com/T/#u

Changes since v2 include:

  * Incorporate riscv changes from Palmer
  * Update macro definitions as suggested by Geert
  * Extend to cover non-port reads via __io_ar() as well

Feedback welcome,

Will

--->8

Will Deacon (3):
  asm-generic/io: Pass result of I/O accessor to __io_[p]ar()
  riscv: io: Update __io_[p]ar() macros to take an argument
  arm64: io: Hook up __io_par() for inX() ordering

 arch/arm64/include/asm/io.h |  1 +
 arch/riscv/include/asm/io.h | 36 ++++++++++++++++++------------------
 include/asm-generic/io.h    | 20 ++++++++++----------
 3 files changed, 29 insertions(+), 28 deletions(-)

-- 
2.11.0
