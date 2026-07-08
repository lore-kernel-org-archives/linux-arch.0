Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF8B3BB13B
	for <linux-arch@vger.kernel.org>; Wed,  8 Jul 2026 05:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783489068; cv=none; b=azuNmMGRB6ibU8d86tT7zUp0Kwr9i3qE4XeIB+o380kWkegYkjy1DeSPZWm5DKJT9fczY0r1G/OmYlhXWQ6O8HBEKJldhaPKVDFC1gMlXdgh0etFacqzlmiMRLIA/Xq8dtbM+OsZ+YnPEYQBRV8rOGXNLC6k2K0wo2uH4jxXRIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783489068; c=relaxed/simple;
	bh=zaV3PbmFUtDnw62zQ3JXo0ZBeG6yDbJIOwaDAH/EVmo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IeYr2fO4lZ+mjrJ/L2YMs/cfqD5tbi0szW/YYwL8WfcpIn/ZPhpKFMqdLnWtd1p8N7soxNjhDvmTKMCyInjcWIc/TRn8fD2CZrRyMlp86Qiq/ac1gDItSb8JmAJSG1Z9RaAxDokq0CYgbWkLCMSfXMBaB9jz6lKwOauEd2SNy/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=inU1ARyo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gXaXwxzd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="inU1ARyo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gXaXwxzd"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66842itN1625100
	for <linux-arch@vger.kernel.org>; Wed, 8 Jul 2026 05:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UVx2Ot4wYHE/kJppGaGF3PrkXXYmH0DCSaT02ef7IcY=; b=inU1ARyoLJAPAbw/
	BjRBXXcr9iSgHE6aynnOtdyQe7dqf3MeI15Yj05HHjTJ9F9ULi9aha9ooZYbXB/Z
	Fv9LDPqVG622oRLW/U1jPwzaFl2OgGK6roZTmy0mtmmf0Xzr/VXlyiF5+OAd03yN
	gX9/C5lEZpNszlb7U84WBlG9WyLucbwAnQ3yY3R2n1sJ6PygSllh+n7LFQLi8TdF
	vNMwrAkymelKH0GuXqux1js0UUqyDCPux6IVl1l6CwprwTGsK2pFmg+dxOZRiYDl
	/tu3f3ExCgBlNu/F2zkV3a9RGN31KdEFe6fw57OUKejVgfbign0bZ8Lv5sU0jU1L
	HcmNeg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f95fd2u1d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Wed, 08 Jul 2026 05:37:45 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-848452dd146so767024b3a.2
        for <linux-arch@vger.kernel.org>; Tue, 07 Jul 2026 22:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783489065; x=1784093865; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UVx2Ot4wYHE/kJppGaGF3PrkXXYmH0DCSaT02ef7IcY=;
        b=gXaXwxzd7QSQiMJx4mJfu0Hk5eU53KNq8h9wT10tgsIMtXnKtKmrp+oaN7zQrmx0Lz
         y9M3KiEMhcPiTEvXTg2FKcQWZUzW52TsJKHeZB8pVC0fKZKQKRgLerPbyUN241yuEDPt
         uPiAjybjpb4jCqghCy2alfrml5bqNSklKd5eWcSbG53iorkrmH3SZBruUCpsb2CQO+3r
         BuiVvz5XqrJPaifrLRtHV/fPw8fhg17zlAvvmcbY5+Cmrbw6xYTkpCkpzG6ZfXprAVhO
         15yIhfkAmL91tSFhVTqxbe3+MfK9Sk1rD23M/ZsuW2RNd45wbbcwLTKF/fCSwmiAW2aq
         n5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783489065; x=1784093865;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UVx2Ot4wYHE/kJppGaGF3PrkXXYmH0DCSaT02ef7IcY=;
        b=W7r02vEPW1wrZNpY6r/5WOQHthyGf3lMxQhKsYCkMqAavT8IIvFBmUSu5rswRshZ85
         QjyVhL8eHS69nHqCwEm/7jsXjJlRFR3bIIGBbctntaqM7+R1AgSYBq32/gwh8jhgtRQ5
         2YRDi2zcrGFh6Z+gv2QDOpT34T+QyJc45OS7OaCTo1ucYaf5p9NsoJOv9aetAyb0+8B4
         lEG8YE7r2d0FxQ+bgGwwFUn3tWmNAz8Z866rwaIogbdyVGDdSCSaVpIrsrpU1JWirCKt
         46qag8wWbkDeVn1+avVl33Gyzr6otBGb50yMeJ/U9GZKn49mUkgqELVKgIydSaLXoMva
         lphA==
X-Forwarded-Encrypted: i=1; AHgh+RoyeP16Q5oo1+6eZnHclH4CsfVXJEnsZAbFsmazTYT/CZ6to+X5gAX8JwtDM8hIfCqiOpVquBrVnmGg@vger.kernel.org
X-Gm-Message-State: AOJu0YxcKocA9t/UbYzBULsnDO0XP1sx6rMvpvrDoRmfO+PMDOx7busg
	0mLv6Fz4hi+2QZieizZvC3Z5R/Jj+BY+Kui5TbcO+8lCjSS4JmxP7IZeOiyraEae/9YveNKXcpy
	xas9+ABTlESzaUA+sQhFTu30x+zvzZSR9bNj2vkP6qAPKO5KhenOVzxmRrjnh9Kdh
X-Gm-Gg: AfdE7clcpXIFRdQ1PB8PiuVU+/gt6UQhGbjDx0VboXpkzwMDuXYrvNMkreO7k/X/xFj
	Tjk8ujcukLlNt10eE4+jnk/KZ6OK5i9zDjHncQR2jjB9ygPWotOA7TQERCUVQ+CGsAL1Z3TFYSW
	I03UqmkrMYcUFqerr29e76V4HBPO6VhGyIYByVFyKhEHd/cRAQsh/dFC2ftHUMwfzUsqKRgB2Os
	RJ/6toiBCnbJPMvfykLTd9Rg3/6O8OFYiIMYHLWQBw5jrvBjVobAKMLhdX+u+LNYKizHBGGqRV7
	l+XP2kl18gxlR5FqOQ4zNb/BhI72Tesi/fF6MMHlKjyvc4pdNn9Jf4mb9xwItwTQU9nz2Np0TMb
	iJjuht9FGyiLtgL3J8AX32YQ+yj2WfzGnaa/RhQ==
X-Received: by 2002:a05:6a00:4106:b0:845:d284:9e10 with SMTP id d2e1a72fcca58-848438c848amr1258962b3a.55.1783489064393;
        Tue, 07 Jul 2026 22:37:44 -0700 (PDT)
X-Received: by 2002:a05:6a00:4106:b0:845:d284:9e10 with SMTP id d2e1a72fcca58-848438c848amr1258874b3a.55.1783489063825;
        Tue, 07 Jul 2026 22:37:43 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6db29d1sm6484592b3a.53.2026.07.07.22.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 22:37:43 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Wed, 08 Jul 2026 11:02:00 +0530
Subject: [PATCH v3 21/26] printk: Register information into meminspect
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-meminspect-v3-v3-21-7aa5a0a74d5c@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783488714; l=2254;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=zaV3PbmFUtDnw62zQ3JXo0ZBeG6yDbJIOwaDAH/EVmo=;
 b=YjEBg3cAlPVuq1xhCmIAiTNcWWeuFlgSHOCYG43WEd1GLttZDwSktzjEnZl0RMIdqfCDXEr21
 C1QgDxuT5KPDakO6+ATEc2L8W3i3ckHvvSzSZ0yPJJB0VegO27FDpYe
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA1MCBTYWx0ZWRfX8APrHfEkQK4l
 jjr7R8shZ21uf1JUOimdu/5VYRFJKgBX664c57qkctAMTxoDiFEOwiYFx7zh/C3yoU9CWOGcG93
 ET1I8uMGo9y1d7KypGt99/w+Se27GxUyV6cdU2Z8Pkfi1AcZ52NFRhXCt6OxR2rEhm75jCXD3so
 /TuV9IRUs5fFz0dQxoIA3Fwj/vfMlfshIWCz4INebKWwDOIQh9I9+ZO0deDCB7PD0+3ZV02Myd/
 Hy6aa/XuTwyoTy7vqzAf1SUh4+hJDQdZSPowAj1KKknj8Ho5xpTMeR4JeuChYKa2X+fqQAtXB9E
 mD8UEk6QTDyD0dW+N7XS8iChak5AuRvdx5IiqSppOsZPU4S7cqaHvZP2NK6rBZlQMR0rXbzkmXi
 tjWw5G65Y1lZjxVU5JWDuFuCVFxPEFG2sC5Q6gIQOPZ4E85SzQVZuR5XH5KUWqFKNOYX5rU1qkE
 rWA9ckVny390T90rszw==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=6a4de229 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=iox4zFpeAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=ZWDwVrzm9O4pBL7d_cQA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22 a=WzC6qhA0u3u7Ye7llzcV:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: yrjF9pDJgrmOaufTYllvjqbzt3VdrGak
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA1MCBTYWx0ZWRfXwhMG6hsj+lIM
 F6LFloPzkmL9OGGUcbLmmppJY2Lk6jcdNhWGXgExAS/ejRfrEfyg897k0Z4CM1v7A1Yv6FIh/Tr
 EWyIBeIsj7EM5LUE/emNWQZsZLfDovQ=
X-Proofpoint-GUID: yrjF9pDJgrmOaufTYllvjqbzt3VdrGak
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080050

Annotate vital static, dynamic information into meminspect for debugging

Static:
 - prb_descs
 - prb_infos
 - prb
 - prb_data
 - clear_seq
 - printk_rb_static
 - printk_rb_dynamic

Dynamic:
 - new_descs
 - new_infos
 - new_log_buf

meminspect uses a different API to annotate variables for inspection,
and information about these variables is stored in the inspection table.

Reviewed-by: Petr Mladek <pmladek@suse.com>
Co-developed-by: Eugen Hristev <eugen.hristev@linaro.org>
Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 kernel/printk/printk.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2fe9a963c823..f7f32c09b9b8 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -49,6 +49,7 @@
 #include <linux/sched/debug.h>
 #include <linux/sched/task_stack.h>
 #include <linux/panic.h>
+#include <linux/meminspect.h>
 
 #include <linux/uaccess.h>
 #include <asm/sections.h>
@@ -518,10 +519,17 @@ static u32 log_buf_len = __LOG_BUF_LEN;
 #endif
 _DEFINE_PRINTKRB(printk_rb_static, CONFIG_LOG_BUF_SHIFT - PRB_AVGBITS,
 		 PRB_AVGBITS, &__log_buf[0]);
+MEMINSPECT_NAMED_ENTRY(prb_descs, _printk_rb_static_descs);
+MEMINSPECT_NAMED_ENTRY(prb_infos, _printk_rb_static_infos);
+MEMINSPECT_NAMED_ENTRY(prb_data, __log_buf);
+MEMINSPECT_SIMPLE_ENTRY(printk_rb_static);
 
 static struct printk_ringbuffer printk_rb_dynamic;
+MEMINSPECT_SIMPLE_ENTRY(printk_rb_dynamic);
 
 struct printk_ringbuffer *prb = &printk_rb_static;
+MEMINSPECT_SIMPLE_ENTRY(prb);
+MEMINSPECT_SIMPLE_ENTRY(clear_seq);
 
 /*
  * We cannot access per-CPU data (e.g. per-CPU flush irq_work) before
@@ -1238,6 +1246,10 @@ void __init setup_log_buf(int early)
 
 	local_irq_restore(flags);
 
+	meminspect_lock_register_va(new_log_buf, new_log_buf_len);
+	meminspect_lock_register_va(new_descs, new_descs_size);
+	meminspect_lock_register_va(new_infos, new_infos_size);
+
 	/*
 	 * Copy any remaining messages that might have appeared from
 	 * NMI context after copying but before switching to the

-- 
2.53.0

