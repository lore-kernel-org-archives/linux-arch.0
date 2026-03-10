Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D3035AC07
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773173988; cv=none; b=t8gSybhwjy8GBOYWjqMm8ZUyNO3ldDVYDznc67fwO1+2aDTPDYF+vryruXwIjz2bF72+sCY8OHsDSpOtlrHjV5OVXJ3v/WTAGeG5A06IF4v/KJdBY3ojdc/DG2NZfVwosMYXHSJOhWAVKp01NUIW652GNyBZN7vXfxa+dQzj64M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773173988; c=relaxed/simple;
	bh=wlqT0KjWJK0l8lqum7wtMlCC8k5TDcN2j/YxGJ8VYZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AsJqWagE5gCoLcsbeFlEhdukVQTNnrxh2H2Y+0Yqx5DJLMy4VT0Ka2ir6TXYwf2KwDmlqbCVuLiNs117EWfWcr7ROLfoKhri6Rw8nDeExdE56w5Nxex32ZEiCGS/mVvKSWMpssl+YUEUzFm7LYUsLiNC0EmxwcVyl6wrdIOzI9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DjRDOs4L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B+TFtFQR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DjRDOs4L";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B+TFtFQR"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AIWJl13417135
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:19:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gwpDp7aMAgBSG+xcal97Cd6xKHw+4XmuCvZKGe6Z0+E=; b=DjRDOs4LgNnogppS
	pbEtzYSW/aSQ1bjfJwg3k2S39P0xRyV7xKiR+7tMMqNmVhvTUY+UQft64oSHwc0m
	O0wKRltcKUkeV5nyagGJrw7iUhjkQ+KaQGhmsAFJu8Ns8VKMirOXkYe9TL/kbNKn
	1EtKdUpA3QAi5bLLilcf6G/V4kHSC3+YBVcuex7nOWge88/ZR8rzGtzNSpfHfm4/
	/PperC8fre5EIXn8E9lbFebGMkC3Jj5XtWMVk5RDFZAHzj1PEvi51Vq/eVnzlBTQ
	nnCRCPJW8Vto+Q9/ZeP8V4rOHGT0Udq57XA8N60ZS4vIorBICL6riLYCBqLcC9Uz
	ax41ZQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctja2a3ut-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:19:45 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c73b0c33e72so1635968a12.0
        for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 13:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773173985; x=1773778785; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gwpDp7aMAgBSG+xcal97Cd6xKHw+4XmuCvZKGe6Z0+E=;
        b=B+TFtFQRkyEnCxFNU423e+2m9+02EAB/d766+wwYcH7ksB5Xrb6VfUwPZnRs09kU+i
         33xDZD/2CXrTn2tIG5rV2xOWmvsr6Xdr2KLtxm9nUBHsmsqXvOvs+Ed4u74a4nerdov2
         Enz9Uq15rE1tRvY/hLY9lvoWrGfxmPtxutWze1pAUtShGKpApSwpP3MwrR76eaZE/FHp
         nz9GsK2oNpD/18XGNIxGFAdkmC35ELXEuDYhENKrnZnoHFTQV2EEnynkDxy0ahINe47T
         pVlIkIrn3o3GbEGTzyQNeZg4pEw9Ei1oUvZuk7YjIO8GaYnV4xSluRYZhpuF/9x1TeJu
         OE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773173985; x=1773778785;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gwpDp7aMAgBSG+xcal97Cd6xKHw+4XmuCvZKGe6Z0+E=;
        b=d9EUkBLAXqO0x5kblYIEOGA2FYU1wCSr73bDWdYi9+c6DCsNn2JoE6E5jk/yp8w/uH
         CkY5VFTB9uobQycACv3bjCWc4IoZ7+aN2m+AKmyq5T7e+D28WS2OZUfc1PVIfmE6WaBa
         PtIwfKRTQYL3M8LwbSWghZw7fluMuxN0yUsrX5kBcM3fKULyuS2ntjOFfgEONfkIPg7I
         /sWUyKcYbqFK9to7gPzGHZqxWVHUXy920SQ4cV/GeWs+hHpimGE2e5JCpf7IGeMlzw1n
         A3Ga04X8HvhTGS+viAQ3e3AY/bWQioY4BHHRVtDUS8dtOnfUeLc4dVQ7TLU3t1FahZGC
         WyVw==
X-Forwarded-Encrypted: i=1; AJvYcCVZZBU3bD/SGJCtd7xg5hmfmUUlYCYXFbdyR1Q1WOrRp2uoHa+D+XqUZyOmWxmbtnY2PFE4DzejtFa9@vger.kernel.org
X-Gm-Message-State: AOJu0YxJb8xudpzadQgXR978V0Y0a8c1ZZRg1NPRzY5B7kv54Am5TSRF
	pZKVChb5pxOSc28qm7NG+VbQL8roxaz4ZXDTCiYgPkqwEfnBh4Y5i+oK8AwkpqmAIJ4KWGEssTb
	yImAfGeYa1dfKirU/mATy18mFDYeNSdnYIngxHqX50de3Qb47BIuxF7t8PVxviU2t
X-Gm-Gg: ATEYQzzqNBFEPPLUL78/pCYnAFRKydqq1ON2nnUdYLP81AHuRhGyAdKc5pr60v4CQlD
	x8noQ9VR/rNH1An63P0y56zBzo/CTHXsGg+blJkQxQJaeYTK1m6TaYCs5LLBk95kEtO86bDO9lC
	E709LL5SWAdIMK2jq+I0j8f/qJ53bCx6H+IefcEaveacu5/tFnrF36LKh7gs47axF6+fnbN3t0x
	dUTAzD9PWg+CXP6dsBCtBCG30c8jyZV943kvjLK+FAVSlK96T9x25oUGgESmXAf9LeGfmrzzZs9
	XPVjSXZmBCYLy7hwhqg0g1w0pH9Q+E3ksB3gpod1pdMm+p+usiQu0K/WoBfKv2vIFLbLFG0j3Q9
	dGU4E49UVprcUGhoNLN1NjWYYxVpTi37KUv2AE4g5bvsDsobs
X-Received: by 2002:a05:6a00:ad04:b0:827:2736:d928 with SMTP id d2e1a72fcca58-829f70f04c4mr138788b3a.39.1773173984651;
        Tue, 10 Mar 2026 13:19:44 -0700 (PDT)
X-Received: by 2002:a05:6a00:ad04:b0:827:2736:d928 with SMTP id d2e1a72fcca58-829f70f04c4mr138715b3a.39.1773173984034;
        Tue, 10 Mar 2026 13:19:44 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6dc2d0asm115262b3a.13.2026.03.10.13.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:19:43 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 01:45:58 +0530
Subject: [PATCH v2 14/25] panic: Annotate static information into
 meminspect
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-minidump-v2-v2-14-f91cedc6f99e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773173756; l=1365;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=lNXUiyOavxpH+nkJAUsL6tXwgIVeayDdpUTtrMGpbN8=;
 b=XhDH2w4mEz3MQsVANAQsn4u6is7j4U79l+YZiSzviUo/lRPaV+eAvCHeg+LHm3FJEyUmXtITH
 h7lwIX9gOjtD4Zhh82gN9bDOruCNJrlOfEq3jVS3l0UVOlydRIeQN4F
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Authority-Analysis: v=2.4 cv=c9WmgB9l c=1 sm=1 tr=0 ts=69b07ce1 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=sIx07V1IIwI039IRSX0A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: c3PeJIYCUB0L67ZcyOb3fqb2SO6hBSNe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE3NyBTYWx0ZWRfX2iFCiuhn3bYN
 hDZNbydQ4Y1T4nCj/RkXgMlRvmPGVDfdDOTrfJr3eviJMTigveQnaNmy3eqBOT/ABuls2KCl5DS
 IPRwhSS4S3DJ8itNgOV9FEmh5znvLh9tQHf6kxZtWxoTl26FPXUJq+swyJtWJNTRyk6aBidt0m2
 Gb9ILGXheeh8PqnLpVLFU4hMvAmFOv1TBHsdOEQgURmTvipZjkAAXR1wk1tJIb8zYakcGKOdKX6
 2+qjEGdaeMm2Yda5tyypej6xRkA8NbEYyFT+ndyGDBnrcYsNhbBnURlztbQufEgszu26vf49Kb0
 suz3NnbwemDKYvkTW2DvDzuMM6wk3jjcUxFXMYWfHGsqQ4IVJYugF0mk4lUuTb78+UP2SU7ligV
 PabdsHR0978kavQmowptBMjC2az9qpsdbE1bHcGPIJ8kAK7r2AgGsN0+ljQtwAy2M2BYXreCKak
 oggxMalCSzBafOHtxIw==
X-Proofpoint-GUID: c3PeJIYCUB0L67ZcyOb3fqb2SO6hBSNe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100177

From: Eugen Hristev <eugen.hristev@linaro.org>

Annotate vital static information into inspection table:
 - tainted_mask
 - taint_flags

Information on these variables is stored into dedicated meminspect
section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 kernel/panic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index 20feada5319d..ea1969d81fd9 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -37,6 +37,7 @@
 #include <linux/context_tracking.h>
 #include <linux/seq_buf.h>
 #include <linux/sys_info.h>
+#include <linux/meminspect.h>
 #include <trace/events/error_report.h>
 #include <asm/sections.h>
 
@@ -57,6 +58,7 @@ static unsigned int __read_mostly sysctl_oops_all_cpu_backtrace;
 int panic_on_oops = IS_ENABLED(CONFIG_PANIC_ON_OOPS);
 static unsigned long tainted_mask =
 	IS_ENABLED(CONFIG_RANDSTRUCT) ? (1 << TAINT_RANDSTRUCT) : 0;
+MEMINSPECT_SIMPLE_ENTRY(tainted_mask);
 static int pause_on_oops;
 static int pause_on_oops_flag;
 static DEFINE_SPINLOCK(pause_on_oops_lock);
@@ -827,6 +829,8 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 	TAINT_FLAG(FWCTL,			'J', ' '),
 };
 
+MEMINSPECT_SIMPLE_ENTRY(taint_flags);
+
 #undef TAINT_FLAG
 
 static void print_tainted_seq(struct seq_buf *s, bool verbose)

-- 
2.50.1

