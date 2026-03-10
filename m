Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26863E9597
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773173821; cv=none; b=PT642X1mHL1NbaKMXkD9YXBNUPYcU7Zi80kOCdKHrSdtNo9X3EE5kydGwfraTKZ5Q1uHoG7H3uKjxvsPqR6klfa2dSl1TUua8W+vd0PrFwyRk288fGY4cS6Ehae5j5WyfAMG249NcfTHHWNvcf433mtRS2R4F3DXVCLRvChSMNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773173821; c=relaxed/simple;
	bh=ayFeigblzCAoyp9Qp6KiYtozlvf4+37AaS9qLsZ8MIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E7zN9ZTANDO4iWlfw1tTUj2QqKO3H0f+wvW7OWYZK7s/Qrg3MM/N3cDn+bF/4LdxjsfIIbcT5LpbDeB+nZMVzNpZ5N2vzHVW8G/rHI1Kiyg+b/JSV+eW6wIAdAopVCSeLfO22CG+aJdi0OGumi7MEkvdLztopilhXFaNAQNl9sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V+F18wF1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i62DQosj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V+F18wF1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i62DQosj"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AHD0V71573138
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BxwX2Y88T6y4LwZjHtHAx5HGwUr/pelc0DybJMU2hAI=; b=V+F18wF1TAP0Q2Ck
	lqU9astfKnwyjiOFMImTog9s0PfE+yGloq82sX9318GQImuTdNu1fKgoeC47LJSm
	3J6LDHLg8JyE5H6MefV5UKiJmlf2iLLqTySnJ93UwOwunil3J8r2Wy+wJkXD2RKv
	YSfbcuOWwGgv7Z9c3FLYBNpX5UL3JwKjRi7iRcb339jJaKB2ErSs/Zg1UMnUH0VW
	isatBrk6/GQGcMDr4479H0gbMtIw7/NIYmuqxcGiVKtd29dq6aBvSN/25HxDvRLr
	RC+X1AHmKE0fMXNPMr4b+/2ckH3EWIKdIyuY1/TWT2o904Mf//My74FF6m7YudWw
	b5YZow==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctqgk8njp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:16:58 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-829b20cc6faso159981b3a.1
        for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 13:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773173818; x=1773778618; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BxwX2Y88T6y4LwZjHtHAx5HGwUr/pelc0DybJMU2hAI=;
        b=i62DQosjFhuR1/P0yAWJQvj6b63ESZ7wTaTJKw0wkcNJthvzgwUVzC+r0krMqiDxT5
         kNFce6xwpF4ejRDN1OnBtKC62WDMs3vKjNYHgn+HOLhjkKi1RM10W8/o8SxbTLIN9BeJ
         f0ZCUKidyss0Zy5aB0sTTawKhHPCj6qBwrYC0Zji2TbTicp4TpptMOz8m9gxErQF5k01
         FxkEGRpX5+tps6WuMq8+UITWtKDwuExUENLUMgt2U2meVFvza7IE+sPhMwZ5jEClY5Ms
         4MIqvvJ6Rd624rWZdqg8YN7zSOpos2/mq9yoPUtPwnZdlAiqvtfq8DympWNQrsDUrN9m
         3Tvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773173818; x=1773778618;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BxwX2Y88T6y4LwZjHtHAx5HGwUr/pelc0DybJMU2hAI=;
        b=L1437rkI1bSPLGMarniFOcnHI8ddw6wpFDVVYHh75c7hKgZ5lV6UrdQhvig3c+oMAZ
         0zdMFj8zn1ppE8lxGtslw1JGhOZcH9TqHcw5Su48ReJGbNvwtgcP45CLLjwPYU8+bBB2
         LxizqQ1oc/vwOC59l3rdRLcmemWNDtdjLX7jrtoiTPXICc27Z0T5Jiki2DAZyf6/FCiF
         CsHQh/Qgf1fohQtGbPi95ZbECnIi1S0ztN8CpIbau0kJjOXbm3xxC2ZBB7I3cBR9BJaK
         //6XVrdvoVWP+ojiioL0yroAZQGvscqQ3tDYPrVl9zKJK4Dz2jTX2yzoD6TcNLrasr3k
         0icw==
X-Forwarded-Encrypted: i=1; AJvYcCUz5TvAqQ06iZHa7RBGhAq7zEBczW0jDFIZr0itHA4eB+VgEMQ6D4wR/29OSnDwkFJHX1axXWabbD7Y@vger.kernel.org
X-Gm-Message-State: AOJu0YxwquBRB3TgtnlA8p/JBPPUJskMxSCtUUV1nAnVsIiJUwgt2zAw
	kwDj8xd1kV8r6YWjcEl3fulH+wPlXss1UXVK1l58Ry2hkaraS41E0esxTjkshFAfqhmTrC6SbQ2
	KN0+H3o2NLW7gG2CismR05u5ykqJh9OytweAShIDasSkQZBbG27847HW3lgAHoNIF
X-Gm-Gg: ATEYQzycNWN9OotRHJMvPQw6777YdKzhGdvl/hmqLovmXeIv1/vvoG7cHE2ElbgLx4t
	FHJvtg+BCwUgEketPpAev2MzZ1sNz8w5GQEmlK4V0g3h4om9CDgEdKIabvYNleZSDFBlhq+8RNy
	Y3WT7YdsWsQl6lJi7CKtGYQZHG+ydnU5saX/JVB8KWNl3lSjm3WVyEGWp89nzIegKS2iuy/70XV
	GlgQOXWshcWUwhro/B8MPCJR19FZavaJhaWpdquKDs3L7NXIELwffBvfrWF+Ip4LUTd1X3ejT2Y
	3EsXMXwclz0bl6gug7nqPIr0KruYhdxFKHDWdUfRObFsKkuhyspxtuWNFV7NoSeooxytIDkASRK
	2GhIqYw9Z022va/6UYzcG8GY6Vk6e1kE+PV1qD31lBGZlfj8g
X-Received: by 2002:a05:6a00:2d14:b0:7e8:3fcb:9b03 with SMTP id d2e1a72fcca58-829e4077415mr4216136b3a.25.1773173817660;
        Tue, 10 Mar 2026 13:16:57 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d14:b0:7e8:3fcb:9b03 with SMTP id d2e1a72fcca58-829e4077415mr4216101b3a.25.1773173817046;
        Tue, 10 Mar 2026 13:16:57 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6dc2d0asm115262b3a.13.2026.03.10.13.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:16:56 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 01:45:47 +0530
Subject: [PATCH v2 03/25] mm/percpu: Annotate static information into
 meminspect
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-minidump-v2-v2-3-f91cedc6f99e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773173756; l=895;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=+tGlmFyqBcoz7Ktr3AUpoQMVM4JnoUBVi4FO5/qneMM=;
 b=NvchOxzzO5I0OEPe3SoUqnDWDl/QAp23qS+G7CfJ1IKH1kWlIdZBO3QW8taGx6ZIGgP28DMU5
 qvn4YwBoiI/BuGfOm2ndKfDymQC5gVBdcKxJtVxj6fAwtL9RVgACP1C
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-GUID: nDQusn4Ri_d_ChIylpR_wh1Whe4nGEGx
X-Proofpoint-ORIG-GUID: nDQusn4Ri_d_ChIylpR_wh1Whe4nGEGx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE3NiBTYWx0ZWRfX7vaCICNlg7Aj
 PNGeZtgYQ7tFlaWWEM6+lXaaxnK6CX7WCMgJVJlxA2a/vsJM1p3mkSuZSaovK/ZPTNSRvMumcgj
 GvetqDV5TKgT0bXcFVH6nLm4SPim0hVW0dtuoZrgi1rZcEXECRjtVTMcs1Ky/SgQrczzbLzw34b
 o49rFChm5iJCO3rPh2zIlGiK0v45u42vt7zOeSTnXslz1R3+OF1Kj0hcyL82I1Uo7mHlBuNLIDb
 nyUFxRX7Zk6JBYpLQ1LovWcmtjbQ+vhh27kzfM+ja3DRvoydT89OWyS+Nu3WJecXo7A6n2QZdZC
 lRITWX25OnwXsdc1x2oi9WT3yJSmqtouB4TbY5txd8dvwmfWizbZF+Yun8uy/GjhWw/hf1eQWfS
 fE/kNx3db4rTAcyYdSvdPWVsDPQXAvKCj6PAVvSWe0mpVF9SVovIO2Q89x8ESOUVC5e/VIisSLA
 J9Er7v8fJB/VMUJBj1g==
X-Authority-Analysis: v=2.4 cv=M4JA6iws c=1 sm=1 tr=0 ts=69b07c3a cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=H2ztsr5sKx9LglhVgPEA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100176

From: Eugen Hristev <eugen.hristev@linaro.org>

Annotate vital static information in meminspect:
 - __per_cpu_offset

Information on these annotated variables is stored in a dedicated
meminspect section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 mm/percpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/percpu.c b/mm/percpu.c
index b0676b8054ed..d4209bdfbef5 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -87,6 +87,7 @@
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
 #include <linux/memcontrol.h>
+#include <linux/meminspect.h>
 
 #include <asm/cacheflush.h>
 #include <asm/sections.h>
@@ -3359,6 +3360,7 @@ void __init setup_per_cpu_areas(void)
 
 #endif	/* CONFIG_SMP */
 
+MEMINSPECT_SIMPLE_ENTRY(__per_cpu_offset);
 /*
  * pcpu_nr_pages - calculate total number of populated backing pages
  *

-- 
2.50.1

