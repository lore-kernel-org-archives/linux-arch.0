From: Marco Elver <elver@google.com>
Subject: [PATCH v2 0/3] Bitops instrumentation for KASAN
Date: Wed, 29 May 2019 16:14:58 +0200
Message-ID: <20190529141500.193390-1-elver@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, aryabinin@virtuozzo.com, dvyukov@google.com, glider@google.com, andreyknvl@google.com, mark.rutland@arm.com
Cc: corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org, arnd@arndb.de, jpoimboe@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kasan-dev@googlegroups.com, Marco Elver <elver@google.com>
List-Id: linux-arch.vger.kernel.org

The previous version of this patch series and discussion can be found
here:  https://lkml.org/lkml/2019/5/28/769

The most significant change is the change of the instrumented access
size to cover the entire word of a bit.

Marco Elver (3):
  lib/test_kasan: Add bitops tests
  x86: Move CPU feature test out of uaccess region
  asm-generic, x86: Add bitops instrumentation for KASAN

 Documentation/core-api/kernel-api.rst     |   2 +-
 arch/x86/ia32/ia32_signal.c               |   9 +-
 arch/x86/include/asm/bitops.h             | 210 ++++----------
 include/asm-generic/bitops-instrumented.h | 317 ++++++++++++++++++++++
 lib/test_kasan.c                          |  75 ++++-
 5 files changed, 450 insertions(+), 163 deletions(-)
 create mode 100644 include/asm-generic/bitops-instrumented.h

-- 
2.22.0.rc1.257.g3120a18244-goog
