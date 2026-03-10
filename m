Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457E63E92B8
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773174033; cv=none; b=bpgUZHONLm875TTMyzjPLjFwPV6bfKy2T7KgzT2u0aPBPEvZjm5uOep7Drm3ZWhfKlnSAxCbHoU8fhvvGEiZz1XgSX645VgN8AVt8sX4SO64cO7phGrFmS2VsJ8S/Ns8pXyH6oRv9RJvE6JovgdKbOS78C5yw88XIVybCPmtpC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773174033; c=relaxed/simple;
	bh=GJsyRX5M78HpXD5ZIPg64tgahV7EZgChDo8/tB3hlfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ftDdt3bInVF/uJ5fwG8qyfp+Jj9CL4biU3vlHgeWAf/EYjWD7CTBkl03/bD4E2E6ZBzYOf8oLXzmx61a71R/zYgZYxuzgQdLBWcHDQOCkzlEyYaUFFzkjXfBrzF73Y7yjzNQ+l1qZhjDst+9mXEoXXuCqjcDjXOZBElwCBCOdYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bNqSVUAR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bdQSvb3x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bNqSVUAR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bdQSvb3x"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AHcrxV2179348
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:20:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FwPwm9egcX+1gvanmp7QoXzEqEd1Picj/3vW/4UCWRY=; b=bNqSVUAReEBebBrT
	ofohgRxPzbWGJJ38g5iWUzHtnSkL/fjdSQlZ0gdSMlAFXkNkOP4rEQmBrnov7snm
	HbeI38MRtkXkee+aCtlogRvfLkSMIR/qWkWlRtD9sFhEMOtYNytkfbSFOFzMfu+H
	We25PIxl2QFD57enTLWaatpPBvYhic/xuHsemTbMvEUO2G2erVOPG8l2ceamOU6E
	/FgY0+QEaDXlCGBSKoIxprW3BLsxJjuly+/xmQvEwgP3fnHLoVwiugxuExFXjhdY
	vKjH9P2s85pdWK0yn16vc2VtDZR5SmuC+uW+yDzEEAMMmgnLoDpKcDkb8EuWnJFa
	F67aIg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctqvsrk7w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:20:31 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-829b7ed8964so2426332b3a.2
        for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 13:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773174030; x=1773778830; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FwPwm9egcX+1gvanmp7QoXzEqEd1Picj/3vW/4UCWRY=;
        b=bdQSvb3x8Bno5avjsdGD1oaHkPQFDn37kSX2EcOjR3T2NQ3zcYRgTK6AVF6FCy73u4
         tMCYmpM9OQtvxi43L7FQpx1j4A1x4PaponcM2lQyQ70o1HAHFaIBJ+pk2E3lZD3Jt+xl
         0Z0zr8XOuT5Eohp4hD9Rs089DTNTKfQH7UiA0SRrUH/Bs+ujVU04dHpDV9w5VgWReR4x
         oWRwrCaufuxqs6+IHlmqJ8NFNWflgQTDa1WDUwJkSdEQtzDSlDGzInpEDIbpfdulSLNV
         6gPejJOCg1rvEG9e3Jz2TYEkxltHfxnP9UeanCAIgF+80TOvrKiNyBO2e2Eb+wrekKox
         pHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773174030; x=1773778830;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FwPwm9egcX+1gvanmp7QoXzEqEd1Picj/3vW/4UCWRY=;
        b=HW6fxdv9fBSYwsGFOYVG1gkL/mP2PVPAY9Bm64Szo1E9aEzcSHpnNi8TWH5OIsGUrp
         q6eXeTDEzZUkDjr69G4cwdtSE4Kk6wcPHN2Wsop+v4+c9kwSXPdhooxfTY3ITcglplC3
         HMcYSq2bebxovMZxXtI8AwMlCY2yQmTtW4aTvHKKWNfW9G+mb1zxFPPoG1RkLNy9xWkP
         A7Q20oc5oSVu6urszRLYUS/ybI5i1UjbcfWo9dyYGx3y8XI2wyqLtucnN/ul6MOLsJUW
         ShXra+Ch4/VM4ZB4UUE3dGP2YFD+qm8Wc4/71EfyNlfMkjhfy5ao8UaWet1Qqq48LaYr
         +bwA==
X-Forwarded-Encrypted: i=1; AJvYcCUykRBMe1Zxz3VJAFMDUIbChKRyS45jz2jpo7FwbouTdtP+X3To6hKyKIt4KUacDp9Zwa7sr9W7kXwn@vger.kernel.org
X-Gm-Message-State: AOJu0YyyCCy0PHXtfAOUon4UFcpJGk7/f6Isud8mOTvgI2jH40aAM2cq
	R682XuIyCY6UHtWLdsW1rXgeLgK74BVxuhIUvdRM/3vs8xQUDz0c1yLpaRvStlcj2sFyhcp6Bnp
	wJG26eQaL3OSKbetJi5vfEAvOL/TRdFX1Z3pknnMji2vIWXPr49Nh8S4PgKpaoz3F
X-Gm-Gg: ATEYQzwVhvQOUCf1OK1pTM/eWAeozoeU7vqvhTBSNBHOwJeae0csx8rqGJSAUkcNkeq
	m2CR9t2DtfLcsi7mSefa2bXlBltZ4jKR92Zq9wBSdZtlz3CfBLCvvLkPFoYker8+X9nD1EQlLEW
	5/Fz9Vz1ph56/7sM6XYnVdXYLqHR2kFeyiqm+kc9PlzaMXXmjauaGyfRVWI1gL80SsptNzaYQWh
	MUw/NwlK7iaNYabswlF0o8ZaZgGTKLobFQus7NfzLIZzQY7tLzWVGru8tqlIHzDItGhB8ZrVKw2
	OunfwP7fCSJ5duITimUGKDokxi/uU7xetsZkyOv+ULm1EZU9OT17Ar+uNBZT/swfBoR9Wjp8nw2
	XSAGW9LGeDjVQVAm78GRXQT7z5uV3xsUrvlSC+P9EK2ODBww8
X-Received: by 2002:a05:6a00:1c85:b0:826:b70a:7350 with SMTP id d2e1a72fcca58-829f7240393mr123117b3a.52.1773174030026;
        Tue, 10 Mar 2026 13:20:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:1c85:b0:826:b70a:7350 with SMTP id d2e1a72fcca58-829f7240393mr123063b3a.52.1773174029418;
        Tue, 10 Mar 2026 13:20:29 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6dc2d0asm115262b3a.13.2026.03.10.13.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:20:29 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 01:46:01 +0530
Subject: [PATCH v2 17/25] sched/core: Annotate runqueues into meminspect
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-minidump-v2-v2-17-f91cedc6f99e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773173756; l=1089;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=ZO7/bDryoGYv40z36iJsb1xhTIu6V9V40nzuQaYTMw4=;
 b=97ph7aGBo5DOsMrEvMbA9BDZtVSKSQVZcudPly6Z6cNUsdakmi1m/CNdYna9ssoZjW5hq3wnH
 06UefCLXjwxBLjVEa/zKZewRQLiHGj6hw5oxhvMiehOvkGLtM23NX1E
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE3NyBTYWx0ZWRfX0W9BcFyY3Ate
 X+F+c6bHx6Kvq1YuA++gHvUH9DdL5k1ggLPtztXA57Wp1BRL2601rLBjCCspIJzvkGpWJhumYb+
 8zgYSvzKpyZE1TwWyq6rKljzB9ZUTmdPf3w1DzoPhmFOsPt1jjgbXFrctvLCmFKXRmlbTTeujUW
 5gppfQs+aOsG7ji9zx5gczmFG8VxSKo9x0Og8BbQQu0dxIKXob+MrLfZ5V7JlHJDFCV9wtLARfQ
 SQQPRHoVp38zn7rfg5+2D84Vkx9ENz7O1x7G8kO0ftv4SSgIaQkBdeYCvaFktrJ0RH7xnLL4xYa
 GWFgA2GEVdWVutlJZMSC3wpD4xdxpClk+vvqLEZU+sF+73uJ3q/aqN9mY1U6FhTvRC1kayMo9RY
 whxTNEHukWo59Cqn6E4wsp2ghL4oYB7rQ2MC3In6dmyG93N09Ey/16wHQZvV8QTU9jyDryVeL7t
 ugU5dlQTSvamee+G2CQ==
X-Proofpoint-ORIG-GUID: aJPbWb1syUPk0pL1mlNFt4mibojcj4Nx
X-Authority-Analysis: v=2.4 cv=Lo2fC3dc c=1 sm=1 tr=0 ts=69b07d0f cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=WIgWxXLGzmshCHNC7soA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: aJPbWb1syUPk0pL1mlNFt4mibojcj4Nx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100177

From: Eugen Hristev <eugen.hristev@linaro.org>

Annotate runqueues into meminspect. Even if these are static, they are
defined percpu, and a later init call will instantiate them for each
cpu. Hence, we cannot annotate them in the usual way, but rather have to
call meminspect API at init time.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 kernel/sched/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 82afa387d529..09a532a5e9f7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -69,6 +69,7 @@
 #include <linux/wait_api.h>
 #include <linux/workqueue_api.h>
 #include <linux/livepatch_sched.h>
+#include <linux/meminspect.h>
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 # ifdef CONFIG_GENERIC_IRQ_ENTRY
@@ -8804,6 +8805,7 @@ void __init sched_init(void)
 		rq->core_cookie = 0UL;
 #endif
 		zalloc_cpumask_var_node(&rq->scratch_mask, GFP_KERNEL, cpu_to_node(i));
+		meminspect_lock_register_va(rq, sizeof(*rq));
 	}
 
 	set_load_weight(&init_task, false);

-- 
2.50.1

