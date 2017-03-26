From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH 0/5] uapi: fix userspace compilation of asm/ ipc headers
Date: Sun, 26 Mar 2017 06:27:28 +0300
Message-ID: <20170326032728.GA13481@altlinux.org>
References: <CAK8P3a1=-Q=gVRyk+PwqxTeTPXa4yrmqWKG7SyZng2d7bcbG=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from vmicros1.altlinux.org ([194.107.17.57]:46278 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751256AbdCZD1o (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 25 Mar 2017 23:27:44 -0400
Content-Disposition: inline
In-Reply-To: <CAK8P3a1=-Q=gVRyk+PwqxTeTPXa4yrmqWKG7SyZng2d7bcbG=g@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

This is resend of short series of trivial userspace compilation fixes
acked earlier by Arnd Bergmann.

Nobody else from the long Cc list of the original patch series has shown
any interest at all, so I've trimmed Cc down.

Dmitry V. Levin (5):
  uapi: fix asm/ipcbuf.h userspace compilation errors
  uapi: fix asm/msgbuf.h userspace compilation errors
  uapi: fix asm/sembuf.h userspace compilation errors
  uapi: fix asm/shmbuf.h userspace compilation errors
  uapi: fix another asm/shmbuf.h userspace compilation error

 arch/alpha/include/uapi/asm/msgbuf.h   | 2 ++
 arch/alpha/include/uapi/asm/sembuf.h   | 2 ++
 arch/alpha/include/uapi/asm/shmbuf.h   | 4 +++-
 arch/avr32/include/uapi/asm/msgbuf.h   | 2 ++
 arch/avr32/include/uapi/asm/sembuf.h   | 2 ++
 arch/avr32/include/uapi/asm/shmbuf.h   | 4 +++-
 arch/frv/include/uapi/asm/msgbuf.h     | 2 ++
 arch/frv/include/uapi/asm/sembuf.h     | 2 ++
 arch/frv/include/uapi/asm/shmbuf.h     | 4 +++-
 arch/ia64/include/uapi/asm/msgbuf.h    | 2 ++
 arch/ia64/include/uapi/asm/sembuf.h    | 2 ++
 arch/ia64/include/uapi/asm/shmbuf.h    | 4 +++-
 arch/m32r/include/uapi/asm/msgbuf.h    | 2 ++
 arch/m32r/include/uapi/asm/sembuf.h    | 2 ++
 arch/m32r/include/uapi/asm/shmbuf.h    | 4 +++-
 arch/mips/include/uapi/asm/msgbuf.h    | 1 +
 arch/mips/include/uapi/asm/sembuf.h    | 2 ++
 arch/mips/include/uapi/asm/shmbuf.h    | 4 +++-
 arch/mn10300/include/uapi/asm/msgbuf.h | 2 ++
 arch/mn10300/include/uapi/asm/sembuf.h | 2 ++
 arch/mn10300/include/uapi/asm/shmbuf.h | 4 +++-
 arch/parisc/include/uapi/asm/msgbuf.h  | 1 +
 arch/parisc/include/uapi/asm/sembuf.h  | 1 +
 arch/parisc/include/uapi/asm/shmbuf.h  | 1 +
 arch/powerpc/include/uapi/asm/msgbuf.h | 2 ++
 arch/powerpc/include/uapi/asm/sembuf.h | 2 ++
 arch/powerpc/include/uapi/asm/shmbuf.h | 4 +++-
 arch/s390/include/uapi/asm/ipcbuf.h    | 2 ++
 arch/s390/include/uapi/asm/msgbuf.h    | 2 ++
 arch/s390/include/uapi/asm/sembuf.h    | 2 ++
 arch/s390/include/uapi/asm/shmbuf.h    | 4 +++-
 arch/sparc/include/uapi/asm/ipcbuf.h   | 2 ++
 arch/sparc/include/uapi/asm/msgbuf.h   | 2 ++
 arch/sparc/include/uapi/asm/sembuf.h   | 2 ++
 arch/sparc/include/uapi/asm/shmbuf.h   | 4 +++-
 arch/x86/include/uapi/asm/sembuf.h     | 2 ++
 arch/xtensa/include/uapi/asm/ipcbuf.h  | 2 ++
 arch/xtensa/include/uapi/asm/msgbuf.h  | 2 ++
 arch/xtensa/include/uapi/asm/sembuf.h  | 1 +
 arch/xtensa/include/uapi/asm/shmbuf.h  | 6 ++++--
 include/uapi/asm-generic/ipcbuf.h      | 2 ++
 include/uapi/asm-generic/msgbuf.h      | 1 +
 include/uapi/asm-generic/sembuf.h      | 1 +
 include/uapi/asm-generic/shmbuf.h      | 3 ++-
 44 files changed, 93 insertions(+), 13 deletions(-)

-- 
ldv
