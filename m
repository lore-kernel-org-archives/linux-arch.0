Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:38355 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759026AbXLTMAL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 20 Dec 2007 07:00:11 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
In-Reply-To: Roland McGrath's message of  Thursday, 20 December 2007 03:52:00 -0800 <20071220115200.C767E26F98A@magilla.localdomain>
References: <20071220115200.C767E26F98A@magilla.localdomain>
Subject: [PATCH -mm 17/43] powerpc CORE_DUMP_USE_REGSET
Message-Id: <20071220115812.E7D5526F98D@magilla.localdomain>
Date: Thu, 20 Dec 2007 03:58:12 -0800 (PST)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>

This switches powerpc to using the user_regset-based code for ELF core
dumps.  The core dumps come out exactly the same either way, except that
the NT_PPC_VMX note is now omitted for any thread that never touched its
Altivec registers (thread_struct.vr_used).

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 include/asm-powerpc/elf.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/asm-powerpc/elf.h b/include/asm-powerpc/elf.h
index 6bd07ef..fd9bf8b 100644
--- a/include/asm-powerpc/elf.h
+++ b/include/asm-powerpc/elf.h
@@ -167,6 +167,7 @@ typedef elf_vrreg_t elf_vrregset_t32[ELF_NVRREG32];
 #define elf_check_arch(x) ((x)->e_machine == ELF_ARCH)
 
 #define USE_ELF_CORE_DUMP
+#define CORE_DUMP_USE_REGSET
 #define ELF_EXEC_PAGESIZE	PAGE_SIZE
 
 /* This is the location that an ET_DYN program is loaded if exec'ed.  Typical
-- 
1.5.3.6

