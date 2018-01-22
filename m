From: Ram Pai <linuxram@us.ibm.com>
Subject: [PATCH v10 11/24] selftests/vm: pkey register should match shadow pkey
Date: Mon, 22 Jan 2018 10:52:04 -0800
Message-ID: <1516647137-11174-12-git-send-email-linuxram@us.ibm.com>
References: <1516647137-11174-1-git-send-email-linuxram@us.ibm.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1516647137-11174-1-git-send-email-linuxram@us.ibm.com>
Sender: owner-linux-mm@kvack.org
To: shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, akpm@linux-foundation.org, dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, linuxram@us.ibm.com, arnd@arndb.de
List-Id: linux-arch.vger.kernel.org

expected_pkey_fault() is comparing the contents of pkey
register with 0. This may not be true all the time. There
could be bits set by default by the architecture
which can never be changed. Hence compare the value against
shadow pkey register, which is supposed to track the bits
accurately all throughout

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 254b66d..6054093 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -926,10 +926,10 @@ void expected_pkey_fault(int pkey)
 	pkey_assert(last_pkey_faults + 1 == pkey_faults);
 	pkey_assert(last_si_pkey == pkey);
 	/*
-	 * The signal handler shold have cleared out PKEY register to let the
+	 * The signal handler shold have cleared out pkey-register to let the
 	 * test program continue.  We now have to restore it.
 	 */
-	if (__rdpkey_reg() != 0)
+	if (__rdpkey_reg() != shadow_pkey_reg)
 		pkey_assert(0);
 
 	__wrpkey_reg(shadow_pkey_reg);
-- 
1.7.1

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
