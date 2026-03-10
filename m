Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FA62C158D
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773174125; cv=none; b=t6YWS1wcscFNbo/rXKqp89/oPJHmxkpt8N6zUZGuFuqzw4jOBJZe+rQ5CGn2j+HoGm313ZXnFPd+AZb46cPsuc8geTqvnHNXfsF+BmJhC+RK1xYcdrpp/rd1ZK659EpFwKlF9GDTc0bxaIc5w06fO4GiHx8xWq9MclxC4+15zyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773174125; c=relaxed/simple;
	bh=wj+luXvDqOTuhru6DvwVtnX3t9V+pGkO1cWy33gHiXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LrF+XoI97LF5ahXz31+qEsAVWyGxK8ToQiIJbWKdX2P7bHFUSTOKUrqWaHFOspM7XubtSRET5RopIF3ArcDlsJWR09iugx/kPb3RbBb/uoEYCtIIn1mjAmEdLRIhG1CuNfk39SQcWhUiFN+wNyfQz0y1hAB8TUumrWu6cDaR5lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YSJh4uFS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IkGKb7cA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YSJh4uFS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IkGKb7cA"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AEF0tb1863218
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	brkrGexervsDjeRqs9RzmRiixQVaocfEogoUtg08MW4=; b=YSJh4uFSvGRFmKbt
	xH++W5JgTe8Mvq0fGvsD2Y99YvKm3+U/JThznCK640M/4G1wZVGCwHZuJB5AL4uc
	BGdG2d5v0LPy05QsTa5J4pE91O5LS2IhS89xNVbJre3CaYQyhisVPdBrzA0Csrsf
	ch4dglNxZaJuU09OJoFN/NN/bZrojYcf+1p/WJ8VkvCTyRWoZfnLvhSr7kLf17QM
	MMnsMfF4h2wPWDlhwdbI84cesSWDUgqAj9pzWnJb+p16SotfK08GiYiZbRVt8sNd
	ckvjBYeQ1d4X6tW2894rVZYZgNXJ9STajqqZp56lAN+Eq/iY+76uyyg1rOD0XXbA
	cbB/LQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctmw81g4r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:22:04 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8299499d582so15170859b3a.2
        for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 13:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773174123; x=1773778923; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=brkrGexervsDjeRqs9RzmRiixQVaocfEogoUtg08MW4=;
        b=IkGKb7cA6L+SM0btttu2n9BPmYXlhzQ5cYCiQxGbMlYBdZ0rAvl2cgh3Vy4NSueScH
         wl++0CyHSI9+AZtVWTQPHqweiF1fj2JhLopqZGTKKUVdaYyf7ioZB4H9ScSiAebWT03k
         OgvK3yXFyJ6YQJdKhTdyOcLlzOWeCL/nolrtXYGo9jE08OyT9CzhIzJ0FGy+KrHgNgQI
         3g8axPLjmQCZGTn1cCpVSFExlXEEFquuSG3bvDfIBmcayxkWRO5mfkV4xI7Zexo0/V1z
         APPTn3LkpSYzWlNEdyu8VjcONXu+hLa3zSH1j0YFHGBxNd+W1OUNq/3KJejfmILJv7wg
         ooKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773174123; x=1773778923;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=brkrGexervsDjeRqs9RzmRiixQVaocfEogoUtg08MW4=;
        b=H28rozBbj+OHwioVBydSOnsIlrmqaoG8XXXckvO9uhflf/wbokwF0uBMkUDj7dz6sK
         0tAXyAHQegtgZWnlYmprTVun8hWacCC/T0KKQimywyxsYiut+l3iikiiZxfdFw7VmLne
         Cww7aN6mnUvo9v4zN0r7gg3cNoVaav2g9BqyZ71ozCzkXppBNhi0SSB3Ti4q34qnJZKd
         +hU9If7QgpTZLt4hNmqhA/KipsA4+flF/f+Ox6KDKKKaHfgKZJNYHC7ovnvYcTY5se10
         HznnoBUDsz+rGaUbch+uTqnkZKSgN6MVb4SvQrIuK6zFbMHDlGPAbKuMSxeIMdNwQ1ii
         rxdg==
X-Forwarded-Encrypted: i=1; AJvYcCVISzEzZEf0+sHkiyj5D40Z10VchtLeaUavdexKMcGuDP4Vc4lRuPV4VSxZ6p5X9CaABIdIgFYmAWjR@vger.kernel.org
X-Gm-Message-State: AOJu0YwbF1rrObLIFhne8whhf+3U7Cdf4kt1L/f48EvrA98XckUVxjDo
	0BHTYZCbns0BPVApGZksoJo5nLjXyPxWbSBXC3mF5tUTXu0hNKGAukW9EhDGAZQ7259E5Pe5QNu
	BIG9sSeGRxzgmDD7mRHXC/JA+VrvLpViNLCxWxoLzYLKmZhhypxtsowA8M9WGvBZ+
X-Gm-Gg: ATEYQzw+VIF3qplMN6zLoVsGm3t4ehqsrcAya5/YPKPEg6NoEjQAbb/MUMzKCv9T9N4
	NNteaaFHAMnOGCDo0s7PK9NEEexULioy8tL7o3IoQEoCOdX9mERuGPqGHoJrAs/8L2As7jnnmGN
	2vUJkSEOL7+9HETNzeHSewxYn5PzhUOInMYACbuhhaVeDThSR4SMEwRQcFfWSnvEGizRn3xVAcw
	rJiMeXRccu3F2VcS8eot+eWOeFmhvLz5Suvm+l/Cgo2PQIH2UWcc//2kXJd/pKVcQoVfxW4RwM0
	83OKPWaFBA0UUghrbyWeGVVK5eH+EITIZhStwTLS4OuHjqRXGnhkyUjgclwwyFfo5Jrp87qVdnC
	Qulnrl4OrYUtaZKBmJnXDZQLgA0hVGk4fxnuXn4Y7pYYLh+VW
X-Received: by 2002:a05:6a00:3e17:b0:828:f1d9:22cc with SMTP id d2e1a72fcca58-829f6f2abe6mr177020b3a.20.1773174123238;
        Tue, 10 Mar 2026 13:22:03 -0700 (PDT)
X-Received: by 2002:a05:6a00:3e17:b0:828:f1d9:22cc with SMTP id d2e1a72fcca58-829f6f2abe6mr176989b3a.20.1773174122629;
        Tue, 10 Mar 2026 13:22:02 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6dc2d0asm115262b3a.13.2026.03.10.13.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:22:02 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 01:46:07 +0530
Subject: [PATCH v2 23/25] soc: qcom: smem: Add minidump platform device
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-minidump-v2-v2-23-f91cedc6f99e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773173756; l=2191;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=I7h36vRINCl73eGOjCLTs1uEZfJpGZtYWsp4d/Eb0ng=;
 b=rMdSNPF/xiEgp7h/2PrlHDpbz9A7fwnRMH+HKK1W4eqdbkbtkF909spMFFFZNQ9yLATM6QiGz
 i5Npb95/nW8AU/UjvwC8S9P1wIPcyGpH6PiS6CA9GiFk8+2THVKvvef
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-ORIG-GUID: OYoKF0-p1DVvhy4ESluJ6tAe0U_vuygn
X-Proofpoint-GUID: OYoKF0-p1DVvhy4ESluJ6tAe0U_vuygn
X-Authority-Analysis: v=2.4 cv=PJECOPqC c=1 sm=1 tr=0 ts=69b07d6c cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=3CFpAjl5I9ltKDqHFfsA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE3NyBTYWx0ZWRfX38UraNz9n303
 dOsyh8t35cl0Vi8faBYeVJtAqMt2P+MDe5eOAuT9RAtSRtpc7S/84HHxhEd9MuoZpnGxkYk3joQ
 CAwM9sC5hXzwdxoT17EyYdnRCf3cQW62oq62q1C2ThuYgpvCKpfJ6DvjjfbHtPQIN0JjyGYK9gq
 YDcUcsEqD2+cFvFOwm11J2lQolKaqBTV9phGD36nG/3TmTsS/v0V97FIj9fbvYimsd7RQjIWAmN
 MGJb9w4QAtiPDSFxNxcOJMPlbjniedhilSka3z2Of7GqdP3EwNWBcYDKYm6pPgFzVb0yirSGQpp
 84ieyvBhPrfq9FjgKX5ARpRDxvqYqbEjjzAZpbxtno1fBMVr3IZ8K2UZ7zCC1YHJg4VE7C1a9CA
 E7II64sRn89SGRaaIfJbV2YoorLpQs+LK0e8qqUrxzTHyDp79zVB5zqWe4t69QWpfSD+1Wb44pf
 rKW28ZbvI2uP+0awIpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100177

From: Eugen Hristev <eugen.hristev@linaro.org>

Minidump can collect various memory snippets using Qualcomm boot firmware
support. To determine which snippets should be collected, each snippet
must be registered by the kernel into a shared memory table managed by
the Qualcomm SMEM driver. To instantiate the minidump platform driver,
register its data using platform_device_register_data(). The minidump
driver will later probe the device and retrieve the required memory
snippets from the memory inspection table (meminspect).

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/soc/qcom/smem.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index d5c94b47f431..65d7b4d99677 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -270,6 +270,7 @@ struct smem_region {
  * @partitions: list of partitions of current processor/host
  * @item_count: max accepted item number
  * @socinfo:	platform device pointer
+ * @mdinfo:	minidump device pointer
  * @num_regions: number of @regions
  * @regions:	list of the memory regions defining the shared memory
  */
@@ -280,6 +281,7 @@ struct qcom_smem {
 
 	u32 item_count;
 	struct platform_device *socinfo;
+	struct platform_device *mdinfo;
 	struct smem_ptable *ptable;
 	struct smem_partition global_partition;
 	struct smem_partition partitions[SMEM_HOST_COUNT];
@@ -1242,12 +1244,20 @@ static int qcom_smem_probe(struct platform_device *pdev)
 	if (IS_ERR(smem->socinfo))
 		dev_dbg(&pdev->dev, "failed to register socinfo device\n");
 
+	smem->mdinfo = platform_device_register_data(&pdev->dev, "qcom-minidump",
+						     PLATFORM_DEVID_AUTO, NULL,
+						     0);
+	if (IS_ERR(smem->mdinfo))
+		dev_err(&pdev->dev, "failed to register platform md device\n");
+
 	return 0;
 }
 
 static void qcom_smem_remove(struct platform_device *pdev)
 {
 	platform_device_unregister(__smem->socinfo);
+	if (!IS_ERR(__smem->mdinfo))
+		platform_device_unregister(__smem->mdinfo);
 
 	/* Set to -EPROBE_DEFER to signal unprobed state */
 	__smem = ERR_PTR(-EPROBE_DEFER);

-- 
2.50.1

