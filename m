Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:40234 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731748AbeGQOXc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 17 Jul 2018 10:23:32 -0400
From: Ram Pai <linuxram@us.ibm.com>
Subject: [PATCH v14 20/22] selftests/vm: testcases must restore pkey-permissions
Date: Tue, 17 Jul 2018 06:49:23 -0700
Message-ID: <1531835365-32387-21-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1531835365-32387-1-git-send-email-linuxram@us.ibm.com>
References: <1531835365-32387-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, dave.hansen@intel.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, linuxram@us.ibm.com, fweimer@redhat.com, msuchanek@suse.de, aneesh.kumar@linux.vnet.ibm.com
Message-ID: <20180717134923.eHHuQxE8AsU5gKBi5kXf84c26V4MSmaivdbqwSpZTf0@z>

Generally the signal handler restores the state of the pkey register
before returning. However there are times when the read/write operation
can legitamely fail without invoking the signal handler.  Eg: A
sys_read() operaton to a write-protected page should be disallowed.  In
such a case the state of the pkey register is not restored to its
original state.  Test cases may not remember to restoring the key
register state. During cleanup generically restore the key permissions.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 8a6afdd..ea3cf04 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -1476,8 +1476,13 @@ void run_tests_once(void)
 		pkey_tests[test_nr](ptr, pkey);
 		dprintf1("freeing test memory: %p\n", ptr);
 		free_pkey_malloc(ptr);
+
+		/* restore the permission on the key after use */
+		pkey_access_allow(pkey);
+		pkey_write_allow(pkey);
 		sys_pkey_free(pkey);
 
+
 		dprintf1("pkey_faults: %d\n", pkey_faults);
 		dprintf1("orig_pkey_faults: %d\n", orig_pkey_faults);
 
-- 
1.7.1
