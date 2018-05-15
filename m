From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v3 0/8] Introduce the for_each_set_clump macro
Date: Tue, 15 May 2018 11:49:34 -0400
Message-ID: <cover.1526397764.git.vilhelm.gray@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linus.walleij@linaro.org
Cc: linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, William Breathitt Gray <vilhelm.gray@gmail.com>
List-Id: linux-arch.vger.kernel.org

Changes in v3:
  - Replace "port word" nomenclature with "clump"
  - Add test cases for for_each_set_clump in lib/test_bitmap.c
  - Move kernel-doc comment for find_next_clump above C definition

While adding GPIO get_multiple/set_multiple callback support for various
drivers, I noticed a pattern of looping manifesting that would be useful
standardized as a macro.

This patchset introduces the for_each_set_clump macro and utilizes it in
several GPIO drivers. The for_each_set_clump macro facilitates a
for-loop syntax that iterates over entire groups of set bits at a time.

For example, suppose you would like to iterate over a 16-bit integer 4
bits at a time, skipping over 4-bit groups with no set bit, where XXXX
represents the current 4-bit group:

    Example:        1011 1110 0000 1111
    First loop:     1011 1110 0000 XXXX
    Second loop:    1011 XXXX 0000 1111
    Third loop:     XXXX 1110 0000 1111

Each iteration of the loop returns the next 4-bit group that has at
least one set bit.

The for_each_set_clump macro has six parameters:

    * clump: set to current clump index for the iteration
    * index: set to current bitmap word index for the iteration
    * offset: bits offset of the found clump in the bitmap word
    * bits: bitmap to search within
    * size: bitmap size in number of clumps
    * clump_size: clump size in number of bits

The clump_size argument can be an arbitrary number of bits and is not
required to be a multiple of 2.

This patchset was rebased on top of the following three commits:

    * commit aaf96e51de11 ("gpio: pci-idio-16: Fix port memory offset for get_multiple callback")
    * commit 304440aa96c6 ("gpio: pcie-idio-24: Fix port memory offset for get_multiple/set_multiple callbacks")
    * commit e026646c178d ("gpio: pcie-idio-24: Fix off-by-one error in get_multiple loop")

When I implemented the test_for_each_set_clump function, I used
bitmap_set to set the expected bitmap for the test. This method of
setting bits only segments at a time was rather tedious and error-prone;
is there a better way to accomplish what I did (set a bitmap after a
DECLARE_BITMAP)?

William Breathitt Gray

William Breathitt Gray (8):
  bitops: Introduce the for_each_set_clump macro
  lib/test_bitmap.c: Add for_each_set_clump test cases
  gpio: 104-dio-48e: Utilize for_each_set_clump macro
  gpio: 104-idi-48: Utilize for_each_set_clump macro
  gpio: gpio-mm: Utilize for_each_set_clump macro
  gpio: ws16c48: Utilize for_each_set_clump macro
  gpio: pci-idio-16: Utilize for_each_set_clump macro
  gpio: pcie-idio-24: Utilize for_each_set_clump macro

 drivers/gpio/gpio-104-dio-48e.c   |  67 +++++---------------
 drivers/gpio/gpio-104-idi-48.c    |  32 ++--------
 drivers/gpio/gpio-gpio-mm.c       |  67 +++++---------------
 drivers/gpio/gpio-pci-idio-16.c   |  67 ++++++--------------
 drivers/gpio/gpio-pcie-idio-24.c  | 102 +++++++++++-------------------
 drivers/gpio/gpio-ws16c48.c       |  66 +++++--------------
 include/asm-generic/bitops/find.h |   9 +++
 include/linux/bitops.h            |   7 ++
 lib/find_bit.c                    |  40 ++++++++++++
 lib/test_bitmap.c                 |  71 +++++++++++++++++++++
 10 files changed, 236 insertions(+), 292 deletions(-)

-- 
2.17.0
