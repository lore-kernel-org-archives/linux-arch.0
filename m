Received: from outbound.ms.icloud.com (p-west3-cluster6-host6-snip4-10.eps.apple.com [57.103.75.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE5E346E51
	for <linux-arch@vger.kernel.org>; Fri,  1 May 2026 05:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.75.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777614974; cv=none; b=qRCUlI9Ez3XyWmnpvLMk/HAXiYHfSa0s1g+oc6rMvX+QG/17AKvcx9U0wvME6AQXgGRqKXwbTLTn0RKgYrv99yTNYRYoRrQ99pVNVHCLTN1SK+fDfDLWY/hvLWPX+kVy+d+nr/Lz7KGS1wsgNO+ChXAwmBfkv/eBC2tLxg4FYjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777614974; c=relaxed/simple;
	bh=tLlHvbten/FbKEjsakcXJK23FKSjMlYil0F1ztvXfy4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GyceslNEkaZ/E1Dy/ICLQ/pZX4akf6X+MRLs9wYEVnprEFhsBE4SF3pIhheJmgRCXXHqV0d2s8rKUFKcvRL0vxkAL1BUuo+MtxYI4FwKShGRMjPli+xeQ37jBIkcKD1zecS7+D6xldbNRSu2v8KhItTmDvtQALrxHvtFDHLDUKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=tZbUnIyh; arc=none smtp.client-ip=57.103.75.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="tZbUnIyh"
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-60-percent-8 (Postfix) with ESMTPS id DC7F11800121;
	Fri, 01 May 2026 05:56:07 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhAA0MFWgFeAUEdXwFLVxQEFEYGVg1dE0wLcwRUB10FXVZQAlpLVBQEFEYGVg1dE0wLcwRUB10FXVZQAlpLQBMESgZNXw5eHwQXRhlVBEceXVZeHhkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4EVAddBV1WUAJaS18ZXUUPXwdZBEAMSAJAQwNCL1oXREBBWh9CFEgDWARcBUQBSwReDytGFVcbVgNDRVEfVEYTGU4bV01QG18CQg8=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1777614970; x=1780206970; bh=ArO79/Yz+eapuC+lM16m1Ks/IIQXLEjawf2FnZmiyak=; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme; b=tZbUnIyhKNnexWjJln4Drt4H+gH8ytUrTUS/yrjXpdRMs5esjcPvt0CLnM+DJdzrNeO20hxCJAVIxEnrHSMjXcSIo+yy+U4rddKIn8n6frmCrucPYxm9TvDS/XQpr4pPbqmBSgRDYlqOXZwpXDRfGOHLAnq7a40pSMFnnxLBUVN310Gz0XKLVi1hk+rMGIypbTxM5x7uJBbDhuNTdbvHtXraNfMQH60lJJ9ZH5oKGZfGWzLLKnU5fTNAXgW6j/ljF1Oz/baEUZs+fW84vW/xdZKiT62t9cNHUL4C2chxOkLXvmeS1talhJi9Pp9yY831gONhwqgE2s3VEVvBujrrsQ==
Received: from [127.0.0.1] (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-60-percent-8 (Postfix) with ESMTPSA id 29DFF1800105;
	Fri, 01 May 2026 05:56:01 +0000 (UTC)
From: Luka Bai <lukafocus@icloud.com>
Date: Fri, 01 May 2026 13:55:43 +0800
Subject: [PATCH 2/5] mm: add pmd level THP COW parameter in sysfs
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-thp_cow-v1-2-005377483738@tencent.com>
References: <20260501-thp_cow-v1-0-005377483738@tencent.com>
In-Reply-To: <20260501-thp_cow-v1-0-005377483738@tencent.com>
To: linux-mm@kvack.org
Cc: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Kairui Song <kasong@tencent.com>, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
 Luka Bai <lukabai@tencent.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777614950; l=5795;
 i=lukabai@tencent.com; s=20260501; h=from:subject:message-id;
 bh=6KT+jkO3Ka4qq13XkF6ZKbrVSZCH58mT9pcv6pbi+AM=;
 b=6EqPYX+PuZjHQKcfgprsY7mv/V4aWtlZT5R+tTAFWFjcm3SRqGZc571FHO583ASFNuAy4VKv9
 bfvO8YAzKRJAiWshdN8Yi/tyJ1YGxhd+8Aetf4bnkr4rixc/J6Epmga
X-Developer-Key: i=lukabai@tencent.com; a=ed25519;
 pk=KeaVteSWd00GIAjFyWZnuFsKAKixjga1ZkLMcI66nPM=
X-Authority-Info-Out: v=2.4 cv=eLQeTXp1 c=1 sm=1 tr=0 ts=69f44079
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10 a=UaoJkeuwEpQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=GvQkQWPkAAAA:8 a=TpG2_MQqjxLYGlnCjREA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: QJ_jTGQgd7VU-fuApa1pEAzmAa2JxrXm
X-Proofpoint-ORIG-GUID: QJ_jTGQgd7VU-fuApa1pEAzmAa2JxrXm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDA1MyBTYWx0ZWRfXzDCdLi85io6x
 zw1xwnafwpI6yxWcbQmNiFR+UXZuYuFr5NuHXEhRjZdobR/qUemadHorvBwAvPrJyag7CYxQi7/
 X2v6J8DI9M1ZoQW1Pif5PlO83fOAEAhlLAsvvItzBXGuNFzpWdpJpYaGpZKwkHSjaphdiYghllp
 eJNyST2LeJ9wPVc3HiKl91Mxppi5xd7ZzpdeNnHj4G1h35SLwnREeCUXWDWgQX159MnSNc2E12j
 /pc3n27XvqEAGqUCGfxi+nknsxpzjbkbVHoJUtvbZVZW3im4HSCEUku3Q+wHZdINfJ334c0qaxe
 dSm6N5FX2Aro0TcIrwxpRn2v3u8uvak6+ZbQ9MEy1j/rtaxV7Pp7KYw7XUhYxo=

From: Luka Bai <lukabai@tencent.com>

We would like to use similar logic of huge anonymous page or huge shmem
pages for THP COW: to categorize the strategies into three types: always,
never, madvise. If setting up to always, then we always do THP COW for
all the existing THPs. If setting up to never, then we never do THP COW.
If setting up to madvise, then we follow the setup we introduced in last
commit to decide whether we do COW for each individual vma.

We add TRANSPARENT_HUGEPAGE_COW_FLAG and
TRANSPARENT_HUGEPAGE_REQ_MADV_COW_FLAG that are very similar to
the TRANSPARENT_HUGEPAGE_FLAG and TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG
which are used to decide whether we do anonymous huge page fault when
it permits. And we add sysfs attribute thp_cow_attr as the interface
to choose from the three strategies we mentioned before.

Signed-off-by: Luka Bai <lukabai@tencent.com>
---
 .../testing/sysfs-kernel-mm-transparent-hugepage   |  1 +
 Documentation/admin-guide/mm/transhuge.rst         | 27 +++++++++++++++
 include/linux/huge_mm.h                            |  2 ++
 mm/huge_memory.c                                   | 39 ++++++++++++++++++++++
 4 files changed, 69 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-transparent-hugepage b/Documentation/ABI/testing/sysfs-kernel-mm-transparent-hugepage
index 7bfbb9cc2c11..43a1af13efe0 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-transparent-hugepage
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-transparent-hugepage
@@ -11,6 +11,7 @@ Description:
 			- khugepaged
 			- shmem_enabled
 			- use_zero_page
+			- thp_cow
 			- subdirectories of the form hugepages-<size>kB, where <size>
 			  is the page size of the hugepages supported by the kernel/CPU
 			  combination.
diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 0ef13c451ac8..0926651bad0d 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -226,6 +226,33 @@ to "always" or "madvise"), and it'll be automatically shutdown when
 all THP sizes are disabled (when both the per-size anon control and the
 top-level control are "never")
 
+Some workloads may want to do copy on write on the pmd size to acquire the
+tlb benifit when it tries to write on a shared anonymous pmd sized entry.
+They can do so by setting up the thp_cow control. The control is only enabled
+when the global THP controls are set to "always" or "madvise" for the
+specific memory region::
+
+::
+
+	echo always >/sys/kernel/mm/transparent_hugepage/thp_cow
+	echo madvise >/sys/kernel/mm/transparent_hugepage/thp_cow
+	echo never >/sys/kernel/mm/transparent_hugepage/thp_cow
+
+always
+	means that the writing process will always do copy on write on
+	the pmd size. If there is no pmd sized folio available, it will
+	fallback to the pte size.
+
+madvise
+	will do things like ``always`` but only for regions that have
+	used madvise(MADV_THP_COW).
+
+never
+	will not do copy on write on the pmd size no matter what setup
+	is done using madvise. When a process writes on a shared anonymous
+	pmd sized entry, it will just allocate a pte sized page and do copy
+	on write on the pte size.
+
 process THP controls
 --------------------
 
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index a0ce8c0b81f5..2a62f0f92f68 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -57,6 +57,8 @@ enum transparent_hugepage_flag {
 	TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG,
 	TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG,
 	TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG,
+	TRANSPARENT_HUGEPAGE_COW_FLAG,
+	TRANSPARENT_HUGEPAGE_REQ_MADV_COW_FLAG,
 };
 
 struct kobject;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1f0d0b780943..babca060feca 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -531,6 +531,44 @@ static ssize_t split_underused_thp_store(struct kobject *kobj,
 static struct kobj_attribute split_underused_thp_attr = __ATTR(
 	shrink_underused, 0644, split_underused_thp_show, split_underused_thp_store);
 
+static ssize_t thp_cow_show(struct kobject *kobj,
+			    struct kobj_attribute *attr, char *buf)
+{
+	const char *output;
+
+	if (test_bit(TRANSPARENT_HUGEPAGE_COW_FLAG, &transparent_hugepage_flags))
+		output = "[always] madvise never";
+	else if (test_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_COW_FLAG,
+			  &transparent_hugepage_flags))
+		output = "always [madvise] never";
+	else
+		output = "always madvise [never]";
+
+	return sysfs_emit(buf, "%s\n", output);
+}
+
+static ssize_t thp_cow_store(struct kobject *kobj,
+			     struct kobj_attribute *attr,
+			     const char *buf, size_t count)
+{
+	ssize_t ret = count;
+
+	if (sysfs_streq(buf, "always")) {
+		clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_COW_FLAG, &transparent_hugepage_flags);
+		set_bit(TRANSPARENT_HUGEPAGE_COW_FLAG, &transparent_hugepage_flags);
+	} else if (sysfs_streq(buf, "madvise")) {
+		clear_bit(TRANSPARENT_HUGEPAGE_COW_FLAG, &transparent_hugepage_flags);
+		set_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_COW_FLAG, &transparent_hugepage_flags);
+	} else if (sysfs_streq(buf, "never")) {
+		clear_bit(TRANSPARENT_HUGEPAGE_COW_FLAG, &transparent_hugepage_flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_COW_FLAG, &transparent_hugepage_flags);
+	} else
+		ret = -EINVAL;
+
+	return ret;
+}
+static struct kobj_attribute thp_cow_attr = __ATTR_RW(thp_cow);
+
 static struct attribute *hugepage_attr[] = {
 	&enabled_attr.attr,
 	&defrag_attr.attr,
@@ -540,6 +578,7 @@ static struct attribute *hugepage_attr[] = {
 	&shmem_enabled_attr.attr,
 #endif
 	&split_underused_thp_attr.attr,
+	&thp_cow_attr.attr,
 	NULL,
 };
 

-- 
2.52.0

