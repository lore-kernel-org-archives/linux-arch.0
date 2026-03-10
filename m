Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4190E3E022B
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773174002; cv=none; b=F0u/b25g/Fk0Y+CjwuepNGfzZJHaDXa8XEjp3tDY3+H2rq91c28eNz+EdzFBiRZ6etiN+BsRYyG1wRaUkSp16PwMe6HiG1e6kyZ0MjN7cA6krXvwuUMiE/DqN1VJzoSEQ3dkRKXehAasW6dNpTdMVVXhqzGne3lkOZ4IAaprtSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773174002; c=relaxed/simple;
	bh=AFMtVOGUsKyGSRr+RDrowkjCGArp/7B11uF63zbOcpg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OXrMaHD+4HuSpd4rWbmYzI8m81kaw5MRdt+RIVw8rrdMDdl4dai2uvI80FZTI8Zf/pkmdg5xX8q37/61ujYgt9rnwtSLP4cnjthrHcp7LLI8NjS8UDmX7rYDGQoT+TZXMTZFltBhhK110gZGM0IonzT9oLoCMKoG0426lPnnQ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dQMX6mcx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MU0sCa69; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dQMX6mcx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MU0sCa69"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AIIO7R3759039
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jwRw+3zoZjJFAT1RlGDVUTiEW0Vv9n3Q33NYxUXFN4A=; b=dQMX6mcxDTnvoa/5
	6ezJq8gaLhHuHHIlrq4Ort9DzKAPwveetu8AW4Oy25sQNHjoLOOgJpeqq6DLgk56
	Z4fZxQ9R+c6QPz8dhw/hjxDXSf1AAXXNx1Z6bff7ceMH0yS97r0jczO14/Fzn9rt
	uNW+QNmFwR33rUn8q8eXw4xLN/bvLzf6liC1pr4tRc7I5LCLc+R506+GhMe2+4ue
	yAIR03vvs7hR3z6Gc/EcmiU+A05oFTw3scor3R188D65kAH0gfflfg3pF15gJe1a
	y0hy9Z32/48hL+XnI6wBKuvrXPnlOkCfVmACKuygve42g5VpRNnBLb+Gox0D5Wtv
	vNRxDA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctk8uhw3j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:20:00 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-829aa961449so1772687b3a.1
        for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 13:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773174000; x=1773778800; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jwRw+3zoZjJFAT1RlGDVUTiEW0Vv9n3Q33NYxUXFN4A=;
        b=MU0sCa695ksZJvz0leEYJ3BjThZD3LKz6uSYWHuwmavnaPvwWiLEbseFjDM29WQOqK
         iT4QL1AHO7k234pFfhVQ1litfjQZ0L08Ujfo4JHFNgZPNRCxs8/4zW/n91DFPlL/ne1O
         PQ1BVCtKBdfxXc1UV+ENyA5kuLK/1a4OKgcoRSyrjJhp27vXJfDh3XlTX7SZbtKUfRkL
         Eq+t6ztsU5CGPoPwd8PKtnveOZwIqbQwP6P108iaf0em//UdP8IyKWqilslTNf/pGkYn
         lqKAVV6QYeEyiIV2evhkGyiROeyCqwv+R0g2J/OsFUfq9eS6sO8odCxbtLrTDfT4AMBV
         OUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773174000; x=1773778800;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jwRw+3zoZjJFAT1RlGDVUTiEW0Vv9n3Q33NYxUXFN4A=;
        b=H2urbjVV/S/8G/LKts/14yKU/bkKwD+yXvcH6wcNrc+tK3gUJlX1/a1o5Nf7pRE6lM
         QmR3mBLT2bREw8C4eRWgJqjY3ytv5+YhHhtCVeOcDGM7ptkt8+7jUbD8eswi2KglmzSl
         ugnTyIALrOiqVGUIvWAUgcsZBZr2xrFj+7ftOBck4SlhAuxEGjye5U6ulkIxSA9QKEGR
         DUN4BE9rW69gdxZxGdCxmPIHavtresDm6dX2FaY9VXwX4u0sI3bWXTE+2MbQyGh8Lo3G
         lF9GUzZOMzd5mVrzYPB9duomB86yGQNpsA8oFphweRGbzD7kBUiESWtJDMv0zb3E4vad
         QoFw==
X-Forwarded-Encrypted: i=1; AJvYcCWxM6dy1CFBRGFcYCqhcmj0w64CkIkVQagaPTQFxJODZPIq6FSvJm/SkcOce0xcBSySGHmr8LqeVzZg@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3uLFMUQgvqyRwbBDiHEi5PNbLmBvBcv2Ck33IvrmTCGueHITl
	wrKCv7bsLWn325BTO+vLZ6MLYW+PamMeJK8Rkamy9FEw9FIjmfzae2daPoMO45MaEDC8Cf5ayPb
	Ar8H6tld+8MLD+Sbf5WQuCBROl+NK+8J786aKjefcmmDWi9NgxDqkS0ufF0UQHeKg
X-Gm-Gg: ATEYQzzj9xBsu5Poc8xsZ2cskdZ31E2tmSlwyANmdacvTY7O73IJgnaBZau3j3U/tUP
	9ySfPpq0ZXqReSAoBrz2R7UJNFX6rSM4o6WGRhZ1zas+YjGzXmCcyEUgW458wl4ARkfF5Kb/pvW
	lEMriXMFBKZoq+qRXj2nqqLwkZztwXzRvubLZGfiTx5qNuFBbWZoFPseFQukOBTMjg4DPZnVJYN
	o6M0gdoyUrUTVHK807H4J3HJGhALPWzxztVU+IaucNnTzC2t0suPztVpH8jY5CujOjEUOmGMPbM
	oCMzQ8gTPyj3YQrMw26EWQN9VHwOHEss+t74jK7M5f+yQo7AgGbTfK/mPByN2OUCz0LySOaG7r8
	U9wUdW0oNaGAgFsowYnGKoqaxPpVZTMxRzjvDvgbVX9MxmZCv
X-Received: by 2002:a05:6a00:1815:b0:821:853f:b9c3 with SMTP id d2e1a72fcca58-829f711ef2cmr141758b3a.58.1773173999756;
        Tue, 10 Mar 2026 13:19:59 -0700 (PDT)
X-Received: by 2002:a05:6a00:1815:b0:821:853f:b9c3 with SMTP id d2e1a72fcca58-829f711ef2cmr141718b3a.58.1773173999148;
        Tue, 10 Mar 2026 13:19:59 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6dc2d0asm115262b3a.13.2026.03.10.13.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:19:58 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 01:45:59 +0530
Subject: [PATCH v2 15/25] kallsyms: Annotate static information into
 meminspect
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-minidump-v2-v2-15-f91cedc6f99e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773173756; l=1395;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=5cCBSBzKqX170EaIe747597hAIrIZlq0oNbXZtqGG78=;
 b=UEgcZFN6n/iIdr4I3xkl5ipDSF8TBMHCjSGi5uHecNqRszG5U0xLBoF7+wvpLEO5xpUvUFbNM
 ogRuwWUh8vDAQ/Ser3c0V3Ex5ozlIGE1K0yhFAi/PuDBiBB+xRCiu04
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-ORIG-GUID: 38vpztQH7TK66BqvU2dGb78Avy2KbAdh
X-Proofpoint-GUID: 38vpztQH7TK66BqvU2dGb78Avy2KbAdh
X-Authority-Analysis: v=2.4 cv=YcmwJgRf c=1 sm=1 tr=0 ts=69b07cf0 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=w68G1zR93E_Nt3437osA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE3NyBTYWx0ZWRfX/q5VBFh+SrYb
 2Cu2RbNe0rJdjmiUB0LSIPgYyhGsp175EPEisFtwnVJGwM2HjERTc9eEnaLq25enYGMl1iDfSDW
 YR1r3L9M8yKiuBfC/zXoKP18JFMtZ2m954pKwXqyABws+JWk/2ubnIYRZJIiDQNsT1KVIiRrs6s
 6yoGFfZ7kjAgx6guVa8ZtMEfOSMRvFr5S0Ccq77YzJjQ7kiaO+bb46Cz/MjLHMZ5vDfRHn+lWSL
 k6iSmP0h92ZgXuO0cM6PmDkrFG+PbUOwPHi3s4CvwDtk7VoV4YAlMDHhK9EkcMQIsNAa2Vupa1I
 FSlCGRg1sU12laMGejEelw6Y4f+pnCH4XXcyJ/Au6fWFrxZBN7VxyvTqeZPTg6gbW7oPUXzkNgx
 cx6O1sYyf5bm2APsDG0YunmZUqva2f2DtCCpImdwXb0bms8fwZBIfuNVEjdBF/mQY5qvbeO/vc6
 GfhYmA6WCXU09jpKfSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603100177

From: Eugen Hristev <eugen.hristev@linaro.org>

Annotate vital static information into meminspect:
 - kallsysms_num_syms
 - kallsysms_offsets
 - kallsysms_names
 - kallsyms_token_table
 - kallsyms_token_index
 - kallsyms_markers
 - kallsyms_seqs_of_names

Information on these variables is stored in a dedicated meminspect
section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 kernel/kallsyms.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index aec2f06858af..e71c085ec837 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -31,9 +31,18 @@
 #include <linux/kernel.h>
 #include <linux/bsearch.h>
 #include <linux/btf_ids.h>
+#include <linux/meminspect.h>
 
 #include "kallsyms_internal.h"
 
+MEMINSPECT_SIMPLE_ENTRY(kallsyms_num_syms);
+MEMINSPECT_AREA_ENTRY(kallsyms_offsets, sizeof(void *));
+MEMINSPECT_AREA_ENTRY(kallsyms_names, sizeof(void *));
+MEMINSPECT_AREA_ENTRY(kallsyms_token_table, sizeof(void *));
+MEMINSPECT_AREA_ENTRY(kallsyms_token_index, sizeof(void *));
+MEMINSPECT_AREA_ENTRY(kallsyms_markers, sizeof(void *));
+MEMINSPECT_AREA_ENTRY(kallsyms_seqs_of_names, sizeof(void *));
+
 /*
  * Expand a compressed symbol data into the resulting uncompressed string,
  * if uncompressed string is too long (>= maxlen), it will be truncated,

-- 
2.50.1

