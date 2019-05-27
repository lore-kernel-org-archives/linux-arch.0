Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:34991 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725996AbfE0GRq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 May 2019 02:17:46 -0400
From: Vincent Chen <vincentc@andestech.com>
Subject: [PATCH v2 0/3] nds32: Prevent FPU emulator from incorrectly modifying IEX status
Date: Mon, 27 May 2019 14:17:18 +0800
Message-ID: <1558937841-4222-1-git-send-email-vincentc@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, greentime@andestech.com, green.hu@gmail.com, deanbo422@gmail.com
Cc: vincentc@andestech.com
Message-ID: <20190527061718.24HkO9zceb_Q3rginJJ31blNi57HOv74-z0lcnQKETY@z>

  In order for kernel to capture each denormalized output, the UDF
trapping enable bit is always raised in $fpcsr. Because underflow case will
issue not an underflow exception but also an inexact exception, it causes
that the IEX, IEX cumulative exception, flag in $fpcsr to be raised in each
denormalized output handling. To make the emulation transparent to the
user, the emulator needs to clear the IEX flag in $fpcsr if the result is a
denormalized number. However, if the IEX flag has been raised before this
floating point emulation, this cleanup may be incorrect. To avoid the IEX
flags in $fpcsr be raised in each denormalized output handling, the 1st
patch always enable IEX trap to fix this issue.

  The existing floating point emulations is only available for floating
instruction that possibly issue denormalized input and underflow
exceptions. These existing FPU emulations are not sufficient when IEx
Trap is enabled because some floating point instructions only issue inexact
exception. The 2nd patch adds the emulations of such floating point
instructions.

  While compiling the files of 2nd patch, compiler thinks the length of
bit-shift may be greater than the bit length of data type so that many
Wshift-count-overflow warning is issued. These warnings are fixed in the
3rd patch.

Vincent Chen (3):
  nds32: Avoid IEX status being incorrectly modified
  nds32: add new emulations for floating point instruction
  math-emu: Use statement expressions to fix Wshift-count-overflow
    warning

 arch/nds32/include/asm/bitfield.h            |    2 +-
 arch/nds32/include/asm/fpu.h                 |    2 +-
 arch/nds32/include/asm/fpuemu.h              |   12 +++++
 arch/nds32/include/asm/syscalls.h            |    2 +-
 arch/nds32/include/uapi/asm/fp_udfiex_crtl.h |   16 +++++++
 arch/nds32/include/uapi/asm/sigcontext.h     |   24 ++++++++---
 arch/nds32/include/uapi/asm/udftrap.h        |   13 ------
 arch/nds32/include/uapi/asm/unistd.h         |    4 +-
 arch/nds32/kernel/fpu.c                      |   15 +++----
 arch/nds32/kernel/sys_nds32.c                |   26 ++++++-----
 arch/nds32/math-emu/Makefile                 |    5 ++-
 arch/nds32/math-emu/fd2si.c                  |   30 +++++++++++++
 arch/nds32/math-emu/fd2siz.c                 |   30 +++++++++++++
 arch/nds32/math-emu/fd2ui.c                  |   30 +++++++++++++
 arch/nds32/math-emu/fd2uiz.c                 |   30 +++++++++++++
 arch/nds32/math-emu/fpuemu.c                 |   57 ++++++++++++++++++++++++--
 arch/nds32/math-emu/fs2si.c                  |   29 +++++++++++++
 arch/nds32/math-emu/fs2siz.c                 |   29 +++++++++++++
 arch/nds32/math-emu/fs2ui.c                  |   29 +++++++++++++
 arch/nds32/math-emu/fs2uiz.c                 |   30 +++++++++++++
 arch/nds32/math-emu/fsi2d.c                  |   22 ++++++++++
 arch/nds32/math-emu/fsi2s.c                  |   22 ++++++++++
 arch/nds32/math-emu/fui2d.c                  |   22 ++++++++++
 arch/nds32/math-emu/fui2s.c                  |   22 ++++++++++
 include/math-emu/op-2.h                      |   17 +++-----
 include/math-emu/op-common.h                 |   11 +++--
 26 files changed, 465 insertions(+), 66 deletions(-)
 create mode 100644 arch/nds32/include/uapi/asm/fp_udfiex_crtl.h
 delete mode 100644 arch/nds32/include/uapi/asm/udftrap.h
 create mode 100644 arch/nds32/math-emu/fd2si.c
 create mode 100644 arch/nds32/math-emu/fd2siz.c
 create mode 100644 arch/nds32/math-emu/fd2ui.c
 create mode 100644 arch/nds32/math-emu/fd2uiz.c
 create mode 100644 arch/nds32/math-emu/fs2si.c
 create mode 100644 arch/nds32/math-emu/fs2siz.c
 create mode 100644 arch/nds32/math-emu/fs2ui.c
 create mode 100644 arch/nds32/math-emu/fs2uiz.c
 create mode 100644 arch/nds32/math-emu/fsi2d.c
 create mode 100644 arch/nds32/math-emu/fsi2s.c
 create mode 100644 arch/nds32/math-emu/fui2d.c
 create mode 100644 arch/nds32/math-emu/fui2s.c
