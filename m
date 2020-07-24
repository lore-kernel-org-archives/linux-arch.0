From: Marco Elver <elver@google.com>
Subject: [PATCH v2 0/8] kcsan: Compound read-write instrumentation
Date: Fri, 24 Jul 2020 09:00:00 +0200
Message-ID: <20200724070008.1389205-1-elver@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGXHAX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jul 2020 03:00:23 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92485C0619E4
        for <linux-arch@vger.kernel.org>; Fri, 24 Jul 2020 00:00:23 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id t12so1890794wrp.0
        for <linux-arch@vger.kernel.org>; Fri, 24 Jul 2020 00:00:23 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: elver@google.com, paulmck@kernel.org
Cc: will@kernel.org, peterz@infradead.org, arnd@arndb.de, mark.rutland@arm.com, dvyukov@google.com, glider@google.com, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

This series adds support for enabling compounded read-write
instrumentation, if supported by the compiler (Clang 12 will be the
first compiler to support the feature). The new instrumentation is
emitted for sets of memory accesses in the same basic block to the same
address with at least one read appearing before a write. These typically
result from compound operations such as ++, --, +=, -=, |=, &=, etc. but
also equivalent forms such as "var = var + 1".

We can then benefit from improved performance (fewer instrumentation
calls) and better reporting for such accesses. In addition, existing
explicit instrumentation via instrumented.h was updated to use explicit
read-write instrumentation where appropriate, so we can also benefit
from the better report generation.

v2:
* Fix CC_HAS_TSAN_COMPOUND_READ_BEFORE_WRITE: s/--param -tsan/--param tsan/
* Add some {} for readability.
* Rewrite commit message of 'kcsan: Skew delay to be longer for certain
  access types'.
* Update comment for gen-atomic-instrumented.sh.

Marco Elver (8):
  kcsan: Support compounded read-write instrumentation
  objtool, kcsan: Add __tsan_read_write to uaccess whitelist
  kcsan: Skew delay to be longer for certain access types
  kcsan: Add missing CONFIG_KCSAN_IGNORE_ATOMICS checks
  kcsan: Test support for compound instrumentation
  instrumented.h: Introduce read-write instrumentation hooks
  asm-generic/bitops: Use instrument_read_write() where appropriate
  locking/atomics: Use read-write instrumentation for atomic RMWs

 include/asm-generic/atomic-instrumented.h     | 330 +++++++++---------
 .../asm-generic/bitops/instrumented-atomic.h  |   6 +-
 .../asm-generic/bitops/instrumented-lock.h    |   2 +-
 .../bitops/instrumented-non-atomic.h          |   6 +-
 include/linux/instrumented.h                  |  30 ++
 include/linux/kcsan-checks.h                  |  45 ++-
 kernel/kcsan/core.c                           |  51 ++-
 kernel/kcsan/kcsan-test.c                     |  65 +++-
 kernel/kcsan/report.c                         |   4 +
 lib/Kconfig.kcsan                             |   5 +
 scripts/Makefile.kcsan                        |   2 +-
 scripts/atomic/gen-atomic-instrumented.sh     |  21 +-
 tools/objtool/check.c                         |   5 +
 13 files changed, 354 insertions(+), 218 deletions(-)

-- 
2.28.0.rc0.142.g3c755180ce-goog
