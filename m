Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C8C3E95BB
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773174064; cv=none; b=fGR6B10IaknUvCq4sC3uEvcIoeP6lclrnCqC4MxHg1U+ZAJ9XN5H8gofOCPUvNJsJyF9yeB72DzNQOr0axGMfMRlayiETQCUEjZtSBmgf1Z16ji8PY6u+pQK68Tu72alX+fDcJNjVPbVyAX77eCrc2y9rHPaTcdbCLp4E320Sfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773174064; c=relaxed/simple;
	bh=s2cfwUngtIxx2eV9eH8Dr8bBdhICSaTG0klgQVpqdHo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V9Z3NjeQZzbPMNSQTgiVBiS8ENOfL60MUeEg4PY0UAnewN52tqsYZZv4idPyBZLcVcMzYs4Zh6aKvOvPFFNuT0lfDlwcmemakLbFpXHfNkHJnt9GxnZvh1MUelLjgti/GGLKxbh0e0BcuxIUTuNVRUO3vXg/185UhyrI4xJ1Kqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WsqaEFjE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cOwEwySQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WsqaEFjE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cOwEwySQ"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AHbU06248694
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:21:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8G6ao9c6IrCim/s3l50tkoj/aPJ0c8mCOq1F3OVXebw=; b=WsqaEFjERT7rg3s3
	Wxh4C+QCKApqmb0SH31sntHGAvWc+qf8wmPqySjMHCo1jeHhJI60NHr0zphUZWHZ
	GQosGveeaBtzUWQ7Q1IAkpdoK9yn08lEhaKJWCAufgufRB6Ior1EGFC2N09sczDb
	7/cx2WLOHllX2osb3iSyttxtVaavlxwEtzl9WjPZXcdjz6WFzIgmYLhGX8eL3AlF
	/KnH3dlStqUuteY6tdTF03fh8MY/DmVq9JpR31DcLm3GeTOhb3PIoEXaBkV+t5P7
	AE2LZZ/2jv+N4eRLEYL00c4jqi+yORHOQGiMaJOCJND+Gilvla1St3elnPg4ssDz
	G0nEOg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctqv10k89-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:21:01 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-358f058973fso13205087a91.1
        for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 13:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773174061; x=1773778861; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8G6ao9c6IrCim/s3l50tkoj/aPJ0c8mCOq1F3OVXebw=;
        b=cOwEwySQsAqF4BoYtofEMNrj0/hVrqVwtd6ZYRpYaRcSgeM0fZ7fq/UQV0sEVaVN7f
         lLgg8NFJzxRdKxy/x64a79N9sKKtVxIyGObTniSYfTXs/C6klVZTPvFxblOki5q5oxI+
         A0zmq8HlK3rj+hpELqRWIXOTT8SMEhLNRXWgjJn5Y8PVeoaGXOY2+85APUHB0cNHUd+I
         bgLSHRgHMhXNCBSnpV5vbIB68njEqa4ecGWxl7CsDi2z1LBk4ZmtUCOJsp9EANnV9urM
         6sstr7rMonFDMQHClIH69fFQKxXT7oVvBsZGPB9k8E9yqfkU7LNbd3g07bWNkl5ejwer
         cAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773174061; x=1773778861;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8G6ao9c6IrCim/s3l50tkoj/aPJ0c8mCOq1F3OVXebw=;
        b=XVI3CB2fxI57ykBCez3V2/faj3/gfzuQ5yPVkZXAqwOnds1bNGrNgI1sLrn/W3kiqF
         7PXA7YdmNSMoWJQMLMBPNIEa+jsDRMuvrbDbb69XVVM31lWPVkZNfYvHU5wWr/JMY2Zv
         YIn3dYP6bMGZWf29nPDV1wOzey1Zvc7vK7g4NGyUKgr+oJ07cYnTRA8S7Uj5TdEFWx+o
         NjzJmZpv8DTV3DbmU4xkR4mx7qAyAiniCwFQj9WFQa7nNKQ/OX70Y1JmNUO7K8yClVKt
         OnzOqEJXs+ikoypGkoH7Pt1Dne4e9Z/HKvymrmymJmBK5nwDs18DUgontB2PVYtf6oHF
         lKEw==
X-Forwarded-Encrypted: i=1; AJvYcCW1ZWJZXXX1mvalyKCxC7YkLQM519p0CilnSioYkFlazOgexPe9nrqXqz0zI2CxVGnLdLaWxH/nb0eL@vger.kernel.org
X-Gm-Message-State: AOJu0YxWbE35hUjWU+skqO6KGA/zNvh7yxCYkY8Kyx1ITVxsEKQGp7RF
	LwfjjQYU3tF9Wt2+OPz3TA59AFAkanVHcjBYjpm4tSbltjZ5kWWnmdUN/1pN8lJnPIUpy6jcRpv
	SHfJzvbpSAZAeN0aArvRcl311X/Fy2BJPmOi8heGalVAq5Wbo91jvxig1AcEmo6rW
X-Gm-Gg: ATEYQzysczOCacqnvmvTcwrYGCwxiFPCOTV1qEd/yH9FQkYMZAKh+vYgC9PKjbUY5VL
	U5h3N1jD8RW7wmyBW/Ybn8WntRiLkPGuVheVa8AvPHTegc1owMywJOWnXVUBEzovPrcOGx5353Y
	twYokvAOS3NPfeCBXrPrM9ajLkbZDbmuurCZJgVipISbPIyysn9mfZEW0iv25VGinXU5R2Djuw+
	J/he6UQ+L7gn1k9mOzCRBsh/ERi0ddMPr2VpZJv9BsKZU9p7SIYglBdvRBnSPFvHUlSpWFLoaRZ
	wxjcgjV+CQeLABSfuItD/wShjWUt1bXwQ3Yu2G0yjdlPT01s2yHSkaTo2D6l3w4HOggKOwp5jvc
	gjUkYWK1uSt88hUlDDmQzQ5xVGxuy6B/i/LzTV+Z5NoMntNLi
X-Received: by 2002:a05:6a21:a97:b0:398:b5c0:587 with SMTP id adf61e73a8af0-398b5c00764mr2440415637.42.1773174060654;
        Tue, 10 Mar 2026 13:21:00 -0700 (PDT)
X-Received: by 2002:a05:6a21:a97:b0:398:b5c0:587 with SMTP id adf61e73a8af0-398b5c00764mr2440378637.42.1773174060015;
        Tue, 10 Mar 2026 13:21:00 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6dc2d0asm115262b3a.13.2026.03.10.13.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:20:59 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 01:46:03 +0530
Subject: [PATCH v2 19/25] mm/sparse: Register information into meminspect
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-minidump-v2-v2-19-f91cedc6f99e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773173756; l=1623;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=s2cfwUngtIxx2eV9eH8Dr8bBdhICSaTG0klgQVpqdHo=;
 b=xNEeXQa/cNWC1GXYckGzvwIw/v3hCspjDsNkZyY1zYhqsFA/V37X9XsQTlN0zIgnx7o5WUfXP
 T8fHWKWsvkND5KTzL/sjt54KQs43AGyHROp1bjPiWExrBXQcpTK+mk+
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE3NyBTYWx0ZWRfX/Lma/zsqK+EE
 GMuEskTCLd1AnBS6RwZ3z/D77xFuWjN3HSj7WlIMjpXndKnJeg3LHTWxMBrHPFTSU0i+oSPYJqk
 irJ/rVlKS5X4YjAadG8Qma9qyEIm2bTUh2p+jGeQIRwxMVBA+8GR809eHb54p8dhHe4NDJsFVJE
 9LDHxuAB90M2QFZTBujmhKEi6wrozw/WjpDaSqhrqIquSa+sv/hTBgv6w1rd51wMEEWtVfHhqmz
 1/429Sc/8CGEH1DyXJlemJqdzy4OdgtjSNAFKx8pYfQ4Zh0HHaDjhUq0uBTTz2u2YabgSDk6eGY
 59fQs5y63IRqI7jvZPCJHSnbRZwmMCR3URwhUZWmX9xdieo3il8HKtbsSexPrpAONyaqZXizTIM
 lNsfQxDBEm0+naWbX3ECc+4zbjKDI3mQHCcZUPQeNmcB5M3BdTaLWvLDzb0u0qPyXs5Q/6os5cK
 laPCkpkx6lCbnhdbHBw==
X-Proofpoint-GUID: eSECIcNjIM25OQBuJ4vRGy2w3vum67i9
X-Authority-Analysis: v=2.4 cv=S5vUAYsP c=1 sm=1 tr=0 ts=69b07d2d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=hPKMzws2jpgYMEASFUsA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: eSECIcNjIM25OQBuJ4vRGy2w3vum67i9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100177

Annotate vital static, dynamic information into meminspect for
debugging:
 - mem_section (static)
 - section (dynamic)
 - mem_section_usage(dynamic)

meminspect uses a different API to annotate variables for inspection,
and information about these variables is stored in the inspection table.

Co-developed-by: Eugen Hristev <eugen.hristev@linaro.org>
Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 mm/sparse.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/sparse.c b/mm/sparse.c
index dfabe554adf8..38beae2d4294 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -15,6 +15,7 @@
 #include <linux/swapops.h>
 #include <linux/bootmem_info.h>
 #include <linux/vmstat.h>
+#include <linux/meminspect.h>
 #include "internal.h"
 #include <asm/dma.h>
 
@@ -30,6 +31,7 @@ struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT]
 	____cacheline_internodealigned_in_smp;
 #endif
 EXPORT_SYMBOL(mem_section);
+MEMINSPECT_SIMPLE_ENTRY(mem_section);
 
 #ifdef NODE_NOT_IN_PAGE_FLAGS
 /*
@@ -253,6 +255,7 @@ static void __init memblocks_present(void)
 		size = sizeof(struct mem_section *) * NR_SECTION_ROOTS;
 		align = 1 << (INTERNODE_CACHE_SHIFT);
 		mem_section = memblock_alloc_or_panic(size, align);
+		meminspect_register_va(mem_section, size);
 	}
 #endif
 
@@ -343,6 +346,9 @@ sparse_early_usemaps_alloc_pgdat_section(struct pglist_data *pgdat,
 		limit = MEMBLOCK_ALLOC_ACCESSIBLE;
 		goto again;
 	}
+
+	meminspect_register_va(usage, size);
+
 	return usage;
 }
 

-- 
2.50.1

