Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CF63BBFC3
	for <linux-arch@vger.kernel.org>; Wed,  8 Jul 2026 05:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783489020; cv=none; b=pfl3UdRKqvRQEkT1viiPcbaM89FXD8jEKK4zOVU5lnn7ik4Qh2tmerQqMZHlYUqZW9TVSTsl9TzooJYhtygI4S7qf/MikBAbk023TAj9Ro3KburUDNEANWedHNOgFnEnmnhLf/V5hJ5kCsDZoRiUEYpMztIeZRwmycRNsfbDLAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783489020; c=relaxed/simple;
	bh=R5az9zECz0wF5NRIZYKf4rRvvkdHnS5/+K9MHbLFHcg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fiGRYDuSTtHO8Y8KC0xfbWhRSX79If9F/NXIvCoqEUJxZwYDmzpZlaKXi70FauKNl2yoqtY2Q4zYY8CAbVaU0SeHdil37SxkcGmQ863mTEzsgcJiB5iOLp+tuKTPUb4x28heANwWFj3rhklw8vicMWigyZNn6nTzAAcepMophrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hs8CZvTU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IP1gLCdS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hs8CZvTU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IP1gLCdS"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66842TSG1447447
	for <linux-arch@vger.kernel.org>; Wed, 8 Jul 2026 05:36:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IIAnYNUT7JIDk/4EOGJSzGq44L2ybK3V5nw9t/195Ms=; b=Hs8CZvTUdRuUzjkk
	8/KBlB9MALBbYzTPnNpJ8xWKxOD2Uh1JEoxS/ozoSe7jU0eflZLmzdqFEv68Mqu1
	kOpVFvvGZLQXJghlhQepHLbRAXFAW206z4Gw6IWDoZekClP0dJB0UlGPGKXBjFiF
	NXl2wLiBxduoVPT1h1Fk3TB+RAcy2DhXvqlGAQGjV1NJ1cjAUK1VJExCD3PRitlu
	DvdPY8QQNUXkiGe+Kg4UGqOAohAZdO/h7eOPVPjNDgu5uHhwRYgR0VFprg0oUpgj
	D8pHymEERJPjUs9qLNGHLtxM2/pBZDEKvramAwS6Jc4hvz0zeHQD5/PYyMZZPeAp
	hTQYXA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f97u11u1a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Wed, 08 Jul 2026 05:36:57 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-845df469a26so909133b3a.3
        for <linux-arch@vger.kernel.org>; Tue, 07 Jul 2026 22:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783489017; x=1784093817; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IIAnYNUT7JIDk/4EOGJSzGq44L2ybK3V5nw9t/195Ms=;
        b=IP1gLCdS7JalfFd3WPjd9wZsMxzstNWgnTLZByzHLoBNyXEmlfMoXhE8e6TZN663P3
         qVj6/UBvO5EK1wuiTwXYcDWEY+dkxGidJBFCQtYH7jnw6rdkmeegT+dARkr+lQNbR/w2
         M0HcTrUQThidAx09xuQz+rI+rpf46gSLMqdRoqKwYqCiJUdtXQIxg9EG++ho+Sdp1X0d
         N1oq6HdWqqaW4NBUqkLJIgOaaEjLh7skgNQQ8O+euAuC9f1LJ6LNfzAJj6Lk6GjG7rV2
         UCqegB9R3CksKFAL/UxCJWzogPpJ/vcD3eVS7fIkqlPo4VBohpv4ewBwCnyGNdOyhKnS
         6umg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783489017; x=1784093817;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IIAnYNUT7JIDk/4EOGJSzGq44L2ybK3V5nw9t/195Ms=;
        b=oe2XQ15if1EdqcvHEgWQbb7dzY3EVlaiKQyZeANnZvZ0U+eREKnStEf2W5rCLrhg6f
         RaELbCqUv3ltVNEqvGnKHOxVUaq3EJTrbX9JoknraQ9TAkTzxjGUnKpio/WYdzPImEag
         mxdfhQ11tfshM4mVQA5Ld3IarGtXNTE2Jk35vvtwZhxmIrVEiG+fOtUMDsmsc3MFTG/e
         PK4qgvaQjyoVAwOcIP4L2gxK6F/xyETgtPk3ZWHig71fxC0xGboC9LteDPfWON0HlKl0
         7t5bklFY8uVU9MeNcHg81YSFZ1cPfjwI3q0lhoyT0bIFGuo6C5TkC8mUQOQuHDx4thgx
         0Egw==
X-Forwarded-Encrypted: i=1; AHgh+Rrgt9AXRs2Tu3mfPNX0v9jIBolMKvOzarZ2jHy25QtrnTLf1DT9HqqJYUfW4OV9+w/Htq6toSvC3aye@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc4QV9YEWBKiHpNv6T88RevQEsxjxYxF7V/eCOZNtT+NhENADS
	u1QSsRuMoKScQ5O4HdyGKsELe26boV/3MqPLPFQsXNmsXRKf69gj1GEnkR8gBpZrOl2c4HTbz76
	5MFwxV1QYItpHw9iA4vy7BwvfNCoUlphvix/Nk8UvC/2jcJe0kcrKOUFzhJkhfzCu
X-Gm-Gg: AfdE7cmXDHNUftjz70iTelqNLdUnouQPMlLf1TJBJC5AXdoe6coH0zt5RKXVmEltxTm
	UIX6fnq6ddA65It7crlazrRRuByfO/lACZC745pw4VgdMsevGka0x2Ld8SDJfLp9em+c2RxhMpu
	GqdE/XoaOanr6yKMOYY1SebE/n3F6bdM/auJvLYC2eml/gSUxgWjjg0I0VwqC9hy1Db0aC2WPa6
	92xOuVnFPCqzMepN88hyfDUclcv8bWe1xKyByBvjhfnJJ1pKNluomRcyAY6s9WNuvB+2ZmJIm6J
	91hfKCzHKlYPLrA9MC4RXGI02vYKMXKJG1WRZHs0SMEAF3Sdk/X+EzIKAqcdwHYd47Ri6zal5yf
	4gFjkX8F6mTlRSJkFSkuCNNmm2+BnC9XjrosuEw==
X-Received: by 2002:a05:6a00:3688:b0:845:c6c3:5e79 with SMTP id d2e1a72fcca58-8484367de8dmr1224988b3a.40.1783489016992;
        Tue, 07 Jul 2026 22:36:56 -0700 (PDT)
X-Received: by 2002:a05:6a00:3688:b0:845:c6c3:5e79 with SMTP id d2e1a72fcca58-8484367de8dmr1224915b3a.40.1783489016304;
        Tue, 07 Jul 2026 22:36:56 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6db29d1sm6484592b3a.53.2026.07.07.22.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 22:36:55 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Wed, 08 Jul 2026 11:01:57 +0530
Subject: [PATCH v3 18/26] sched/core: Annotate runqueues into meminspect
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-meminspect-v3-v3-18-7aa5a0a74d5c@oss.qualcomm.com>
References: <20260708-meminspect-v3-v3-0-7aa5a0a74d5c@oss.qualcomm.com>
In-Reply-To: <20260708-meminspect-v3-v3-0-7aa5a0a74d5c@oss.qualcomm.com>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
        Eugen Hristev <ehristev@kernel.org>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
        Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Brendan Jackman <jackmanb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
        Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>,
        Youngjun Park <youngjun.park@lge.com>, Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        Eugen Hristev <ehristev@kernel.org>
X-Mailer: b4 0.14-dev-f7c49
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783488714; l=1065;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=JYWiKEpaZYGfni18VOJ16Qd4auRJiaJNrpQIWqmhZDo=;
 b=cv0EO/V7wbPDz5pf7/xTcxOXaIbi9Un31Ad+m/LM7I14uYWvl+7At4fcK1lJJIifZZYnjzb5B
 4sQ6pyvmT9ECMDABWn7BstHPke0QDVSzou+abCFZ7VcASrjrp50XxfR
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-ORIG-GUID: ChlwAT8sjRBKxcjHBLgagkWhEFn_ty3j
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA1MCBTYWx0ZWRfX8nmZpsXRpMlh
 PHeGALbydhqeshhM8HEkmWrvbAyXA4t3p1CeFkdlwTtYAJN++EHL7IQtEIMF5wuC4mLiCMa0H4M
 dbQ37zFzHrsQXjE0WBHxUngZWltc8Ts=
X-Authority-Analysis: v=2.4 cv=F9JnsKhN c=1 sm=1 tr=0 ts=6a4de1f9 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=WIgWxXLGzmshCHNC7soA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: ChlwAT8sjRBKxcjHBLgagkWhEFn_ty3j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA1MCBTYWx0ZWRfX3Iver2E8WFPp
 OUdkn0kK+f5eEEnuwv+FEP8z1lzwhttgHtQrZlkaLxFe4jYTTDu8DWA8n1ehiKfXFtDc+rJwVji
 AKZIt3U1o8w4kmyrSPN0L77Ft9vufBgSRQkeQh2kXTUkpfFqq9y3YRdLY1WXCzWw2uJblkyXykz
 8DejY1KP3UTtDrLHMbE/MRvqcn2McdGdaqNRp4Ada8EMO9MPYq2jEEoAsIPbKpZNM1rK/4NBsLF
 YwAtzRjhzw1bl/yMxEQ63oh+Xj8fUpzSkU+yTaEABM978C2pe59qeL2b0dkrBWJsLFTRHIxtfYt
 of8KvUwWHKMGko+0Pg6CZ9UhT8VHCIY0gPV4PIgKbfqHbxixCvjIQ+cYp+H+gWaRBTU2V8UOHcG
 pym5/mNjM+4g808I2LiEDVRA4vvplhvY64R2JxUC7F64t0/21XclJb9bsTYY1S3gQDZVJh1f8PH
 Ji1OvPtWrAHMYgEuefw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080050

From: Eugen Hristev <ehristev@kernel.org>

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
index 2e7cde033a31..1c2e80a54d2b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -69,6 +69,7 @@
 #include <linux/wait_api.h>
 #include <linux/workqueue_api.h>
 #include <linux/livepatch_sched.h>
+#include <linux/meminspect.h>
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 # ifdef CONFIG_GENERIC_IRQ_ENTRY
@@ -9059,6 +9060,7 @@ void __init sched_init(void)
 #endif
 
 		zalloc_cpumask_var_node(&rq->scratch_mask, GFP_KERNEL, cpu_to_node(i));
+		meminspect_lock_register_va(rq, sizeof(*rq));
 	}
 
 	set_load_weight(&init_task, false);

-- 
2.53.0

