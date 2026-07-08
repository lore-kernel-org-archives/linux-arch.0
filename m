Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8463BBA08
	for <linux-arch@vger.kernel.org>; Wed,  8 Jul 2026 05:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783488940; cv=none; b=UAY+YLWHVdYjvS+Qo6cYerNypFE6lAoPKOoFeqp7heWoKVRwI+TGJ2HNHrwi9m8cOTuSJ7glgEOta7oV9F/idzwCJr3cwCkMCmsi9nqrb7fO+UEbJZF+53C0l+Hv2zJ8hIqTMF+ldw2XBMzaRG1RdAZwOsnfrzyEiDt2JcC3Zz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783488940; c=relaxed/simple;
	bh=VGtMpDFFJ8AMn/x41vfBeQZo7MfofL1gwJeLzgL/KfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X/HnInc9U+A3oZcUBzf5yyDw5uNcP1ijLyidZE2vkRFSE2PNTrT7uPD0UeNWtuGLH0qb6tompyUAB1s8oSnfKEZv3iVrS2El6dOHUYJbzIaK9D+ljxoTOxQCiqkumU+pR1gvTxg59R1Y/xJhwDvBSapR0cio+8sdrEQL2I7xzlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VEFi7exh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j4BLFId3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VEFi7exh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j4BLFId3"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6685Di3K1817805
	for <linux-arch@vger.kernel.org>; Wed, 8 Jul 2026 05:35:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mY9TC1kShItUPWikoDVcElgzg0fCudtz+RsSBo7NFkQ=; b=VEFi7exhNSE6eNEW
	+eOINcOvpmvrYtMDQ2p7cokzjt5kzecHBE1gJNpxiTLmdl1qUz9o1o61/AidoM9W
	5aVMXNyOdd4piuVhr9ZC+O09c06yDw6rYq9buVtuC53q/zta3TqKj6PITSKHl+/k
	4PQSHLgG6NrMtQ4lDdeuzpexKnNxfO5AlU89IR26micEaRG1GgUStu+GqIHiKTVc
	HGee/omlz97CBjj3CBgGEj+7JiOX7FYdeyJXhDqFXm33K0IEohevYWzTnQ226eR8
	qJgj7kGAOJQh7X9PuwyrCsOhrXCLtCpcWAVqDBKFcdtCsj/36uY1RrBoJoyk1l5w
	LvCdVg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9g7hg29q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Wed, 08 Jul 2026 05:35:38 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-846f50381a6so326345b3a.0
        for <linux-arch@vger.kernel.org>; Tue, 07 Jul 2026 22:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783488938; x=1784093738; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mY9TC1kShItUPWikoDVcElgzg0fCudtz+RsSBo7NFkQ=;
        b=j4BLFId30yRKUSl5jy2zKpDX5zgGymn5BKU/iYU8PRPrdulovZxYudlNUJvl9xt7Sj
         h3g29M109NGiiN6fSPQE+N/Yi9U4L3qOtWJv4oUwXte8bMlHnfBb6kaFtFAmmUIjAKkE
         Lq24Q7zed45Qwk7ij+Pm+79ahfp4QIVgqj7Aqc+MoQh12OTnxY79EsK5BNEBpuZdduYY
         R3YakMR0qZPnwubxDuJg7NMwYfZ9C2nNaiDtl4IByxOuq8eoqG3mqkGDFU0GFCLJaqs8
         XAzE1Y+VXLzDcRTHWbx42mzOkBxaOPiztPi+DIpdNdV3CJABMUN5GoM3N9XTuzQBUgZ+
         xHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783488938; x=1784093738;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mY9TC1kShItUPWikoDVcElgzg0fCudtz+RsSBo7NFkQ=;
        b=Qlods5haBZNKcewZpO8cRTM0cQiHADQ8vXiXCSjjnGxGSefnmdSRMJlfB1oJxcgTVa
         m9gxazkB7csgvamzeYlKNonLf0FPQrq2GFAACpv9JHVzZk9hY0xAG/AY9vJNCBr60tnn
         dh9UD16OwUlnqnUQ3RPMPuPL5/TKR7QxCAaDztK4cGpEmIga8zI0uZi7Lx7kHMl0ZHaX
         WYKF1ZHnfUp7v40I0MWirM0sEaplXcEujQO5/70WA/hPTRjcvsa29OkDpPPPb0hnWEpP
         SIRd5NFli+Rh3SLuJMHD2JWex3A3sxp/bbx+w9Levf1K59HLl1hZogRF/S9Pj5NojpQh
         TLog==
X-Forwarded-Encrypted: i=1; AHgh+Rq6JdO3xgdJw7SkMZ3x9ekZmUITVWhzq2a0x6yNglfxDx2jDr6UFarZ0T56RROp6juKHF/j+DEjPRRd@vger.kernel.org
X-Gm-Message-State: AOJu0YwXVxZ4wU1DYibpD5FVjtvV0aSyXd8PypHY3kdHOYnwzlfn+xu3
	Ix8jw+9DD+Aofm/05jYSYSZPlLqd4TPvUFLIceFj3tjFqP4l3NFARCfaX+GZW8x/08NkZSSPZ8y
	dz0EhGr3uQTzpAVXm0eNOwoogcOVlKXYlCc+yvVm8fPFISF10yOYvQQNZIRPeN5Z1
X-Gm-Gg: AfdE7cmtSz1Dlbfoja4JR733iEP4D9hHeT3obpvYWVenwXFmPBTVp9EXB2Z9yC7bU2E
	mxdOIPFWmjEdW4AvIuTN5S83etEAKLJswkRJx51fSx973Uocr9WO2i5+MrmNw2sB9BzY30p/Rw3
	3Kyyyf4ARnqFkUyyn5gPX/XgMQZVj4KkS8UB1fC8i+J/bqjjBZ+w4e5oUrdgtfzG5WdheqsUjmx
	FjLQInImQ6nJrxY40Ve9qiRRkt5wmHR29gVpz70/Sq9B6ASTWCu03ksTKc7tdKqH0kLGr1GSkGc
	p8RAEtI+njOQ99puQ1wtmhhZBZidWk8Lm+athPMf8xcZcZSbmiX+u46G5jVL6u3AQrLZcyvObIf
	IiKU/xoNdJrmMZBIBB+Nc9SXBu93SA85WBoN4aA==
X-Received: by 2002:a05:6a00:3a13:b0:848:2f74:1d66 with SMTP id d2e1a72fcca58-848438d7230mr1080737b3a.76.1783488937334;
        Tue, 07 Jul 2026 22:35:37 -0700 (PDT)
X-Received: by 2002:a05:6a00:3a13:b0:848:2f74:1d66 with SMTP id d2e1a72fcca58-848438d7230mr1080644b3a.76.1783488936625;
        Tue, 07 Jul 2026 22:35:36 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6db29d1sm6484592b3a.53.2026.07.07.22.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 22:35:36 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Wed, 08 Jul 2026 11:01:52 +0530
Subject: [PATCH v3 13/26] kernel/configs: Register dynamic information into
 meminspect
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-meminspect-v3-v3-13-7aa5a0a74d5c@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783488714; l=1125;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=ZV2kS+66Zo+GSuPrvrjZxSGkrByR7dJYtHrlrdTWNGk=;
 b=5SVbNkatrByr1/TpyiDmMuVtbPFXDVWi0cCCZKl5b9Zre8CMglPYGspE5ZWEb3Shosf+K63nu
 /z7Qty/Pfv5AEFi1fClZu/IN1yxFaXSgXEakFkdUbQUtlP344UBgWQA
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA1MCBTYWx0ZWRfX95IV7VTge19G
 seO52jkj7S3UUZ1dIRxc1xVIGDGf35irMuBqrjankBpiqXDnbDQcbRtA15DvhAHPaJ7FnAoQds2
 sUR7ZXMa4+abukuvCcWZVEHpo8G7HV1/ZvZ4INzQroBhhHzY+uvn/NBbz2M5XLnRktaNrAzIBsN
 Rl+eEohpgrKaNzZPJbFF7ccZKCSZ0zoSCQ/5YOZWT8FMtYfWt0AYX3eqvLoltmnkRIkFoQnpH6U
 hrjD2NrUPivMCEn8/p0vHbz78K2eIUJW/KJtrYIN/QE7TogPrtkEL8mpKklDi17G0nR3g0m1f8Z
 X0ZlYyn52vJg95xm8EJwkRAvjmN7VUce/cHQ0xUdW6UUoWmK7x7mwIBqRIwQy7hIlcvAunbk6Px
 9rGVhGIhI/gE2uxoL/41SbX8TiCvzq/xmidwTA4JiVtxCAfNf1JHhBC45TcsAm6qsD+7mheAq6W
 4BTRwvZ0exmZg4uTn8g==
X-Proofpoint-GUID: 8XEfE1m6xZoOraxpqgFwyn9Bj74B4Rtv
X-Authority-Analysis: v=2.4 cv=TMp1jVla c=1 sm=1 tr=0 ts=6a4de1aa cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=LjyN-fOCrMyGU0ESAFYA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA1MCBTYWx0ZWRfX1i9ONgFlvbL/
 HoUTxIvu39xlMAUYLHIlUZ0L9L/Mcv6VqFJjGUCGxyk+tRw0Cqe6vf88mYVlxYB2Qtierh05ChH
 HvdQxvQdkIZ/uTBp4hWye+VwN4YaKvw=
X-Proofpoint-ORIG-GUID: 8XEfE1m6xZoOraxpqgFwyn9Bj74B4Rtv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080050

From: Eugen Hristev <ehristev@kernel.org>

Register kernel_config_data information into inspection table.
Debugging tools look for the start and end markers, so we need to
capture those as well into the region.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 kernel/configs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/configs.c b/kernel/configs.c
index a28c79c5f713..1e7b86a8b3fc 100644
--- a/kernel/configs.c
+++ b/kernel/configs.c
@@ -15,6 +15,7 @@
 #include <linux/seq_file.h>
 #include <linux/init.h>
 #include <linux/uaccess.h>
+#include <linux/meminspect.h>
 
 /*
  * "IKCFG_ST" and "IKCFG_ED" are used to extract the config data from
@@ -64,6 +65,11 @@ static int __init ikconfig_init(void)
 
 	proc_set_size(entry, &kernel_config_data_end - &kernel_config_data);
 
+	/* Register 8 bytes before and after, to catch the marker too */
+	meminspect_lock_register_id_va(MEMINSPECT_ID_CONFIG,
+				       (void *)&kernel_config_data - 8,
+				       &kernel_config_data_end - &kernel_config_data + 16);
+
 	return 0;
 }
 

-- 
2.53.0

