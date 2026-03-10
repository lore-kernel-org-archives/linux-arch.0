Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0673E9F8A
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773173836; cv=none; b=AmuZI/niIux77t1uOa1y/PIE3NsYvDsZTGFs0k/vjTib+hPnMMkZShUwRt9f0EulYGkKs9ZG0sAejD5txvtzrEmiNQfbS5MU0/VgOZJGdQMfJKCZvm1b4ZuCCByhJnQjI8qKJ7cecFFRcTXKkQ2E0AC0+ASgT3xv9Bxvo1lW/uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773173836; c=relaxed/simple;
	bh=hwTKx4AO6/xs28moalEx4R0KYwoB1SNoDfcBPsxkMek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sCN0TmOBb6SL4I57NEb7JqDfMpxJBTfsisEXDwsNH3bcOLXkOvx1x779VvynpaCozbR5RXgmpvNVm90B7zgss9M43VQtxK/SecnDoQqILVvQmfU/SCvI1u4gsSunxnlYRMyFglMeHMgPXlKLbhKSzWmvRmsR9PbuwJZblnXopW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d8M4xU//; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h7l1FOxr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d8M4xU//";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h7l1FOxr"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AGGvJs508294
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:17:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JMbcxvfGnpO2kUkVDeQzzJXRTIyuF4NzJgKQxZFl54w=; b=d8M4xU//pa3iRcZL
	9k2gcobpvQi/oLgFMti2zHaQKpYMq7WC5KHszs5r/5XIooXIqOsUpJ15qyViXx1c
	PU3UeFWqpJLWXPclVANvs+AS3eFmEahvLPYpBj0/SREzgXgbUm3Mbcp6zP+/NVh6
	V4y9Yf9xhbOzBsjeNr6u0YfPCG3L5epl0SWPeGoGNBQ1XzKSx3inWfS9kKkrNFGo
	oCllBnobYFaqkD58GCFm6fGVgSQM6qLbiCMxb7QKOshg+GjEK+KVIZo+FOiWkdMt
	rs3SKjNQTu/GW/6hV4fMJRq8kcmfqC+iK5XkF2oudCzMZrbWZxvmbhTm8pQBFfBw
	BnZHQg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctppagwft-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:17:13 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-829942cf9deso4513137b3a.0
        for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 13:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773173833; x=1773778633; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JMbcxvfGnpO2kUkVDeQzzJXRTIyuF4NzJgKQxZFl54w=;
        b=h7l1FOxrtZTmF1mZh84e0Fv+XRbsTg1SG5dEUoS9yxNx+iuyI7ZtiWPhre+QNeAS8z
         fPgQea3KFtoy4GhR4Ic2jud6lkBhBBY38FVzfgtRPVWD0/C7nlPts+tfo9xxzK0I2dbu
         1mZfFh7d+uJ+Uq4rWZFa4k6fv3bya6mFvepsMiwW1TUW3uhySndzM02y733dBXZYDMo9
         v8z+dg9sPd/fN2voPlegfnQNm5kT/aUnWOXpdqk/PXS//PB4M7mbA84YJgiNPGwkfN8L
         oKXowrjsVpZuPwDJN5gr/ohvdlgndkSXcfSyd/dFSy6riD8y2+O1F/k7ZzZleb5s/bX2
         Rp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773173833; x=1773778633;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JMbcxvfGnpO2kUkVDeQzzJXRTIyuF4NzJgKQxZFl54w=;
        b=M9EvJKLaNtuZ1F5oWepVNzx15HXcqgIpHPWNaXX/btv1tUIuJ/iscSkcGyHrpKKIo+
         ZIbQYuPPOSLMNldHwrG6pyR0zz6XSdOpP9MWp0m2FOCYb9KncqVKz94PjESevV6MYnYy
         KOeHl6Y72LRJn2G2lSQUrFSmwzQYDgNh1pJLZODja95pTG4rY1pQ6Tv84o6m4q4zvzAt
         MaELUCuqxtggROGMRt+t01C+cXqoxF24GPxFI8a70nslAoBpLB8WgLKP+OkHoY3V/gX1
         cnvMIgSvvcchG5CYGmT3YTj6B42Vsuh8REtT3e9t9cAvHQE4VwuWa8lwHEXl6dPWRuMc
         XnJA==
X-Forwarded-Encrypted: i=1; AJvYcCV6AW1F2neBdb8Ncrf9fAicqp3iaPeJdz3J0d0Omul7OaaO4nkN4ZDGDYacQX+XIxPCgPYDIChaEfO4@vger.kernel.org
X-Gm-Message-State: AOJu0YxD9a8aJDFHHt+QDjlrD7u75/JqpWwPVTmQ2ILe0OfEXAv/VbHi
	MC0XUU5OmHuqB9R7bLvEvJ3T6IwiH9ddyGVl63ijdY69eUuegkKiG3fK67TYg716uV1ZHSHHiVj
	JOdgZGH/9YvZl1CMAqUx1mbqastfU1/mbVV88g0LgbjXXMQDPzyOBI7LVTd0bxn9O
X-Gm-Gg: ATEYQzwEkauwvIAnzrQzjh6YDiaKgHDwJp0BRwZjgU4PfZyi2FqRo3E5WjJyMdPKq2s
	ikOlbVZkT8ryVkqsjG+/ebtAMLtfGVLFfsfzbwGtQ3butz9PArmX9zprZIrxXkwD/12eB0yrRVN
	Qc8JryR2T7mI9jCl/3VurwIUmr6AjpSzGsWElTlFlaUsnjqZW834wiY7NLO7gfAbwf3q0hBTOY0
	GHtialxp08s0q1OtZjbM11utgmInqlPyHuWvMTN40jDbzlGCVwOwazQXEhnUKHTAsBWqzo61A94
	s+1it3aCz64UKKYW/zsHjcMw1pn0xVl5yVBtwfrL1In7l8TzK7w7mXhXKtO/5pJzKLrxWWXeR2U
	Gj+mk9fbZtVHjdK4Gr3dpi2q74cqFZlM+y7SxO3rS5Mwe1Bcz
X-Received: by 2002:a05:6a00:1582:b0:81f:b97:14a with SMTP id d2e1a72fcca58-829f70d574cmr110735b3a.61.1773173832810;
        Tue, 10 Mar 2026 13:17:12 -0700 (PDT)
X-Received: by 2002:a05:6a00:1582:b0:81f:b97:14a with SMTP id d2e1a72fcca58-829f70d574cmr110660b3a.61.1773173832144;
        Tue, 10 Mar 2026 13:17:12 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6dc2d0asm115262b3a.13.2026.03.10.13.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:17:11 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 01:45:48 +0530
Subject: [PATCH v2 04/25] cpu: Annotate static information into meminspect
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-minidump-v2-v2-4-f91cedc6f99e@oss.qualcomm.com>
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
 bh=JIIb0fgbimtcknN5I2sV/aALlXS8ugEHIxtl7tKUkUg=;
 b=yXlU0vbeIL+rP/TVk5DDTuofv1NrCJH8YoUDw3a/Y/cDnFlVa7jur1W2IPvmwrwhu/aujvbGx
 uIv7w8SUm9zBOJWsYqXfqlc9L31mJK/006ep+rZj2cSkRngOtM577Hg
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-GUID: 3HT0ulcmfVNyA2MYvUvTQXAL5qQ_0AJS
X-Authority-Analysis: v=2.4 cv=D7BK6/Rj c=1 sm=1 tr=0 ts=69b07c49 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=3A8An4GuCW952TOlvi4A:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE3NiBTYWx0ZWRfXybANLJ0IB9Jv
 ew7tDX7Uvl9Oqzvp07IshyZEcqEYhj+wJJchWwci1HYEe+H2ksAuEQd/e99393ABtBdvtluOqpR
 NR9aLsdLHGMQrRB5hs/0TRaKZhU6J3ReB8P8Au8ECtsM6j3F2apXqQCFhE4Y9NvFfY3iYXMNxsu
 rXt++3KKljL5VMMFZryksOQ/V3GJdmyS0x6zS6mvwaUmfrgT//oXBXrI6q8PGSSLNE9NC50FJYC
 62pv+cw7SG152dl/cx61wM+oiC1SPDzrvJoN7SAwNalCEaNb5J7wEliLcdxMiLYIqenM0ESDNF9
 xvyXGxFhhjF/0ASjb6WQSeIofVw1jzXd84bW/Rz6jx5Ioae5xoketOB0oczpa8vjH9iVB1lJVNx
 5Z+xw+s3iNdLhJItNfKXzHgU20L15zMTuEuG+yngXboSRpYb8oyNX0R+T9/jlonsuMfBERoaodU
 P59jD51J4YCCTit7nMQ==
X-Proofpoint-ORIG-GUID: 3HT0ulcmfVNyA2MYvUvTQXAL5qQ_0AJS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603100176

From: Eugen Hristev <eugen.hristev@linaro.org>

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
index bc4f7a9ba64e..25b0fffbda83 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -37,6 +37,7 @@
 #include <linux/random.h>
 #include <linux/cc_platform.h>
 #include <linux/parser.h>
+#include <linux/meminspect.h>
 
 #include <trace/events/power.h>
 #define CREATE_TRACE_POINTS
@@ -3087,19 +3088,23 @@ struct cpumask __cpu_possible_mask __ro_after_init;
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
2.50.1

