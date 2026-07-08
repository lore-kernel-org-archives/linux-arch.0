Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016423BA237
	for <linux-arch@vger.kernel.org>; Wed,  8 Jul 2026 05:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783488877; cv=none; b=IXSWSNFcJcr5wKl4g5i5mY724oBk6KzRFX9T10KRQBdUmLLeBhROaemtluBxaDHnUStmDV/crZPu1qSXT0f/hp+3KRRcUB4SQukfGu70taj11RgCpSluBXkIBrT/QC3QHxVsibbz0f6bU6PqLweCcq1fgj+wl/dWUHp+6QASzyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783488877; c=relaxed/simple;
	bh=RL/Wvj2Mp0n5HJ5Cy6pG6HZOBt2AowIl22lTfZqvl/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HSx18m+Wyhj2q7SaD4io+2QuZwWrnG4K8nbdH/Y+fwoEo4F6jD/XBnZZIpS/3uynNodzDm/hXdCs8I46j6+14bfZxzIjR/bYQ51cvPBHlXK25D4W0ViwozcSZanIXHS1QUq+2LtuajjfgCx2brSIuW5CqPUq9geJo9awbz3uI1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EqtfYnE9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S4mTZxwR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EqtfYnE9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S4mTZxwR"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66842Zxk1491290
	for <linux-arch@vger.kernel.org>; Wed, 8 Jul 2026 05:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xCieFDn9o1/mTKBwZokgs/AnxZFC6Cu9M4cCeHRgDUo=; b=EqtfYnE9jR6VGU4L
	YvdI2c1EaI3rL4BCZXWS7Zo3iHKZIqpJQoNZfsSUxo6NEe8oRbLa5EMTeaRu4voU
	IY1pIizZJPRrLq/hLiu165f0oCyIxIZz4PmDh1RLDU+G31ae54kVZkpL8H9dzi7N
	qUxd9tE6S2sdcUCXsus076nYopGmu0k//mgdILW/Cbpyv0LiKG7ZXO054xRQwWgE
	QO+w2lP8mecmRm+/MjbG17xHONiDgyJ+CAdJSi0hv8CtmtfEuTh370P5IgAuM46F
	h8tCLgRzunwaNw28X3j1P2+8NJGdqyibeRrhaGsHbkAMaogF5HGPvQrCQ9/IHRh8
	USIY6w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9b5g94hn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Wed, 08 Jul 2026 05:34:35 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-848452dd146so761022b3a.2
        for <linux-arch@vger.kernel.org>; Tue, 07 Jul 2026 22:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783488874; x=1784093674; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xCieFDn9o1/mTKBwZokgs/AnxZFC6Cu9M4cCeHRgDUo=;
        b=S4mTZxwRmBpU6rTOF7ZM31N0VoZfIQbMg42c8OCp/NX48VINCPHV6K/3rnMi+OTEKB
         NlUm0H60/AFXQ90ozyNiZpBvkaUkUtOFdqyQnrLNKy4Fmb5qakT1fL6A/+/n3PwWGX9b
         T24bByzAY6uHrDxbJDstWad92Fg75LZygoT5bRdoDccXDKTP5afn8QW+fzpxgbMlhHf4
         sRdW81O1H9n+BiPuZVZC42aYvl2zi7Nij7YVxY7Q9HzSKQjyFVSwZPnkpjjxgr2IcVfA
         x69PyIpUswftToK+1Lz6t5q7wt4zujqVxQkvj+CTMLeaORih4QB3vOa0LrMPBQeUiCPP
         wpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783488874; x=1784093674;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xCieFDn9o1/mTKBwZokgs/AnxZFC6Cu9M4cCeHRgDUo=;
        b=f82MLX1txldg3uNLvCIqjGgySjG8daEWuOrSpjEDzzmzBzBvCOiMyMwYyKd4f8PNgb
         jtv6nf6qL8jotTLIaCzE2JeknfgIvZ6Jjk3VudObKIzVLfT8Mitl9j8ufQ1qsh/CDXyo
         AsXHtwnkwogSbghNX4w6Z6JK10iBqoBsVONQVC7GQNoqC9m1y1mY/GS5jDM/cTfNbrJk
         aM9/UQ7y0hWl13i2aP45NBO1uob84fly/6QSzpQtP1vBUdN2Pnmi2FmMZrb/DD5RfNug
         B5E5SMIV3aTAyXGE9Mo6iwvIjvxALmAdWO38+E4nYoaK9ndQacA+PV9+fdDapz7Dol2e
         9jaQ==
X-Forwarded-Encrypted: i=1; AHgh+RqqFLU1/0le6L7DwF6uTSxk+nllxnYqmMrlTRPsFs7ArHzFfOpKyQDeMPsS6PjFA8K7NZlh1qH7hcls@vger.kernel.org
X-Gm-Message-State: AOJu0YwUM9M+4lShzQDMTMFUgS0HzHE+1PPvXOngbTMSKmafi619w5ZW
	YzDzxQnlLlIzhX1OO/yMg5pW6d/6+Kn5lUAQ83+4LC+0ubR/wpLHWVbgbpdabAPOkLSyGH+AG/V
	whdkg0bWlWVEyb7IkTPwAZzJOt5zQvaPlVjEFxnuRJzEfpbzqmYiHNPeORvd9+U2j
X-Gm-Gg: AfdE7ck6QUIY/6je8n+buVsW729QC3NYKJYN+maAME05XHH8BhtiN5RiTf+pOXnWGoM
	jhx3/Y7AD4xBY4oqAv8pz2+9ogPg2SKGGrHjbk2l/V2T65FxETu9+KzdhV0ykNEsRIv9SbKWAI7
	jBckgBBxm/OD46bnXWOxCK7paO8aO0dMvqANlbutbGYivqSvP8A2EpKDVyFZ2b7IpcZ9s0o7hK4
	Q6vUCPGWLFYJartqHt/1DaxLym0jK0wgdYLlxYFXnjqe3+CUUXt8bLcbCsOcf/YLCM+f9Axv++z
	MI4IU1FSuoWi8ckg/qsJrYC1G5YdxA57vVo6iSH8IjnOYHXz/41ttoFAaVZfcQ4MraSluDFTo+w
	T0Yzjo/GvSuoQaz+W70ULtgAPs36lBp6Yb7Dkdg==
X-Received: by 2002:a05:6a00:c8c:b0:847:902a:57b5 with SMTP id d2e1a72fcca58-84843675521mr1352949b3a.35.1783488873940;
        Tue, 07 Jul 2026 22:34:33 -0700 (PDT)
X-Received: by 2002:a05:6a00:c8c:b0:847:902a:57b5 with SMTP id d2e1a72fcca58-84843675521mr1352904b3a.35.1783488873305;
        Tue, 07 Jul 2026 22:34:33 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6db29d1sm6484592b3a.53.2026.07.07.22.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 22:34:33 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Wed, 08 Jul 2026 11:01:48 +0530
Subject: [PATCH v3 09/26] mm/page_alloc: Annotate static information into
 meminspect
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-meminspect-v3-v3-9-7aa5a0a74d5c@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783488714; l=944;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=L6c+15QWfJQlsN7pofG7oj9ERof+W0cwt812FgtujDc=;
 b=l1lEkLsA4P0Av7A6H60+TWCYPTjtTVceVA79u4NAHGXJ0OzlnegIIncayRRiyD3tgW/XBu0j3
 S5WBgcBHx3qDeX1/wpk1pjLIXGINMHFVPzaNC/c9Fa6/35YeFUeYUZv
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA1MCBTYWx0ZWRfXwug7p6JDdU8m
 GaoXTgXvYvrGows3lRuw/YF8MoBPhBnV4DTpPwJPnzEkUt+jtc9eWS/C4EnUkd9MeenO5rHHfWi
 aV05FunpCm/TawXR/+DLFK3g6m7x6ME=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA1MCBTYWx0ZWRfXyiYXQ0neKD/4
 2MWsL0aNtxAWn4YAIopVMiq9LVPL5Z2g7uf17oASA+BYIULp0liymFuicaRC4HSsh1Z3Hpeobnn
 cm125dkJsigJU+VF0nnjSOfgd70KchOfoupsjvrSUmUgNf+ZB3+GofarE0qmZda08BRBz9/gxrC
 +pZyv3F4AE9TnZfVcopW3P1jswYFljIE53Q3iSY6pIz6T2xga2n9mJFNivUjovKUZ7rS2KnBVT3
 FYu5N0w/pplCDNrShUwWy2AK5GDMDC6vGdRtXYi9eByKfjPGoRAfe++K5nt7vQ/PjldLEPAyURi
 HDcu0hCR591M9SeARXw7HJAcAJFLZK2sftyxCimwETxiVsqWMgNiT8jbEz+STVT0Yt08RPAJwke
 qfgE9QCWbZMiUXLVJKQaY9SP1p7ku4+1ogClFhkrG6lEl2Fwy3MDD2jk442bJhjwXXvKgNzDG90
 cOK1E++/iRdYQ3mOCHA==
X-Proofpoint-ORIG-GUID: 1Ipg8cwMPTVFMRymS51kuPmIhN6ABqW-
X-Authority-Analysis: v=2.4 cv=JLULdcKb c=1 sm=1 tr=0 ts=6a4de16b cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=TiJDLkziv7N9Y1Svq3wA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 1Ipg8cwMPTVFMRymS51kuPmIhN6ABqW-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080050

From: Eugen Hristev <ehristev@kernel.org>

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
index a63733dac659..70c5e0794efa 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -54,6 +54,7 @@
 #include <linux/delayacct.h>
 #include <linux/cacheinfo.h>
 #include <linux/pgalloc_tag.h>
+#include <linux/meminspect.h>
 #include <asm/div64.h>
 #include "internal.h"
 #include "page_alloc.h"
@@ -204,6 +205,7 @@ nodemask_t node_states[NR_NODE_STATES] __read_mostly = {
 #endif	/* NUMA */
 };
 EXPORT_SYMBOL(node_states);
+MEMINSPECT_SIMPLE_ENTRY(node_states);
 
 gfp_t gfp_allowed_mask __read_mostly = GFP_BOOT_MASK;
 

-- 
2.53.0

