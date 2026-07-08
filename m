Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13B13B9D8C
	for <linux-arch@vger.kernel.org>; Wed,  8 Jul 2026 05:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783488752; cv=none; b=hMdV40C7jbLzkKVDC8/Obh80HZIa69oz6/0QM4oQyGKRvQ4mmLee3+1rm+qyiM1udY9qPxecNuTCc8pxgmH/MFb84Ap5sXEf3vki0oiGzhZPqNUZ0ITCyoEgxucpeUKGztm4knWi2S3b6tGU4KLpGH2mcyueeRfKYL2ihxdRQCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783488752; c=relaxed/simple;
	bh=Z7D3jVFLgDKyQlXMpU8F+KGv/fjROjiV57bvVjq0PKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h/ry28FIYnAioCkUXkQ1dYuGkQULNY1Sfuf/Oj0wglcyD8Ulhvx9/hIENR+UZ7KvzC+8SivahTCSKotQQ4I9k/3Gtf8GU5XbujZuoyp0jHurPigdJ0eOV3sywM0N+porCBGd+coX9EVs73aY6G6oyppNkoxtRHY+N6IrvY/V68o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f7xorGSn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GKIm5rLH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f7xorGSn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GKIm5rLH"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66842SKr1447408
	for <linux-arch@vger.kernel.org>; Wed, 8 Jul 2026 05:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2UlZIVibfpd8EiTrzJIuWoHo83AyTv6ZN+29VIlyxn4=; b=f7xorGSn3tkhgRd1
	cTuwWHbqzuRBH/bk6CJcKZLo6SWYxtjFylTyUKbMk8rC5hY6S1VjcvHBPrmnRnlX
	zI3+Pk5cS7XvzcMirqdqgv1MmljsyEwYxGYso+j928SPs2gHJrRODya03r4jOv5N
	PwMIzoYEKOvERlrzhYcJl5ioCms02Vgt3dme7AssGfaz12Ndfq1OAf1nM8w0xyxF
	16KX3goYl6bLkG4MwnMDiSuOTwW+Sjq7rK9NLmwuZ77tYzXZePBSVxGYe9JHjzvh
	hMdiwtOQW9lXt/kyNk2IbEKnWBTejDIwd1vTKPuGSg4W2GIWtbI020oL2VgNdi1j
	jH4llQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f97u11t7y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Wed, 08 Jul 2026 05:32:28 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8478a1ec69fso561199b3a.0
        for <linux-arch@vger.kernel.org>; Tue, 07 Jul 2026 22:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783488748; x=1784093548; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2UlZIVibfpd8EiTrzJIuWoHo83AyTv6ZN+29VIlyxn4=;
        b=GKIm5rLHcIejBexvm4ga3d9Q7JLklAMzR66DaMv7DMnKrw7BvEOzycwHnNX6qb/XrY
         JWD8/VqtuZZQ9S4QU+oVYcETk4jmtPPzN/VTdznrr2imowNJgQPZmfo+qeUtIQCo5UVM
         4/zBtu3Yfk3XFmE4ZwHMaiVxuXIWOoQI5LDtuv7gMd6478MB6yEBumCtnmFJgoIrkqtq
         kLlOR+JDImVRDgBklKEZa5maahxrg4BEv0KYcKHUUfx42jvmtwSdAz8zNXZdrHP/LPr9
         RXe7XwCz9SzIrewL7Muozv3wQh3MsX9QHZGyegx6ZNThBQPY6JW5kWH9iz3snDdxTLrn
         TkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783488748; x=1784093548;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2UlZIVibfpd8EiTrzJIuWoHo83AyTv6ZN+29VIlyxn4=;
        b=Kz0jSeBWy0UCZqxFt2vq9oYvc022Zqv+Xmd5BWdD/b/gfXpaGfRBMMCQbOdURaeY20
         WuzTrDg40xNkHJo7dBtsBrIP5Mq7WoNSVC+ba6SWkwb8foMryX6CGAFLun1XyZh6rn4N
         aQ7+963jIiroqfo6tgyB8Mi4SM2WO5CnxSXlL9lHd9ivjURBOuDgMqfoO2YW44fA9qhf
         ZUnb7WtnCu5wSvZ+R0i7eLSduoyjZFT0gevPbkggPv5PVzyh+RYDzqFFHBrrtylCsWN2
         Qtw4r1uDqBroaLJLBq/VcSVpFNKWdNRVGMC4BdbCvJkKHVirNU0I1f62r8sWRgdv0V9+
         L1vQ==
X-Forwarded-Encrypted: i=1; AHgh+RoXNllsU6rXbfnJ5J/4jdWcMN3w+YJVVoILn17s71nd3ZFU5iSy2og1H+0gC4iPJnP3Ok8mlZAgGS2w@vger.kernel.org
X-Gm-Message-State: AOJu0YyOy0EdyTePeYQjZRQpEk1UdWos5JsF6KXKlvTvFXvFXpcBJqPt
	6yuT8vmvHLOhQksbDwCnQS3c/47bvLlH7l9WHg0LVeGkjVw1U9fuUBoEw0hC4wWCsuQkupRHCST
	BFe8IFff90XYGPNjLu6z/avpike/ZMTVKLL4/k5bVHgxkOy+HAGVhSg+/ZeghCPLr
X-Gm-Gg: AfdE7cnfiWW2MFL3CFGe3k5u+cznSiQnCdrcy41wOyNZDG5gUtxW665SeHwICkLaSV+
	bycBDDVpkAhurPXt5FHWbW+pSnKz9oPMUQCFGW06083VJ9rlVbncSncBbuisdda1Ube5iSP/9q5
	isIiq3AhxcBrKLg/oeD3wJtACzw9CLmY/CJvNdUzQ8Y6NqbZlznercED35OPuMvqfcuoc9zDFln
	wGdOIMQwXbc/1OpxdhHNRsg14r4sEI80eVCb4W+qKrh8yzGhfSAHnsx5ev3njjpoHT8NXV02kIW
	EWwKrNkyaWFsR9RnFya1oUsFwsuWtl56Uv2JXv1WM6DCtvxiazMA+co8/VFbYEGJsmCFuk2mWpv
	YzfGKKq/4+6nBaNTQ1aU4emOB0RI9cypfVMfcmw==
X-Received: by 2002:a05:6a00:94a2:b0:848:4809:51da with SMTP id d2e1a72fcca58-84848095566mr345758b3a.50.1783488747234;
        Tue, 07 Jul 2026 22:32:27 -0700 (PDT)
X-Received: by 2002:a05:6a00:94a2:b0:848:4809:51da with SMTP id d2e1a72fcca58-84848095566mr345693b3a.50.1783488746369;
        Tue, 07 Jul 2026 22:32:26 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6db29d1sm6484592b3a.53.2026.07.07.22.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 22:32:25 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Wed, 08 Jul 2026 11:01:40 +0530
Subject: [PATCH v3 01/26] kernel: Introduce meminspect
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-meminspect-v3-v3-1-7aa5a0a74d5c@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783488714; l=33009;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=KH3mHgbi2s3PjaGSL0rvvW+S0Ryh28FGRdTIZA8SodA=;
 b=qqUV47FptMIoE2ON8cbgzqhWLo02DhyQzv15i6loIAVxcdMkrVlr9lNo7UdFzuewFyKPw9/te
 fI1GwlpG+Z3DdyDOhn24sdGJ4zR2YjO9WLp8u1+0iU1o4sZEZNe4Oe0
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-ORIG-GUID: jhuX0AWWzzCjrNhQeOka4QzWS-v7bMqp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA1MCBTYWx0ZWRfX1nzsE4m+wVM2
 TiO4EXJ7KP9ekx99+hFMAJVmX2EtVdRCnTFoqph8hiSa+ybsw5nKruIso52bAH2t4iq2BvV82gX
 GoC0phkw8BmhAnd4qpOp2MM92suRSKA=
X-Authority-Analysis: v=2.4 cv=F9JnsKhN c=1 sm=1 tr=0 ts=6a4de0ec cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=37rDS-QxAAAA:8
 a=n5v8ppSJA3wPCkGJsRoA:9 a=_LG0Lte88zW-95Wx:21 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22 a=k1Nq6YrhK2t884LQW06G:22
X-Proofpoint-GUID: jhuX0AWWzzCjrNhQeOka4QzWS-v7bMqp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA1MCBTYWx0ZWRfX+OVB3sdDx9Yu
 xbMNhfDGq9v2HTpV+wbbgiTuBGKDjwdJ27nrIWpwIIYdZO2FjVkatHxlnwhmU6n9ErpkogTl9Kb
 SQC0P0FrH7U7ntT9HG965R012jcDss4SA9UxoFuOpfRArTENdMTo3ecDU7J99RrNhNeR9eCc5Ck
 Lcx8t+vNSisuczYgm7scVSYn0P5t12U75LQC0NwxGkdJAz2bxc7w/2M0bNbQpKXTmg0aYS8qRpx
 1ZGUt6gcnXoJss3BXrLxELaYDwGAGeoVkjgREg1SVH691vtFplBpV7RCRn0viEmDi5MOUj5wvAL
 IUwI+9yAs0wPiJMnpr82lj8TwmbkZt7P/Dj4bTEyfuUmGpXCUzGypXrHOH+/kKdcSy4dGpNMAa2
 y8yFZ+oSfJromYw78Yha9KB0F3RK5IuGZ3iU/Ou01NUy7l5CyTimIRbovneXJRd/p3gYBpXz938
 vF9P/2z+cWUyzGPZYsQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080050

From: Eugen Hristev <ehristev@kernel.org>

Memory inspection mechanism allows registration of a specific
memory area (or object) for later inspection purposes. Ranges are
added into an inspection table, which can be requested and
analyzed by specific drivers. Drivers would interface with any
hardware mechanism that will allow inspection of the data,
including but not limited to: dumping for debugging, creating a
core dump, analysis, or statistical information. Drivers can
register a notifier to know when new objects are registered, or
to traverse an existing inspection table. The inspection table is
created ahead of time such that it can be later used regardless
of the state of the kernel (running, frozen, crashed, or any
particular state).

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 Documentation/dev-tools/index.rst      |   1 +
 Documentation/dev-tools/meminspect.rst | 144 ++++++++++
 MAINTAINERS                            |   9 +
 include/asm-generic/vmlinux.lds.h      |  13 +
 include/linux/meminspect.h             | 270 +++++++++++++++++++
 init/Kconfig                           |   1 +
 kernel/Makefile                        |   1 +
 kernel/meminspect/Kconfig              |  18 ++
 kernel/meminspect/Makefile             |   3 +
 kernel/meminspect/meminspect.c         | 474 +++++++++++++++++++++++++++++++++
 10 files changed, 934 insertions(+)

diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/index.rst
index 59cbb77b33ff..ea2989ca1566 100644
--- a/Documentation/dev-tools/index.rst
+++ b/Documentation/dev-tools/index.rst
@@ -40,3 +40,4 @@ Documentation/process/debugging/index.rst
    autofdo
    propeller
    container
+   meminspect
diff --git a/Documentation/dev-tools/meminspect.rst b/Documentation/dev-tools/meminspect.rst
new file mode 100644
index 000000000000..4ca10e33e4fd
--- /dev/null
+++ b/Documentation/dev-tools/meminspect.rst
@@ -0,0 +1,144 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========
+meminspect
+==========
+
+This document provides information about the meminspect feature.
+
+Overview
+========
+
+meminspect is a mechanism that allows the kernel to register a chunk of
+memory into a table, to be used at a later time for a specific
+inspection purpose like debugging, memory dumping or statistics.
+
+meminspect allows drivers to traverse the inspection table on demand,
+or to register a notifier to be called whenever a new entry is being added
+or removed.
+
+The reasoning for meminspect is also to minimize the required information
+in case of a kernel problem. For example a traditional debug method involves
+dumping the whole kernel memory and then inspecting it. Meminspect allows the
+users to select which memory is of interest, in order to help this specific
+use case in production, where memory and connectivity are limited.
+
+Although the kernel has multiple internal mechanisms, meminspect fits
+a particular model which is not covered by the others.
+
+meminspect Internals
+====================
+
+API
+---
+
+Static memory can be registered at compile time, by instructing the compiler
+to create a separate section with annotation info.
+For each such annotated memory (variables usually), a dedicated struct
+is created with the required information.
+To achieve this goal, some basic APIs are available:
+
+* MEMINSPECT_ENTRY(idx, sym, sz)
+  is the basic macro that takes an ID, the symbol, and a size.
+
+To make it easier, some wrappers are also defined
+
+* MEMINSPECT_SIMPLE_ENTRY(sym)
+  uses the dedicated MEMINSPECT_ID_##sym with a size equal to sizeof(sym)
+
+* MEMINSPECT_NAMED_ENTRY(name, sym)
+  is a simple entry that has an id that cannot be derived from the sym,
+  so a name has to be provided
+
+* MEMINSPECT_AREA_ENTRY(sym, sz)
+  registers sym, but with the size given as sz, useful for e.g.
+  arrays which do not have a fixed size at compile time.
+
+For dynamically allocated memory, or for other cases, the following APIs
+are defined::
+
+  meminspect_register_id_pa(enum meminspect_uid id, phys_addr_t zone,
+                            size_t size, unsigned int type);
+
+which takes the ID and the physical address.
+
+Similarly there are variations:
+
+ * meminspect_register_pa() omits the ID
+ * meminspect_register_id_va() requires the ID but takes a virtual address
+ * meminspect_register_va() omits the ID and requires a virtual address
+
+If the ID is not given, the next available dynamic ID is allocated.
+
+To unregister a dynamic entry, some APIs are defined:
+ * meminspect_unregister_pa(phys_addr_t zone, size_t size);
+ * meminspect_unregister_id(enum meminspect_uid id);
+ * meminspect_unregister_va(va, size);
+
+All of the above have a lock variant that ensures the lock on the table
+is taken.
+
+
+meminspect drivers
+------------------
+
+Drivers are free to traverse the table by using a dedicated function::
+
+ meminspect_traverse(void *priv, meminspect_iter_cb_t cb)
+
+The callback is called for each entry in the table.
+
+Drivers can also register a notifier with meminspect_notifier_register()
+and unregister with meminspect_notifier_unregister() to be called when a new
+entry is added or removed.
+
+Data structures
+---------------
+
+The regions are stored in a simple fixed size array. It avoids
+memory allocation overhead. This is not performance critical nor does
+allocating a few hundred entries create a memory consumption problem.
+
+The static variables registered into meminspect are annotated into
+a dedicated .inspect_table memory section. This is then walked by meminspect
+at a later time and each variable is then copied to the whole inspect table.
+
+meminspect Initialization
+-------------------------
+
+At any time, meminspect is ready to accept region registration
+from any part of the kernel. The table does not require any initialization.
+In case CONFIG_CRASH_DUMP is enabled, meminspect creates an ELF header
+corresponding to a core dump image, in which each region is added as a
+program header. In this scenario, the first region is this ELF header, and
+the second region is the vmcoreinfo ELF note.
+By using this mechanism, all the meminspect table, if dumped, can be
+concatenated to obtain a core image that is loadable with the `crash` tool.
+
+meminspect example
+==================
+
+A simple scenario for meminspect is the following:
+The kernel registers the linux_banner variable into meminspect with
+a simple annotation like::
+
+  MEMINSPECT_SIMPLE_ENTRY(linux_banner);
+
+The meminspect late initcall will parse the compile-time table
+and copy the entry information into the inspection table.
+At a later point, any interested driver can call the traverse function to
+find out all entries in the table.
+A specific driver will then note into a specific table the address of the
+banner and the size of it.
+The specific table is then written to a shared memory area that can be
+read by upper level firmware.
+When the kernel freezes (hypothetically), the kernel will no longer feed
+the watchdog. The watchdog will trigger a higher exception level interrupt
+which will be handled by the upper level firmware. This firmware will then
+read the shared memory table and find an entry with the start and size of
+the banner. It will then copy it for debugging purpose. The upper level
+firmware will then be able to provide useful debugging information,
+like in this example, the banner.
+
+As seen here, meminspect facilitates the interaction between the kernel
+and a specific firmware.
diff --git a/MAINTAINERS b/MAINTAINERS
index c3f72058a2f2..fdad8ef377c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16892,6 +16892,15 @@ F:	arch/*/include/asm/sync_core.h
 F:	include/uapi/linux/membarrier.h
 F:	kernel/sched/membarrier.c
 
+MEMINSPECT
+M:	Eugen Hristev <eugen.hristev@linaro.org>
+M:	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/dev-tools/meminspect.rst
+F:	include/linux/meminspect.h
+F:	kernel/meminspect/*
+
 MEMBLOCK AND MEMORY MANAGEMENT INITIALIZATION
 M:	Mike Rapoport <rppt@kernel.org>
 L:	linux-mm@kvack.org
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 5659f4b5a125..3122ddf5517a 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -506,6 +506,8 @@
 	FW_LOADER_BUILT_IN_DATA						\
 	TRACEDATA							\
 									\
+	MEMINSPECT_TABLE						\
+									\
 	PRINTK_INDEX							\
 									\
 	/* Kernel symbol table */					\
@@ -904,6 +906,17 @@
 #define TRACEDATA
 #endif
 
+#ifdef CONFIG_MEMINSPECT
+#define MEMINSPECT_TABLE						\
+	. = ALIGN(8);							\
+	.inspect_table : AT(ADDR(.inspect_table) - LOAD_OFFSET) {	\
+		BOUNDED_SECTION_POST_LABEL(.inspect_table,		\
+					   __inspect_table, , _end)	\
+	}
+#else
+#define MEMINSPECT_TABLE
+#endif
+
 #ifdef CONFIG_PRINTK_INDEX
 #define PRINTK_INDEX							\
 	.printk_index : AT(ADDR(.printk_index) - LOAD_OFFSET) {		\
diff --git a/include/linux/meminspect.h b/include/linux/meminspect.h
new file mode 100644
index 000000000000..a9eb93c6ea2f
--- /dev/null
+++ b/include/linux/meminspect.h
@@ -0,0 +1,270 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _MEMINSPECT_H
+#define _MEMINSPECT_H
+
+#include <asm/page.h>
+#include <linux/notifier.h>
+
+enum meminspect_uid {
+	MEMINSPECT_ID_NONE = 0,
+	MEMINSPECT_ID_ELF,
+	MEMINSPECT_ID_VMCOREINFO,
+	MEMINSPECT_ID_CONFIG,
+	MEMINSPECT_ID__totalram_pages,
+	MEMINSPECT_ID___cpu_possible_mask,
+	MEMINSPECT_ID___cpu_present_mask,
+	MEMINSPECT_ID___cpu_online_mask,
+	MEMINSPECT_ID___cpu_active_mask,
+	MEMINSPECT_ID_mem_section,
+	MEMINSPECT_ID_jiffies_64,
+	MEMINSPECT_ID_linux_banner,
+	MEMINSPECT_ID_nr_threads,
+	MEMINSPECT_ID_total_nr_irqs,
+	MEMINSPECT_ID_tainted_mask,
+	MEMINSPECT_ID_taint_flags,
+	MEMINSPECT_ID_node_states,
+	MEMINSPECT_ID___per_cpu_offset,
+	MEMINSPECT_ID_nr_swapfiles,
+	MEMINSPECT_ID_init_uts_ns,
+	MEMINSPECT_ID_printk_rb_static,
+	MEMINSPECT_ID_printk_rb_dynamic,
+	MEMINSPECT_ID_prb,
+	MEMINSPECT_ID_prb_descs,
+	MEMINSPECT_ID_prb_infos,
+	MEMINSPECT_ID_prb_data,
+	MEMINSPECT_ID_clear_seq,
+	MEMINSPECT_ID_high_memory,
+	MEMINSPECT_ID_init_mm,
+	MEMINSPECT_ID__sinittext,
+	MEMINSPECT_ID__einittext,
+	MEMINSPECT_ID__end,
+	MEMINSPECT_ID__text,
+	MEMINSPECT_ID__stext,
+	MEMINSPECT_ID__etext,
+	MEMINSPECT_ID_kallsyms_num_syms,
+	MEMINSPECT_ID_kallsyms_offsets,
+	MEMINSPECT_ID_kallsyms_names,
+	MEMINSPECT_ID_kallsyms_token_table,
+	MEMINSPECT_ID_kallsyms_token_index,
+	MEMINSPECT_ID_kallsyms_markers,
+	MEMINSPECT_ID_kallsyms_seqs_of_names,
+	MEMINSPECT_ID_swapper_pg_dir,
+	MEMINSPECT_ID_DYNAMIC,
+	MEMINSPECT_ID_MAX = 201,
+};
+
+#define MEMINSPECT_TYPE_REGULAR		0
+
+#define MEMINSPECT_NOTIFIER_ADD		0
+#define MEMINSPECT_NOTIFIER_REMOVE	1
+
+/**
+ * struct inspect_entry - memory inspect entry information
+ * @id: unique id for this entry
+ * @va: virtual address for the memory (pointer)
+ * @pa: physical address for the memory
+ * @size: size of the memory area of this entry
+ * @type: type of the entry (class)
+ */
+struct inspect_entry {
+	enum meminspect_uid	id;
+	void			*va;
+	phys_addr_t		pa;
+	size_t			size;
+	unsigned int		type;
+};
+
+/**
+ * typedef meminspect_iter_cb_t - Iterator callback for meminspect traversal
+ * @priv: private data passed through from the caller of meminspect_traverse()
+ * @ie:   pointer to the current inspect_entry; read-only, table lock held
+ *
+ * The table lock is held by the caller; the callback must not call any
+ * meminspect_table_lock() or meminspect_table_unlock() variants.
+ */
+typedef void (*meminspect_iter_cb_t)(void *priv, const struct inspect_entry *ie);
+
+#ifdef CONFIG_MEMINSPECT
+/* .inspect_table section table markers*/
+extern const struct inspect_entry __inspect_table[];
+extern const struct inspect_entry __inspect_table_end[];
+
+/*
+ * Annotate a static variable into inspection table.
+ * Can be called multiple times for the same ID, in which case
+ * multiple table entries will be created
+ */
+#define MEMINSPECT_ENTRY(idx, sym, sz)						\
+	static const struct inspect_entry __UNIQUE_ID(__inspect_entry_##idx)	\
+	__used __section(".inspect_table") = {					\
+		.id = idx,							\
+		.va = (void *)&(sym),						\
+		.size = (sz),							\
+	}
+/*
+ * A simple entry is just a variable, the size of the entry is the variable size
+ * The variable can also be a pointer, the pointer itself is being added in this
+ * case.
+ */
+#define MEMINSPECT_SIMPLE_ENTRY(sym)	\
+	MEMINSPECT_ENTRY(MEMINSPECT_ID_##sym, sym, sizeof(sym))
+/*
+ * In the case when `sym` is not a variable, but a member of a struct e.g.,
+ * and we cannot derive a name from it, a name must be provided.
+ */
+#define MEMINSPECT_NAMED_ENTRY(name, sym)	\
+	MEMINSPECT_ENTRY(MEMINSPECT_ID_##name, sym, sizeof(sym))
+/*
+ * Create a more complex entry, by registering an arbitrary memory starting
+ * at sym. The size is provided as a parameter.
+ * This is used e.g. when the symbol is a start of an unknown sized array.
+ */
+#define MEMINSPECT_AREA_ENTRY(sym, sz) \
+	MEMINSPECT_ENTRY(MEMINSPECT_ID_##sym, sym, sz)
+
+/* Iterate through .inspect_table section entries */
+#define for_each_meminspect_entry(__entry)		\
+	for (__entry = __inspect_table;			\
+	     __entry < __inspect_table_end;		\
+	     __entry++)
+
+#else
+#define MEMINSPECT_ENTRY(...)
+#define MEMINSPECT_SIMPLE_ENTRY(...)
+#define MEMINSPECT_NAMED_ENTRY(...)
+#define MEMINSPECT_AREA_ENTRY(...)
+#endif
+
+#ifdef CONFIG_MEMINSPECT
+
+/*
+ * Dynamic helpers to register entries.
+ * These do not lock the table, so use with caution.
+ */
+void meminspect_register_id_pa(enum meminspect_uid id, phys_addr_t zone,
+			       size_t size, unsigned int type);
+void meminspect_table_lock(void);
+void meminspect_table_unlock(void);
+
+#define meminspect_register_pa(...) \
+	meminspect_register_id_pa(MEMINSPECT_ID_DYNAMIC, __VA_ARGS__, MEMINSPECT_TYPE_REGULAR)
+
+#define meminspect_register_id_va(id, va, size) \
+	meminspect_register_id_pa(id, virt_to_phys(va), size, MEMINSPECT_TYPE_REGULAR)
+
+#define meminspect_register_va(...) \
+	meminspect_register_id_va(MEMINSPECT_ID_DYNAMIC, __VA_ARGS__)
+
+void meminspect_unregister_pa(phys_addr_t zone, size_t size);
+void meminspect_unregister_id(enum meminspect_uid id);
+
+#define meminspect_unregister_va(va, size) \
+	meminspect_unregister_pa(virt_to_phys(va), size)
+
+void meminspect_traverse(void *priv, meminspect_iter_cb_t cb);
+
+/*
+ * Producers, or registrators, are advised to use the locked API below
+ */
+#define meminspect_lock_register_pa(...)			\
+	do {							\
+		meminspect_table_lock();			\
+		meminspect_register_pa(__VA_ARGS__);		\
+		meminspect_table_unlock();			\
+	} while (0)
+
+#define meminspect_lock_register_id_va(...)			\
+	do {							\
+		meminspect_table_lock();			\
+		meminspect_register_id_va(__VA_ARGS__);		\
+		meminspect_table_unlock();			\
+	} while (0)
+
+#define meminspect_lock_register_va(...)			\
+	do {							\
+		meminspect_table_lock();			\
+		meminspect_register_va(__VA_ARGS__);		\
+		meminspect_table_unlock();			\
+	} while (0)
+
+#define meminspect_lock_unregister_pa(...)			\
+	do {							\
+		meminspect_table_lock();			\
+		meminspect_unregister_pa(__VA_ARGS__);		\
+		meminspect_table_unlock();			\
+	} while (0)
+
+#define meminspect_lock_unregister_va(...)			\
+	do {							\
+		meminspect_table_lock();			\
+		meminspect_unregister_va(__VA_ARGS__);		\
+		meminspect_table_unlock();			\
+	} while (0)
+
+#define meminspect_lock_unregister_id(...)			\
+	do {							\
+		meminspect_table_lock();			\
+		meminspect_unregister_id(__VA_ARGS__);		\
+		meminspect_table_unlock();			\
+	} while (0)
+
+#define meminspect_lock_traverse(...)				\
+	do {							\
+		meminspect_table_lock();			\
+		meminspect_traverse(__VA_ARGS__);		\
+		meminspect_table_unlock();			\
+	} while (0)
+
+int meminspect_notifier_register(struct notifier_block *n);
+int meminspect_notifier_unregister(struct notifier_block *n);
+
+#else
+static inline void meminspect_register_id_pa(enum meminspect_uid id,
+					     phys_addr_t zone,
+					     size_t size, unsigned int type)
+{
+}
+
+static inline void meminspect_table_lock(void)
+{
+}
+
+static inline void meminspect_table_unlock(void)
+{
+}
+
+static inline void meminspect_unregister_pa(phys_addr_t zone, size_t size)
+{
+}
+
+static inline void meminspect_unregister_id(enum meminspect_uid id)
+{
+}
+
+static inline void meminspect_traverse(void *priv, meminspect_iter_cb_t cb)
+{
+}
+
+static inline int meminspect_notifier_register(struct notifier_block *n)
+{
+	return 0;
+}
+
+static inline int meminspect_notifier_unregister(struct notifier_block *n)
+{
+	return 0;
+}
+
+#define meminspect_register_pa(...)		do { } while (0)
+#define meminspect_register_id_va(...)		do { } while (0)
+#define meminspect_register_va(...)		do { } while (0)
+#define meminspect_lock_register_pa(...)	do { } while (0)
+#define meminspect_lock_register_va(...)	do { } while (0)
+#define meminspect_lock_register_id_va(...)	do { } while (0)
+#define meminspect_lock_traverse(...)		do { } while (0)
+#define meminspect_lock_unregister_va(...)	do { } while (0)
+#define meminspect_lock_unregister_pa(...)	do { } while (0)
+#define meminspect_lock_unregister_id(...)	do { } while (0)
+#endif
+
+#endif
diff --git a/init/Kconfig b/init/Kconfig
index fa42fb264c9c..adbe607b7b62 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2294,6 +2294,7 @@ config TRACEPOINTS
 source "kernel/Kconfig.kexec"
 
 source "kernel/liveupdate/Kconfig"
+source "kernel/meminspect/Kconfig"
 
 endmenu		# General setup
 
diff --git a/kernel/Makefile b/kernel/Makefile
index 1e1a31673577..7c74a4f94a81 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -52,6 +52,7 @@ obj-y += locking/
 obj-y += power/
 obj-y += printk/
 obj-y += irq/
+obj-y += meminspect/
 obj-y += rcu/
 obj-y += livepatch/
 obj-y += liveupdate/
diff --git a/kernel/meminspect/Kconfig b/kernel/meminspect/Kconfig
new file mode 100644
index 000000000000..18ff511ad4cf
--- /dev/null
+++ b/kernel/meminspect/Kconfig
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config MEMINSPECT
+	bool "Allow the kernel to register memory regions for inspection purpose"
+	depends on !CRASH_DUMP || DMA_CMA
+	help
+	  Inspection mechanism allows registration of a specific memory
+	  area (or object) for later inspection purposes. Ranges are added
+	  into an inspection table, which can be requested and analyzed by
+	  specific drivers. Drivers would interface any hardware mechanism
+	  that will allow inspection of the data, including but not limited
+	  to: dumping for debugging, creating a coredump, analysis, or
+	  statistical information.  The inspection table is created ahead
+	  of time such that it can be later used regardless of the state of
+	  the kernel (running, frozen, crashed, or any particular state).
+
+	  Note that modules using this feature must be rebuilt if this
+	  option changes.
diff --git a/kernel/meminspect/Makefile b/kernel/meminspect/Makefile
new file mode 100644
index 000000000000..09fd55e6d9cf
--- /dev/null
+++ b/kernel/meminspect/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_MEMINSPECT) += meminspect.o
diff --git a/kernel/meminspect/meminspect.c b/kernel/meminspect/meminspect.c
new file mode 100644
index 000000000000..d9d38f484f1f
--- /dev/null
+++ b/kernel/meminspect/meminspect.c
@@ -0,0 +1,474 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/crash_core.h>
+#include <linux/dma-map-ops.h>
+#include <linux/errno.h>
+#include <linux/meminspect.h>
+#include <linux/notifier.h>
+#include <linux/vmcore_info.h>
+
+static DEFINE_MUTEX(meminspect_lock);
+static struct inspect_entry inspect_entries[MEMINSPECT_ID_MAX];
+
+static ATOMIC_NOTIFIER_HEAD(meminspect_notifier_list);
+
+#ifdef CONFIG_CRASH_DUMP
+
+#define CORE_STR "CORE"
+
+static struct elfhdr *ehdr;
+static size_t elf_offset;
+static bool elf_hdr_ready;
+
+static void append_kcore_note(char *notes, size_t *i, const char *name,
+			      unsigned int type, const void *desc,
+			      size_t descsz)
+{
+	struct elf_note *note = (struct elf_note *)&notes[*i];
+
+	note->n_namesz = strlen(name) + 1;
+	note->n_descsz = descsz;
+	note->n_type = type;
+	*i += sizeof(*note);
+	memcpy(&notes[*i], name, note->n_namesz);
+	*i = ALIGN(*i + note->n_namesz, 4);
+	memcpy(&notes[*i], desc, descsz);
+	*i = ALIGN(*i + descsz, 4);
+}
+
+static void append_kcore_note_nodesc(char *notes, size_t *i, const char *name,
+				     unsigned int type, size_t descsz)
+{
+	struct elf_note *note = (struct elf_note *)&notes[*i];
+
+	note->n_namesz = strlen(name) + 1;
+	note->n_descsz = descsz;
+	note->n_type = type;
+	*i += sizeof(*note);
+	memcpy(&notes[*i], name, note->n_namesz);
+	*i = ALIGN(*i + note->n_namesz, 4);
+}
+
+static struct elf_phdr *elf_phdr_entry_addr(struct elfhdr *ehdr, int idx)
+{
+	struct elf_phdr *ephdr = (struct elf_phdr *)((size_t)ehdr + ehdr->e_phoff);
+
+	return &ephdr[idx];
+}
+
+static int clear_elfheader(const struct inspect_entry *e)
+{
+	struct elf_phdr *phdr;
+	struct elf_phdr *tmp_phdr;
+	unsigned int phidx;
+	unsigned int i;
+
+	for (i = 0; i < ehdr->e_phnum; i++) {
+		phdr = elf_phdr_entry_addr(ehdr, i);
+		if (phdr->p_paddr == e->pa &&
+		    phdr->p_memsz == ALIGN(e->size, 4))
+			break;
+	}
+
+	if (i == ehdr->e_phnum) {
+		pr_debug("Cannot find program header entry in elf\n");
+		return -EINVAL;
+	}
+
+	phidx = i;
+
+	/* Clear program header */
+	tmp_phdr = elf_phdr_entry_addr(ehdr, phidx);
+	for (i = phidx; i < ehdr->e_phnum - 1; i++) {
+		tmp_phdr = elf_phdr_entry_addr(ehdr, i + 1);
+		phdr = elf_phdr_entry_addr(ehdr, i);
+		memcpy(phdr, tmp_phdr, sizeof(*phdr));
+		phdr->p_offset = phdr->p_offset - ALIGN(e->size, 4);
+	}
+	memset(tmp_phdr, 0, sizeof(*tmp_phdr));
+	ehdr->e_phnum--;
+
+	elf_offset -= ALIGN(e->size, 4);
+
+	return 0;
+}
+
+static void update_elfheader(const struct inspect_entry *e)
+{
+	struct elf_phdr *phdr;
+
+	phdr = elf_phdr_entry_addr(ehdr, ehdr->e_phnum++);
+
+	phdr->p_type = PT_LOAD;
+	phdr->p_offset = elf_offset;
+	phdr->p_vaddr = (elf_addr_t)e->va;
+	if (e->pa)
+		phdr->p_paddr = (elf_addr_t)e->pa;
+	else
+		phdr->p_paddr = (elf_addr_t)virt_to_phys(e->va);
+
+	phdr->p_filesz = ALIGN(e->size, 4);
+	phdr->p_memsz = ALIGN(e->size, 4);
+	phdr->p_flags = PF_R | PF_W;
+	elf_offset += ALIGN(e->size, 4);
+}
+
+/*
+ * This function prepares the elf header for the coredump image.
+ * Initially there is a single program header for the elf NOTE.
+ * The note contains the usual core dump information, and the vmcoreinfo.
+ */
+static int init_elfheader(void)
+{
+	struct elf_phdr *phdr;
+	void *notes;
+	unsigned int elfh_size, buf_sz;
+	unsigned int phdr_off;
+	size_t note_len, i = 0;
+	struct page *p;
+
+	struct elf_prstatus prstatus = {};
+	struct elf_prpsinfo prpsinfo = {
+		.pr_sname = 'R',
+		.pr_fname = "vmlinux",
+	};
+
+	/*
+	 * Header buffer contains:
+	 * ELF header, Note entry with PR status, PR ps info, and vmcoreinfo.
+	 * Also, MEMINSPECT_ID_MAX program headers.
+	 */
+	elfh_size = sizeof(*ehdr);
+	elfh_size += sizeof(struct elf_prstatus);
+	elfh_size += sizeof(struct elf_prpsinfo);
+	elfh_size += sizeof(VMCOREINFO_NOTE_NAME);
+	elfh_size += ALIGN(vmcoreinfo_size, 4);
+	elfh_size += (sizeof(*phdr)) * (MEMINSPECT_ID_MAX);
+
+	elfh_size = ALIGN(elfh_size, 4);
+
+	/* Length of the note is made of :
+	 * 3 elf notes structs (prstatus, prpsinfo, vmcoreinfo)
+	 * 3 notes names (2 core strings, 1 vmcoreinfo name)
+	 * sizeof each note
+	 */
+	note_len = (3 * sizeof(struct elf_note) +
+		    2 * ALIGN(sizeof(CORE_STR), 4) +
+		    VMCOREINFO_NOTE_NAME_BYTES +
+		    ALIGN(sizeof(struct elf_prstatus), 4) +
+		    ALIGN(sizeof(struct elf_prpsinfo), 4) +
+		    ALIGN(vmcoreinfo_size, 4));
+
+	buf_sz = elfh_size + note_len - ALIGN(vmcoreinfo_size, 4);
+
+	/* Never freed */
+	p = dma_alloc_from_contiguous(NULL, buf_sz >> PAGE_SHIFT,
+				      get_order(buf_sz), true);
+	if (!p)
+		return -ENOMEM;
+
+	ehdr = dma_common_contiguous_remap(p, buf_sz,
+					   pgprot_decrypted(pgprot_dmacoherent(PAGE_KERNEL)),
+					   __builtin_return_address(0));
+	if (!ehdr) {
+		dma_release_from_contiguous(NULL, p, buf_sz >> PAGE_SHIFT);
+		return -ENOMEM;
+	}
+
+	memset(ehdr, 0, elfh_size);
+
+	/* Assign Program headers offset, it's right after the elf header. */
+	phdr = (struct elf_phdr *)(ehdr + 1);
+	phdr_off = sizeof(*ehdr);
+
+	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
+	ehdr->e_ident[EI_CLASS] = ELF_CLASS;
+	ehdr->e_ident[EI_DATA] = ELF_DATA;
+	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
+	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
+	ehdr->e_type = ET_CORE;
+	ehdr->e_machine = ELF_ARCH;
+	ehdr->e_version = EV_CURRENT;
+	ehdr->e_ehsize = sizeof(*ehdr);
+	ehdr->e_phentsize = sizeof(*phdr);
+
+	elf_offset = elfh_size;
+
+	notes = (void *)(((char *)ehdr) + elf_offset);
+
+	/* we have a single program header now */
+	ehdr->e_phnum = 1;
+
+	phdr->p_type = PT_NOTE;
+	phdr->p_offset = elf_offset;
+	phdr->p_filesz = note_len;
+
+	/* advance elf offset */
+	elf_offset += note_len;
+
+	strscpy(prpsinfo.pr_psargs, saved_command_line,
+		sizeof(prpsinfo.pr_psargs));
+
+	append_kcore_note(notes, &i, CORE_STR, NT_PRSTATUS, &prstatus,
+			  sizeof(prstatus));
+	append_kcore_note(notes, &i, CORE_STR, NT_PRPSINFO, &prpsinfo,
+			  sizeof(prpsinfo));
+	append_kcore_note_nodesc(notes, &i, VMCOREINFO_NOTE_NAME, 0,
+				 ALIGN(vmcoreinfo_size, 4));
+
+	ehdr->e_phoff = phdr_off;
+
+	/* This is the first coredump region, the ELF header */
+	meminspect_register_id_pa(MEMINSPECT_ID_ELF, page_to_phys(p),
+				  buf_sz, MEMINSPECT_TYPE_REGULAR);
+
+	/*
+	 * The second region is the vmcoreinfo, which goes right after.
+	 * It's being registered through vmcoreinfo.
+	 */
+
+	return 0;
+}
+#endif
+
+/**
+ * meminspect_unregister_id() - Unregister region from inspection table.
+ * @id: region's id in the table
+ *
+ * Return: None
+ */
+void meminspect_unregister_id(enum meminspect_uid id)
+{
+	struct inspect_entry *e;
+
+	WARN_ON(!mutex_is_locked(&meminspect_lock));
+
+	e = &inspect_entries[id];
+	if (!e->id)
+		return;
+
+	atomic_notifier_call_chain(&meminspect_notifier_list,
+				   MEMINSPECT_NOTIFIER_REMOVE, e);
+#ifdef CONFIG_CRASH_DUMP
+	if (elf_hdr_ready)
+		clear_elfheader(e);
+#endif
+	memset(e, 0, sizeof(*e));
+}
+EXPORT_SYMBOL_GPL(meminspect_unregister_id);
+
+/**
+ * meminspect_unregister_pa() - Unregister region from inspection table.
+ * @pa: Physical address of the memory region to remove
+ * @size: Size of the memory region to remove
+ *
+ * Return: None
+ */
+void meminspect_unregister_pa(phys_addr_t pa, size_t size)
+{
+	struct inspect_entry *e;
+	enum meminspect_uid i;
+
+	WARN_ON(!mutex_is_locked(&meminspect_lock));
+
+	for (i = MEMINSPECT_ID_ELF; i < MEMINSPECT_ID_MAX; i++) {
+		e = &inspect_entries[i];
+		if (e->pa != pa)
+			continue;
+		if (e->size != size)
+			continue;
+		meminspect_unregister_id(e->id);
+		return;
+	}
+}
+EXPORT_SYMBOL_GPL(meminspect_unregister_pa);
+
+/**
+ * meminspect_register_id_pa() - Register region into inspection table
+ *		 with given ID and physical address.
+ * @req_id: Requested unique meminspect_uid that identifies the region
+ *	This can be MEMINSPECT_ID_DYNAMIC, in which case the function will
+ *	find an unused ID and register with it.
+ * @pa: physical address of the memory region
+ * @size: region size
+ * @type: region type
+ *
+ * Return: None
+ */
+void meminspect_register_id_pa(enum meminspect_uid req_id, phys_addr_t pa,
+			       size_t size, unsigned int type)
+{
+	struct inspect_entry *e;
+	enum meminspect_uid uid = req_id;
+
+	WARN_ON(!mutex_is_locked(&meminspect_lock));
+
+	if (uid <= MEMINSPECT_ID_NONE || uid >= MEMINSPECT_ID_MAX)
+		return;
+
+	if (uid == MEMINSPECT_ID_DYNAMIC)
+		while (uid < MEMINSPECT_ID_MAX) {
+			if (!inspect_entries[uid].id)
+				break;
+			uid++;
+		}
+
+	if (uid == MEMINSPECT_ID_MAX)
+		return;
+
+	e = &inspect_entries[uid];
+
+	if (e->id)
+		meminspect_unregister_id(e->id);
+
+	e->pa = pa;
+	e->va = phys_to_virt(pa);
+	e->size = size;
+	e->id = uid;
+	e->type = type;
+#ifdef CONFIG_CRASH_DUMP
+	if (elf_hdr_ready)
+		update_elfheader(e);
+#endif
+	atomic_notifier_call_chain(&meminspect_notifier_list,
+				   MEMINSPECT_NOTIFIER_ADD, e);
+}
+EXPORT_SYMBOL_GPL(meminspect_register_id_pa);
+
+/**
+ * meminspect_table_lock() - Lock the mutex on the inspection table
+ *
+ * Return: None
+ */
+void meminspect_table_lock(void)
+{
+	mutex_lock(&meminspect_lock);
+}
+EXPORT_SYMBOL_GPL(meminspect_table_lock);
+
+/**
+ * meminspect_table_unlock() - Unlock the mutex on the inspection table
+ *
+ * Return: None
+ */
+void meminspect_table_unlock(void)
+{
+	mutex_unlock(&meminspect_lock);
+}
+EXPORT_SYMBOL_GPL(meminspect_table_unlock);
+
+/**
+ * meminspect_traverse() - Traverse the meminspect table and call the
+ *		callback function for each valid entry.
+ * @priv: private data to be passed to the callback
+ * @cb: meminspect iterator callback that should be called for each entry
+ *
+ * Return: None
+ */
+void meminspect_traverse(void *priv, meminspect_iter_cb_t cb)
+{
+	const struct inspect_entry *e;
+	int i;
+
+	WARN_ON(!mutex_is_locked(&meminspect_lock));
+
+	for (i = MEMINSPECT_ID_ELF; i < MEMINSPECT_ID_MAX; i++) {
+		e = &inspect_entries[i];
+		if (e->id)
+			cb(priv, e);
+	}
+}
+EXPORT_SYMBOL_GPL(meminspect_traverse);
+
+/**
+ * meminspect_notifier_register() - Register a notifier to meminspect table
+ * @n: notifier block to register. This will be called whenever an entry
+ *		is being added or removed.
+ *
+ * Return: errno
+ */
+int meminspect_notifier_register(struct notifier_block *n)
+{
+	return atomic_notifier_chain_register(&meminspect_notifier_list, n);
+}
+EXPORT_SYMBOL_GPL(meminspect_notifier_register);
+
+/**
+ * meminspect_notifier_unregister() - Unregister a previously registered
+ *		notifier from meminspect table.
+ * @n: notifier block to unregister.
+ *
+ * Return: errno
+ */
+int meminspect_notifier_unregister(struct notifier_block *n)
+{
+	return atomic_notifier_chain_unregister(&meminspect_notifier_list, n);
+}
+EXPORT_SYMBOL_GPL(meminspect_notifier_unregister);
+
+#ifdef CONFIG_CRASH_DUMP
+static int __init meminspect_prepare_crashdump(void)
+{
+	const struct inspect_entry *e;
+	int ret;
+	enum meminspect_uid i;
+
+	ret = init_elfheader();
+
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Some regions may have been registered very early.
+	 * Update the elf header for all existing regions,
+	 * except for MEMINSPECT_ID_ELF and MEMINSPECT_ID_VMCOREINFO,
+	 * those are included in the ELF header upon its creation.
+	 */
+	for (i = MEMINSPECT_ID_VMCOREINFO + 1; i < MEMINSPECT_ID_MAX; i++) {
+		e = &inspect_entries[i];
+		if (e->id)
+			update_elfheader(e);
+	}
+
+	elf_hdr_ready = true;
+
+	return 0;
+}
+#endif
+
+static int __init meminspect_prepare_table(void)
+{
+	const struct inspect_entry *e;
+	enum meminspect_uid i;
+	int ret;
+
+	meminspect_table_lock();
+	/*
+	 * First, copy all entries from the compiler built table
+	 * In case some entries are registered multiple times,
+	 * the last chronological entry will be stored.
+	 * Previously registered entries will be dropped.
+	 */
+	for_each_meminspect_entry(e) {
+		inspect_entries[e->id] = *e;
+		if (!inspect_entries[e->id].pa && inspect_entries[e->id].va)
+			inspect_entries[e->id].pa = virt_to_phys(inspect_entries[e->id].va);
+	}
+#ifdef CONFIG_CRASH_DUMP
+	ret = meminspect_prepare_crashdump();
+	if (ret)
+		pr_warn("meminspect: failed to prepare crashdump ELF header: %d\n", ret);
+#endif
+	/* if we have early notifiers registered, call them now */
+	for (i = MEMINSPECT_ID_ELF; i < MEMINSPECT_ID_MAX; i++)
+		if (inspect_entries[i].id)
+			atomic_notifier_call_chain(&meminspect_notifier_list,
+						   MEMINSPECT_NOTIFIER_ADD,
+						   &inspect_entries[i]);
+	meminspect_table_unlock();
+
+	pr_debug("Memory inspection table initialized\n");
+
+	return 0;
+}
+late_initcall(meminspect_prepare_table);

-- 
2.53.0

