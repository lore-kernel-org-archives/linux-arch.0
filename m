From: Babu Moger <babu.moger@oracle.com>
Subject: [PATCH v2 3/7] arch/sparc: Define config parameter CPU_BIG_ENDIAN
Date: Fri, 19 May 2017 18:16:57 -0600
Message-ID: <1495239421-441642-4-git-send-email-babu.moger@oracle.com>
References: <1495239421-441642-1-git-send-email-babu.moger@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <1495239421-441642-1-git-send-email-babu.moger@oracle.com>
Sender: sparclinux-owner@vger.kernel.org
To: davem@davemloft.net, peterz@infradead.org, mingo@redhat.com, arnd@arndb.de
Cc: babu.moger@oracle.com, shannon.nelson@oracle.com, haakon.bugge@oracle.com, steven.sistare@oracle.com, vijay.ac.kumar@oracle.com, jane.chu@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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
 arch/sparc/Kconfig |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index a2ad946..0f5813b 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -91,6 +91,10 @@ config ARCH_DEFCONFIG
 config ARCH_PROC_KCORE_TEXT
 	def_bool y
 
+config CPU_BIG_ENDIAN
+	bool
+	default y if SPARC
+
 config ARCH_ATU
 	bool
 	default y if SPARC64
-- 
1.7.1

