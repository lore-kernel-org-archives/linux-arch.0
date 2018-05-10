From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH -resend 00/27] New macros for assembler symbols
Date: Thu, 10 May 2018 10:06:17 +0200
Message-ID: <20180510080644.19752-1-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-arch.vger.kernel.org

This series introduces new macros for assembly as was discussed [1].
The macros are introduced in the first patch of the series. The rest
of patches start using these new macros in x86, converting *all* uses
of the old macros to the new ones throughout the last patch. With
every last user of some old macro, the macro is immediatelly made
forbidden for x86.

When this settles down, conversion of other architectures can be done
too.

For introduction, documentation, use and examples, please see
Documentation/asm-annotations.rst from the first patch of the series.

[1] https://lkml.org/lkml/2017/3/1/742

Jiri Slaby (27):
  linkage: new macros for assembler symbols
  x86: assembly, use SYM_DATA for data
  x86: assembly, annotate relocate_kernel
  x86: entry, annotate THUNKs
  x86: assembly, annotate local pseudo-functions
  x86: crypto, annotate local functions
  x86: boot, annotate local functions
  x86: assembly, annotate aliases
  x86: entry, annotate interrupt symbols properly
  x86: head, annotate data appropriatelly
  x86: boot, annotate data appropriatelly
  x86: um, annotate data appropriatelly
  x86: xen-pvh, annotate data appropriatelly
  x86: purgatory, start using annotations
  x86: assembly, do not annotate functions by GLOBAL
  x86: assembly, use SYM_CODE_INNER_LABEL instead of GLOBAL
  x86: realmode, use SYM_DATA_* instead of GLOBAL
  x86: assembly, remove GLOBAL macro
  x86: assembly, make some functions local
  x86: ftrace, mark function_hook as function
  x86_64: assembly, add ENDs to some functions and relabel with
    SYM_CODE_*
  x86_64: assembly, change all ENTRY+END to SYM_CODE_*
  x86_64: assembly, change all ENTRY+ENDPROC to SYM_FUNC_*
  x86_32: assembly, add ENDs to some functions and relabel with
    SYM_CODE_*
  x86_32: assembly, change all ENTRY+END to SYM_CODE_*
  x86_32: assembly, change all ENTRY+ENDPROC to SYM_FUNC_*
  x86: assembly, replace WEAK uses

 Documentation/asm-annotations.rst                  | 218 +++++++++++++++++
 arch/x86/boot/compressed/efi_stub_32.S             |   4 +-
 arch/x86/boot/compressed/efi_thunk_64.S            |  33 +--
 arch/x86/boot/compressed/head_32.S                 |  15 +-
 arch/x86/boot/compressed/head_64.S                 |  60 ++---
 arch/x86/boot/compressed/mem_encrypt.S             |  14 +-
 arch/x86/boot/copy.S                               |  16 +-
 arch/x86/boot/pmjump.S                             |   8 +-
 arch/x86/crypto/aes-i586-asm_32.S                  |   8 +-
 arch/x86/crypto/aes-x86_64-asm_64.S                |   4 +-
 arch/x86/crypto/aes_ctrby8_avx-x86_64.S            |  12 +-
 arch/x86/crypto/aesni-intel_asm.S                  | 114 ++++-----
 arch/x86/crypto/aesni-intel_avx-x86_64.S           |  24 +-
 arch/x86/crypto/blowfish-x86_64-asm_64.S           |  16 +-
 arch/x86/crypto/camellia-aesni-avx-asm_64.S        |  44 ++--
 arch/x86/crypto/camellia-aesni-avx2-asm_64.S       |  44 ++--
 arch/x86/crypto/camellia-x86_64-asm_64.S           |  16 +-
 arch/x86/crypto/cast5-avx-x86_64-asm_64.S          |  24 +-
 arch/x86/crypto/cast6-avx-x86_64-asm_64.S          |  32 +--
 arch/x86/crypto/chacha20-avx2-x86_64.S             |   4 +-
 arch/x86/crypto/chacha20-ssse3-x86_64.S            |   8 +-
 arch/x86/crypto/crc32-pclmul_asm.S                 |   4 +-
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S          |   4 +-
 arch/x86/crypto/crct10dif-pcl-asm_64.S             |   4 +-
 arch/x86/crypto/des3_ede-asm_64.S                  |   8 +-
 arch/x86/crypto/ghash-clmulni-intel_asm.S          |  12 +-
 arch/x86/crypto/poly1305-avx2-x86_64.S             |   4 +-
 arch/x86/crypto/poly1305-sse2-x86_64.S             |   8 +-
 arch/x86/crypto/salsa20-i586-asm_32.S              |   4 +-
 arch/x86/crypto/salsa20-x86_64-asm_64.S            |   4 +-
 arch/x86/crypto/serpent-avx-x86_64-asm_64.S        |  32 +--
 arch/x86/crypto/serpent-avx2-asm_64.S              |  32 +--
 arch/x86/crypto/serpent-sse2-i586-asm_32.S         |   8 +-
 arch/x86/crypto/serpent-sse2-x86_64-asm_64.S       |   8 +-
 arch/x86/crypto/sha1-mb/sha1_mb_mgr_flush_avx2.S   |   8 +-
 arch/x86/crypto/sha1-mb/sha1_mb_mgr_submit_avx2.S  |   4 +-
 arch/x86/crypto/sha1-mb/sha1_x8_avx2.S             |   4 +-
 arch/x86/crypto/sha1_avx2_x86_64_asm.S             |   4 +-
 arch/x86/crypto/sha1_ni_asm.S                      |   4 +-
 arch/x86/crypto/sha1_ssse3_asm.S                   |   4 +-
 arch/x86/crypto/sha256-avx-asm.S                   |   4 +-
 arch/x86/crypto/sha256-avx2-asm.S                  |   4 +-
 .../crypto/sha256-mb/sha256_mb_mgr_flush_avx2.S    |   8 +-
 .../crypto/sha256-mb/sha256_mb_mgr_submit_avx2.S   |   4 +-
 arch/x86/crypto/sha256-mb/sha256_x8_avx2.S         |   4 +-
 arch/x86/crypto/sha256-ssse3-asm.S                 |   4 +-
 arch/x86/crypto/sha256_ni_asm.S                    |   4 +-
 arch/x86/crypto/sha512-avx-asm.S                   |   4 +-
 arch/x86/crypto/sha512-avx2-asm.S                  |   4 +-
 .../crypto/sha512-mb/sha512_mb_mgr_flush_avx2.S    |   8 +-
 .../crypto/sha512-mb/sha512_mb_mgr_submit_avx2.S   |   4 +-
 arch/x86/crypto/sha512-mb/sha512_x4_avx2.S         |   4 +-
 arch/x86/crypto/sha512-ssse3-asm.S                 |   4 +-
 arch/x86/crypto/twofish-avx-x86_64-asm_64.S        |  32 +--
 arch/x86/crypto/twofish-i586-asm_32.S              |   8 +-
 arch/x86/crypto/twofish-x86_64-asm_64-3way.S       |   8 +-
 arch/x86/crypto/twofish-x86_64-asm_64.S            |   8 +-
 arch/x86/entry/entry_32.S                          | 155 ++++++------
 arch/x86/entry/entry_64.S                          | 107 ++++-----
 arch/x86/entry/entry_64_compat.S                   |  16 +-
 arch/x86/entry/thunk_32.S                          |   4 +-
 arch/x86/entry/thunk_64.S                          |   8 +-
 arch/x86/entry/vdso/vdso32/system_call.S           |   2 +-
 arch/x86/include/asm/linkage.h                     |   4 -
 arch/x86/kernel/acpi/wakeup_32.S                   |  11 +-
 arch/x86/kernel/acpi/wakeup_64.S                   |  25 +-
 arch/x86/kernel/ftrace_32.S                        |  23 +-
 arch/x86/kernel/ftrace_64.S                        |  42 ++--
 arch/x86/kernel/head_32.S                          |  60 ++---
 arch/x86/kernel/head_64.S                          | 106 +++++----
 arch/x86/kernel/relocate_kernel_32.S               |  13 +-
 arch/x86/kernel/relocate_kernel_64.S               |  13 +-
 arch/x86/kernel/verify_cpu.S                       |   4 +-
 arch/x86/lib/atomic64_386_32.S                     |   4 +-
 arch/x86/lib/atomic64_cx8_32.S                     |  32 +--
 arch/x86/lib/checksum_32.S                         |  16 +-
 arch/x86/lib/clear_page_64.S                       |  12 +-
 arch/x86/lib/cmpxchg16b_emu.S                      |   4 +-
 arch/x86/lib/cmpxchg8b_emu.S                       |   4 +-
 arch/x86/lib/copy_page_64.S                        |   8 +-
 arch/x86/lib/copy_user_64.S                        |  16 +-
 arch/x86/lib/csum-copy_64.S                        |   4 +-
 arch/x86/lib/getuser.S                             |  24 +-
 arch/x86/lib/hweight.S                             |   8 +-
 arch/x86/lib/iomap_copy_64.S                       |   4 +-
 arch/x86/lib/memcpy_64.S                           |  20 +-
 arch/x86/lib/memmove_64.S                          |   8 +-
 arch/x86/lib/memset_64.S                           |  16 +-
 arch/x86/lib/msr-reg.S                             |   8 +-
 arch/x86/lib/putuser.S                             |  20 +-
 arch/x86/lib/retpoline.S                           |   4 +-
 arch/x86/lib/rwsem.S                               |  24 +-
 arch/x86/math-emu/div_Xsig.S                       |   4 +-
 arch/x86/math-emu/div_small.S                      |   4 +-
 arch/x86/math-emu/mul_Xsig.S                       |  12 +-
 arch/x86/math-emu/polynom_Xsig.S                   |   4 +-
 arch/x86/math-emu/reg_norm.S                       |   8 +-
 arch/x86/math-emu/reg_round.S                      |   4 +-
 arch/x86/math-emu/reg_u_add.S                      |   4 +-
 arch/x86/math-emu/reg_u_div.S                      |   4 +-
 arch/x86/math-emu/reg_u_mul.S                      |   4 +-
 arch/x86/math-emu/reg_u_sub.S                      |   4 +-
 arch/x86/math-emu/round_Xsig.S                     |   8 +-
 arch/x86/math-emu/shr_Xsig.S                       |   4 +-
 arch/x86/math-emu/wm_shrx.S                        |   8 +-
 arch/x86/math-emu/wm_sqrt.S                        |   4 +-
 arch/x86/mm/mem_encrypt_boot.S                     |   8 +-
 arch/x86/platform/efi/efi_stub_32.S                |   4 +-
 arch/x86/platform/efi/efi_stub_64.S                |   4 +-
 arch/x86/platform/efi/efi_thunk_64.S               |  16 +-
 arch/x86/platform/olpc/xo1-wakeup.S                |   3 +-
 arch/x86/power/hibernate_asm_32.S                  |   6 +-
 arch/x86/power/hibernate_asm_64.S                  |  14 +-
 arch/x86/purgatory/entry64.S                       |  21 +-
 arch/x86/purgatory/setup-x86_64.S                  |  14 +-
 arch/x86/purgatory/stack.S                         |   7 +-
 arch/x86/realmode/rm/header.S                      |   8 +-
 arch/x86/realmode/rm/reboot.S                      |  13 +-
 arch/x86/realmode/rm/stack.S                       |  14 +-
 arch/x86/realmode/rm/trampoline_32.S               |  16 +-
 arch/x86/realmode/rm/trampoline_64.S               |  29 ++-
 arch/x86/realmode/rm/trampoline_common.S           |   4 +-
 arch/x86/realmode/rm/wakeup_asm.S                  |  15 +-
 arch/x86/realmode/rmpiggy.S                        |  10 +-
 arch/x86/um/vdso/vdso.S                            |   6 +-
 arch/x86/xen/xen-asm.S                             |  20 +-
 arch/x86/xen/xen-asm_32.S                          |   7 +-
 arch/x86/xen/xen-asm_64.S                          |  34 +--
 arch/x86/xen/xen-head.S                            |   8 +-
 arch/x86/xen/xen-pvh.S                             |  15 +-
 include/linux/linkage.h                            | 261 ++++++++++++++++++++-
 131 files changed, 1474 insertions(+), 982 deletions(-)
 create mode 100644 Documentation/asm-annotations.rst

-- 
2.16.3
