Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93603E92BE
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773174112; cv=none; b=Kpc68lGa6W6YLHpPpVm8oZ5Be9rudY+0iULH/awlFvLH+pSYVT/8nI+H0r9u8WyLZ6r39i7w/eKQ2IX5lu+kD5gfl34rbqpPkJrSVJCElHQulvfKH3PI7JDr8BAOvv7h7QAy94yiknXgXxqkrqBFcWRn1S6o+wYJDk21gKO9Rw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773174112; c=relaxed/simple;
	bh=dPaYhz5WrNn4l2Exbmn17f/435P8WoEizkP3B6PTFzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JAyRQOhqSV+SXf7h3IkSWLuhHFYnuUkNZgniJZ7AKyedt6Cxy8tKchag+GgEqXYRp6GgKS/7HTk4HLteCWst5JObw90I0OQakmXhf9oLhZ8TsEQkSAtYkjMQytvdO6bBXxzKOUPM0J6+YPTcHMlckKatg0mnSslnDsS1ztnc09A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HQL1QpS6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EUHcgmeo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HQL1QpS6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EUHcgmeo"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AHcrxf2179348
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:21:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VCdzm9lFxRWxv/OGB66sjGQmhg7GtSvSgtFyJmtFvU8=; b=HQL1QpS6PGBC/FZA
	PX4YjsgO0EBnSchfNwcBS3m6TU+NNlCLcGrQtQkorNh0FzaHM5W1qBUSH4t40Ywe
	rnqKPE+bKNZHgqY6cQwf4xlvZZWCp452mWOUukXFDr0W7J54/mR69MCA3ZBbLonf
	/r1SEgJueONA3Z83MxDPYnNQIwaW3hnRpauSnUkZh7U9UoVPrYU2J/tcDo7QurKO
	wSAkOiSXKoaEchsvNOOrD/jiFQaBVl6utpry/KlB+nytq6sReLZ5m7oxRucUenoE
	NsMcKBaLuf/yCIWvjHH7ul8NkWRIdrXIa0DVm0Olsw2A8tyt4D9vZ4VeTQZGe++R
	9biJ7Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctqvsrkcm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:21:48 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b62da7602a0so8030147a12.2
        for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 13:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773174108; x=1773778908; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VCdzm9lFxRWxv/OGB66sjGQmhg7GtSvSgtFyJmtFvU8=;
        b=EUHcgmeo9Mj1muhpQy5B9BiLL/WBo2xjeLfeRaVZUS4WemEJHKAc6CuEojlGuUCZP8
         CX8E1Cm7Hy4fdCUgBFJ6wZj7bKYZB8t+CXjem434xZrnHu/oZAyApS4eWxldxkXelmMM
         5fcD1TdqOmi6xtxWGwfPXhe1wBIGstJOGGDIR29rBJheIYsx33vkGVrnx4Bl5fZwG5sV
         PBBp4fzFrD3eZHRn6mSSWvsdWuXXX+UoYsq/UpioE7fDXxL5aiOfXYJhObcDWBCdbb9i
         ID8I0jOSGvCFaIrAumUZhjTzGlsMJ174/6tSDOl+f/tA437kZgDb7x8JK/ZZcgXhe9us
         zT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773174108; x=1773778908;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VCdzm9lFxRWxv/OGB66sjGQmhg7GtSvSgtFyJmtFvU8=;
        b=a1/AdbjjBMtfBusgbb1l3FiOTR5lPHjiCHcUrjJcCqlp83ngbFj9d+ErdX/RqJ/5dH
         uVsvEvi8BKSgL7+Hi5pFpgTvBbj7Yeh4jzkjceaEUoaqaIiouBK86KyZKELRTGu7yG5B
         8o3h4b9ttMVxSDpt0B+OpiJYe5SUNVeyQY75jKM0KgregWXhXMM1QSIGAWFV8RXHtC9d
         H1IiX1TkSTgcAJf9yvuedSqhJjsdANCPP9WI0TZk0xmWBnFKEL/fbRGjSZPu82omgswQ
         g+OhcxiCZAsfntbJePw+ZH4YiB9gNbQ8CbJWOj3IMy7C/JSKJKGi1RSa4BFifSu/FT1u
         mjGw==
X-Forwarded-Encrypted: i=1; AJvYcCVnANin1oPrX8qrZfUfRgyVJqILAJoVGLbE7bQ2TY38wY+UuWgB1UKW/A4ZRnQ4p5qjAzvc1iry+yRX@vger.kernel.org
X-Gm-Message-State: AOJu0YyIV5K4o9qij2XbkBVEc+Zn2j902+o9cSqh8GwUwUHtGUctziUl
	TNxx4AK+v/memjo3OL00pB/72y/GpzeFWWP3dXOkVU7BMYyxPS82m3SbbSQ7pDCxvHkr/wYtJFg
	Ry1eOgUWpZGKeSwvIJgLfEGdrQfJ4wBlSl6c6Qv9qJqAeZPR7WyzeLasTtomtloSR
X-Gm-Gg: ATEYQzwk+KnEq7NxsV4V9W2MBcXLmVgbh80fWww2RICXYxr+tXuN8ytiofagy/YB2fv
	PHKd3kCedWrSTh+4bhnsBYlyV5R2u85GayUzajcESW+WgfQ09ev777uepyPVmtcKVGsTqvvCXvw
	K8fV4RJzvfIFFa7001DmEgjbmmLNmSAuoWOEbG0kje3O+rq1OnEFtZfOc6CSkBknt0XUNAmKFEt
	HNS5RLuly/4CeZzSsOKX31jlhvPe6F/iipwLOsdxzwA45BKRkO74+ayMG4ThIaQDf7X9TFPUG60
	OfhOpIZc7shvWjNEIMulmMYzqijXdcgtjpXdQBkZL02NtbgW3bxNFMzD0I1jnmPY6gEpLHG21Ei
	Xkl6qqmFyoIMrV4IjOLSn5qg5VoxPr2irmE4o/TXI8AJ+KfcE
X-Received: by 2002:a05:6a00:4b10:b0:81f:4dfe:ddd5 with SMTP id d2e1a72fcca58-829f70733aamr147816b3a.4.1773174107393;
        Tue, 10 Mar 2026 13:21:47 -0700 (PDT)
X-Received: by 2002:a05:6a00:4b10:b0:81f:4dfe:ddd5 with SMTP id d2e1a72fcca58-829f70733aamr147769b3a.4.1773174106642;
        Tue, 10 Mar 2026 13:21:46 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6dc2d0asm115262b3a.13.2026.03.10.13.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:21:46 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 01:46:06 +0530
Subject: [PATCH v2 22/25] soc: qcom: Add minidump backend driver
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-minidump-v2-v2-22-f91cedc6f99e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773173756; l=10956;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=RDT7v6bqYk5bgglut/PG+8UNw5M1qTcxV6gcC7IX5m8=;
 b=6AemMMzEj5Dcxm3yu8ESj11geNVlW4Nj1GEwJAOJ9eDH9gXDzgGOuIBfr3oWn4RQBrTsomaxJ
 Id1S77WZvDVDh1w7OTBnW+ynij8GaYSu7aKk6/IJZndYW8gs6ezdeuh
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE3NyBTYWx0ZWRfX8F2IwjloxG7O
 bStA3cB5TMi4trj91Ae827EkiuTpstpu/E1QbZ6kzwCx96TjtrJcE3VaSqeMIPcvhWLLIICqTbJ
 zC3eavsDVzkNgdz2nHHsFlQK42WnxnFs/J/GI524HCdHmcK/YWar13TZ/ss8EMAP6HDoCISbtHd
 fzjTXNpYf7Ga7tnxRcGHH+pFuVUOY6QYqTp2ObPfplWDVZzhnH4L2e+4ZRQKoAj6O7WapwH/UJa
 OAJ2XcsNaUbTDuRHzBuIjjwkUtJ3E7XYIlukSpaaP3LTvHcRKbwnc9M1OQd0ZJKgBYR7PU1cAlW
 aen8ZxR3kJ23oqpQ9vtIDJJGb6I9KJ5fKkElmSyXoMNjemPyVaZLvD/16aGT/Lex5Nx0LZp80RP
 +KpCUVJ+DVwbvir+UNWSN34uvWXFYp49bCmEXjp4dM4IpMoCXAFg2EUausi8UVF5jKNapYDcr94
 l4YxNMyMYF2bb9tCWIQ==
X-Proofpoint-ORIG-GUID: azDCOW-32jDhwV6n_I13RH4wHJ2UnL4o
X-Authority-Analysis: v=2.4 cv=Lo2fC3dc c=1 sm=1 tr=0 ts=69b07d5c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=nZcrojPlbim1gEWq_fIA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: azDCOW-32jDhwV6n_I13RH4wHJ2UnL4o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100177

From: Eugen Hristev <eugen.hristev@linaro.org>

Qualcomm Minidump is a backend driver that manages the minidump shared
memory table on Qualcomm platforms. It uses the meminspect table that
it parses in order to obtain inspection entries from the kernel and
convert them into regions. Regions are afterwards being registered into
the shared memory's Minidump table of contents. Further, Qualcomm boot
firmware can read the table of contents and dump the memory accordingly,
as per the firmware requirements.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/soc/qcom/Kconfig          |  13 ++
 drivers/soc/qcom/Makefile         |   1 +
 drivers/soc/qcom/minidump.c       | 272 ++++++++++++++++++++++++++++++++++++++
 include/linux/soc/qcom/minidump.h |   4 +
 4 files changed, 290 insertions(+)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 2caadbbcf830..be768537528e 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -180,6 +180,19 @@ config QCOM_SMEM
 	  The driver provides an interface to items in a heap shared among all
 	  processors in a Qualcomm platform.
 
+config QCOM_MINIDUMP
+	tristate "Qualcomm Minidump memory inspection driver"
+	depends on ARCH_QCOM || COMPILE_TEST
+	depends on QCOM_SMEM
+	help
+	  Say y here to enable the Qualcomm Minidump memory inspection driver.
+	  This driver uses memory inspection mechanism to register minidump
+	  regions with the Qualcomm firmware, into the shared memory.
+	  The registered regions are being linked into the minidump table
+	  of contents.
+	  Further on, the firmware will be able to read the table of contents
+	  and extract the memory regions on case-by-case basis.
+
 config QCOM_SMD_RPM
 	tristate "Qualcomm Resource Power Manager (RPM) over SMD"
 	depends on ARCH_QCOM || COMPILE_TEST
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index b7f1d2a57367..3e5a2cacccd4 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -25,6 +25,7 @@ qcom_rpmh-y			+= rpmh.o
 obj-$(CONFIG_QCOM_SMD_RPM)	+= rpm-proc.o smd-rpm.o
 obj-$(CONFIG_QCOM_SMEM) +=	smem.o
 obj-$(CONFIG_QCOM_SMEM_STATE) += smem_state.o
+obj-$(CONFIG_QCOM_MINIDUMP)	+= minidump.o
 CFLAGS_smp2p.o := -I$(src)
 obj-$(CONFIG_QCOM_SMP2P)	+= smp2p.o
 obj-$(CONFIG_QCOM_SMSM)	+= smsm.o
diff --git a/drivers/soc/qcom/minidump.c b/drivers/soc/qcom/minidump.c
new file mode 100644
index 000000000000..8d2e5047b5d9
--- /dev/null
+++ b/drivers/soc/qcom/minidump.c
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Qualcomm Minidump kernel inspect driver
+ * Copyright (C) 2016,2024-2025 Linaro Ltd
+ * Copyright (C) 2015 Sony Mobile Communications Inc
+ * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/notifier.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+#include <linux/soc/qcom/smem.h>
+#include <linux/soc/qcom/minidump.h>
+#include <linux/meminspect.h>
+
+/**
+ * struct minidump - Minidump driver data information
+ *
+ * @dev:	Minidump device struct.
+ * @toc:	Minidump table of contents subsystem.
+ * @regions:	Minidump regions array.
+ * @nb:		Notifier block to register to meminspect.
+ */
+struct minidump {
+	struct device			*dev;
+	struct minidump_subsystem	*toc;
+	struct minidump_region		*regions;
+	struct notifier_block		nb;
+};
+
+static const char * const meminspect_id_to_md_string[] = {
+	"",
+	"ELF",
+	"vmcoreinfo",
+	"config",
+	"totalram",
+	"cpu_possible",
+	"cpu_present",
+	"cpu_online",
+	"cpu_active",
+	"mem_section",
+	"jiffies",
+	"linux_banner",
+	"nr_threads",
+	"nr_irqs",
+	"tainted_mask",
+	"taint_flags",
+	"node_states",
+	"__per_cpu_offset",
+	"nr_swapfiles",
+	"init_uts_ns",
+	"printk_rb_static",
+	"printk_rb_dynamic",
+	"prb",
+	"prb_descs",
+	"prb_infos",
+	"prb_data",
+	"high_memory",
+	"init_mm",
+	"init_mm_pgd",
+};
+
+/**
+ * qcom_md_table_init() - Initialize the minidump table
+ * @md: minidump data
+ * @mdss_toc: minidump subsystem table of contents
+ *
+ * Return: On success, it returns 0 and negative error value on failure.
+ */
+static int qcom_md_table_init(struct minidump *md,
+			      struct minidump_subsystem *mdss_toc)
+{
+	md->toc = mdss_toc;
+	md->regions = devm_kcalloc(md->dev, MAX_NUM_REGIONS,
+				   sizeof(*md->regions), GFP_KERNEL);
+	if (!md->regions)
+		return -ENOMEM;
+
+	md->toc->regions_baseptr = cpu_to_le64(virt_to_phys(md->regions));
+	md->toc->enabled = cpu_to_le32(MINIDUMP_SS_ENABLED);
+	md->toc->status = cpu_to_le32(1);
+	md->toc->region_count = cpu_to_le32(0);
+
+	/* Tell bootloader not to encrypt the regions of this subsystem */
+	md->toc->encryption_status = cpu_to_le32(MINIDUMP_SS_ENCR_DONE);
+	md->toc->encryption_required = cpu_to_le32(MINIDUMP_SS_ENCR_NOTREQ);
+
+	return 0;
+}
+
+/**
+ * qcom_md_get_region_index() - Lookup minidump region by id
+ * @md: minidump data
+ * @id: minidump region id
+ *
+ * Return: On success, it returns the internal region index, on failure,
+ *	returns	negative error value
+ */
+static int qcom_md_get_region_index(struct minidump *md, int id)
+{
+	unsigned int count = le32_to_cpu(md->toc->region_count);
+	unsigned int i;
+
+	for (i = 0; i < count; i++)
+		if (md->regions[i].seq_num == id)
+			return i;
+
+	return -ENOENT;
+}
+
+/**
+ * register_md_region() - Register a new minidump region
+ * @priv: private data
+ * @e: pointer to inspect entry
+ *
+ * Return: None
+ */
+static void __maybe_unused register_md_region(void *priv,
+					      const struct inspect_entry *e)
+{
+	unsigned int num_region, region_cnt;
+	const char *name = "unknown";
+	struct minidump_region *mdr;
+	struct minidump *md = priv;
+
+	if (!(e->va || e->pa) || !e->size) {
+		dev_dbg(md->dev, "invalid region requested\n");
+		return;
+	}
+
+	if (e->id < ARRAY_SIZE(meminspect_id_to_md_string))
+		name = meminspect_id_to_md_string[e->id];
+
+	if (qcom_md_get_region_index(md, e->id) >= 0) {
+		dev_dbg(md->dev, "%s:%d region is already registered\n",
+			name, e->id);
+		return;
+	}
+
+	/* Check if there is a room for a new entry */
+	num_region = le32_to_cpu(md->toc->region_count);
+	if (num_region >= MAX_NUM_REGIONS) {
+		dev_dbg(md->dev, "maximum region limit %u reached\n",
+			num_region);
+		return;
+	}
+
+	region_cnt = le32_to_cpu(md->toc->region_count);
+	mdr = &md->regions[region_cnt];
+	scnprintf(mdr->name, MAX_REGION_NAME_LENGTH, "K%.8s", name);
+	mdr->seq_num = e->id;
+	if (e->pa)
+		mdr->address = cpu_to_le64(e->pa);
+	else if (e->va)
+		mdr->address = cpu_to_le64(__pa(e->va));
+	mdr->size = cpu_to_le64(ALIGN(e->size, 4));
+	mdr->valid = cpu_to_le32(MINIDUMP_REGION_VALID);
+	region_cnt++;
+	md->toc->region_count = cpu_to_le32(region_cnt);
+
+	dev_dbg(md->dev, "%s:%d region registered %llx:%llx\n",
+		mdr->name, mdr->seq_num, mdr->address, mdr->size);
+}
+
+/**
+ * unregister_md_region() - Unregister a previously registered minidump region
+ * @priv: private data
+ * @e: pointer to inspect entry
+ *
+ * Return: None
+ */
+static void __maybe_unused unregister_md_region(void *priv,
+						const struct inspect_entry *e)
+{
+	struct minidump_region *mdr;
+	struct minidump *md = priv;
+	unsigned int region_cnt;
+	unsigned int idx;
+
+	idx = qcom_md_get_region_index(md, e->id);
+	if (idx < 0) {
+		dev_dbg(md->dev, "%d region is not present\n", e->id);
+		return;
+	}
+
+	mdr = &md->regions[0];
+	region_cnt = le32_to_cpu(md->toc->region_count);
+
+	/*
+	 * Left shift one position all the regions located after the
+	 * region being removed, in order to fill the gap.
+	 * Then, zero out the last region at the end.
+	 */
+	memmove(&mdr[idx], &mdr[idx + 1], (region_cnt - idx - 1) * sizeof(*mdr));
+	memset(&mdr[region_cnt - 1], 0, sizeof(*mdr));
+	region_cnt--;
+	md->toc->region_count = cpu_to_le32(region_cnt);
+}
+
+static int qcom_md_notifier_cb(struct notifier_block *nb,
+			       unsigned long code, void *entry)
+{
+	struct minidump *md = container_of(nb, struct minidump, nb);
+
+	if (code == MEMINSPECT_NOTIFIER_ADD)
+		register_md_region(md, entry);
+	else if (code == MEMINSPECT_NOTIFIER_REMOVE)
+		unregister_md_region(md, entry);
+
+	return 0;
+}
+
+static int qcom_md_probe(struct platform_device *pdev)
+{
+	struct minidump_global_toc *mdgtoc;
+	struct device *dev = &pdev->dev;
+	struct minidump *md;
+	size_t size;
+	int ret;
+
+	md = devm_kzalloc(dev, sizeof(*md), GFP_KERNEL);
+	if (!md)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, md);
+
+	md->dev = dev;
+	md->nb.notifier_call = qcom_md_notifier_cb;
+
+	mdgtoc = qcom_smem_get(QCOM_SMEM_HOST_ANY, SBL_MINIDUMP_SMEM_ID, &size);
+	if (IS_ERR(mdgtoc)) {
+		ret = PTR_ERR(mdgtoc);
+		dev_err_probe(dev, ret, "Couldn't find minidump smem item\n");
+	}
+
+	if (size < sizeof(*mdgtoc) || !mdgtoc->status)
+		dev_err_probe(dev, -EINVAL, "minidump table not ready\n");
+
+	ret = qcom_md_table_init(md, &mdgtoc->subsystems[MINIDUMP_SUBSYSTEM_APSS]);
+	if (ret)
+		dev_err_probe(dev, ret, "Could not initialize table\n");
+
+	meminspect_notifier_register(&md->nb);
+
+	meminspect_lock_traverse(md, register_md_region);
+	return 0;
+}
+
+static void qcom_md_remove(struct platform_device *pdev)
+{
+	struct minidump *md = platform_get_drvdata(pdev);
+
+	meminspect_notifier_unregister(&md->nb);
+	meminspect_lock_traverse(md, unregister_md_region);
+}
+
+static struct platform_driver qcom_md_driver = {
+	.probe = qcom_md_probe,
+	.remove = qcom_md_remove,
+	.driver  = {
+		.name = "qcom-minidump",
+	},
+};
+
+module_platform_driver(qcom_md_driver);
+
+MODULE_AUTHOR("Eugen Hristev <eugen.hristev@linaro.org>");
+MODULE_AUTHOR("Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>");
+MODULE_DESCRIPTION("Qualcomm minidump inspect driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/soc/qcom/minidump.h b/include/linux/soc/qcom/minidump.h
index 25247a6216e2..f90b61feb550 100644
--- a/include/linux/soc/qcom/minidump.h
+++ b/include/linux/soc/qcom/minidump.h
@@ -10,12 +10,16 @@
 #ifndef __QCOM_MINIDUMP_H__
 #define __QCOM_MINIDUMP_H__
 
+#define MINIDUMP_SUBSYSTEM_APSS	0
 #define MAX_NUM_OF_SS           10
 #define MAX_REGION_NAME_LENGTH  16
 #define SBL_MINIDUMP_SMEM_ID	602
 #define MINIDUMP_REGION_VALID		('V' << 24 | 'A' << 16 | 'L' << 8 | 'I' << 0)
 #define MINIDUMP_SS_ENCR_DONE		('D' << 24 | 'O' << 16 | 'N' << 8 | 'E' << 0)
+#define MINIDUMP_SS_ENCR_NOTREQ		(0 << 24 | 0 << 16 | 'N' << 8 | 'R' << 0)
 #define MINIDUMP_SS_ENABLED		('E' << 24 | 'N' << 16 | 'B' << 8 | 'L' << 0)
+#define MAX_NUM_REGIONS		201
+
 
 /**
  * struct minidump_region - Minidump region

-- 
2.50.1

