From: Marco Elver <elver@google.com>
Subject: Re: [PATCH v5 0/3] Bitops instrumentation for KASAN
Date: Mon, 17 Jun 2019 16:00:38 +0200
Message-ID: <CANpmjNMCmcg8GS_pkKc2gsdtd7-A2t27mOXATY9OLb1vQW5Lsg@mail.gmail.com>
References: <20190613125950.197667-1-elver@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190613125950.197667-1-elver@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dmitry Vyukov <dvyukov@google.com>, Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@google.com>, Mark Rutland <mark.rutland@arm.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, the arch/x86 maintainers <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Josh Poimboeuf <jpoimboe@redhat.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>, Linux Memory Management List <linux-mm@kvack.org>
List-Id: linux-arch.vger.kernel.org

All 3 patches have now been Acked and Reviewed. Which tree should this land in?

Since this is related to KASAN, would this belong into the MM tree?

Many thanks,
-- Marco




On Thu, 13 Jun 2019 at 15:00, Marco Elver <elver@google.com> wrote:
>
> Previous version:
> http://lkml.kernel.org/r/20190613123028.179447-1-elver@google.com
>
> * Only changed lib/test_kasan in this version.
>
> Marco Elver (3):
>   lib/test_kasan: Add bitops tests
>   x86: Use static_cpu_has in uaccess region to avoid instrumentation
>   asm-generic, x86: Add bitops instrumentation for KASAN
>
>  Documentation/core-api/kernel-api.rst     |   2 +-
>  arch/x86/ia32/ia32_signal.c               |   2 +-
>  arch/x86/include/asm/bitops.h             | 189 ++++------------
>  arch/x86/kernel/signal.c                  |   2 +-
>  include/asm-generic/bitops-instrumented.h | 263 ++++++++++++++++++++++
>  lib/test_kasan.c                          |  81 ++++++-
>  6 files changed, 382 insertions(+), 157 deletions(-)
>  create mode 100644 include/asm-generic/bitops-instrumented.h
>
> --
> 2.22.0.rc2.383.gf4fbbf30c2-goog
>
