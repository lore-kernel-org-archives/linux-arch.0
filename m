From: Ram Pai <linuxram@us.ibm.com>
Subject: [PATCH v13 0/3] mm, x86, powerpc: Enhancements to Memory Protection Keys.
Date: Tue, 27 Mar 2018 02:09:25 -0700
Message-ID: <1522141768-25485-1-git-send-email-linuxram@us.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, linuxram@us.ibm.com, corbet@lwn.net, arnd@arndb.de
List-Id: linux-arch.vger.kernel.org

This patch series provides arch-neutral enhancements to
enable memory-keys on new architecutes, and the corresponding
changes in x86 and powerpc specific code to support that.

a) Provides ability to support upto 32 keys.  PowerPC
	can handle 32 keys and hence needs this.

b) Arch-neutral code; and not the arch-specific code,
   determines the format of the string, that displays the key
   for each vma in smaps.

History:
-------
version v13:
	(1) fixed a git bisect error. :(

version v12:
	(1) fixed compilation errors seen with various x86
		configs.
version v11:
	(1) code that displays key in smaps is not any more
		defined under CONFIG_ARCH_HAS_PKEYS.
       	    - Comment by Eric W. Biederman and Michal Hocko
	(2) merged two patches that implemented (1).
		- comment by Michal Hocko

version prior to v11:
	(1) used one additional bit from VM_HIGH_ARCH_*
       		to support 32 keys.
	    - Suggestion by Dave Hansen.
	(2) powerpc specific changes to support memory keys.


Ram Pai (3):
  mm, powerpc, x86: define VM_PKEY_BITx bits if CONFIG_ARCH_HAS_PKEYS
    is enabled
  mm, powerpc, x86: introduce an additional vma bit for powerpc pkey
  mm, x86, powerpc: display pkey in smaps only if arch supports pkeys

 arch/powerpc/include/asm/mmu_context.h |    5 -----
 arch/powerpc/include/asm/pkeys.h       |    2 ++
 arch/x86/include/asm/mmu_context.h     |    5 -----
 arch/x86/include/asm/pkeys.h           |    1 +
 arch/x86/kernel/fpu/xstate.c           |    5 +++++
 arch/x86/kernel/setup.c                |    8 --------
 fs/proc/task_mmu.c                     |   15 ++++++++-------
 include/linux/mm.h                     |   12 +++++++-----
 include/linux/pkeys.h                  |    7 ++++++-
 9 files changed, 29 insertions(+), 31 deletions(-)
