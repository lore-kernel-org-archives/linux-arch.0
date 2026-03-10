Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86132E4257
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773174141; cv=none; b=QZAQpsoarR0pilW8zj+x05WzID55XS0K4QE6D8qy4sMdABsXBzl15McJXXTHqh9FzuFzGB6dCNA8a0uGWX4sQUdoD5n+pQyhs4ilxZ9Xxzx3r1U6H5GNV/BzT6HZcZhG5LC9lCxjQ3/8XdBjvoKH81N7pxur+mdtDPAkY12dwwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773174141; c=relaxed/simple;
	bh=kxkhHL6Inn5vy91sWNPBwxtVUU5b0erQRsexgGrH3n8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kOYitFrkQ/40DaI/XGaOA0mLQBBMcrRwFAo/4ryFCTRTNu7UTS+KxZMNcNgCMFVjsRggl35xMjOiVwob/UtENrHPB4tZmGxQb4D8YKSJ48m3RXxZp2gMeuMVZaAVYfXpSZWmXChbuYjkTGbLMIqOEg9erh8EREEEua6jhIq0Cec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aPw1h3cc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R4bUEyyb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aPw1h3cc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R4bUEyyb"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AIhZ6K303910
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:22:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/uUYtzbBAMu+u7bupalNhBTW7BYEt5Sa2Qb3bAaRTLs=; b=aPw1h3ccTPQ6vDva
	8RL6Id8V2H9C8hHgbuFfmEhGDmnb66zSn4duAggHPmCRidkKkeyWI2C71J46RzVh
	xEmYcvijqUFc063opGpKoJds5en9I434aZD37fdwqygNZi38H+sNnj3tiJHvNmaK
	Q/7YZyhp3lwCWmwcUg4mJaVZaWy2BWI6YokznMU+P2LlC6zp2oryV/X9AGryskIB
	D+T2+reeGB3+BB9a4illrxG7VfFFABat1d0C5HOBn7StO11xfUh3IXQinWhjw0he
	4xgTqLGpeGIzh0BoJ8aYSWIPxxkIMDz0RovcfKd90Af+N+l4plGNy856xnj/hPv+
	CzKZIA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cthjf2bfs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:22:19 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-829c331b4c6so985015b3a.0
        for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 13:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773174139; x=1773778939; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/uUYtzbBAMu+u7bupalNhBTW7BYEt5Sa2Qb3bAaRTLs=;
        b=R4bUEyybXcQFYMIw+51tFc0KlLUWWAK3JetzJLWfxL8vPoZ1yoY0CGwUzsRghD7UZa
         nYHRz0csuMcTi9U3pql+jNy5uisd/YzCBcNBBXavZ0/GlbcopshyMyHDqXNrFTJeERWm
         uWp0rPAEahuYqQnlwDWFVYNaA2aX6cODUhGLZt5KH0IC6ZqI8ng56OIz5kl+1BBO9zx/
         rhuJZBREZr5z82jItzjNEp37t4AEwYgsyOPCftBGTlPJh/CHDMviBaK7dGmCGEYvHfEr
         PVKgFJByVzWkL7rzZXrTTlQE3S58Z/y5ePvM16qEkbeIsMUR4AY1kncML4L7K8EfiQmT
         nsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773174139; x=1773778939;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/uUYtzbBAMu+u7bupalNhBTW7BYEt5Sa2Qb3bAaRTLs=;
        b=go03iimxF158boxNIgprTG9gS4AXUY59jq75yZCmd1HjnGmKTL6RyyfcTyH9uQ27Bj
         gmrxAF3+VfFpHVSITBRMOSwQBWmFs88TrOpRu94Xj4aaXrgChxFIApD9kwKJqWJ5MJKp
         eArgQdeD8Ht+ZoX3gUzEAA6K+RuuyhfYDos5JeC0L1HQPic8YuQPLq5u64shyVITy+lQ
         +MMPMXFytTB3eOqV5lvJSiPuSb+mNK2rD8WjxGDkUzUQpmtKOVvFwMtGsx+P9+eZCan0
         TxsG8wf/nqfR4Kr7CR8G+cQ1R2JvxdeHV7wX6TOIrnez8HQfibsMAHOuvv6ZUgJTUVjM
         h0gg==
X-Forwarded-Encrypted: i=1; AJvYcCWtRzDPfLWh0tApEwoZxMy0mGrTQylCeKreXdm0yoM+2lj1khXyVJRnW1N6lcyqw/Kya/Lum+RE4LDu@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4vEszHm9ZHXqAZGy0VnG9S32SPFNhUMPWOaJoO7DD9TbAHc7G
	2vfVQNtCvqVl8tZduXVsRmeamPFxDDrRKPfJStmCGV0JESTcpiWgQbdUUkJuUqbqztjVTUJE75Z
	Fqw1IZDlE8vXlLbVKOgCaSrPizxhE9tI+LxQztylNkbKkdBDuZQ2q/f7AwbLsTs+C
X-Gm-Gg: ATEYQzw4jhLtiSnTUQx/wyMPRzh/cPwAi+YWrsthnl2Hs0yzHeHTQ9cYjPWprfJqIli
	Zt9yzGpq4Ma3KoVYRmtDjc4KXyvg4/ww4svnFxU9WI47xz5xJh9qoMTqc3YBw7HKrlAP3zpWjQL
	vCOk6WkhEg4eESix5RFqTbm+5qzj2BSNk1oXfvtAb457sBpAItt+Qy1gcxzI8a7tI/MW20cHCCH
	AeBLyaGu+xQ8+5a69aLfPf6i0bxjGkRVfaVLuHfcOYeS1NAQjMowtJsGUF6m6BS4XuUw9bx9tBm
	LdpK69KUrZiS8la88VrZrY3KjIpR5MQY7GHH0wHhZKCX/cGwdEXoi+uKi8Eiz68CXruUDcb4qks
	lOajSpOvORnYdR6U99hWgblMGQTd/OYVOsimBK1b27DzXiE++
X-Received: by 2002:a05:6a00:1d90:b0:829:8041:83f with SMTP id d2e1a72fcca58-829f707301dmr155564b3a.7.1773174139076;
        Tue, 10 Mar 2026 13:22:19 -0700 (PDT)
X-Received: by 2002:a05:6a00:1d90:b0:829:8041:83f with SMTP id d2e1a72fcca58-829f707301dmr155530b3a.7.1773174138369;
        Tue, 10 Mar 2026 13:22:18 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6dc2d0asm115262b3a.13.2026.03.10.13.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:22:17 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 01:46:08 +0530
Subject: [PATCH v2 24/25] dt-bindings: reserved-memory: Add Google Kinfo
 Pixel reserved memory
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-minidump-v2-v2-24-f91cedc6f99e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773173756; l=2474;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=kxkhHL6Inn5vy91sWNPBwxtVUU5b0erQRsexgGrH3n8=;
 b=6MT7VZEYiJ26WHI1HB+RUTYRS5S4mWBasU/tY0AGrn+K0ZHF6GT766OHo8RuR4PhqhgpOtU11
 ixnzFMgK0faBvouTgqwCNSVVa7/2YaR2C2ym1CGyS7TIOWKzb2K+whi
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-GUID: gU2gHKkRS0iA5jW3aDO4x1RE3klNLh7C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE3OCBTYWx0ZWRfX9aWd7yIccR9A
 O1HfKlsCQaCpf/O7dpKM8valeAwaW5E2EvQVRKg2VgpWt31wcayoIxj+w7tTvlBJC1EhUD9SCPS
 0t0M8r/t5mmswnd4wgaDyCupB6I+A/qDlemJTDJHCBReRADNUQ2jnuf4BCg2pXmsnJJz7KWdu7s
 ZmNtP5DMPY26NcQ/XkYfoWbqVxm/eVA2Ei5F7bZAHqHb1rnZeM6ukUtCg8pPDeSS+hmZu8y3p1a
 UOK0x7Itw7hmTdXq6Uaas4JFOVmuI1U1h5Zg9iaXlZVr0fGajI9yq1hPC8EKYK/Y4QWDddDa/Ki
 hQK31Lz+CCrywNJjBx+Ao3haY/s8xLoVf8pXGKulwgddPeQDn/aUYc+E9rB3ycxeYSpYrNNFAm1
 yx8ofXvEAwhW4nRi4JcBVGs7iMiQKSDufNMbbEHPDZfDGaELKmVXmR/Rk/QLi8pcoaWTMJVNdpG
 ScbuNM7bG2zKhdRH1xA==
X-Authority-Analysis: v=2.4 cv=A71h/qWG c=1 sm=1 tr=0 ts=69b07d7b cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=gEfo2CItAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=37rDS-QxAAAA:8 a=2rb2LGFNx5Mo7s1WZPsA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22
 a=k1Nq6YrhK2t884LQW06G:22
X-Proofpoint-ORIG-GUID: gU2gHKkRS0iA5jW3aDO4x1RE3klNLh7C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100178

Add documentation for Google Kinfo Pixel reserved memory area.

Co-developed-by: Eugen Hristev <eugen.hristev@linaro.org>
Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 .../bindings/reserved-memory/google,kinfo.yaml     | 46 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 +++
 2 files changed, 52 insertions(+)

diff --git a/Documentation/devicetree/bindings/reserved-memory/google,kinfo.yaml b/Documentation/devicetree/bindings/reserved-memory/google,kinfo.yaml
new file mode 100644
index 000000000000..2f964151f0c0
--- /dev/null
+++ b/Documentation/devicetree/bindings/reserved-memory/google,kinfo.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/google,kinfo.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Google Pixel Kinfo reserved memory
+
+maintainers:
+  - Eugen Hristev <eugen.hristev@linaro.org>
+  - Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
+
+description: |
+  This binding represents reserved-memory used to store data for firmware/bootloader
+  on the Pixel platform. The stored data is debugging information of the running
+  kernel.
+
+allOf:
+  - $ref: reserved-memory.yaml
+
+properties:
+  compatible:
+    const: google,debug-kinfo
+
+  reg:
+    description: page-aligned region of memory containing debugging data of running kernel
+
+required:
+  - compatible
+  - reg
+  - no-map
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    reserved-memory {
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        debug-kinfo@fa00000 {
+            compatible = "google,debug-kinfo";
+            reg = <0xfa00000 0x1000>;
+            no-map;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index ebf478dbd15c..2504b7df0e7d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16592,6 +16592,12 @@ F:	Documentation/dev-tools/meminspect.rst
 F:	include/linux/meminspect.h
 F:	kernel/meminspect/*
 
+MEMINSPECT KINFO DRIVER
+M:	Eugen Hristev <eugen.hristev@linaro.org>
+M:	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/reserved-memory/google,kinfo.yaml
+
 MEMBLOCK AND MEMORY MANAGEMENT INITIALIZATION
 M:	Mike Rapoport <rppt@kernel.org>
 L:	linux-mm@kvack.org

-- 
2.50.1

