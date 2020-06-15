Return-Path: <SRS0=nbOu=74=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729990AbgFOMu2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jun 2020 08:50:28 -0400
Date: Mon, 15 Jun 2020 18:20:05 +0530
From: Syed Nayyar Waris <syednwaris@gmail.com>
Subject: [PATCH v8 0/4] Introduce the for_each_set_clump macro
Message-ID: <cover.1592224128.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linus.walleij@linaro.org, akpm@linux-foundation.org
Cc: andriy.shevchenko@linux.intel.com, vilhelm.gray@gmail.com, michal.simek@xilinx.com, arnd@arndb.de, rrichter@marvell.com, bgolaszewski@baylibre.com, yamada.masahiro@socionext.com, rui.zhang@intel.com, daniel.lezcano@linaro.org, amit.kucheria@verdurent.com, linux-arch@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Message-ID: <20200615125005.S-h8rpbL2LR4ub735_33TU6fKYeXBWGaL0kRU2PxVoc@z>

Hello Linus,

Since this patchset primarily affects GPIO drivers, would you like
to pick it up through your GPIO tree?

This patchset introduces a new generic version of for_each_set_clump. 
The previous version of for_each_set_clump8 used a fixed size 8-bit
clump, but the new generic version can work with clump of any size but
less than or equal to BITS_PER_LONG. The patchset utilizes the new macro 
in several GPIO drivers.

The earlier 8-bit for_each_set_clump8 facilitated a
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

But with the new for_each_set_clump the clump size can be different from 8 bits.
Moreover, the clump can be split at word boundary in situations where word 
size is not multiple of clump size. Following are examples showing the working 
of new macro for clump sizes of 24 bits and 6 bits.

Example 1:
clump size: 24 bits, Number of clumps (or ports): 10
bitmap stores the bit information from where successive clumps are retrieved.

     /* bitmap memory region */
        0x00aa0000ff000000;  /* Most significant bits */
        0xaaaaaa0000ff0000;
        0x000000aa000000aa;
        0xbbbbabcdeffedcba;  /* Least significant bits */

Different iterations of for_each_set_clump:-
'offset' is the bit position and 'clump' is the 24 bit clump from the
above bitmap.
Iteration first:        offset: 0 clump: 0xfedcba
Iteration second:       offset: 24 clump: 0xabcdef
Iteration third:        offset: 48 clump: 0xaabbbb
Iteration fourth:       offset: 96 clump: 0xaa
Iteration fifth:        offset: 144 clump: 0xff
Iteration sixth:        offset: 168 clump: 0xaaaaaa
Iteration seventh:      offset: 216 clump: 0xff
Loop breaks because in the end the remaining bits (0x00aa) size was less
than clump size of 24 bits.

In above example it can be seen that in iteration third, the 24 bit clump
that was retrieved was split between bitmap[0] and bitmap[1]. This example 
also shows that 24 bit zeroes if present in between, were skipped (preserving
the previous for_each_set_macro8 behaviour). 

Example 2:
clump size = 6 bits, Number of clumps (or ports) = 3.

     /* bitmap memory region */
        0x00aa0000ff000000;  /* Most significant bits */
        0xaaaaaa0000ff0000;
        0x0f00000000000000;
        0x0000000000000ac0;  /* Least significant bits */

Different iterations of for_each_set_clump:
'offset' is the bit position and 'clump' is the 6 bit clump from the
above bitmap.
Iteration first:        offset: 6 clump: 0x2b
Loop breaks because 6 * 3 = 18 bits traversed in bitmap.
Here 6 * 3 is clump size * no. of clumps.

Changes in v8:
 - [Patch 2/4]: Minor change: Use '__initdata' for correct section mismatch
   in 'clump_test_data' array.

Changes in v7:
 - [Patch 2/4]: Minor changes: Use macro 'DECLARE_BITMAP()' and split 'struct'
   definition and test data.

Changes in v6:
 - [Patch 2/4]: Make 'for loop' inside test_for_each_set_clump more
   succinct.

Changes in v5:
 - [Patch 4/4]: Minor change: Hardcode value for better code readability.

Changes in v4:
 - [Patch 2/4]: Use 'for' loop in test function of for_each_set_clump.
 - [Patch 3/4]: Minor change: Inline value for better code readability.
 - [Patch 4/4]: Minor change: Inline value for better code readability.

Changes in v3:
 - [Patch 3/4]: Change datatype of some variables from u64 to unsigned long
   in function thunderx_gpio_set_multiple.

CHanges in v2:
 - [Patch 2/4]: Unify different tests for 'for_each_set_clump'. Pass test data as
   function parameters.
 - [Patch 2/4]: Remove unnecessary bitmap_zero calls.

Syed Nayyar Waris (4):
  bitops: Introduce the for_each_set_clump macro
  lib/test_bitmap.c: Add for_each_set_clump test cases
  gpio: thunderx: Utilize for_each_set_clump macro
  gpio: xilinx: Utilize for_each_set_clump macro

 drivers/gpio/gpio-thunderx.c      |  11 ++-
 drivers/gpio/gpio-xilinx.c        |  62 ++++++-------
 include/asm-generic/bitops/find.h |  19 ++++
 include/linux/bitmap.h            |  61 +++++++++++++
 include/linux/bitops.h            |  13 +++
 lib/find_bit.c                    |  14 +++
 lib/test_bitmap.c                 | 145 ++++++++++++++++++++++++++++++
 7 files changed, 291 insertions(+), 34 deletions(-)


base-commit: 444fc5cde64330661bf59944c43844e7d4c2ccd8
-- 
2.26.2
