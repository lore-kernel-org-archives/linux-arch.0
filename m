Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB753BA237
	for <linux-arch@vger.kernel.org>; Wed,  8 Jul 2026 05:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783489005; cv=none; b=jd5hRZiegyIMcPjeu5QYNa4rqAmRugaM/7PXbqA2lcGGEvPgOAzpkEPuwdcPb5brmTMEPrBtSJhq+G8igDesat+ElbjIKocu8N/ir5msJ/lECkVC8EQ1W1omvBqjUjQE/Tqeu7xlXkQIsP1VxFQu2Iz6D8o99Dxmw8yRtGI9zns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783489005; c=relaxed/simple;
	bh=6zWg2efwvk7/IxI9WkFGX94qU9nMXnZuURGzm95EFMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UvINIIIdRuCMhyVO4AdZ+kmJ/4z1hKrsqb0F4GP5e9Ae5kxZCeJGcuytcdi/FBaATdCMupzYGpTVyiy5PhalbNa0NDKeMl+eq6ibCi5xMIZzoIMU2iCN1n3eeo0DbgI9XKfLh3Xq3CDIPtereW3sI7pZL3NEZ0TxpqAB88tPa9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bY7gB7vt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MsgKTG+r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bY7gB7vt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MsgKTG+r"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66842Cm61656537
	for <linux-arch@vger.kernel.org>; Wed, 8 Jul 2026 05:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UqTfYZuS5v9TxvWd8p5QVvgMLn1YG1IPnoC+xwtJa7I=; b=bY7gB7vtGS8iufzp
	Aps8jeKcX4XgrAJWi3U8RG1DNWLmc23/ZS5++izX2zXirGVrH7nHEhYlRn42vY6i
	wGhTFMamIDLJoj3sUgqu6VBwoxT7ZVJGKkPInUh/xbag4Ja8O3yK2XKc0m2L2zfg
	kB15s+RoFoP4iezQSUzk8iCZFz6w+ddGEwklrZMf2jkdbOd7U2f5I64Vo2EZHR45
	6coNpwsO3rlnQuL9jAqb6b3WJUSaMRwvXcM2wNosfqs+DnOyFsS37ELYHTE3QCn5
	8qwWqZ91PSGQzaQV8mWRyyzhsc8FQ06P9/r9HAG/4mej+cAA2O4p9EyHAW2D28g2
	uSjXMw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9cssru02-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Wed, 08 Jul 2026 05:36:42 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-847ac21582cso440564b3a.2
        for <linux-arch@vger.kernel.org>; Tue, 07 Jul 2026 22:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783489001; x=1784093801; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UqTfYZuS5v9TxvWd8p5QVvgMLn1YG1IPnoC+xwtJa7I=;
        b=MsgKTG+rAZvOnOYtL0AcU0Pjo73lESfzBY0jto/GhrgZlrsnxiD9iGpAPmdAB0iFVp
         jRa0FCKKlZ0G7nsonzcie/W7MCqSVtMqpBi51lBWtU8EqRSrfd6YMUWYPh0/Bf3cbZEX
         D6LocBv+pLU5KdIZBjhJ5IXfXGZf7/LNE9/O+EyqdrnrgVQA6NRjI2705zgx3wsf6Txb
         K8U9ztB+zmkXVwYSoiN3kj6thtX35ZrGRfCipgxvY/jktcZDUsTREYFZZ2V5TTKo+rlY
         yaq4UxqZQludDgalL/2sa1G0Ia/2j+Sob5lZPKKLdZjpBcytsZkBjIRK/8K1b8WT4Hb7
         gEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783489001; x=1784093801;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UqTfYZuS5v9TxvWd8p5QVvgMLn1YG1IPnoC+xwtJa7I=;
        b=arZ+JKVpg7TB5yXszSihNnzRawIBxUupWHJQxjGIvQRI9/YocRM7x1RLCY/FBNIy63
         PkICoTpMomVwSrrMIpSRDozFmvuwf876j83OHb34Qok8IIhOx4lvdOw6HDjzt78woNqd
         OE+5PdAmtY9/xLlickMjLITk+utKUauRh3n+MlCVb9Yy7Di3QMZZy1Fl8HPMDj53p8o4
         xjXIUNAn+Ng7zSOPKOY1XJODERyji/CleQ1XZCYC5zCCFVddEQctKUJqLStitE72NQUs
         LSnQjA9gdMUqhOZjpPRgpcSi9Sk+lz2uGrFAqW85JjNXIqcUmXnFYIBCBfG8VySbIWPp
         l2gQ==
X-Forwarded-Encrypted: i=1; AHgh+RqD7QJ+CKruopu1JvnLDJ+v249LETf0bQjYFdzaygU2r0aojvHY7g/SSeLuRI1brAAuvHK62KBqpDeF@vger.kernel.org
X-Gm-Message-State: AOJu0YyGEgGizu+UQnHqJRvwjpwFc0OMT9nJ9vDxtJlS++Q5rsrupUD7
	V85CWdEXxYVDgAu58NUPS03ngweIfAdXRfp0HYxHzuwBPIkpU6dM13SobNRPuxDUt9AFKWXgZm2
	L0cjApUHhztvHGlHQl+c7NpZylIH5cZIYC7ObqCQvnxPXYTJHtknnJrvoAAn/L/uA
X-Gm-Gg: AfdE7ckmapVihxAhqZlCWarXhKL4Li36IYVCwVLvHPJPhzgN6KO10EM9Or5s/uNTt3R
	RKt899V3ffluyL+g6zvSPv8miQHKR51gmRb2yRJKX1XPHX2F1i/ZIjtKvIfb1qjY2qaIDguizoQ
	RDZheuwbSXqGhNCm9c5yp7TGFyLbg4DrYNTLjHoimtPB0L9yc7AM1GTWzgjdX6vs+iWTS/DWmdz
	naz7fLLq2JpwZjmXFVGu+jlCmoOqDuu/chorTDsD+Fe1BBE0iCjCBm0RBaae4/1GI9191HOuNaK
	Nh3kcvsAYU4AapMee87Q/1Ef6LVW0aTkZVdNd6C1JJpAqbWEwrzDDPeGZjImHjdv+wtL2gVXE5k
	AWGq61prfJ1i7WFrdEM9LXGM03vbSB5nkzWkDbQ==
X-Received: by 2002:a05:6a00:2e88:b0:848:2f71:b661 with SMTP id d2e1a72fcca58-84843000749mr1202846b3a.76.1783489001225;
        Tue, 07 Jul 2026 22:36:41 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e88:b0:848:2f71:b661 with SMTP id d2e1a72fcca58-84843000749mr1202755b3a.76.1783489000489;
        Tue, 07 Jul 2026 22:36:40 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6db29d1sm6484592b3a.53.2026.07.07.22.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 22:36:40 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Wed, 08 Jul 2026 11:01:56 +0530
Subject: [PATCH v3 17/26] mm/mm_init: Annotate static information into
 meminspect
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-meminspect-v3-v3-17-7aa5a0a74d5c@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783488714; l=909;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=4qnpCkPRiE5CsuQx1UWQEXlwAhSangPKX8XiWfRWTRE=;
 b=z97EtvKBT6y9k21SRqlalAiHkntvPI/WQIsgr0jHNuEecXk60Tdz+odDPSt9xKDoeipWusU9X
 d9152pff/1jClPE14SdlYcsdmZc6dXry9myPmuVfXbE/BcULjts2es9
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Authority-Analysis: v=2.4 cv=EtziaycA c=1 sm=1 tr=0 ts=6a4de1ea cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=R-PfVeyQBJMsRd_P_MAA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA1MCBTYWx0ZWRfX7Iszo0igWOkk
 f78LlbROASQniqyai71Cp4E8UitzUx5UH74vd/5l+h4a3PyRlT9WU60X/XF4lCB9Unf6bcCNdWX
 c7H8D4XClmv6cgr9CkBAX06NXoBTgY/OzuNes9tDAF54UvhwIrPvAkj72+jy0sN+ZBfpNcDbugW
 GMovD86AXN4xNj5PMCGO8LElbmALDKXrOuxmTkRsY7/N92OsFGvV07OugDVUwcWXdo5VJerpXd1
 flH8OKCm7LtSmZDDi8pCObYMfaa9wTrZzmPWif1NoquJqJB32C87M2HJgtOIAG2PlUiYlGiyZJM
 ELhb1vs/VVOOsODqQRoHodJ5qXnUIpVq6YbLygCpAy284ulcRmOPMifuQvcjNlJDbTA+fGETLZy
 +GQKDWd+d00fKeVEEyPIrARXT07D+Ddl2f1oHAkiuGJMR+QrQ31zcnwS2ugSgE0N5BPmx1TQgKj
 FC7uFQWgbofsHZ2M21g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA1MCBTYWx0ZWRfXzl7FMPpVFe+v
 RAMJNtjUX903aj5B6xBBvWKDl40Bh2yYQvVMhW+cbRHhGfGwJv9sNHSUMwgKuH4ABeUV16M2lep
 NF4KP3AI0iwTbThJqtuxN4INROVf9bs=
X-Proofpoint-GUID: 1ObWO24MpNCD-KDnPoG2VqAaJ3jpYD6v
X-Proofpoint-ORIG-GUID: 1ObWO24MpNCD-KDnPoG2VqAaJ3jpYD6v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080050

From: Eugen Hristev <ehristev@kernel.org>

Annotate vital static information into inspection table:
 - high_memory

Information on these variables is stored in a dedicated meminspect
section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 mm/mm_init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 3ff2e90aa17a..d98b6071d2a1 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -32,6 +32,7 @@
 #include <linux/vmstat.h>
 #include <linux/kexec_handover.h>
 #include <linux/hugetlb.h>
+#include <linux/meminspect.h>
 #include "internal.h"
 #include "page_alloc.h"
 #include "slab.h"
@@ -53,6 +54,7 @@ EXPORT_SYMBOL(mem_map);
  */
 void *high_memory;
 EXPORT_SYMBOL(high_memory);
+MEMINSPECT_SIMPLE_ENTRY(high_memory);
 
 unsigned long zero_page_pfn __ro_after_init;
 EXPORT_SYMBOL(zero_page_pfn);

-- 
2.53.0

