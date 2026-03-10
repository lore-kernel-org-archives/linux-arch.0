Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8CC3E9597
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773174094; cv=none; b=TTWWH5vxjM7rPPPLzbKL6w4HyiH2CBE9e9KSW0Uhf8QfIhXrbVDEB61uSVwSl1h0ooxxJZ597YDEInblh8ZZCfa+m9mMrJB/+SyC58u1WVc59cg/98qqjK758//hI/tVofZ0e7q0hwOpnZw4LfeyzJQno+XoGl9+4dg91fBT1wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773174094; c=relaxed/simple;
	bh=qLXORSt6Biqkafumy/w8uQlCnPelA2T/8GEvFsCbfAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mr1gRUEB6HWaUJB81Zbgv1HNsXQOQu4UkdUwGmrAwEdDJK+ta3OVCgzzhHYxk/AwT0/aM4UszkVMMvx1Vb+dxJ9IUz0hs9uCMiiLNfVTOxjdvLZihGVhOxcgvQli2Z34AYnRQ9YGq7jxMRE9DYmm25G1iVRc0OR/dMG/sZ2PvCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cSKAc1KE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Sp8dv9CE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cSKAc1KE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Sp8dv9CE"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AIkHfa2863148
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:21:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rin5Xzgf9RNm/Gx3a/2HtbrcZkKjggIhMf3Yv3Ghmqo=; b=cSKAc1KERyQjjkOA
	qTajW6Q83Ix/u5Eo0LKOiiBoEeptb7pCB/5odF2wr54RzKSDwm2ZvAH1qbcE7bvL
	888ZY5YbJRAd5+ZbXvznNccWLQNvJDYINVNXrJlChhha/S6KjOCs25AuVQMZS/I+
	IW3ufpqfqgC+m3IVCa7My1xhEC7ecNIzapfE8ftgLSu0ZaKFg4Fmxnnw2k+EzT+9
	i+5yGn0jb2+hNMwFqqHO3SkKe4Htt4NSzxCd6uI6/y9xDdr55bRTv8B1pq++DHtf
	mcckOKiGXNl/58X10nzQET/pv5I2+NglpHcBJlr85o0qksKbZMF1kfx9UYGm9UHC
	dST3QQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cte3wb6hh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:21:32 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-829ad972df6so1786689b3a.3
        for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 13:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773174091; x=1773778891; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rin5Xzgf9RNm/Gx3a/2HtbrcZkKjggIhMf3Yv3Ghmqo=;
        b=Sp8dv9CEk0meJyJpb4DZfCCxM7MPDNqKl6FUa3ebeK3gdw/a/Zz7ipZ74MjMQlhAzQ
         Dx9ItA2P2NylO28don96hLtalSixi5h10xEKdeshswchgxMEe8SBuhKXCNPsBjrkRi3U
         u42oN7vr1/6fzqCvZXYdcfVXDKLdmNfVT/hvdSRzhZpbKo+Ecv5Z7av8fRp8R3v4J/0S
         MpH9GJd0d+n15blG6QgQ/o6uKtFrdXCQgRfdyEsB5laVzl4DXvoZGbRhSTNO7STjQI8x
         VZAVaDE3I15o5Q/zE9qR5YttK1436i1Z8UaiB3xPuI7wpDqqjGrzMpAYcqh74j2V/XBu
         DBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773174091; x=1773778891;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rin5Xzgf9RNm/Gx3a/2HtbrcZkKjggIhMf3Yv3Ghmqo=;
        b=DmOtBhMh5zlgMGE3MCikwTIskT8L5MzpSauLAOsB+88af68VNeW6M9WwP2o/3OTCXT
         2N1ZU88uPi3q/BvQPD845b8vNWYF4iDXDNsyeiAc5eGLjdr/AcmknWEllxaAi57YewKC
         8IK+RpYg0e923khPsHH5GVtHeIb0YtGP0ysoBZEiApfOv0MmRyfsCPpHj1V5mPB4mQ3k
         etMfsgUKOapP0Yb+YwUFylnOYd4eCX7l5xegR98zDNHXGbxslO7yc5IyUHGssg/bpxS9
         6kW7ixLdlbRCLd+Qobjz0oiPY90Fju5zHbvl0FYG1oUgLwLOW27mnc3fni1uusSEloPb
         007A==
X-Forwarded-Encrypted: i=1; AJvYcCU4FrfceEGkVD0uKC3F0tMBYNqPTlzQxpMQ3ofuNgwL8Jz5FMjm8cTWESQBVAygpTEkhEevoOpz/QVK@vger.kernel.org
X-Gm-Message-State: AOJu0YxGgV35EftYg0IbBaM3aFcpxaqcg+d072W8Q1eIzC1aATkz04L+
	R0NQRvodY6rGm2d28bnarAgc6xhnNIhCbZ9LGlJMs+Qc1cFN7csHw2I3FoBGMnYRRmieSea59/f
	ewS82WoC6/RrWBaUHcDergrvTRETy9RvmjaAU41KLl/3BwE80/OcYj0tbcMwZY1Qv
X-Gm-Gg: ATEYQzydKJy52LhuGq2/Nl/7GUJ9IM8LazOmGgkPdG2vJt/wylZhYcEM+6YWNcws3Ia
	ziy2GSmZe3jzDkwJ6cT+/6+lhU4fgqiE0+c4hQSmR2ZKqwSvXNe9eAlnN8uQ86EQJF4iIEr2dHz
	S447+8hn2mC6dNP4CRMjggI3ACKsMw6bVa2jSJSiF9vbYdw7t0odKJVJ2iSGK7yq947pFfRJt5p
	Jz8kcAxXFFPyNR5j2euSvQYTtVdlYSVTZXq4MLQCJsmJjPLY+X5rcVEg5ediBKkntAvDZZu816t
	cuanGU6kWhZ8PPuNw0NdrMQXC/EI6yNkvQUzmVowi2trnPbjq8wZLsPfuXzKF4MT8++aF/Q+EDW
	llOfXnM8RK9BPrVRxLzVrUvuEAjZEIupGuRFvrIk3gwLJ+WF4
X-Received: by 2002:a05:6a00:bc93:b0:823:cbb:a484 with SMTP id d2e1a72fcca58-829f706c200mr175212b3a.14.1773174091203;
        Tue, 10 Mar 2026 13:21:31 -0700 (PDT)
X-Received: by 2002:a05:6a00:bc93:b0:823:cbb:a484 with SMTP id d2e1a72fcca58-829f706c200mr175158b3a.14.1773174090546;
        Tue, 10 Mar 2026 13:21:30 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6dc2d0asm115262b3a.13.2026.03.10.13.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:21:30 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 01:46:05 +0530
Subject: [PATCH v2 21/25] remoteproc: qcom: Move minidump data structures
 into its own header
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-minidump-v2-v2-21-f91cedc6f99e@oss.qualcomm.com>
References: <20260311-minidump-v2-v2-0-f91cedc6f99e@oss.qualcomm.com>
In-Reply-To: <20260311-minidump-v2-v2-0-f91cedc6f99e@oss.qualcomm.com>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
        Eugen Hristev <eugen.hristev@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Kees Cook <kees@kernel.org>, Brendan Jackman <jackmanb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
        Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>,
        Youngjun Park <youngjun.park@lge.com>, Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14-dev-f7c49
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773173756; l=5406;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=KXQCMJRLCbRonZvqZxJyWcxsG8bFtO60YADpZ72A4+g=;
 b=7x0MeE/624UBgwaYA8d01C2eHOaPSi5LvmpDqTC0RDeXSdnY95KEknozT67woVS1EZWsgkcpb
 kHF12b/JwLyAxBxitovgKsNVTm6BUP7AGvDHLNONgLVcKcqhMzi7W9d
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE3NyBTYWx0ZWRfX+uw3nj/+mYnE
 z5vM9GUALYBjlkeRIHdqvD16s+GBUNUaW4HTy7EhNxnWsdmE0oI7CX0KYewg36x4jgOe+scfxl8
 ffLTJ4KkymMh6N+TQfCzcijw6RKB7LC1kdd7Eq0aH9AO9a5HJoBmCM9EjHfTykFgoCxKBgZKF1d
 ESO12jpnRcZhzkgN3a3VNiKq/TniAgJWwBqnZNqqNoDdimkMNy3PX2HQtQM20VYVgPKy/kEOuyf
 ghJjQwm8+UU5TU3U9p6eEPyKG46mX9kooU14nXmNjq8lWn3yT9IGHv/gZCfnWWoUkBQ+gljQrOY
 hZxBJoTuCFOZa4phQqLGppePolFsYyVRi3WpcbrshF07p7JQ1oKdeYHnOltRlSO7lm2igeb77nB
 2Mu/enowMHy/u7uOT3VFpL7xpOlwvTD40FOB0KowFlJV2b613ME13Pw0fS6Urggt/MDzNS6ngRP
 f3YFTWHXkyeowVTdexw==
X-Authority-Analysis: v=2.4 cv=GtFPO01C c=1 sm=1 tr=0 ts=69b07d4c cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=NM4Q4TbMW06K43K3HisA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: yrusbUPXc_IjDzE_g0-LMZOOmGtm6EAW
X-Proofpoint-GUID: yrusbUPXc_IjDzE_g0-LMZOOmGtm6EAW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100177

From: Eugen Hristev <eugen.hristev@linaro.org>

Move the minidump data structures into its own header such that it can
be reused by other drivers. No functional change.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/remoteproc/qcom_common.c  | 56 +-------------------------------
 include/linux/soc/qcom/minidump.h | 68 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 55 deletions(-)

diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
index 6c31140268ac..864c89f060b1 100644
--- a/drivers/remoteproc/qcom_common.c
+++ b/drivers/remoteproc/qcom_common.c
@@ -18,6 +18,7 @@
 #include <linux/rpmsg/qcom_smd.h>
 #include <linux/slab.h>
 #include <linux/soc/qcom/mdt_loader.h>
+#include <linux/soc/qcom/minidump.h>
 #include <linux/soc/qcom/smem.h>
 
 #include "remoteproc_internal.h"
@@ -28,61 +29,6 @@
 #define to_ssr_subdev(d) container_of(d, struct qcom_rproc_ssr, subdev)
 #define to_pdm_subdev(d) container_of(d, struct qcom_rproc_pdm, subdev)
 
-#define MAX_NUM_OF_SS           10
-#define MAX_REGION_NAME_LENGTH  16
-#define SBL_MINIDUMP_SMEM_ID	602
-#define MINIDUMP_REGION_VALID		('V' << 24 | 'A' << 16 | 'L' << 8 | 'I' << 0)
-#define MINIDUMP_SS_ENCR_DONE		('D' << 24 | 'O' << 16 | 'N' << 8 | 'E' << 0)
-#define MINIDUMP_SS_ENABLED		('E' << 24 | 'N' << 16 | 'B' << 8 | 'L' << 0)
-
-/**
- * struct minidump_region - Minidump region
- * @name		: Name of the region to be dumped
- * @seq_num:		: Use to differentiate regions with same name.
- * @valid		: This entry to be dumped (if set to 1)
- * @address		: Physical address of region to be dumped
- * @size		: Size of the region
- */
-struct minidump_region {
-	char	name[MAX_REGION_NAME_LENGTH];
-	__le32	seq_num;
-	__le32	valid;
-	__le64	address;
-	__le64	size;
-};
-
-/**
- * struct minidump_subsystem - Subsystem's SMEM Table of content
- * @status : Subsystem toc init status
- * @enabled : if set to 1, this region would be copied during coredump
- * @encryption_status: Encryption status for this subsystem
- * @encryption_required : Decides to encrypt the subsystem regions or not
- * @region_count : Number of regions added in this subsystem toc
- * @regions_baseptr : regions base pointer of the subsystem
- */
-struct minidump_subsystem {
-	__le32	status;
-	__le32	enabled;
-	__le32	encryption_status;
-	__le32	encryption_required;
-	__le32	region_count;
-	__le64	regions_baseptr;
-};
-
-/**
- * struct minidump_global_toc - Global Table of Content
- * @status : Global Minidump init status
- * @md_revision : Minidump revision
- * @enabled : Minidump enable status
- * @subsystems : Array of subsystems toc
- */
-struct minidump_global_toc {
-	__le32				status;
-	__le32				md_revision;
-	__le32				enabled;
-	struct minidump_subsystem	subsystems[MAX_NUM_OF_SS];
-};
-
 struct qcom_ssr_subsystem {
 	const char *name;
 	struct srcu_notifier_head notifier_list;
diff --git a/include/linux/soc/qcom/minidump.h b/include/linux/soc/qcom/minidump.h
new file mode 100644
index 000000000000..25247a6216e2
--- /dev/null
+++ b/include/linux/soc/qcom/minidump.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Qualcomm Minidump definitions
+ *
+ * Copyright (C) 2016 Linaro Ltd
+ * Copyright (C) 2015 Sony Mobile Communications Inc
+ * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef __QCOM_MINIDUMP_H__
+#define __QCOM_MINIDUMP_H__
+
+#define MAX_NUM_OF_SS           10
+#define MAX_REGION_NAME_LENGTH  16
+#define SBL_MINIDUMP_SMEM_ID	602
+#define MINIDUMP_REGION_VALID		('V' << 24 | 'A' << 16 | 'L' << 8 | 'I' << 0)
+#define MINIDUMP_SS_ENCR_DONE		('D' << 24 | 'O' << 16 | 'N' << 8 | 'E' << 0)
+#define MINIDUMP_SS_ENABLED		('E' << 24 | 'N' << 16 | 'B' << 8 | 'L' << 0)
+
+/**
+ * struct minidump_region - Minidump region
+ * @name		: Name of the region to be dumped
+ * @seq_num:		: Use to differentiate regions with same name.
+ * @valid		: This entry to be dumped (if set to 1)
+ * @address		: Physical address of region to be dumped
+ * @size		: Size of the region
+ */
+struct minidump_region {
+	char	name[MAX_REGION_NAME_LENGTH];
+	__le32	seq_num;
+	__le32	valid;
+	__le64	address;
+	__le64	size;
+};
+
+/**
+ * struct minidump_subsystem - Subsystem's SMEM Table of content
+ * @status : Subsystem toc init status
+ * @enabled : if set to 1, this region would be copied during coredump
+ * @encryption_status: Encryption status for this subsystem
+ * @encryption_required : Decides to encrypt the subsystem regions or not
+ * @region_count : Number of regions added in this subsystem toc
+ * @regions_baseptr : regions base pointer of the subsystem
+ */
+struct minidump_subsystem {
+	__le32	status;
+	__le32	enabled;
+	__le32	encryption_status;
+	__le32	encryption_required;
+	__le32	region_count;
+	__le64	regions_baseptr;
+};
+
+/**
+ * struct minidump_global_toc - Global Table of Content
+ * @status : Global Minidump init status
+ * @md_revision : Minidump revision
+ * @enabled : Minidump enable status
+ * @subsystems : Array of subsystems toc
+ */
+struct minidump_global_toc {
+	__le32				status;
+	__le32				md_revision;
+	__le32				enabled;
+	struct minidump_subsystem	subsystems[MAX_NUM_OF_SS];
+};
+
+#endif

-- 
2.50.1

