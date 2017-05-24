Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:50156 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161697AbdEXX4G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 May 2017 19:56:06 -0400
From: Babu Moger <babu.moger@oracle.com>
Subject: [PATCH v4 3/7] arch/sparc: Define config parameter CPU_BIG_ENDIAN
Date: Wed, 24 May 2017 17:55:11 -0600
Message-ID: <1495670115-63960-4-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1495670115-63960-1-git-send-email-babu.moger@oracle.com>
References: <1495670115-63960-1-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: peterz@infradead.org, mingo@redhat.com, arnd@arndb.de, davem@davemloft.net
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, geert@linux-m68k.org, babu.moger@oracle.com, shannon.nelson@oracle.com, haakon.bugge@oracle.com, steven.sistare@oracle.com, vijay.ac.kumar@oracle.com, jane.chu@oracle.com
Message-ID: <20170524235511.ry0YeJ8TcxDbfhQhrMpY2vdOwOxIOBFAH6A4nme9hSc@z>

Found this problem while enabling queued rwlock on SPARC.
The parameter CONFIG_CPU_BIG_ENDIAN is used to clear the
specific byte in qrwlock structure. Without this parameter,
we clear the wrong byte. Here is the code.

static inline u8 *__qrwlock_write_byte(struct qrwlock *lock)
 {
	return (u8 *)lock + 3 * IS_BUILTIN(CONFIG_CPU_BIG_ENDIAN);
 }

Define CPU_BIG_ENDIAN for SPARC to fix it.

Signed-off-by: Babu Moger <babu.moger@oracle.com>
Reviewed-by: Håkon Bugge <haakon.bugge@oracle.com>
Reviewed-by: Jane Chu <jane.chu@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
Reviewed-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
---
 arch/sparc/Kconfig |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 908f019..0d9dc49 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -92,6 +92,9 @@ config ARCH_DEFCONFIG
 config ARCH_PROC_KCORE_TEXT
 	def_bool y
 
+config CPU_BIG_ENDIAN
+	def_bool y
+
 config ARCH_ATU
 	bool
 	default y if SPARC64
-- 
1.7.1
