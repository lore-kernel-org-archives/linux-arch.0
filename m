From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v7 0/8] Introduce the for_each_set_clump8 macro
Date: Sat, 12 Jan 2019 10:47:34 +0900
Message-ID: <cover.1547257386.git.vilhelm.gray@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linus.walleij@linaro.org
Cc: akpm@linux-foundation.org, linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk, William Breathitt Gray <vilhelm.gray@gmail.com>
List-Id: linux-arch.vger.kernel.org

Changes in v7:
  - Pass bitmap_set_value8 'value' parameter by value
  - Remove bitmap_set_value8 final mask operation; users beware: values
    greater than 8 bits may clobber bitmap

While adding GPIO get_multiple/set_multiple callback support for various
drivers, I noticed a pattern of looping manifesting that would be useful
standardized as a macro.

This patchset introduces the for_each_set_clump8 macro and utilizes it
in several GPIO drivers. The for_each_set_clump macro8 facilitates a
for-loop syntax that iterates over a memory region entire groups of set
bits at a time.

For example, suppose you would like to iterate over a 32-bit integer 8
bits at a time, skipping over 8-bit groups with no set bit, where
XXXXXXXX represents the current 8-bit group:

    Example:        10111110 00000000 11111111 00110011
    First loop:     10111110 00000000 11111111 XXXXXXXX
    Second loop:    10111110 00000000 XXXXXXXX 00110011
    Third loop:     XXXXXXXX 00000000 11111111 00110011

Each iteration of the loop returns the next 8-bit group that has at
least one set bit.

The for_each_set_clump8 macro has four parameters:

    * start: set to the bit offset of the current clump
    * clump: set to the current clump value
    * bits: bitmap to search within
    * size: bitmap size in number of bits

In this version of the patchset, the for_each_set_clump macro has been
reimplemented and simplified based on the suggestions provided by Rasmus
Villemoes and Andy Shevchenko in the version 4 submission.

In particular, the function of the for_each_set_clump macro has been
restricted to handle only 8-bit clumps; the drivers that use the
for_each_set_clump macro only handle 8-bit ports so a generic
for_each_set_clump implementation is not necessary. Thus, a solution for
odd-sized clumps (e.g. 3-bit, 7-bit, etc.) mismatching word boundaries
can be postponed until a driver appears that actually requires a generic
for_each_set_clump implementation.

In addition, the bitmap_get_value8 and bitmap_set_value8 functions are
introduced to get and set 8-bit values respectively. Their use is based
on the behavior suggested in the patchset version 4 review. Similarly,
the implementation of the find_next_clump function has been simplified
in order for the function to match the syntax and use of the
find_next_bit function.

William Breathitt Gray (8):
  bitops: Introduce the for_each_set_clump8 macro
  lib/test_bitmap.c: Add for_each_set_clump8 test cases
  gpio: 104-dio-48e: Utilize for_each_set_clump8 macro
  gpio: 104-idi-48: Utilize for_each_set_clump8 macro
  gpio: gpio-mm: Utilize for_each_set_clump8 macro
  gpio: ws16c48: Utilize for_each_set_clump8 macro
  gpio: pci-idio-16: Utilize for_each_set_clump8 macro
  gpio: pcie-idio-24: Utilize for_each_set_clump8 macro

 drivers/gpio/gpio-104-dio-48e.c   |  71 ++++++-------------
 drivers/gpio/gpio-104-idi-48.c    |  36 ++--------
 drivers/gpio/gpio-gpio-mm.c       |  71 ++++++-------------
 drivers/gpio/gpio-pci-idio-16.c   |  73 +++++++-------------
 drivers/gpio/gpio-pcie-idio-24.c  | 109 +++++++++++-------------------
 drivers/gpio/gpio-ws16c48.c       |  71 ++++++-------------
 include/asm-generic/bitops/find.h |  14 ++++
 include/linux/bitops.h            |   5 ++
 lib/find_bit.c                    |  63 +++++++++++++++++
 lib/test_bitmap.c                 |  65 ++++++++++++++++++
 10 files changed, 279 insertions(+), 299 deletions(-)

-- 
2.20.1
