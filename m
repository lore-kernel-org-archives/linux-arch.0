From: Ram Pai <linuxram@us.ibm.com>
Subject: [RFC v6 48/62] selftest/vm: clear the bits in shadow reg when a pkey is freed.
Date: Sat, 15 Jul 2017 20:56:50 -0700
Message-ID: <1500177424-13695-49-git-send-email-linuxram@us.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
Sender: owner-linux-mm@kvack.org
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, linuxram@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com, mhocko@kernel.org
List-Id: linux-arch.vger.kernel.org

When a key is freed, the  key  is  no  more  effective.
Clear the bits corresponding to the pkey in the shadow
register. Otherwise  it  will carry some spurious bits
which can trigger false-positive asserts.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 0f2d1ce..4f4ce36 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -582,6 +582,9 @@ int alloc_pkey(void)
 int sys_pkey_free(unsigned long pkey)
 {
 	int ret = syscall(SYS_pkey_free, pkey);
+
+	if (!ret)
+		shadow_pkey_reg &= reset_bits(pkey, PKEY_DISABLE_ACCESS);
 	dprintf1("%s(pkey=%ld) syscall ret: %d\n", __func__, pkey, ret);
 	return ret;
 }
-- 
1.7.1

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
