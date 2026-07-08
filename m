Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F02377558
	for <linux-arch@vger.kernel.org>; Wed,  8 Jul 2026 05:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783488829; cv=none; b=dsRaJe1l4K3TkOdhiUWbn5adtk5LiC9RUBVZ/n02I71YAAx58Evx1vMMvZSc7jucQTxGRKVGD53/7aISfd1Fj6fFYyCeiH/Qfa65HTO+CDlD8K8ZQfuN253SkSjvb6oKTWRDvFuwBTOFhB0FViznbSOR9Gdq2nEZM/yS3bew1hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783488829; c=relaxed/simple;
	bh=rausTGX/cA29KL+8ZlV/G0O47Zo2G68qaUiTzxM2SoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ovCteqr85GnHJAg3dbqGWPI3krCAQEY76EtlI/3SK/g9pE7TzoWadsgxmvDInodK28oPfcfm8BCta+jzZ5KIAXVhtZg9A5AR9a9LA1XR6BAPSJfQq0ygpZiNhnNuou3GxgMtyVC7uTuVMuZCHcCQqaWzzaYhSBUkUtyrj4xYhzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Kis4SS8T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BgQ9+Zdt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kis4SS8T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BgQ9+Zdt"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66842lHb1625566
	for <linux-arch@vger.kernel.org>; Wed, 8 Jul 2026 05:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ITO+JE3opr8LgPgXIr5SaVvHjNfRbkajEoRTp9nYlQ8=; b=Kis4SS8TmV5iP1Yz
	l7VP5KpLpSZzCD0HrWRlM9bPZ/SXhy/pzeuagg8DfSkugOIRNgwO+qGFPEI8UTz6
	xxQpKMEk3q4vPwwhSx2yHQIvCKGadfWDzWEVWxxZr1U1tAjm1JTlZhcuxJq/wHZU
	v5KN+a2tdu1/uxc1SoYHlL4x7Zm1t6TpzqRjbQrtGNZjDwpsvXYsl4iAMzvO/kTd
	fHtdDkbAxSVGRHy3kRK5EmfbHzCsONFcZa09PxBGA18MaN9K7IL+V55kZODy+bra
	MfzYkjW7Hiq0Qt7h8a2OhI8IXcXLg5BAILmPstdQeEwpidHjLbiSIdgV5v2jd4m6
	vvOMqg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f95fd2td9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Wed, 08 Jul 2026 05:33:47 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8484739a9cbso151265b3a.0
        for <linux-arch@vger.kernel.org>; Tue, 07 Jul 2026 22:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783488826; x=1784093626; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ITO+JE3opr8LgPgXIr5SaVvHjNfRbkajEoRTp9nYlQ8=;
        b=BgQ9+Zdtz83Ulr6SUm835C4Nxqd9yP1s1FR5XzT6neenmVXvmHpamP6ngLyywkXMMG
         t3xU+CWCKLi/u+N8DRxGeqc27x5brgEPsDhExjFgZoGdLTGjIPqsoJUs7Ir9R2aZ9ISX
         qL5InlPmVhk7E8z9+Ong7/St7FFmUK37ZP9J54blErteGVyxiDTCTQP7S4MpjeMw5pij
         +N0pHLD8fXvZ4EfnZLsULl29/TCVz7MPuk+IPtOla69iUJ1bz8e/zXPcWgyFzXX/Qygx
         dNNXT4de7QVnR3abyVHdpKaTSf8Qx0x3WBylACY3PMLaX5L9A8ZllTbb+u3XRCfLuIgD
         Q8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783488826; x=1784093626;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ITO+JE3opr8LgPgXIr5SaVvHjNfRbkajEoRTp9nYlQ8=;
        b=AjHI7iTPvE5ehWQWYzXdT9jOE9p5KRyyv/QUSTREo6Lbl6wRXoN0kMxywuNelzdTcf
         OKVgEKaml3VkuXJYDWxbS2ASQaqr/m/Byvx4c2FfAB31KJjsPTueIAARCDcLBeg2BxgF
         tKKi8leuHYEd8yYdPpE3F1TimqFxVBQriAw8FgrdYgY7wZYchWZH4PLoqAjeccB+Kog2
         eEAIT6SYvkk9Qk8buh+QqSNj6ykIQs2EBl82r4ShsjzmL78Wnk6w8Y7xJpF6fiNnnunO
         Q5Ra+67TxOG0ZdwJZo2V3guLk8x8VhnFiRROpaqPyXgEbKJAZEk5m9wlh0Zah5PZmo0B
         QLkg==
X-Forwarded-Encrypted: i=1; AHgh+Ro59FgtGHWia4af4vF9/6G0kwgmglpuJQ8kGUuxfSTensLcg/OmlOq+Savq6Kp3IqGPS7xGrd1wqe2b@vger.kernel.org
X-Gm-Message-State: AOJu0YxksozFVWHGuYaV2WeX8JYYDZZ9yWtHH85on3Z6rkIeg7JsvkDe
	/X6mMEBcjkqnnqN4qssUJ66xPY3HksRdi51MPbHy/smr3ww/8EMJK6ZgNZpPUXLNzftkKjd6k6/
	patls1067XmcaQ273awD5UlxlLpUzWPbk4BkxC/PLAjr3nYbvCY3WGBKhS4IYtkj0
X-Gm-Gg: AfdE7ck5f0LCTfsQF2NvHxRSG0w2CbguFGFjANC64N/1OGqNNlRGiaR1x7fLQ+NAwO2
	esK7k5OGQ6N6k+AMUFCe1t3H+uJYCqEj2w0StLWYm7WRXDd96Qll39m6oCsrL8YEpPqfB7h7++e
	qSi7Jnmm1AvQl9r0KiWRJ+8du13503FBlh6YyflVKcr/EORwDyGePjXocK6n673z5+2TkPGhg5s
	Dw2C3ybDlcBPcUdQhQZLkwTRz9zzOPy4aWe9eDlgn3wU+MvfgjsbODELQlXLtsVOE4WTsKSwJoo
	8vHGXIvvo7AgFsZR1xClBKKfRTejofWIvTZCDDrZoLbFeu2HbO1OCTwe7mkDSDbnT14dxL7JLim
	CbcjcfWXzTsM4q/VGS9xgqX4jZnqjoubqqO0cbA==
X-Received: by 2002:a05:6a00:8d8a:b0:847:8791:f54f with SMTP id d2e1a72fcca58-84842fe321cmr1182143b3a.29.1783488826158;
        Tue, 07 Jul 2026 22:33:46 -0700 (PDT)
X-Received: by 2002:a05:6a00:8d8a:b0:847:8791:f54f with SMTP id d2e1a72fcca58-84842fe321cmr1182097b3a.29.1783488825439;
        Tue, 07 Jul 2026 22:33:45 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6db29d1sm6484592b3a.53.2026.07.07.22.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 22:33:45 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Wed, 08 Jul 2026 11:01:45 +0530
Subject: [PATCH v3 06/26] timers: Annotate static information into
 meminspect
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-meminspect-v3-v3-6-7aa5a0a74d5c@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783488714; l=952;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=dRXeUIpIlzWe1LNHxoHjAVpHzKcKSqqlKNhUPjx2KTw=;
 b=FTqRhuK4jJoW5z8xkIzP9taBuoDPVq9v+EOp0exYW2spJdYWD+lEd+oHVaecDxylcFpv676MQ
 j09Wz7/ilg8AWemdOCnZLhJohxL16BOY0AIU6SL7rCeCEXHzowGgz/i
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA1MCBTYWx0ZWRfX1rZgeQn9g9UT
 50TMuXbQC+Y6kIhXBT3LA8USHsEzOBpPVZ1f26BFnHQVV9mC97zK287lKRuulY740NJGNvtzi4Q
 EXpgR/0+3S0Edox2A15+h0AoPv1TnOBRFkU7jp1sJ+xIpUeKFVxV9Zx6VI19igIbzxZ8lomtCGL
 e7lxiHsOMFDap/4jEkcKByqDcrVqei/VQsAFXe7KVZrrJo+PsEb7RnPBqCYINR3zN+9Mv6rWq7P
 CcuWlZqz1Hh47kNRUm98vb819/JoP1md4yMf71XEHpRv8wQlKzY9ZPhtFsTVrqB/D5tJk62h+9B
 dACGMwqFcXKjl/DsQAUgc7/i/TQyL1DGv/yUro1aDsPQ6aJfmpixi0EIQhysjzi4Og8vySh/e8q
 5uFl7ekSqjk+ASTRIFwLcGwpfswiL8ocKIQrmMUqM+5E2dmKlvB7usbNUZdYFD+vPVt7zMkS8fq
 QGdRFeq8svQhwwf422w==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=6a4de13b cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=WZmkKkIAQcJSthQVk9EA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 5SdLPASsQmSrPVLjPTbuZMKCyS35F3YX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA1MCBTYWx0ZWRfX7aCOJockcUtD
 l4tx+MfROtCEIn+LPDcRKPewKirxp9uxVV0hAMot89WKV7MDhsdpuDqho5GhIR9ypVbiu60AWwu
 +TKSdRrgLX+n91bjtjEsRHbYQbDt/vE=
X-Proofpoint-GUID: 5SdLPASsQmSrPVLjPTbuZMKCyS35F3YX
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

Annotate vital static information into inspection table:
 - jiffies_64

Information on these variables is stored in a dedicated meminspect
section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 kernel/time/timer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 655a8c6cd84d..6cbb054c7c4b 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -44,6 +44,7 @@
 #include <linux/compat.h>
 #include <linux/random.h>
 #include <linux/sysctl.h>
+#include <linux/meminspect.h>
 
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
@@ -60,6 +61,7 @@
 __visible u64 jiffies_64 __cacheline_aligned_in_smp = INITIAL_JIFFIES;
 
 EXPORT_SYMBOL(jiffies_64);
+MEMINSPECT_SIMPLE_ENTRY(jiffies_64);
 
 /*
  * The timer wheel has LVL_DEPTH array levels. Each level provides an array of

-- 
2.53.0

