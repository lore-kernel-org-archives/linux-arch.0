From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH v2 00/11] test_user_copy improvements
Date: Fri, 7 Aug 2015 16:21:53 +0100
Message-ID: <1438960924-23628-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:43727 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbbHGPWg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Aug 2015 11:22:36 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, James Hogan <james.hogan@imgtec.com>, Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, Michal Simek <monstr@monstr.eu>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole.se>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, nios2-dev@lists.rocketboards.org, linux@lists.openrisc.net, linux-xtensa@linux-xtensa.org

These patches extend the test_user_copy test module to handle lots more
cases of user accessors which architectures can override separately, and
in particular those which are important for checking the MIPS Enhanced
Virtual Addressing (EVA) implementations, which need to handle
overlapping user and kernel address spaces, with special instructions
for accessing user address space from kernel mode.

- Checking that kernel pointers are accepted when user address limit is
  set to KERNEL_DS, as done by the kernel when it internally invokes
  system calls with kernel pointers.
- Checking of the unchecked accessors (which don't call access_ok()).
  Some of the tests are special cased for EVA at the moment which has
  stricter hardware guarantees for bad user accesses than other
  configurations.
- Checking of other sets of user accessors, including the inatomic user
  copies, clear_user, compatibility accessors (copy_in_user and
  _unaligned), the user string accessors, and the user checksum
  functions, all of which need special handling in arch code with EVA.

Tested on MIPS with and without EVA, and on x86_64.

Only build tested for arm, blackfin, metag, microblaze, openrisc,
parisc, powerpc, sh, sparc, tile, i386 & xtensa.

All arches were audited for the appropriate exports, only score is known
to still be missing some.

Changes in v2:
- Add arch exports (patches 1-4).
- Reorder patches slightly.
- Patch 9: Drop strlen_user test. Microblaze doesn't define it, and
  nothing actually uses it. IMO it should be removed, and there's no
  point testing it in the mean time.
- Patch 10: Conditionalise on CONFIG_COMPAT, otherwise it breaks build
  on some 32-bit arches e.g. i386 (kbuild test robot).
- Patch 10: Add testing of _unaligned accessors, which are also
  conditional upon CONFIG_COMPAT.
- Patch 11: Only test csum_partial_copy_from_user #ifndef
  _HAVE_ARCH_COPY_AND_CSUM_FROM_USER, fixing powerpc64 build (Stephen
  Rothwell)

James Hogan (11):
  microblaze: Export __strnlen_user to modules
  nios2: Export strncpy_from_user / strnlen_user to modules
  openrisc: Export __clear_user to modules
  xtensa: Export __strnlen_user to modules
  test_user_copy: Check legit kernel accesses
  test_user_copy: Check unchecked accessors
  test_user_copy: Check __copy_{to,from}_user_inatomic()
  test_user_copy: Check __clear_user()/clear_user()
  test_user_copy: Check user string accessors
  test_user_copy: Check user compatibility accessors
  test_user_copy: Check user checksum functions

 arch/microblaze/kernel/microblaze_ksyms.c |   1 +
 arch/nios2/mm/uaccess.c                   |   2 +
 arch/openrisc/kernel/or32_ksyms.c         |   1 +
 arch/xtensa/kernel/xtensa_ksyms.c         |   1 +
 lib/test_user_copy.c                      | 251 ++++++++++++++++++++++++++++++
 5 files changed, 256 insertions(+)

Cc: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Ley Foon Tan <lftan@altera.com>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: nios2-dev@lists.rocketboards.org
Cc: linux@lists.openrisc.net
Cc: linux-xtensa@linux-xtensa.org
-- 
2.3.6
