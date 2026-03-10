Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0633BC687
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773173897; cv=none; b=BP61sZsCspCuOxtjegIMcbP+EdXuYBwsHkvlnkiqjXcWncTJzh9ZZQaRaC6t0qepyGAnoHKJl0gNKvvXJs8JM/a3P8U+qQ8l7EnQdZUBRFJrHPNr8Y2XQza2bsYL50k4kn8UY+rGye3wpKe0D37fOeTN0F2hGMxTn43yLJPR5UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773173897; c=relaxed/simple;
	bh=0ritzErIaOpABamjKjWNtLluyjwBIb/S6nslk4thba0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QTilKrIN1UFryfMPsjhJF8exmDJM6ycq8u8Msih6JP4/vL17OVQlS0P/P+lb93fE42Kl+uJUHRVmtlOqfT31pt9+wjeB4RczX0JuKMlXHhftxsILbwNjdrAR3ggeNTeR1pCIdIITcuXx42/IYQ8XV+dL38Sisn5C3ivTEUpR7Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ThgTmnWO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YE5L8rqt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ThgTmnWO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YE5L8rqt"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AJ07AG3417921
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GUnRC5Z9iDEsUkeDXjt9L4ivaeLdDr4kj19gbc3Hy6I=; b=ThgTmnWOfvbZeQo1
	JmhSGY/XWUnWavEygPXUvRtSQuzM7eO68HBklkhFXiEJF/pLtdJLv9M+QvmNdpDB
	53Uf1epX1mwcmxWxQ1hUuD9kbeKWXsJMxUE5Owva3qpevqhT2s4DprTxmfaEsHRV
	AS8AUtpw1FcKodPRvcM23BVifHTzbJE2vlQdv2BO45BEGoN5lT9go52vFwF0Al1i
	jzr9rv/rVfs1Qli/kRemy5JL6zrh1CczgpDCntp48GdKc27UkzLmNceX7dJ1QTfu
	SmrbICVkKh5nF70f1D18IYFvLjwJBpM30gywzH6qahOL4lGsZ5J6XKCACmAucW8W
	cvRrgw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctja2a3pr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:18:14 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ae49080364so80589645ad.0
        for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 13:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773173894; x=1773778694; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GUnRC5Z9iDEsUkeDXjt9L4ivaeLdDr4kj19gbc3Hy6I=;
        b=YE5L8rqtFEU6EzNvPcMhB0JYHDcnG58RTV0joEEWkpgrIRtsTK/vMV18v9uCD/7acU
         ulQdL8Q8cD7zPW/AvGu2DaxcU19mqCI/he6BSXmz6bcmzXmfh0qQxTqIQSV2TPtBryLH
         Am5MAF15OQW3GL1qvmsAAYgE0k1HXs1ymXwCJEtUojTVHGJXmu60cg32Sp/jT/5bXMcv
         5Sbn7f8x+/F+AQ2+8YBZBUknf5znxQaIj2r77ksq1OpDAxRsaUKLsWMki3fmnlPSeMGi
         +QxEjOhxjKhil1iCApzR+yfgElWvaRfN7Y42G08pguYY5P5i78q8rNLn+OAh+dlnQwgU
         m75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773173894; x=1773778694;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GUnRC5Z9iDEsUkeDXjt9L4ivaeLdDr4kj19gbc3Hy6I=;
        b=B3xBtz6MSuA+HMzX9gr8Wd7QYypCEzPifKpQ/GPw4IGm4nn//imlHxmq4sVwtDWVFE
         +cjOoYW1swdD/COnPgrXcRU+y5UTAuh2UQrg49PgBDtY+YC9lYvXMpgMki91uwM6mLwm
         ONdNSwc/DW1T0nnyownCzLyVMq5YA/7CCPEEYbHXMJpc8yLZ9vqlBdPq0bfnGzshu9oE
         4M0A5p5UV6mcbHV7+k0JHhz5hsp5l68VAAw9Cd5PIr1x9nOHO1XFUJ6MS6+Fa7SXWXNC
         MsYzLi0ixhC861E/kC8JqTgNCQsxqLPJSHwXCYy5lO5zji4FBGKKnOKltDC7IXCnaj0T
         jQbw==
X-Forwarded-Encrypted: i=1; AJvYcCU/rBagMHRHCgf+R7+BmJT4Ku+MzIUuZXUwTQd48B8yQfJN0IwHmQDKZRsNR9olsocgQOTLmVyRxoPk@vger.kernel.org
X-Gm-Message-State: AOJu0YwZZ+XrVkURjPIWpOq3GoVFQCX5h+OsdvVKWL/F2tjcyQ7aVTnG
	j+WJ372JRhfRdjwHvojRfNJ5arJj0YW3njW8QunOBApzkCI/7eBhLn4GcuEEll5/gaBfpO2C1Q2
	mYgjsZQiGXMo8eM3oyBHcpPxBSArTPAxFIqCyd0eGZRoDzDnmqgy7hhO6n/q94BHf
X-Gm-Gg: ATEYQzyrnAbhvOyIh1J78ZeSuSjrWrZuSN1kLT07/q7ZlBEnYYNl/MrP7tOas5uWOcF
	PxxwXEbFcyWnP78AaUWd8PcAIIw4k6iDIBx3nxVbYw3Jyhui+Hef/uoWfJEeNO0Dsq9I5PeboiM
	lpIG3g1MKCtgd/shJctYd8GYlHkZdDka2GJClm5fuTUh01E+FvW0sCp4DeYZF043gFDqxUo87BU
	Js4O3VXhMy+LRKJccGlEv1DFzxIEW3igbAg4jcIln9sH9Jxj9q5PaR9eAW07fly87gVmw6rkwnH
	brMrj8NVHZVsRAHv4RBm8/7DZvUjP9zo3FRBwnqkce3qxEuIiBUFOSrPSz/n98uOekvlZyYqfCr
	JS5B8jW+AFxqvLUDEItS7TNfDw/WTqSwi68UxRkKrJgEcsVoF
X-Received: by 2002:a05:6a00:420c:b0:80a:fc3c:f839 with SMTP id d2e1a72fcca58-829f7078837mr151535b3a.49.1773173893783;
        Tue, 10 Mar 2026 13:18:13 -0700 (PDT)
X-Received: by 2002:a05:6a00:420c:b0:80a:fc3c:f839 with SMTP id d2e1a72fcca58-829f7078837mr151503b3a.49.1773173893211;
        Tue, 10 Mar 2026 13:18:13 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6dc2d0asm115262b3a.13.2026.03.10.13.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:18:12 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 01:45:52 +0530
Subject: [PATCH v2 08/25] mm/page_alloc: Annotate static information into
 meminspect
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-minidump-v2-v2-8-f91cedc6f99e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773173756; l=951;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=WjWOTE5wCASvyqTEqQTC8D45Mnb3Je5ENWQae6LBsc8=;
 b=sCMEZiGoy1i3RaFgw2bPkErqvS8tQsW6y9j1/DY+TYT3BAmsnGCCvrBuUVNv5kpwQ0AKxsqsc
 0GXsjJqIPzVAxAfgDVGIQ0i5cxpLM7I3P0NkJ56C69IwXRBjC/8natt
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Authority-Analysis: v=2.4 cv=c9WmgB9l c=1 sm=1 tr=0 ts=69b07c86 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=TiJDLkziv7N9Y1Svq3wA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: iI5EL7LZCwXmOBq66WAUbXW-DtX34_4B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE3NyBTYWx0ZWRfX7yI5GHtOgcZa
 Mssor2gvBQPpgUzGgWWPgfkp3bJynUdqC38JG6TXMwaFAtpnnpTUS+uRzfpKuaM+Phgp44GrMt7
 X+tRuG77QTFZGdNfmXE4CqyyE2yqUlFyceg2ZQOyWcTZnifigQ35Q08Oo7/iA/Op4VGNC1telly
 zgvT1xKiBxUszZfVbzBYNZhpYfq2W8k7ndSg5TzYkj3XB/0J6Ue/YQifL1JCBzRucZz1pw5LeMX
 a/8ogcoUTYI0IBkLThbYLoJIK9w2sHGqyqCtaVi9r4b+O2+Lmzv8uL5cg9qWtRL29OOVPR6alHI
 /7oJCgLUE/1o4DkH0x3l+SFJyD2nzXUiRq8NeYN8oy97RQmDj+0lh1p9L86yA/Qx9+saav5iIKk
 g0D5lzUVFz9kA4z1yhHBi8tEl5CgzL+XzOi7Nr9oAwttIXv++xKbBEWS+g3b9bwkMo+qvzXNfw3
 Yf5C3Jr+tTwMdkAHDtg==
X-Proofpoint-GUID: iI5EL7LZCwXmOBq66WAUbXW-DtX34_4B
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
 - node_states

Information on these variables is stored in a dedicated meminspect
section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 mm/page_alloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 75ee81445640..c28a84d11d49 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -54,6 +54,7 @@
 #include <linux/delayacct.h>
 #include <linux/cacheinfo.h>
 #include <linux/pgalloc_tag.h>
+#include <linux/meminspect.h>
 #include <linux/mmzone_lock.h>
 #include <asm/div64.h>
 #include "internal.h"
@@ -199,6 +200,7 @@ nodemask_t node_states[NR_NODE_STATES] __read_mostly = {
 #endif	/* NUMA */
 };
 EXPORT_SYMBOL(node_states);
+MEMINSPECT_SIMPLE_ENTRY(node_states);
 
 gfp_t gfp_allowed_mask __read_mostly = GFP_BOOT_MASK;
 

-- 
2.50.1

