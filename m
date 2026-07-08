Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFDF360EE4
	for <linux-arch@vger.kernel.org>; Wed,  8 Jul 2026 05:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783488798; cv=none; b=rCuCtGda2oLKn/ehyQWY+3g3xq/5+ncqyeELi1cM2LkEN3EA+jN8TrxeSF3WMgaAYfStBehibGU89WSzfqAscb/v4E7BljrS6G5F41DORaZ+bjpCymm7YxL0VEogVT2rnC8YZOcDCO2eWtIM/ZWlT/+RHqLeITYax3h4x1SECcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783488798; c=relaxed/simple;
	bh=271DJ9jgC45m5gX4TZNLlhbT+pwRoJn+F1VDPJD1wOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S2lWhoHn+OL4000U9c0pdve+gM0MrF2VRc+HGRZGifIb97g5bdByQJvT6yJDWQKKu8T/wHuMBGIq+go2N4HWsQDMRAqtUIHocCFWEcMHGQOnaLXrbdqSes7o7A7TrXYJOoejIhpTwkJy5IaMwimsSM9WVpo9MJr53+NZmc76tA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A7BSBhmn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xg7cziYx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A7BSBhmn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xg7cziYx"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66842h3N1625072
	for <linux-arch@vger.kernel.org>; Wed, 8 Jul 2026 05:33:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KS6KjK1VRA0E19Ye/3uABUACVvGYCQVpFSdxjmPI/eE=; b=A7BSBhmnYL9DWL2C
	l5JDHhwJ7GrYQHhPPKjA404myQsOdZd2oyRn+UsW04vWmNE7TR6RTv4dXk+7gp/W
	3y7LDxyAXAauz6Eua/VvYIpk4vTPWLT1P+6f3kJrlN3vryFcLA2EkxxJBRVZeR0C
	XIW76Mbl7R7fNY2naLO2rYODQ3AAMHozxgt2IhBGFH2mQJf4H4S2sxqSH6zxuT1O
	XfaZ3LN+qpSMwaexOrXBNB5vW0FoS88oVDIKRiNzYTuIz+vgY9Hj3jeupq4y/6BC
	q3ZS3yRSpez49f7J/yMTrYGBbGA9hrUu1U9DFw4X+jZKtpgjgo5fTKGdSYV7oNtf
	oRNmsg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f95fd2ta7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Wed, 08 Jul 2026 05:33:15 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c88ad1558f4so562488a12.2
        for <linux-arch@vger.kernel.org>; Tue, 07 Jul 2026 22:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783488795; x=1784093595; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KS6KjK1VRA0E19Ye/3uABUACVvGYCQVpFSdxjmPI/eE=;
        b=Xg7cziYxD0IHZZulvIyRyTn46JYdUSTlh/dx5kz/xyxhTHrYpqFAqL/+z0iGAYWVbC
         9FrTyTkk/N8aXeGGBvsympoNp11m2E/pXkBza3hhZmtHL4m+ACFr9KPDLurcEBavRhvt
         Qj68fCaVn+peYONZ11iepNkWEjAURQtE04DGp6wE/ZL3QhdUzAMoiA7kMHVDIxOEVa4n
         0871jR/+ELA6yXSCQVphdVBG52zT7lW27OogVcfo1dkdOXbWaw4druNVyE+8/G/TzGwJ
         utkeIeDKMx7UWvZraB1F5nNA2FoQv3iE4d1vVkVIFDe9dU6zYUfemsqBP36YmGZbtWrW
         eVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783488795; x=1784093595;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KS6KjK1VRA0E19Ye/3uABUACVvGYCQVpFSdxjmPI/eE=;
        b=NL/2yr+1+crurQAAR/G0lG1Q8ZXcOmLn0GKh5ooG0YJYW9al2dePiu962U1j+LKIBr
         MdkEVT8S4dxOLSe68mBV8VZc/QAkGI42QIBkXLWtAo1EnoGDdaACqCzc3Az7fFnxENYE
         OyHC05Y8ngJOAR1dE03zu2Q054IxnzDESdTIRkuSMHB+TEN5yiHBWb2bclJnYz0toxjA
         V/UDvcM7rnd2V0JZnAHQ1UjwoN4IFzoRXMJtEDOZrtEEDSDCbezHf5p95a49rVTI6gx7
         jFV1//Giws9mWZd9vujxeAPFbhXKdaASMew0q3mWXSrbpVoW1J7RGm/KlHeMAsMyfSNJ
         DFKg==
X-Forwarded-Encrypted: i=1; AHgh+RoFrdzsA90RkJtwm3iHIWPVYKqD1pWIxM3AmlTU4llkh3Y26LC5J7C/gDOhpa1z+ow+l/LLQTpBxnZS@vger.kernel.org
X-Gm-Message-State: AOJu0YzdS1JhSlg+r7WLuSpGUush+LdquYbekz8JLL5d8Ek/4aKWGgHe
	B98kHMJbkU6eeEYUw+vagSLCxpLs6h3tWtF3hFgZxM9i6hVLSZzdCAvvmbeusoeJTfcHRzvXhXe
	9ZD3WS47po3cghmTs7qSMnen6u+TntXQBElEdEOwFx6lMeCk86q6sVsXJMakHIU63
X-Gm-Gg: AfdE7clcDxhOmZH62Mf/bODQIOuB3uCiB8qkqBVhCFNaeVd3tadBbF608y3aGuYIBmC
	0Z0BnWZ64nbAFw8Gxc/0G5GfAIg15LP4DRl0V9nhc8hP4d+UlOpXCAP9eriZP+9RoDsHeuQFlIW
	N/dtiAUSUAhmf4HrRPnXSM5oPRHn07OQRAECKhP7Xm18arFua0d3+CeWQU/995K5F1P2CnrwfSp
	VZ5WEy0SO2GDH0P7fH28Vj0ElzLhQPDmbGSpHn6AYZigSQwuwDNOOc2WDdFxO8Uzvo+mrxPsBSG
	Df+8I7mjh9i5ulKtTXjulPlgMYADiFimh39JilXCCBxdJ93LKSIcuYHStOVm5lGTeiHoJHuEilK
	UNZ3KhN2tQ64vFgXFcjcTOcg0hjLhvbIqvtHoPQ==
X-Received: by 2002:a05:6a00:9510:b0:848:2d1d:836f with SMTP id d2e1a72fcca58-84842f090c1mr1174813b3a.28.1783488794561;
        Tue, 07 Jul 2026 22:33:14 -0700 (PDT)
X-Received: by 2002:a05:6a00:9510:b0:848:2d1d:836f with SMTP id d2e1a72fcca58-84842f090c1mr1174746b3a.28.1783488793925;
        Tue, 07 Jul 2026 22:33:13 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6db29d1sm6484592b3a.53.2026.07.07.22.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 22:33:13 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Wed, 08 Jul 2026 11:01:43 +0530
Subject: [PATCH v3 04/26] cpu: Annotate static information into meminspect
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-meminspect-v3-v3-4-7aa5a0a74d5c@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783488714; l=1623;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=7tcV3EojDUJDYXtqUmecbHdHj5TxMJCFkfbTBXEPzZE=;
 b=uPlnXmsDJ/5XV/qNRqQUBd29GoRnPLMg69Q8kK5yzcp43jc/cas0ETVH8wiJJdiYqnzbfi3s9
 zEovQovAgGzBkEvohecMwfP1GUVvyzxtLtHFt9S/LksPawXMLNMVZUu
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA1MCBTYWx0ZWRfX6e5BqGNV/2ps
 ty0oqcpYyhmbzBE2iu63rvs95K4NdbWVNJedmYWsDsBImaaeX80YbS1C5OmFXCCSgNld+KHm58N
 wFmTqvhBP7tzD0c2PaueNChkZY3r/ZZXHQfuIr+xvwwo/6U7wWdpyyxOvK+kF7mAC1SuqBqM2a2
 dfENlEMaGG9KLKt4RJMIzExG6klgjIGsR0+/cumsp/P7YHLGO3jGuR9cBLdOE5RxQAo9tW2C6z1
 c8TbflYbBut1Sld+f0cRyLPsHJncvaSi9IEUXlHD8TDoDayIi8N2lAPFb+wi3wEFRGJmDgnS4fw
 4k4ct6jCYf81Yxce1LRwYF8jPe6lNoai99bdnBMsQ9g03rwtvY7q4TP9xjo04N4/3cLx3DDNANp
 ES+dCDMHd5EA5DbmME5loCZB6Q5HFwLeCCfOXwLyFNkgOu3290NUWcdOXMUS9mIzjBEbRl/BufG
 gCZ5TdAcq9OJLvmxaLQ==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=6a4de11b cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=3A8An4GuCW952TOlvi4A:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: sPZOpEG9V4iYVC6SClJwAvGhNbSX_SHI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA1MCBTYWx0ZWRfXyBhUAelkgArh
 PMWXhgn65fVZcwQik57yMTrinfnFUi3RdQhNnRrF/pOlya3ulPm1nBnA9iQz4osQjzs6ccpMo3k
 scIG+OLAIGiT74vVFktXothuiXmr8I0=
X-Proofpoint-GUID: sPZOpEG9V4iYVC6SClJwAvGhNbSX_SHI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080050

From: Eugen Hristev <ehristev@kernel.org>

Annotate vital static information into memory inspection table:
 - __cpu_present_mask
 - __cpu_online_mask
 - __cpu_possible_mask
 - __cpu_active_mask

Information on these annotated variables is stored in a dedicated
meminspect section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 kernel/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index b3c8553d7bd6..01c86510124f 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -37,6 +37,7 @@
 #include <linux/random.h>
 #include <linux/cc_platform.h>
 #include <linux/parser.h>
+#include <linux/meminspect.h>
 
 #include <trace/events/power.h>
 #define CREATE_TRACE_POINTS
@@ -3083,19 +3084,23 @@ struct cpumask __cpu_possible_mask __ro_after_init;
 unsigned int __num_possible_cpus __ro_after_init;
 #endif
 EXPORT_SYMBOL(__cpu_possible_mask);
+MEMINSPECT_SIMPLE_ENTRY(__cpu_possible_mask);
 EXPORT_SYMBOL(__num_possible_cpus);
 
 struct cpumask __cpu_online_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_online_mask);
+MEMINSPECT_SIMPLE_ENTRY(__cpu_online_mask);
 
 struct cpumask __cpu_enabled_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_enabled_mask);
 
 struct cpumask __cpu_present_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_present_mask);
+MEMINSPECT_SIMPLE_ENTRY(__cpu_present_mask);
 
 struct cpumask __cpu_active_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_active_mask);
+MEMINSPECT_SIMPLE_ENTRY(__cpu_active_mask);
 
 struct cpumask __cpu_dying_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_dying_mask);

-- 
2.53.0

