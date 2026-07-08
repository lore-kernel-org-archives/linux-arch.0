Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9EF3BB13B
	for <linux-arch@vger.kernel.org>; Wed,  8 Jul 2026 05:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783489035; cv=none; b=lzF8lAcVQ/AZBItPwJ93uGYYWSOy0G/AWewUxMjJ2sGTnz+c9vzZCVDMjYjYFelgHgbexiTqlhrzioO15tQ/h1EB4JP88hI7ia5QrzrHpPUrkLL/wqCBGCwIR2NzcAXrVY/1b2ifPMieZ5GhqyO7zkUhUb3Z88HSTMBWvCFkUO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783489035; c=relaxed/simple;
	bh=ulGsdKu+z7HvLotkVxGi0y8RHEdMhDyQClvnrll+Bzk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L5RHR0iUgNt+N5SJswXfJ/0k4Ltd/Nj77Wurlgw3a3fPhZ/Ws6bvUiEIh2zoVF10RoF2xNcecIJShOUuK4MVnNmBNzFIdY369o5J3g4lWXJHxTlI5m58tTT8G/zTHWCQNDDH4GAGH8rqze7g4PgnQPHUTZGH5U1EKaxZ6XBZT+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P+jq7OyT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h8xkuJtb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P+jq7OyT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h8xkuJtb"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66843MIQ1527424
	for <linux-arch@vger.kernel.org>; Wed, 8 Jul 2026 05:37:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	236Inguw/8J4ynlJvnfLp1ewWMlbBoPnuOUaZpd8dt8=; b=P+jq7OyTqjAc9wXu
	RxNeVEVWgYrBpdAGK5o3b6AWPpRdC/g1cbrqpKSQiGfUKvq1e+0DgOyE1riJOnZj
	lMFxe7ytkjieiLs1bLJJoI6UfdSwS/kZFnw6Ci9E1IqzyI6Y9DJJ7r08KjH1V0ru
	9wrL3tchIUUG+dXTt3ewbVrMxTEodI7+6+wCRFSxdpxYZ7QWyJD1wL8qcbsxkW5N
	PWAAHB8x9PzRoHQMrt8RSH2RzIU9BvQagmTR5nMG7cOd30b9kwE3GnbuBDdz/2dk
	0MbD7d+C9BijjANSzQYL0Nrm5mXyk//z9XTUjvKIIksxsnJNEWkm7PJ44mkMqK5t
	bfEhbw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8vun50n1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Wed, 08 Jul 2026 05:37:13 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8423f1fe39eso664546b3a.1
        for <linux-arch@vger.kernel.org>; Tue, 07 Jul 2026 22:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783489033; x=1784093833; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=236Inguw/8J4ynlJvnfLp1ewWMlbBoPnuOUaZpd8dt8=;
        b=h8xkuJtbuDUK/6glmEL5W0ajqq21kzfRtjwCvyXm5wtJLYBGQweI8X/ZlHcvHOTS8R
         mCzSRT8AWj3x9dao13wIdi8Jw+Vc1S476/bExe0K77kYkdeGl+S8AYj5D7iR7iTOUhbN
         0CraUq8PwP8pCV0nh04tXClOkOwYZZ3U96Y6laQEKuHs3ooX0+GQlbH5yQgy9QA2Eoqr
         pWACC23IoU85UKqnIbwnH65DZvaGuPOcTZkhGprHIW25eUJFcuhmNQ+WO6pmp1p69cTn
         Dd2y7+Bo4GDXGgPddQ6SlIEJikmMXOVSlSUzslbWnUNEPLYYjTqaP8eHJJn3cbyA/9fv
         wKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783489033; x=1784093833;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=236Inguw/8J4ynlJvnfLp1ewWMlbBoPnuOUaZpd8dt8=;
        b=I0EipgooUv4/7XV8GUlroxMzdgWqRDI2o+Q+OZeeG7PFCGlXnnZtnLhebAEQuraPKh
         /Vij3l88US/stl1it/OaSO7WGcFJj0AhSOKiojzgiLEkU+jxpk8cbDwxmWEaA+3fjYDS
         ScbqqXEy7KQtDd7yiMJWShmhygjc/yVJfJVjujX/xes7tLDzzeLmktkN10ow9+shl60L
         2iZbPG+gHWsP1oHbaiQM8RR+FzgsvsMMMWartNgSGm5IAtWX+Op7VZ5Kuz9AVG91xiSs
         OTqeHYmXUYfeOrsqV5QgmdSduAvokayHZb27+DIMZJOyvHpsphWzcZCXFdQ484wfCYXA
         xxjg==
X-Forwarded-Encrypted: i=1; AHgh+RpQ8XO7IQGGx+/iNGRvod2DHiDdsXoxZII7DZDzgunzGXgXVJmQ9tLPfoqYPMVV6nzhWZl0vdwUUCjx@vger.kernel.org
X-Gm-Message-State: AOJu0YwaljxeVDlDdeHhUBhcF/ECwiBoqkbPz7Wg0Vg3bpbdRSYjzw3I
	Mnalz0hDB9UTysTRSmP1mPJRVuYHbcuUpR88DcDZ0ATK+i5/8kbndupKyBp7DT2mq9ZjZoEhpA1
	B1UYLGRKPUvMXYZq40U1aP9y5QGHQPZw7Bcd5oNY8GdmrxA32fzxuAHQeKZH0Le28
X-Gm-Gg: AfdE7ckZYNwWx8ELQLnHRcGuS4qums59FryRn/rA6XpkNoBcFXehNtfji9r8SZja7zd
	otByrGRYo4SSzYxoPU+fSzT29gqWsdNJOHuMehbOj2bKMtphtcHTnZXqbeHOCZ6NcI6brl+jY0Y
	8CoyAGAGn2ITjM5PIfEm/RxrRGUftFll0p2BPw2dKxqrDaEb0CBKGeC0by3KbD/J5q6btjlUorm
	gYkzQolK3wgI2ZpzAc+6pLuubWEE3qzrGEeSBUa7eYWptEEXPPbzJA28Z1dunuxLD9tA51l/YWi
	n8I+ljq+GxSO2F9c41gsP/unbUZ/RNkTwIai7n2J5o2aYKBGrGsORNL2QJrUlqKa4SG5XmOKgif
	EItadcYx9UOxXmGVZ4kxaImhQx95jJF6KFnIVwg==
X-Received: by 2002:a05:6a00:2990:b0:847:927d:47a8 with SMTP id d2e1a72fcca58-8484327cab4mr1157494b3a.18.1783489032810;
        Tue, 07 Jul 2026 22:37:12 -0700 (PDT)
X-Received: by 2002:a05:6a00:2990:b0:847:927d:47a8 with SMTP id d2e1a72fcca58-8484327cab4mr1157416b3a.18.1783489032130;
        Tue, 07 Jul 2026 22:37:12 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6db29d1sm6484592b3a.53.2026.07.07.22.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 22:37:11 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Wed, 08 Jul 2026 11:01:58 +0530
Subject: [PATCH v3 19/26] mm/numa: Register node data information into
 meminspect
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-meminspect-v3-v3-19-7aa5a0a74d5c@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783488714; l=1048;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=ulGsdKu+z7HvLotkVxGi0y8RHEdMhDyQClvnrll+Bzk=;
 b=MyMhtvJ0wOXNwjzXvlmiA8Ab9JBujyIxKxBCpE0ObhCZPfckWyAffIDGpRxS9EBhvOuKic1KN
 jH7INpGJKThDjepKcHIt//QYPSzCAx6MP/DqcCdV9jTWtJ2PBlwoCaR
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA1MCBTYWx0ZWRfX2onlYZ+0RVGC
 kaP0KI/q3tDa9nYR43SHNx2gNhrg7mQrGCzaJ1hyc2xPSrGsJ8tM3OWhzxTMO42IfXImRbozvZt
 cjL1+g0r2PI+s4d2FYCSoZ1/S2QdNAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA1MCBTYWx0ZWRfX5SD5DbhAfxZF
 HfID3hmMT5gGsEyjVPE7lm7gbnf5kjbwjo44RJ1weIwd2blhv9TlEc89BVgpLdo39ZaD21UXAgJ
 HDhUfN/0m3ZoQ7z0Gzn8ZyyoidCplYtgm2TM4s6ewYJK7NEhkw/UsIf34CvVsfzplgXTSqdgFL8
 yA1D5/TmOgUWXsNEWGD1fpVaXS22Pi+BpNxcVl+llIkQgPVyiGVmYa1ul1ibZqdnLpOIbZJi/0m
 rEwneEjaXiGGmflpDCxIqeoZmXT9GWmtuDi48aImjlK03jv8kUEoKlDXnr0hlR/x1Nb98piOgFF
 IW9P17A75NQLVkEbYngRj4JjuJC90b3a4nU8Ft3lC6ReaAgOv9hRABQCE4MQr1iTHqbhTYTqcwb
 pLDGu6xw8Nm/HJAluVMf+UAWLJ6WQb8UPmNMhKk8LvsUwHG+son7wd7iOTF6mUEJrxn5MGZc6IF
 nGTIOeCSEKWMo0RdPSQ==
X-Proofpoint-GUID: z1Q25XR2E3_ftObMzcL95hAjqrr_U1Q2
X-Authority-Analysis: v=2.4 cv=N+IZ0W9B c=1 sm=1 tr=0 ts=6a4de209 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=nLJQaZXserL0MincpKQA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: z1Q25XR2E3_ftObMzcL95hAjqrr_U1Q2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080050

Register dynamic information into meminspect for debugging:
 - dynamic node data for each node

Use meminspect_register_pa() to collect node data into meminspect.

Co-developed-by: Eugen Hristev <eugen.hristev@linaro.org>
Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 mm/numa.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/numa.c b/mm/numa.c
index 7d5e06fe5bd4..f04740dfb2cb 100644
--- a/mm/numa.c
+++ b/mm/numa.c
@@ -4,6 +4,7 @@
 #include <linux/printk.h>
 #include <linux/numa.h>
 #include <linux/numa_memblks.h>
+#include <linux/meminspect.h>
 
 struct pglist_data *node_data[MAX_NUMNODES];
 EXPORT_SYMBOL(node_data);
@@ -20,6 +21,7 @@ void __init alloc_node_data(int nid)
 	if (!nd_pa)
 		panic("Cannot allocate %zu bytes for node %d data\n",
 		      nd_size, nid);
+	meminspect_lock_register_pa(nd_pa, nd_size);
 
 	/* report and initialize */
 	pr_info("NODE_DATA(%d) allocated [mem %#010Lx-%#010Lx]\n", nid,

-- 
2.53.0

