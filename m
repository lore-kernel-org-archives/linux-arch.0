Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551FE3BCD02
	for <linux-arch@vger.kernel.org>; Wed,  8 Jul 2026 05:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783488988; cv=none; b=rMkILcDB/epK5wF49GkgwYaKnzt7lPFGzCKtFORsjxE7q1Uk2834MGvdETcye130zckTCPIezqRrQzVQgLUqId/KgwP/zzjjpRHruP2H9OuJZustfCr9/l+PlW5ddpPVnGoZEx+aHFoa9cfV1IF4ExyVeK8UEVlLezya78i74qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783488988; c=relaxed/simple;
	bh=X7v99CqRbrev+LS4B/JWYl94Ngrd5oDJbPRJ/GykfFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=km3BTA3vGkckvOkUsnD0tGCcP2QNvl2auPGHFFpElI8UkkKSUoTz+5LncMAKEvAMU8hvOPh8kUM+ZvGYtEOlOfeCg7o/blKaUl+gtjMNZryxkhycCe6JEmYiGmG1fzgTzAC7wRS4MVx214F/2G1AeGnPEgq+AmN9VGWHKdUOSBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Iv99Fe6j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OOoSAAtN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Iv99Fe6j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OOoSAAtN"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66842hE71625060
	for <linux-arch@vger.kernel.org>; Wed, 8 Jul 2026 05:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IoV8YBxGFxD7tibQwZ9WC2gTvFHftXwkSTWa9oagng0=; b=Iv99Fe6jAbsZCCqS
	NiM/Qq1pQ3aRuun62AHDkFpQxEYFtdthDAqXaUY+HQUJ1wFw/bPDans7nAPcDs9M
	zYV9AMQhoif2Gkb4YRB+yMEyKyLZA4TgjnGcZzO34H69ejcJqodnn2faDF1JpYXp
	dpjHuH2gzqRGZC1HgzQ0bJ5ZdgcWksb+VhkNv6BDiaCOdBP4HAdY4zJQD6GIEugc
	2xwzrptfJ2UTJcvWMfTxb0j/6zbeZImKWeK8+zIm88CQSNIePJGMAwKFFtmL2+E0
	5yS36eJoF4Q4RsIvsAJ7LbVBeImkcTef+XGdPa3CMbZgTFwHEQUo9Zb29FthjhhF
	OrAt5A==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f95fd2ttc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Wed, 08 Jul 2026 05:36:26 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8478e9c4bd2so416006b3a.1
        for <linux-arch@vger.kernel.org>; Tue, 07 Jul 2026 22:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783488985; x=1784093785; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IoV8YBxGFxD7tibQwZ9WC2gTvFHftXwkSTWa9oagng0=;
        b=OOoSAAtNFXkS8eu8/ekb/tE0dsO3pxsCnr1aalEDiKgo9xecXkyZ+fGuAxjKehWw7X
         6N0OhN5LZI23tdkR2ZV7k/5A8/KcGDRghl3JF74r1mKfCl1Zj5sl+RBDEH//cj+AiENr
         eNWo98g5QjQxORqCWUmcyDEr/afr3wxULXWfXXL2hbtPvrX6HDkUEU+H4Mkk01vskglG
         AWaetEFi2o5ajpmhIgEtTV3ew0QS6kx0YpEdTdcIN61kq+FP3/fBVrBdjlzYa2KeHwzD
         LmQh3cZ0KisRqZSI2VLYHxEtG2N8vIB/1kCEUO+J2iia3sb8zSMxQFHbCZrnek8GA3HS
         HJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783488985; x=1784093785;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IoV8YBxGFxD7tibQwZ9WC2gTvFHftXwkSTWa9oagng0=;
        b=G+TPhBa4E1xwllUdFbquuaFprg+pL9Duy8t80U7xlFYxfLmIZEypK0CY9T+0ISbecj
         mTr5adBZdZte+Rv6rvCIDyylWemYxskTGRK7/P/D0Ikk4AGRZZHnhoLt6KUk7K7ZLq3u
         DJZ7fYKpVx74x2u6pS/g7LHdh6ofyuXEBUuJbwkzhdT32JdZhFEowCvofQ4aKYHSan+q
         WFOw93e7EoZUdn3IgUsfjs95AWkQnyJyEHaoWIPiPleCXKSCr1di1XHbcUb6zFHiJpiX
         SdauiBY5730ESGSeUO5zYXRoRPcNnlCKiCv/JIkCdgjZWTDSanbEvJk2Im1rESxKMFYd
         26/w==
X-Forwarded-Encrypted: i=1; AHgh+Rrxr5wTtCKCfTxEpZIYycQnRK4RhfzFGBxEgtK7xFKccRTkuVi/R0Yl5c472iJ2v5bN3AHlxPwlPA/4@vger.kernel.org
X-Gm-Message-State: AOJu0YwBlIx0bd+rnReSMKltNzF0okhUzZiTHtlzNVLYstLelYF5WxdY
	UAwZvSYgeRxqU+LnP7xWl0t61hCLvbdgMUbIDDSfrOJTGPg0BrShIifsnk7jy9ly1YA6xcz6i0s
	Um3J7Z8d2CbZNSNEDEx3x4jMAEthFO3Znbfq6whrJ+FtAh27ieQiC/BShrZDgiyqj
X-Gm-Gg: AfdE7cnecHjrwEPCjwqOC73KeSefHZh8fBlln4wjJnQpX1qY9FGL4xm1vRBkB4tDo0b
	8NB3XRNfei1oelR6SApn+XEmB8a7CgfwyzlHEVsqPd97uQd22uyJ2SIErlKhSvTHrDyCGqfoVNW
	jbqtfkipcXMaEYRWUB9pZa341dyIS4gNZdyF6zU2lhhEWdaPEJiNPhu88bPL85diWKtb8trATSG
	oId04ugaoM5+wK1mqIhdcyim65Ktbnn2+0Wa7dDeIRZkLNhR67oIlfonhKMpO9Cy64BvKJAYOrr
	lCsKl6HEDtupIrRiR/Y1Q9iH+6a10o6yo3EMelJ66TVju0g5Xvced+z0bpp1WZJB2+atufH8jUx
	3OY7R9gmt5BSZu4GV7KrjF9JApYbZsBgorTIliQ==
X-Received: by 2002:a05:6a00:a205:b0:846:bc7f:16a7 with SMTP id d2e1a72fcca58-84843233d05mr1113973b3a.28.1783488985096;
        Tue, 07 Jul 2026 22:36:25 -0700 (PDT)
X-Received: by 2002:a05:6a00:a205:b0:846:bc7f:16a7 with SMTP id d2e1a72fcca58-84843233d05mr1113887b3a.28.1783488984399;
        Tue, 07 Jul 2026 22:36:24 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6db29d1sm6484592b3a.53.2026.07.07.22.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 22:36:24 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Wed, 08 Jul 2026 11:01:55 +0530
Subject: [PATCH v3 16/26] kallsyms: Annotate static information into
 meminspect
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-meminspect-v3-v3-16-7aa5a0a74d5c@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783488714; l=1392;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=Gi0PIfTIjU9TnT41l5DIWFSBN6wjIpAR6J0C3M16mR4=;
 b=4j3BsRQDoQCY2sSeQc174A2W0e6sMIQ9ts68CSYZZ6ZC0iuChwxNv0mlJ/UxecW0pFQsfhCfc
 knHk43S2I6HDzfKU2yn6g+e2LK0aM67W84x5u9xvsDoxGMo1wtX+K7g
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA1MCBTYWx0ZWRfXwkkGw6lCzFuY
 FJrHURY6CGAhJJJ7Q2V8mayo8mBrVFmxMYgWOLlewNoneyznI+LLdYwg0wGCNy1gXSjWYGtc6Zu
 VvD2BEDwMKIzCbUjgPqxfqD9pO9id5mV+Iw6iXtU+mRnX93kbYyAeuTPyMozrsorj6TXyGtaqNC
 VaLFl9s+jQSn6yprbA2uNUJe3PRse2tINpYA3pkDqUGy+cd8/kpLUQltejhJ5uQKzl5+2wJhb66
 nr6tvAJKH02N5o5H/gcxTCEu43ooL+hPStxv0Bl2yipFZ7RpaWHqoPt0eftxOW3Ax5hz1YrPDjW
 TFVTf4R3n0YDN3Ovq18Tq9DoLE/pXCun5r2Azct7unl9aEASl1agvnLi5gBLn+CrbSaRRufGHrY
 6L7OcyZmUS07FYtYzoQQSv0EEa41AC2v/nEkRIIgOCj0pBbuDagYflUra5Sy3dBoDXlnlDxUZXA
 I7kB1Mxg4q7tybLtlMA==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=6a4de1da cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=w68G1zR93E_Nt3437osA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: CBtixE8lV9YBdfFR74PIpQ7T_33qbVA5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA1MCBTYWx0ZWRfXzFLSMAwIBW7+
 2HpjKA3IV2kECt4HffLMmhZjBPyBs7UplaPe9qCmanVloMIzCuFSPHqirN9N9/oZKi7HxLt9iu+
 jTxar9hPfZ1fInuKUBpUS9yLBDetks0=
X-Proofpoint-GUID: CBtixE8lV9YBdfFR74PIpQ7T_33qbVA5
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

Annotate vital static information into meminspect:
 - kallsyms_num_syms
 - kallsyms_offsets
 - kallsyms_names
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
2.53.0

