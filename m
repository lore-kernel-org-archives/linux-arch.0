Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8123E92B8
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773173972; cv=none; b=J8PrqWDVdpIgn61kM0IqdLbhDHbBZXgkUSIaUp7WButEKnLwB5L3n5SCCfvC62OuIrZRe8qU/5L4KjaP+x6CLwMgxov6pl4xp1pEAPx+AiMxGt1Y8MwjVCBsfquOckYexvrfmQkHvby3oG+78kRc6iY5IPfmI0yZJPAuUR5UVjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773173972; c=relaxed/simple;
	bh=SDVzuWlIT0Mtepv+39geIXaXq+UWjaDr7JbnOUNe6QM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u7VhQg4I+OgLG6nAVAP7gFEiRrbG9amr43BKRvp4T/zeFwyrEAFhqEl6SJe86JtCcsU9XhqaNPUFVYKoMyJkBU4fS+TVM3rDMTUyxF8csSGka1HEYE0bbHnQxpPrLrd7Cfwtfu5iETLD5fm5QPstJSpTIflPcDWyJGPVuFLNdDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lpukSPyA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RFJEfbkt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lpukSPyA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RFJEfbkt"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AInf8Z3417140
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:19:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o14Z2a6/l2NPuJTTgYLWWvyApkp7bYXMngm3IoV823k=; b=lpukSPyA3VeEnHyR
	NLJSoEqP4ax8Yy2GOodPU4MzO3kLLtNTNCVaqaajOgmUE5ZC1WAur70H7NsehL4E
	GtQ9HNrCOhegZZFynzYM6fnATHBTeZ3o+wH/Yq7J3k9EVPuVbRRiMMPsDcwFHuHr
	XOcT39XRmjb3bwN52r+AnJZD5kU118bZa73vAx3Yv5QoYGmGpkvts05pinATjuhV
	wSf0t5jNLICVa69+TV4FioHsK/egPTVNgWdbu2uEL86s5BWsNV2aJzVTNYENoA1W
	qnHbsscQCwJAEsPoPKAyDgJSgJIn5hOHgQes0gIOMWxoxEEMxkkHZcjGIW7N84/u
	tMOAvA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctja2a3td-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:19:30 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82988b04c5cso15186031b3a.3
        for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 13:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773173970; x=1773778770; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o14Z2a6/l2NPuJTTgYLWWvyApkp7bYXMngm3IoV823k=;
        b=RFJEfbktKiowYBV2iPbyR/8QII5dUu/1/5LaSPsOXYIpY/hZ5EHKzrflWTBOisZ+76
         J9seCoZN0/o6ZCBZczZ7KePFnoeY1AsSs49PJAy+jbQVzq/kU4E61AvCp9y12kSOUNFU
         aslBZtsMaM8Px1hhrqEwi/k1nhBzrXPm6DXaPzx2CL67P29Wb/SZ4v5FCP4+1SAn+Em8
         tZIDG45yVGbYd+BbOc3vkcKZyBaehJxEW2QOoMZ/j5fdSNPrI3Jl/DsMidTTgHCzJlfo
         kUTIki0jGMhcyVvjNYA5Q66AUXKgBscm8yzykgnZ3W3BAI2gSt61hQEDOW7/nvQvTEae
         esXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773173970; x=1773778770;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o14Z2a6/l2NPuJTTgYLWWvyApkp7bYXMngm3IoV823k=;
        b=SlxYjD0VH4hDXgpVFHj9nqgd5BFVZ75xCPzcJhm869ikvcSxefdA2qKGqYaVQ5WFkm
         dwmW3WtgPRsIUlnx6egcbAK6Booz5Alen2jTrFEb8QpvO68/dwWWZtBIkxn3ia1erT/a
         r1sBP1lpmzvby1rG0veyTKDlrBDikRHf+RdnMZXWL+bkpdp5/3UlWF/uDkr/YMntJJ4M
         XgdaVBWLBk3XY9rbT0bnkZ76hu5E1j1mZB4Bpn4uPuU0iKF3bvr3OzHfLv6HJWELYIYR
         kJ4D9o4lysV0bKsrlyZZOjpjCbS5Ut5v5BhUFT8QZUh92WH6FlcONdsS9GhOrpi4ECI5
         Co/g==
X-Forwarded-Encrypted: i=1; AJvYcCWcWHBsDNDsuvl7W/tPHMd7Hsiwi2wHPU/NlvB2zV/+wRCsJPnxnJTzk/JCEgtymU1tOOeZLyoTaj1s@vger.kernel.org
X-Gm-Message-State: AOJu0YzPIysJ34XS07ngH1fVhf8fuw/MdNotXd3oX673oYKKpje/vZuA
	yM3nbmmK6HNaalUqQ5SX0c6GaHJMYomnSxWcrsBdDBSAYh4WsrGa6hGwHrbjk9d1oRZys+vyX9c
	wRRbhmdOjaRzZumvhH7qqJyFBWvxUaX91PvGNodjpLOP3zc7OmMRP3gb0PVsn+4FH
X-Gm-Gg: ATEYQzxGD2QDqce+XN5BH8MSyMkYitubAt4LpWFdtkIa3R86SbvZvR6Wkb5I+lzPrlZ
	JvTPubUHdoNyclym9N3E9u2Ndhfo8OcpwwrBdV+pKr6yoexexsensOZIzzqiOczFKz8IGzAAoRl
	x6OsVpJ3LLSdTN8zKlDkbkX1WerisqsheduYHE83SWuDJZFQhpmU+a0FpfjBLmQb7UW1qd2B1SO
	oDXZm3xJITbh20dlvaoAent0btScR4aYNcJ+zYm2kgFnMaQQrEs8sSauzm4l8f/885LfzY0qdI0
	NP8PNbClTXddic0Nw6D8CHj/8ybDVnzzvHubOCPFZ79MXnGovrQD9lcPR2D/6TMen5RavcJldnM
	pa5H8GvTu6wut2dg+bEYIVjbJmNICdRktqkc5DzaCMPaE1LXt
X-Received: by 2002:a05:6a00:94d2:b0:827:4372:dd15 with SMTP id d2e1a72fcca58-829f710801fmr145160b3a.40.1773173969568;
        Tue, 10 Mar 2026 13:19:29 -0700 (PDT)
X-Received: by 2002:a05:6a00:94d2:b0:827:4372:dd15 with SMTP id d2e1a72fcca58-829f710801fmr145089b3a.40.1773173968931;
        Tue, 10 Mar 2026 13:19:28 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6dc2d0asm115262b3a.13.2026.03.10.13.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:19:28 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 01:45:57 +0530
Subject: [PATCH v2 13/25] mm/init-mm: Annotate static information into
 meminspect
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-minidump-v2-v2-13-f91cedc6f99e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773173756; l=1598;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=5nQ0p9n3c31Q2RIq4yMUZPGaE3IA3pjushf8tYEqgcs=;
 b=t7nzKjfrKipDpTwS4ZqlI9VkibqL8C9dDspYDVaOjrd+X4QGwj5GMAm1C9hhwSvzQOmAs+88P
 roE/qXbWEnYD4lhp8Gct4DRbuiio0CZSZC02jdz7e/q3zVjh3RXgYE2
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Authority-Analysis: v=2.4 cv=c9WmgB9l c=1 sm=1 tr=0 ts=69b07cd2 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=HJIP93yTpLwjP442z3MA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: l4c39Ig3gOsbMLsorm5N_JqxiTmSEIny
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE3NyBTYWx0ZWRfX+HMtrWqay9t2
 mOQGbdZUCoH9/T7+ssB4EtaAA4txi5Mezy6Wl5cc7AiolBlYb1lY6EEvb1WwMIjtfmhx72+EQjX
 IY2LRq+IVuhJ80scSwOW4LGB1ov6vOHQTlPlrfuDGHrTqZG7B0Mx/IBTJ7CTSBUH9FlsI5wEhWc
 k21TVWM03KCiL280VF5zmgkHb3vr7KOxf3qsvDB42PODwgyQeglBAYSNjPjBUsNUHw+czhpo+Hw
 GoIaI/YT27JCUeMzR9jJASmNmgs7sR0Adwc5JozhV1VG1ZYYv6B+JtUVG/yFxlAqwUC619di4gJ
 wqVz9gq5A7ueEm9f5MSSi2yvx8wzqfEltPWmt8t07c4yWlXGKGDFn6aAs144RG6LWSJ5i2FF++x
 X1GDt8weUAlZwOjOClX0hY6+hoNuEgnG6Jd1OF/HrLNXX7NsszdfVPBxxkslR11/Kb2HsM06oC7
 Tueq8JKkmD0ab35WgWQ==
X-Proofpoint-GUID: l4c39Ig3gOsbMLsorm5N_JqxiTmSEIny
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
 - init_mm
 - swapper_pg_dir
 - _sinittext
 - _einittext
 - _end
 - _text
 - _stext
 - _etext

Information on these variables is stored into dedicated meminspect
section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 mm/init-mm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/init-mm.c b/mm/init-mm.c
index c5556bb9d5f0..4add144a0e99 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -7,6 +7,7 @@
 #include <linux/cpumask.h>
 #include <linux/mman.h>
 #include <linux/pgtable.h>
+#include <linux/meminspect.h>
 
 #include <linux/atomic.h>
 #include <linux/user_namespace.h>
@@ -19,6 +20,13 @@
 
 const struct vm_operations_struct vma_dummy_vm_ops;
 
+MEMINSPECT_AREA_ENTRY(_sinittext, sizeof(void *));
+MEMINSPECT_AREA_ENTRY(_einittext, sizeof(void *));
+MEMINSPECT_AREA_ENTRY(_end, sizeof(void *));
+MEMINSPECT_AREA_ENTRY(_text, sizeof(void *));
+MEMINSPECT_AREA_ENTRY(_stext, sizeof(void *));
+MEMINSPECT_AREA_ENTRY(_etext, sizeof(void *));
+
 /*
  * For dynamically allocated mm_structs, there is a dynamically sized cpumask
  * at the end of the structure, the size of which depends on the maximum CPU
@@ -51,6 +59,9 @@ struct mm_struct init_mm = {
 	INIT_MM_CONTEXT(init_mm)
 };
 
+MEMINSPECT_SIMPLE_ENTRY(init_mm);
+MEMINSPECT_AREA_ENTRY(swapper_pg_dir, sizeof(void *));
+
 void setup_initial_init_mm(void *start_code, void *end_code,
 			   void *end_data, void *brk)
 {

-- 
2.50.1

