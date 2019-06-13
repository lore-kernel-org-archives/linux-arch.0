Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f202.google.com ([209.85.222.202]:35095 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732121AbfFMNAG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Jun 2019 09:00:06 -0400
Received: by mail-qk1-f202.google.com with SMTP id 5so854994qki.2
        for <linux-arch@vger.kernel.org>; Thu, 13 Jun 2019 06:00:06 -0700 (PDT)
Date: Thu, 13 Jun 2019 14:59:47 +0200
Message-ID: <20190613125950.197667-1-elver@google.com>
Mime-Version: 1.0
Subject: [PATCH v5 0/3] Bitops instrumentation for KASAN
From: Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: peterz@infradead.org, aryabinin@virtuozzo.com, dvyukov@google.com, glider@google.com, andreyknvl@google.com, mark.rutland@arm.com, hpa@zytor.com
Cc: corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, arnd@arndb.de, jpoimboe@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kasan-dev@googlegroups.com, Marco Elver <elver@google.com>
Message-ID: <20190613125947.rE2pPTbDOTE57bxiRDaAc6FycGZ2llZQPupIsybbHiE@z>

Previous version:
http://lkml.kernel.org/r/20190613123028.179447-1-elver@google.com

* Only changed lib/test_kasan in this version.

Marco Elver (3):
  lib/test_kasan: Add bitops tests
  x86: Use static_cpu_has in uaccess region to avoid instrumentation
  asm-generic, x86: Add bitops instrumentation for KASAN

 Documentation/core-api/kernel-api.rst     |   2 +-
 arch/x86/ia32/ia32_signal.c               |   2 +-
 arch/x86/include/asm/bitops.h             | 189 ++++------------
 arch/x86/kernel/signal.c                  |   2 +-
 include/asm-generic/bitops-instrumented.h | 263 ++++++++++++++++++++++
 lib/test_kasan.c                          |  81 ++++++-
 6 files changed, 382 insertions(+), 157 deletions(-)
 create mode 100644 include/asm-generic/bitops-instrumented.h

-- 
2.22.0.rc2.383.gf4fbbf30c2-goog
