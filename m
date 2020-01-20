Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36982 "EHLO
 mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
 with ESMTP id S1726417AbgATIib (ORCPT <rfc822;linux-arch@vger.kernel.org>);
 Mon, 20 Jan 2020 03:38:31 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1]) by
 mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00K8cDJn050423
 for <linux-arch@vger.kernel.org>; Mon, 20 Jan 2020 03:38:29 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98]) by
 mx0b-001b2d01.pphosted.com with ESMTP id 2xmfy0g4a4-1 (version=TLSv1.2
 cipher=AES256-GCM-SHA384 bits=256 verify=NOT) for
 <linux-arch@vger.kernel.org>; Mon, 20 Jan 2020 03:38:17 -0500
Received: from localhost by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted for
 <linux-arch@vger.kernel.org> from <sandipan@linux.ibm.com>; Mon, 20 Jan 2020
 08:37:33 -0000
From: Sandipan Das <sandipan@linux.ibm.com>
Subject: [PATCH v17 23/24] selftests/vm/pkeys: Override access right
 definitions on powerpc
Date: Mon, 20 Jan 2020 14:06:20 +0530
In-Reply-To: <cover.1579507768.git.sandipan@linux.ibm.com>
References: <cover.1579507768.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1579507768.git.sandipan@linux.ibm.com>
References: <cover.1579507768.git.sandipan@linux.ibm.com>
Message-ID: <9ef3a92391dc305b226df57d6f2d5ccb60421878.1579507768.git.sandipan@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc: linux-arch@vger.kernel.org, fweimer@redhat.com, dave.hansen@intel.com, x86@kernel.org, linuxram@us.ibm.com, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Message-ID: <20200120083620.3__Wqjg9cDHB_X9MJiDYbfEJe6IzZovQSIbE787R4Lo@z>

From: Ram Pai <linuxram@us.ibm.com>

Some platforms hardcode the x86 values for PKEY_DISABLE_ACCESS
and PKEY_DISABLE_WRITE such as those in:
 /usr/include/bits/mman-shared.h.

This overrides the definitions with correct values for powerpc.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 tools/testing/selftests/vm/pkey-powerpc.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/pkey-powerpc.h b/tools/testing/selftests/vm/pkey-powerpc.h
index d31665c48f5e..02bd4dd7d467 100644
--- a/tools/testing/selftests/vm/pkey-powerpc.h
+++ b/tools/testing/selftests/vm/pkey-powerpc.h
@@ -16,11 +16,13 @@
 #define fpregs			fp_regs
 #define si_pkey_offset		0x20

-#ifndef PKEY_DISABLE_ACCESS
+#ifdef PKEY_DISABLE_ACCESS
+#undef PKEY_DISABLE_ACCESS
 # define PKEY_DISABLE_ACCESS	0x3  /* disable read and write */
 #endif

-#ifndef PKEY_DISABLE_WRITE
+#ifdef PKEY_DISABLE_WRITE
+#undef PKEY_DISABLE_WRITE
 # define PKEY_DISABLE_WRITE	0x2
 #endif

-- 
2.17.1
