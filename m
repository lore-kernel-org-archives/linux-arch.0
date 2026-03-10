Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B1B1F09A8
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773173926; cv=none; b=RrYH2mh5+n3tWExVscyEj2ByXS+s6r+hfTTi6BivKfmwH6YEKVYe4nD/cL2+fPoGErNINJrBZhxaNQAX4waNg+8DVwj5lR7h2ZW/3Oz3vaa1loeX5o2K7sde/7GN9JSX4lu/ilOHSvDvvOHmq6fdP07k3g3yFWtk/vBGYgj8rzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773173926; c=relaxed/simple;
	bh=lQDikNlzlcSt50phSDa4IXhRVO0iEhluLF5Uv4Ogkaw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ORoUkXpoKLGAu7pIKHZrsX6WtQsc+X+4/ghMQs4HPzpUdCNH9X4HWUF35ReBiifEdmexw0ENFVNaRqOBuazV14xpiTTENLflCNjxfloll0SghIaMw8jGd7d8fODlB3U/8l6Tsb0RyH72qCHPuLRE1fjnnl0RH6+oa+Qc1ldp7eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ik9HsVe2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Exh9BpQY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ik9HsVe2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Exh9BpQY"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AGAiTR1265897
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GRfV+v8T0vtqGrE/H48Sbm8BwZSwOTwP5bNFawAy1Fk=; b=ik9HsVe27x7k7E+e
	7lwbkzTzKs+Xaa30Gwlu8DLnPa/d9oQ0nR6g8WEDDpquIfohhaf/ldNmONkYrHSX
	5+aozV2K6RXs05Ks5/qSSt8OAA7DFEB3znqkdC1gCDMTAN3Hz9nvYgKTD3vtKpYC
	1UZKCggpJTEftG2QeJGWx9Pdfz72tXsFE0kTxa5COwTCVBIoN3KguwyA4zxmhHWL
	p/w8XWCMBJhl44cJq9qnOKhcsk8lSeDdyOGEv0v/xA1rAPZyLpsaXrNFnHrYFcTx
	TYYN1mU1HNA35xh9h1gWfC0mcaWaRFK52is/s4kKpby5MgjBrr3SPbnthq6zQtzF
	ojqwBQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctpkfh04a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:18:44 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-829ad8a2896so12378266b3a.0
        for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 13:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773173924; x=1773778724; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRfV+v8T0vtqGrE/H48Sbm8BwZSwOTwP5bNFawAy1Fk=;
        b=Exh9BpQYFlFZvvy+VZDSDnSidMsMs4kHfFHA9yzR7UAvNALmXMNFvOFm+sqwKa5FwZ
         0rYD7oxh6WPD01uLWNpckcgfQmX5D810Z05/2Nhsqk09QTqw6MGlL1gFi5AlLrRrQHfN
         e7c3FeI8H1yJojfhsKUP2jf51cfOm7/RoQhTneFkdjw28oajCNQsfHATa51LCEuuG6OI
         r0+KMQ5NwlZDUy8Ju3jdenSgM+Z6otcAoucBnXo2d/N/3ugarfUJt4ULkxnWpvk2tcvb
         6uBBK4UmGk96H2IevXWpD2Xla1L0/a4JbnwW/suZPJpW4LPGTYddVuV/g9lcDewebkkT
         w4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773173924; x=1773778724;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GRfV+v8T0vtqGrE/H48Sbm8BwZSwOTwP5bNFawAy1Fk=;
        b=amilK2f1rWQZK5a9/5xXZPy+HurshWGKfazwV+ZmDXGTaOZbKWcJ/Z+1L7xhkbNdIY
         AMxOoZZhVZTWAhG7Kxudyn2roaInLahtYrYA6DBD4cttXSz542Mnef1kTFYrGlXQBv9G
         XyYRCBEfsMVAJTQ5V2XKqSHl5pC4p37vpxI7XzXQhCFB6xYiL1xww7Wx3j8OBVlP0v3n
         gSbFMdTQGj8EjbLqxHvBOGw90MnGdiwNU7IVIQd78RMvfCBc1SdAXJ1bHemHXsUvd35D
         z2uA0VkW+oV0dye0thpnYPHfbtZMXA/Q/Nv8kduTNzmsitDTmo4vJmr2zuuc2ptDjaSd
         hVSg==
X-Forwarded-Encrypted: i=1; AJvYcCVE8A5NQUCN+Ub2vxxHwFtcSxnY6xFXCv+IazEG8ZLDW1fg19YeRcZhJCJSh90rqeGu37lSu2IcNvDt@vger.kernel.org
X-Gm-Message-State: AOJu0YwH3iCTyx4gFGRcsOhl+hdFTEJUQOHswjfF2zpMPoua4R/w3iQp
	ucOplIwNGK0A7u9ZVmS0Y1whpIkwjFllIatFJ45Ly13NqpuTdL+4zrfQidSj8nTiBrZAm9TvlYe
	SitKgQSrR9wgL83ooaJVGoDeKdu/tceB8+bdta4SYE9J26penAAleCsCYjlMOmV1q
X-Gm-Gg: ATEYQzy2MshBm/+SrxkH0HQyfz/A2rLr+5z9p1DkUSNKwk6p02vqyjatfm2Hpa3Tbjg
	RbWiGlg78nwVmy5xpKxVBu6yYXfB1gyiRSEvX0kYf8F+t7MBNd6s3Fu6mEplODy7rgZq3vSQSXw
	NTdcQUDoSFAZ4il9Ty+oeDCF1MYWGeqhiCZAZ85gAHbr4Q5tAR8C8d5FFke0+N7cQEEPHG6o0jm
	uqKJImGv3wj2hLK+HDknx8JsxvbeP7uhB/7B1w62BgzY4Q7qvTMZlw/MBEJJaHlvbBSlDnKjMy0
	jUXaVUVcs6apityviIVT5XfwcB5WrLvW+alsGJecVfBDKQwARg/dMowrJYkejfP02SsUH01lBy/
	k8HPNr9TjB4Gb6gk2Ah1Uf6iBsMq4FAeVnLH9gllJFP3XfLgH
X-Received: by 2002:a05:6a00:7082:b0:827:2cee:ed88 with SMTP id d2e1a72fcca58-829f71c2ddemr118124b3a.66.1773173923942;
        Tue, 10 Mar 2026 13:18:43 -0700 (PDT)
X-Received: by 2002:a05:6a00:7082:b0:827:2cee:ed88 with SMTP id d2e1a72fcca58-829f71c2ddemr118106b3a.66.1773173923413;
        Tue, 10 Mar 2026 13:18:43 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6dc2d0asm115262b3a.13.2026.03.10.13.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:18:43 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 01:45:54 +0530
Subject: [PATCH v2 10/25] mm/swapfile: Annotate static information into
 meminspect
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-minidump-v2-v2-10-f91cedc6f99e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773173756; l=977;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=Tfb2N6LauUTGiRFAYk0nYJYKBMAQNAqF6HcYVIzPbHw=;
 b=So4F5y2//OWXVBpu6mb1G2pjPDprKl6dD0OwLjg3M54+O5uetJywuxdJPx+lFXIZJyyrlQ8RK
 O05sCcy76vCAVjm8ctNTaSyWivzLnJvWFr91LSWTGqkpzQ2TiYaDGt2
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-GUID: xUtX7gqOKx6zruH5gHV4NYG3vQ5rbh8D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE3NyBTYWx0ZWRfX5P/cXd1szJcZ
 rDGdhtOpedJ2OK8TXJcMKlt1wcagmeyAllyH6r6mU53yoMr1jX64glgGADR2GBxHfaNxJB4R5ID
 wnZsmK7IMII4DmuYUY9ug+hfGELIc2nKwdDzL7xgsDaLw/vZnjRAxq8zCGi7YMYwQUrtkPNSLqR
 duij4EBT5CmEw7HjvdWUFr+rPW17fntgsnojfogiC5wQBbCkfI3NGwoWCE+Q1geapCvFTnMPGvt
 paUo06dlTMHuvo4+KVNYMDXgE7yU/JB2eWIMjxB+rt6csIQMTZY3hl5B2yCDpQecYbjc/UDY/G8
 hxln2siKGg/ekNp/XFygo0HJQ6oIy7EdcTtmsqevEyDIPt0xiFwWQZZR5dkRpd+qEuFozUn8ZV0
 e57+dZstodYOzdcEkjKscOplhDyH9mJftsSY80Nm1BnZs8QpIqxfbJXZnkOu7Qvd/yvnLYcfqkV
 LK9+SfMiMi2kgKny1mQ==
X-Proofpoint-ORIG-GUID: xUtX7gqOKx6zruH5gHV4NYG3vQ5rbh8D
X-Authority-Analysis: v=2.4 cv=Gq5PO01C c=1 sm=1 tr=0 ts=69b07ca4 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=7W-H8-9HiqHpPtFVMfQA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100177

From: Eugen Hristev <eugen.hristev@linaro.org>

Annotate vital static information into inspection table:
 - nr_swapfiles

Information on these variables is stored in a dedicated meminspect
section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 mm/swapfile.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index f39c3d712273..03aee425bdbd 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -42,6 +42,7 @@
 #include <linux/suspend.h>
 #include <linux/zswap.h>
 #include <linux/plist.h>
+#include <linux/meminspect.h>
 
 #include <asm/tlbflush.h>
 #include <linux/leafops.h>
@@ -67,6 +68,7 @@ static void move_cluster(struct swap_info_struct *si,
  */
 static DEFINE_SPINLOCK(swap_lock);
 static unsigned int nr_swapfiles;
+MEMINSPECT_SIMPLE_ENTRY(nr_swapfiles);
 atomic_long_t nr_swap_pages;
 /*
  * Some modules use swappable objects and may try to swap them out under

-- 
2.50.1

