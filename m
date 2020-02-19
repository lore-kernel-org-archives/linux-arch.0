From: Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 0/6] Silence some instances of -Wtautological-compare and enable globally
Date: Tue, 18 Feb 2020 21:54:17 -0700
Message-ID: <20200219045423.54190-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: Masahiro Yamada <masahiroy@kernel.org>, Michal Marek <michal.lkml@markovi.net>, Arnd Bergmann <arnd@arndb.de>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Jason Baron <jbaron@akamai.com>, Catalin Marinas <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, clang-built-linux@googlegroups.com, Nathan Chancellor <natechancellor@gmail.com>
List-Id: linux-arch.vger.kernel.org

Hi everyone,

This patch series aims to silence some instances of clang's
-Wtautological-compare that are not problematic and enable it globally
for the kernel because it has a bunch of subwarnings that can find real
bugs in the kernel such as
https://lore.kernel.org/lkml/20200116222658.5285-1-natechancellor@gmail.com/
and https://bugs.llvm.org/show_bug.cgi?id=42666, which was specifically
requested by Dmitry.

The first patch adds a macro that casts the section variables to
unsigned long (uintptr_t), which silences the warning and adds
documentation.

Patches two through four silence the warning in the places I have
noticed it across all of my builds with -Werror, including arm, arm64,
and x86_64 defconfig/allmodconfig/allyesconfig. There might still be
more lurking but those will have to be teased out over time.

Patch six finally enables the warning, while leaving one of the
subwarnings disabled because it is rather noisy and somewhat pointless
for the kernel, where core kernel code is expected to build and run with
many different configurations where variable types can be different
sizes.

A slight meta comment: This is the first treewide patchset that I have
sent. I pray I did everything right but please let me know if I did not.
I assume someone like Andrew will pick this up with acks from everyone
but let me know if there is someone better.

Cheers,
Nathan

Nathan Chancellor (6):
  asm/sections: Add COMPARE_SECTIONS macro
  kernel/extable: Wrap section comparison in sort_main_extable with
    COMPARE_SECTIONS
  tracing: Wrap section comparison in tracer_alloc_buffers with
    COMPARE_SECTIONS
  dynamic_debug: Wrap section comparison in dynamic_debug_init with
    COMPARE_SECTIONS
  mm: kmemleak: Wrap section comparison in kmemleak_init with
    COMPARE_SECTIONS
  kbuild: Enable -Wtautological-compare

 Makefile                       | 3 +--
 include/asm-generic/sections.h | 7 +++++++
 kernel/extable.c               | 3 ++-
 kernel/trace/trace.c           | 2 +-
 lib/dynamic_debug.c            | 2 +-
 mm/kmemleak.c                  | 3 ++-
 6 files changed, 14 insertions(+), 6 deletions(-)


base-commit: 02815e777db630e3c183718cab73752b48a5053e
-- 
2.25.1
