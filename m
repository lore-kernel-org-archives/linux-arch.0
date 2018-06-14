Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34587 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935869AbeFNAqz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Jun 2018 20:46:55 -0400
From: Ram Pai <linuxram@us.ibm.com>
Subject: [PATCH v13 05/24] selftests/vm: Make gcc check arguments of sigsafe_printf()
Date: Wed, 13 Jun 2018 17:44:56 -0700
Message-ID: <1528937115-10132-6-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
References: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, dave.hansen@intel.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, linuxram@us.ibm.com, fweimer@redhat.com, msuchanek@suse.de, aneesh.kumar@linux.vnet.ibm.com
Message-ID: <20180614004456.8e7zClGYTJ-MY-xLdq2FOyeQqGUzuCxCT28NkdVpLHI@z>

From: Thiago Jung Bauermann <bauerman@linux.ibm.com>

This will help us ensure we print pkey_reg_t values correctly in different
architectures.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 tools/testing/selftests/vm/pkey-helpers.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/tools/testing/selftests/vm/pkey-helpers.h b/tools/testing/selftests/vm/pkey-helpers.h
index 3ed2f02..7f18a82 100644
--- a/tools/testing/selftests/vm/pkey-helpers.h
+++ b/tools/testing/selftests/vm/pkey-helpers.h
@@ -27,6 +27,10 @@
 #define DPRINT_IN_SIGNAL_BUF_SIZE 4096
 extern int dprint_in_signal;
 extern char dprint_in_signal_buffer[DPRINT_IN_SIGNAL_BUF_SIZE];
+
+#ifdef __GNUC__
+__attribute__((format(printf, 1, 2)))
+#endif
 static inline void sigsafe_printf(const char *format, ...)
 {
 	va_list ap;
-- 
1.7.1
