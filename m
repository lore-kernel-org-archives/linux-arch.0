Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20906 "EHLO
 mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
 with ESMTP id S1726780AbgATIiY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
 Mon, 20 Jan 2020 03:38:24 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1]) by
 mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00K8cHvL033485
 for <linux-arch@vger.kernel.org>; Mon, 20 Jan 2020 03:38:23 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98]) by
 mx0b-001b2d01.pphosted.com with ESMTP id 2xmg7xqyx5-1 (version=TLSv1.2
 cipher=AES256-GCM-SHA384 bits=256 verify=NOT) for
 <linux-arch@vger.kernel.org>; Mon, 20 Jan 2020 03:38:19 -0500
Received: from localhost by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted for
 <linux-arch@vger.kernel.org> from <sandipan@linux.ibm.com>; Mon, 20 Jan 2020
 08:37:03 -0000
From: Sandipan Das <sandipan@linux.ibm.com>
Subject: [PATCH v17 12/24] selftests: vm: pkeys: Use the correct huge page
 size
Date: Mon, 20 Jan 2020 14:06:09 +0530
In-Reply-To: <cover.1579507768.git.sandipan@linux.ibm.com>
References: <cover.1579507768.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1579507768.git.sandipan@linux.ibm.com>
References: <cover.1579507768.git.sandipan@linux.ibm.com>
Message-ID: <e24b5ce670a4731b703ca71b9c4d949145ee06d0.1579507768.git.sandipan@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc: linux-arch@vger.kernel.org, fweimer@redhat.com, dave.hansen@intel.com, x86@kernel.org, linuxram@us.ibm.com, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Message-ID: <20200120083609.ok0yU4LvBGgYx3tBONjMJesBxzV8FYtZJVV5VT1UpQY@z>

The huge page size can vary across architectures. This will
ensure that the correct huge page size is used when accessing
the hugetlb controls under sysfs. Instead of using a hardcoded
page size (i.e. 2MB), this now uses the HPAGE_SIZE macro which
is arch-specific.

Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c | 23 ++++++++++++++------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 9cc82b65f828..535e464e27e9 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -739,12 +739,15 @@ void *malloc_pkey_anon_huge(long size, int prot, u16 pkey)
 }

 int hugetlb_setup_ok;
+#define SYSFS_FMT_NR_HUGE_PAGES "/sys/kernel/mm/hugepages/hugepages-%ldkB/nr_hugepages"
 #define GET_NR_HUGE_PAGES 10
 void setup_hugetlbfs(void)
 {
 	int err;
 	int fd;
-	char buf[] = "123";
+	char buf[256];
+	long hpagesz_kb;
+	long hpagesz_mb;

 	if (geteuid() != 0) {
 		fprintf(stderr, "WARNING: not run as root, can not do hugetlb test\n");
@@ -755,11 +758,16 @@ void setup_hugetlbfs(void)

 	/*
 	 * Now go make sure that we got the pages and that they
-	 * are 2M pages.  Someone might have made 1G the default.
+	 * are PMD-level pages. Someone might have made PUD-level
+	 * pages the default.
 	 */
-	fd = open("/sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages", O_RDONLY);
+	hpagesz_kb = HPAGE_SIZE / 1024;
+	hpagesz_mb = hpagesz_kb / 1024;
+	sprintf(buf, SYSFS_FMT_NR_HUGE_PAGES, hpagesz_kb);
+	fd = open(buf, O_RDONLY);
 	if (fd < 0) {
-		perror("opening sysfs 2M hugetlb config");
+		fprintf(stderr, "opening sysfs %ldM hugetlb config: %s\n",
+			hpagesz_mb, strerror(errno));
 		return;
 	}

@@ -767,13 +775,14 @@ void setup_hugetlbfs(void)
 	err = read(fd, buf, sizeof(buf)-1);
 	close(fd);
 	if (err <= 0) {
-		perror("reading sysfs 2M hugetlb config");
+		fprintf(stderr, "reading sysfs %ldM hugetlb config: %s\n",
+			hpagesz_mb, strerror(errno));
 		return;
 	}

 	if (atoi(buf) != GET_NR_HUGE_PAGES) {
-		fprintf(stderr, "could not confirm 2M pages, got: '%s' expected %d\n",
-			buf, GET_NR_HUGE_PAGES);
+		fprintf(stderr, "could not confirm %ldM pages, got: '%s' expected %d\n",
+			hpagesz_mb, buf, GET_NR_HUGE_PAGES);
 		return;
 	}

-- 
2.17.1
