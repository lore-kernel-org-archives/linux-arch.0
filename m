From: David Howells <dhowells@redhat.com>
Subject: [PATCH 19/29] Disintegrate asm/system.h for OpenRISC
Date: Wed, 07 Mar 2012 19:49:26 +0000
Message-ID: <20120307194925.15987.83054.stgit@warthog.procyon.org.uk>
References: <20120307194548.15987.36073.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120307194548.15987.36073.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: paul.gortmaker@windriver.com, hpa@zytor.com
Cc: torvalds@linux-foundation.org, sfr@canb.auug.org.au, mingo@redhat.com, arnd@arndb.de, dhowells@redhat.com, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Disintegrate asm/system.h for OpenRISC.  Not compiled.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/openrisc/include/asm/system.h |   35 -----------------------------------
 1 files changed, 0 insertions(+), 35 deletions(-)
 delete mode 100644 arch/openrisc/include/asm/system.h

diff --git a/arch/openrisc/include/asm/system.h b/arch/openrisc/include/asm/system.h
deleted file mode 100644
index cf65888..0000000
--- a/arch/openrisc/include/asm/system.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- * OpenRISC Linux
- *
- * Linux architectural port borrowing liberally from similar works of
- * others.  All original copyrights apply as per the original source
- * declaration.
- *
- * OpenRISC implementation:
- * Copyright (C) 2003 Matjaz Breskvar <phoenix@bsemi.com>
- * Copyright (C) 2010-2011 Jonas Bonn <jonas@southpole.se>
- * et al.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#ifndef __ASM_OPENRISC_SYSTEM_H
-#define __ASM_OPENRISC_SYSTEM_H
-
-#ifdef __KERNEL__
-#ifndef __ASSEMBLY__
-
-#include <asm/spr.h>
-#include <asm-generic/system.h>
-
-/* We probably need this definition, but the generic system.h provides it
- * and it's not used on our arch anyway...
- */
-/*#define nop() __asm__ __volatile__ ("l.nop"::)*/
-
-#endif /* __ASSEMBLY__ */
-#endif /* __KERNEL__ */
-#endif /* __ASM_OPENRISC_SYSTEM_H */
