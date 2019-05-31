Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f201.google.com ([209.85.222.201]:36067 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfEaPLg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 May 2019 11:11:36 -0400
Received: by mail-qk1-f201.google.com with SMTP id a12so8177372qkb.3
        for <linux-arch@vger.kernel.org>; Fri, 31 May 2019 08:11:36 -0700 (PDT)
Date: Fri, 31 May 2019 17:08:28 +0200
Message-ID: <20190531150828.157832-1-elver@google.com>
Mime-Version: 1.0
Subject: [PATCH v3 0/3] Bitops instrumentation for KASAN
From: Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: peterz@infradead.org, aryabinin@virtuozzo.com, dvyukov@google.com, glider@google.com, andreyknvl@google.com, mark.rutland@arm.com, hpa@zytor.com
Cc: corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, arnd@arndb.de, jpoimboe@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kasan-dev@googlegroups.com, Marco Elver <elver@google.com>
Message-ID: <20190531150828.ou6FPrPYMeZ79BFVDwn1Kd4W815MmAwoSBkUQp_25pE@z>

Previous version of this patch series and discussion can be found here:
http://lkml.kernel.org/r/20190529141500.193390-1-elver@google.com

Marco Elver (3):
  lib/test_kasan: Add bitops tests
  x86: Use static_cpu_has in uaccess region to avoid instrumentation
  asm-generic, x86: Add bitops instrumentation for KASAN

 Documentation/core-api/kernel-api.rst     |   2 +-
 arch/x86/ia32/ia32_signal.c               |   2 +-
 arch/x86/include/asm/bitops.h             | 189 ++++------------
 arch/x86/kernel/signal.c                  |   2 +-
 include/asm-generic/bitops-instrumented.h | 263 ++++++++++++++++++++++
 lib/test_kasan.c                          |  75 +++++-
 6 files changed, 376 insertions(+), 157 deletions(-)
 create mode 100644 include/asm-generic/bitops-instrumented.h

-- 
2.22.0.rc1.257.g3120a18244-goog
