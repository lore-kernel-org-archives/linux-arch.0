From: Ram Pai <linuxram@us.ibm.com>
Subject: [PATCH v12 2/3] mm, powerpc,
 x86: introduce an additional vma bit for powerpc pkey
Date: Wed, 21 Feb 2018 15:52:17 -0800
Message-ID: <1519257138-23797-3-git-send-email-linuxram@us.ibm.com>
References: <1519257138-23797-1-git-send-email-linuxram@us.ibm.com>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1519257138-23797-1-git-send-email-linuxram@us.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, corbet@lwn.net, ebiederm@xmission.com, msuchanek@suse.com, fweimer@redhat.com, arnd@arndb.de, dave.hansen@intel.com, x86@kernel.org, linuxram@us.ibm.com, linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com, bauerman@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, khandual@linux.vnet.ibm.com
List-Id: linux-arch.vger.kernel.org

Currently only 4bits are allocated in the vma flags to hold 16
keys. This is sufficient for x86. PowerPC  supports  32  keys,
which needs 5bits. This patch allocates an  additional bit.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Michael Ellermen <mpe@ellerman.id.au>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 fs/proc/task_mmu.c |    1 +
 include/linux/mm.h |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 6b996d0..6d83bb7 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -685,6 +685,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 		[ilog2(VM_PKEY_BIT1)]	= "",
 		[ilog2(VM_PKEY_BIT2)]	= "",
 		[ilog2(VM_PKEY_BIT3)]	= "",
+		[ilog2(VM_PKEY_BIT4)]	= "",
 #endif /* CONFIG_ARCH_HAS_PKEYS */
 	};
 	size_t i;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ad207ad..d534f46 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -231,9 +231,10 @@ extern int overcommit_kbytes_handler(struct ctl_table *, int, void __user *,
 #ifdef CONFIG_ARCH_HAS_PKEYS
 # define VM_PKEY_SHIFT	VM_HIGH_ARCH_BIT_0
 # define VM_PKEY_BIT0	VM_HIGH_ARCH_0	/* A protection key is a 4-bit value */
-# define VM_PKEY_BIT1	VM_HIGH_ARCH_1
+# define VM_PKEY_BIT1	VM_HIGH_ARCH_1	/* on x86 and 5-bit value on ppc64   */
 # define VM_PKEY_BIT2	VM_HIGH_ARCH_2
 # define VM_PKEY_BIT3	VM_HIGH_ARCH_3
+# define VM_PKEY_BIT4	VM_HIGH_ARCH_4
 #endif /* CONFIG_ARCH_HAS_PKEYS */
 
 #if defined(CONFIG_X86)
-- 
1.7.1
