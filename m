Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0622A3E92A2
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773173912; cv=none; b=mXbWeiOR5KZRPFeZsQfsJQDwrufsKytH7PcsGtFrpteV2pTJlpKrCSyIfYHtT6psnbmg3XjALI1MsDSaR39nMtpI88oMi1Lo7V7JNJ6dlLkCpf74nq3pCs7BWH5et2EsgR3ee/HcNlF14aMqKqDVi5gEZ5+kHfpKf8AJlZvuJJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773173912; c=relaxed/simple;
	bh=ddnLcCWQifntrskr0bcFbMBQGwwCpIQxRxTa/csgC88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M4omstQmLifFlY0L1ZuFL5+LO9f0VR/7uxV1jC8+osjrvmwT2hDghBdHkc51xBoaxU4jkQ+Y9JKKXB1/3Lls0xR3oYPtjCYy77xPFoQ8iZpvjFptc1by4UvqCHpa11xHqnihESwfghX8VcY743ezc9p5KiRhuZCiv5W8CVTj5ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AnrC4NkB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MaLXtyRO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AnrC4NkB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MaLXtyRO"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AJ00xm3417107
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xUalwRtla+ayp0MJOatYREBpi53Z8RFSi3SjDfIMcEA=; b=AnrC4NkBToNr65+G
	AeOELDrpl9XgKlIS8M/AtttB4QyAglvTb6SQxjBuNnsCiDxLCeSoU5WmEqxThd3n
	q1r7NaFq7tri0wHflV+Z3u1FJeS4NCUh+YoW29ccfw+azNMLfQsyntExTh9g0eM/
	OK65QDkAjslsNMXN0BZIg5Zs35L3NZGED64QqDWnvxaOkQbYFjYXtz/2YHDRZZ4x
	d/i6zaSKGtTvF74k4p0sDUwgSutpk1nIU+WC11pYUqWQKNQWVXSoRlKiNN3DpcMs
	OyewJGRmFq0SSbpreUfhULNlhtKqRVRBf7e0xiXv8vwnmwA8wH/1n+oQZ2VCsAGO
	B+jY/Q==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctja2a3qb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:18:30 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c7385e8fa73so3575836a12.3
        for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 13:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773173909; x=1773778709; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xUalwRtla+ayp0MJOatYREBpi53Z8RFSi3SjDfIMcEA=;
        b=MaLXtyROcBZIG2lrTCKQpdHM3sgGv7EaztOOHEKwzuUfvG+cYkBQMf7QFqE70H4VGX
         rlPCdwv9FDZ7jO4aPW76cF0kfNenn/pcsqLX5M0fEfMEPWZ8JEoEDWzyt0+CeiFrZYg8
         rJx39BzDt4GWhbjJm3rOwnAtTKiIvI6W/GBUuwqYLGrTTjF8nQ5UH9skMxB69zjTrLvL
         HVejgm7woF6iKUJuEo0oGrP4dDC4iD3yJqBZFTQWM5665OkV1DV0tCa0YxSIEe/CYLw8
         /hKDDgV5d8m41vAk5IdyzqdTzui6ihs4pdsxbYRfbIabjjwQ6qTcJW3PWWr36RcHIiLz
         bWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773173909; x=1773778709;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xUalwRtla+ayp0MJOatYREBpi53Z8RFSi3SjDfIMcEA=;
        b=OmScml41B0KYFFVmau76lWXSWnFlTEgYqlbzRZrhjyy5nqZoHZDJBVxz4tnq9o7Esd
         Owfb8oUpPMQKXzkXYI8XX8+GK/IYkUnzrGxiWlvat2h4hERDTefyp4MfVNT27PGls+IM
         oB0xM72mUYVJOwG1zUGD70NgAp6Cea0T1TdLCp9+TA5DruAJK44reN77efX7GwJnMiId
         kOlTQCyocRTex3tHZAR+dqhmJ7psHPtn3IvA3puqNLWx0g50PqzO7Wa/myOessmB1WS1
         u/eEj69hMJsEcd6uo8lnOV+sltL5lIO9xB9L3gmSmUlp3bmsLmPPDajqCZ1lKVLylD6L
         GyHA==
X-Forwarded-Encrypted: i=1; AJvYcCXIMXcR/Dw9YJ1rYOFYN6zbUbUsY+wbc6IX96nuITW3VKkmdy7SZ+4YIokNcn5UweMJYgHt9xvaAd7s@vger.kernel.org
X-Gm-Message-State: AOJu0YzHmMJoCC1ZImNZBxciIzvYSGs+xAm35MAMVOO4/hUnS7ewXuK/
	fOYdF3KPDDvEUnqLpfM5XUm3uBhT4XvzKTzj+xDPzPMtoNRtL7/RUKXWkSPdafe6nDq3hkvSAYn
	T3Nw4i8XJqL32siBKU2Uc8ry1LegenRG6FKR2rJPNrjR8ki4u35Ete5TCqKD4Jwbb
X-Gm-Gg: ATEYQzw8YRyxx8GeKMfQahvbXWcs3Mj+1XfVUTSK1Pf7igsA7RxoajHqcfv4tT7HChA
	l36gC3sOShwwAv8QwRkfkQMXWYTgQJxC0xWyHSs9stt9+kew3FQYurjC1mIzWI9M0xS79qCnjsD
	en2RdrDHlGzPt5NF4xWxcNrdMXBnIyxcHYs82kfvaRVg9haqZLBLfUIg3ftDA09dY5/kns/FHLJ
	lS2q33rKclhUFaEa+6Dgig9U5i99LVTpsDiF0w3u1ARHv+vDqKQdi5DRGkDEof67KsZ2dM1Hhcd
	NPhxtyQ6UufHiIWOE2yYz2YeTqL9XAq+nnOZBZu5aaVDLkX8O6o6zbdA8FcIhuLdjqtAccUdIzF
	I02T2t/5m9DBIrDYyWEMJm5VX8cy+vVup6Kpm7hKopj9EwJBH
X-Received: by 2002:a05:6a00:1c9e:b0:829:88e7:c89e with SMTP id d2e1a72fcca58-829f6ee65abmr188002b3a.9.1773173908905;
        Tue, 10 Mar 2026 13:18:28 -0700 (PDT)
X-Received: by 2002:a05:6a00:1c9e:b0:829:88e7:c89e with SMTP id d2e1a72fcca58-829f6ee65abmr187951b3a.9.1773173908318;
        Tue, 10 Mar 2026 13:18:28 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6dc2d0asm115262b3a.13.2026.03.10.13.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:18:28 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 01:45:53 +0530
Subject: [PATCH v2 09/25] mm/show_mem: Annotate static information into
 meminspect
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-minidump-v2-v2-9-f91cedc6f99e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773173756; l=896;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=hnWgTs3BqNwkuy01WGRtLHEmLnAWVLqGtO9y7HspcnE=;
 b=uLHZ20TEam9IFeoPaxYKND50xjzJmo8/66x/toJROlPuRsGnYldJCrFNEUSo9htPmJgsz83XB
 h1nzBbPPYs9BIy9KMclSQJQfzgEIMyig5knFQTbc87F6JhGMpL4Ps/A
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Authority-Analysis: v=2.4 cv=c9WmgB9l c=1 sm=1 tr=0 ts=69b07c96 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Ayq6lH46roXo9nsmW_UA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: N26La8Js7mswyUhz-RzoUypjDCInGFcW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE3NyBTYWx0ZWRfXw7NjEU3NDyAs
 Lyg62LJ7NP47Y4/UUaKVCu9+wnLnagG7N+77RLgc1B5y2lS5tXcRaIDW8mMB7glq0gr3wOmSKYe
 p45gcwnNdnPGV4q4KupyfNQGLrztTTChxKA4Cs5OyiHQdL2rNiv14oWix3WfXXq7xPMvcBwLxvH
 z7eyOaVFkbP8FWaRIj/6eBvuWfG6twkgnAwYOehEC1r099P0rJMxC2+D+GVh3unyxeX1cSH6ALO
 cFprLtKRdjmGK2953NibwOnUrCK2K8w9Dtpdm/YziMbyi+81If/QJRv2JXImPagBNVQVXBAn7X9
 g3uBSM6R5y/j8gQ3CuRXH01iytYlc26hzcl0npPlXx2SmU1ZKGTq3ysVL6Qe2eNYBQ/PbtjAOb9
 zvk4RuxZHrkN6XNahu/vwsZyDDX0ohf00FVP5J+2C/LGaAmGeiCTDMI4ggXkH75hA/OOq8yEATZ
 kGxrEHxVA9mvsYIO+kg==
X-Proofpoint-GUID: N26La8Js7mswyUhz-RzoUypjDCInGFcW
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
 - _totalram_pages

Information on these variables is stored in a dedicated meminspect
section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 mm/show_mem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/show_mem.c b/mm/show_mem.c
index d7d1b6cd6442..f6a92c7d9d1d 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -15,12 +15,14 @@
 #include <linux/mmzone_lock.h>
 #include <linux/swap.h>
 #include <linux/vmstat.h>
+#include <linux/meminspect.h>
 
 #include "internal.h"
 #include "swap.h"
 
 atomic_long_t _totalram_pages __read_mostly;
 EXPORT_SYMBOL(_totalram_pages);
+MEMINSPECT_SIMPLE_ENTRY(_totalram_pages);
 unsigned long totalreserve_pages __read_mostly;
 unsigned long totalcma_pages __read_mostly;
 

-- 
2.50.1

