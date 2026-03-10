Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA873E95B9
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773173852; cv=none; b=ohsehvVVB1/yK7Kwl+MXk1OmdUkfZvH9ZHG+Kvv0qO4OeV9TENO+rV37norzJVcTnXC1ue/rjJopqzKCIJadF3rqIja+LLy4OSxeWOBrJ/ZhLmvuKaDLNzg+oA5nLnDSQBlY4cYo67io7mal7RB65kiIgqHnp3wENBR6d/8T7a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773173852; c=relaxed/simple;
	bh=/g8HEiXUYfa3Zq5UeMQE3tUVgKrL8ys+bUgFTnVC3x0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ftq8HRmQ+zIAXco3zzTdejQOEXBx9X2GGFUSaEsbH7jnRWCBeiYMYWHwfLk1KIM5EMnJOMEYRUQO+kvMxR8oAvLORukz0KhOybk2fYSe1IaOKiCv2KKfnMoC+PECYhl718vkrB14kgWvuYZztnPVjS6r/c8aXeuwykf/va/aTIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=by4B4Kk5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hU3TKpNN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="by4B4Kk5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hU3TKpNN"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AIjN5Y303787
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/p5bQNtsurS8ELLM8cfGcTYhFbVSlQNGcc/PqunPdEc=; b=by4B4Kk5+VrKoSdS
	6QyqTOk4zerpxFHN9awWxqzVBp5b3Mbr9Z2OSzscqVAx95NlEcLuGCeFrp5wkCor
	c4u8y1+2cddOZHOuCwlb4trlfPIlcBqsiLktXdRhu26uZ7LrcFQWmSSE1xgkztHZ
	bRkzfwzAfTXWaFbv9/xATSrCiv2I3Wfn36Loaj3XoBEioFfD/2E6fsm63URDyl2y
	nkIFioEFaNvJKMYKFzFHpmIGQL7IU1jCt2ZIcL9zpLf2QlAYZrKj0XqOF75lafAU
	dJwLzxk2YiqgzWwu7Pg7sSwVEv2cgU23b9noj6vPEkTuFMFs2LXYtiNLQ7ovBjj+
	SjLD4g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cthjf2aw0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 20:17:29 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-829a6463afeso2461086b3a.3
        for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2026 13:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773173849; x=1773778649; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/p5bQNtsurS8ELLM8cfGcTYhFbVSlQNGcc/PqunPdEc=;
        b=hU3TKpNNJ001yX2DiFyaTw4dzs1LcUKPlbeShEYB1mM/k3aw1BYqXUkWlJDuIcV7Cu
         8cJguLTa/cMI/Os8l+uQxW8WGd+UdAETzDAj3nfVKUlA/ppjx0zZgcBQzoLcPVVTV2Gf
         aBAEarGR9wObJInuokzQ5S7B7hr0kOeHGwJpzgBayMv61hM1hB/CDZ+xT9RQk3wtpowC
         HIkjVSgQobgItO2BOWYXRTVOIw+0S9Oy1y8Ii5GLbJyq/rjDivc6hfnpuIHLYwMcUKEc
         a/dS8v18OEzvKaO89H1NhqD9jM/wRuwQ8P2dMn+o1WY+xwh+gLKjA1Wad96PT1ehfCna
         41KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773173849; x=1773778649;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/p5bQNtsurS8ELLM8cfGcTYhFbVSlQNGcc/PqunPdEc=;
        b=BwseN0awU2CeeojtvCtHq97DTlTAH+s7UJsa5DR20uoRThXdQ2OWrpEqV0Z4OSaly/
         PxHfHFRQtB3IoLm17cs7MrtdSY1Yq0wl7H9Jd74QuqIdVWzz56FzyZMw/dS5OJNe0lhz
         3gFSP2gfKKt/GqoCON3Ug7dyoeQi9qmHFSt41gasClFxNlqLbRfZnwuOhvBO4hj2Yp5R
         ro7U3TCC4sprgqhrASH7IODgIZfCTZ2ZJ84qpLQIpVc8moWIzior99i4JLKLPREq6a/6
         7NNBbmEav08hpH9xmSMENzH0R4EdqoSejrVDbwTU16taoGw0MaB0Bn6UjKFDIz0rWN5M
         OYIA==
X-Forwarded-Encrypted: i=1; AJvYcCVZ78Y/conXFf/I7Ac1JMsY9pymD2W7AjU9xncZIwP6rA6cW3ikNGxxAITrQy94Jch36clETGdMyhPQ@vger.kernel.org
X-Gm-Message-State: AOJu0YytzQMhqthyuoirNTyCew0aHiiZG98A54x0sVQdKnTiPhQN8u+T
	p3DUA5FmLX6IvhtugyLQysgEkqANewILK7Cjn3SbdXkEfnEH3jYlxMQxm7Cyo9vBP51fdcBBCDr
	bs+5FRrJGfIeHO8uZ3w065WsywYpboE1ImuxoYqAYhhASivIQ4Y53pfNnY4wV5EPR
X-Gm-Gg: ATEYQzzJ3/77MatcYRdj3CfKz8V4bYSHfnzmBOBjMdzdf1heiD5WlYbWC++bMid47rH
	OhdpGNDnOQCVq6UT9R3FMQVJ4/Z01BdFQR/lUNS//+AL6Z/ixt+/EIBB/Jybn0hDJPO6tl/rClq
	mVMs1S1aP3G4Babu1luAMQdXW51FXtuTc8DDwcxMzfKQ2Rn5TU2DnDdyStaomaXu9m/vcMejOJN
	lbXotkSDneFjMuevUK3PdgazuioTukEvz17dlCUX932BH4VvsU6E7cSRzWVNjwZvIF31pqqqY3l
	g5zefx9v9ee72mMfSVFakvn51+X60q8H3lLYejmHKy5Y+wLWnF7ZN5QL2pNH06Ozp8aRWxGLKzT
	+Vj6846IxNI/GzOlyq/t0sQyoEwCFv9TFbg94W3bkM+K3ssov
X-Received: by 2002:a05:6a00:180f:b0:829:7e6d:cf12 with SMTP id d2e1a72fcca58-829f6ea54e6mr176832b3a.18.1773173848440;
        Tue, 10 Mar 2026 13:17:28 -0700 (PDT)
X-Received: by 2002:a05:6a00:180f:b0:829:7e6d:cf12 with SMTP id d2e1a72fcca58-829f6ea54e6mr176795b3a.18.1773173847792;
        Tue, 10 Mar 2026 13:17:27 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6dc2d0asm115262b3a.13.2026.03.10.13.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:17:27 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 01:45:49 +0530
Subject: [PATCH v2 05/25] genirq/irqdesc: Annotate static information into
 meminspect
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-minidump-v2-v2-5-f91cedc6f99e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773173756; l=961;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=UXg1t0l9m5ubA1qVNL7kczvqoaB7NuMSr+jbvqU0OqA=;
 b=tpLi1SDrgekMvdM7bSodVPbvBq2jkmRJ9w+7dr9fMPSvTOVcpu589oNcA+Ssz2qd7S8Bd4rG9
 EZ0hqpigrLFAIbWc52tOHGSzhTc9cgRgeA1CcE72coJ1nJxp+QVKA/P
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-GUID: pLcyWzS46H2ZRf1rHYMi6cLmqjaUrkCc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE3NyBTYWx0ZWRfXxgJ/JH1V9CuE
 X+woe9NmsRRMke6lYkJof8dFGOnBEyLp//s+fEHaDGTu1YefavakWSLxLxTUjTxWxebvZyTtTLC
 IBVpwBju2XdPaCE8EflWmBV43b59jpXvoTEUzk6pk3bikfsS77c5bkRPFQbOiJnFecNrZNg3/1f
 x5dfa9+fe2op9MiVOhkxfonAO/tESOeaJYJ+Sig0R1Qs9hS7Wix1q/yFbZdG2u5Haz2/ZS1P4EX
 a1PLfrSGWFjPZRH/dEz6bqrps56+fGT92S1no29ReiLUp+HcX8fD8mPxiJV4SK/GtL8pJrxylt1
 C38NU7MRYWN2rdnO4B9QIoR8inKjWDTOnsPOsYrV816cvqEEYlfI0dBeHdycPyfEwzNaTG7UpLq
 brN6j8hEwzQkqjykOZ662eV2E9C6NuNFPzytJpnYsHQD1YKdUifXF9KcnHZ/rVMlXJQf2sxsUHU
 hw0OSjYqPsow0zCOgUg==
X-Authority-Analysis: v=2.4 cv=A71h/qWG c=1 sm=1 tr=0 ts=69b07c59 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=W0BCv_TwhUmk0ohr3HAA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: pLcyWzS46H2ZRf1rHYMi6cLmqjaUrkCc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1011 suspectscore=0 bulkscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100177

From: Eugen Hristev <eugen.hristev@linaro.org>

Annotate vital static information into inspection table:
 - nr_irqs

Information on these annotated variables is stored in a dedicated
meminspect section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 kernel/irq/irqdesc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 7173b8b634f2..44ef0ebcc3ce 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -16,6 +16,7 @@
 #include <linux/irqdomain.h>
 #include <linux/sysfs.h>
 #include <linux/string_choices.h>
+#include <linux/meminspect.h>
 
 #include "internals.h"
 
@@ -141,6 +142,7 @@ static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
 }
 
 static unsigned int nr_irqs = NR_IRQS;
+MEMINSPECT_SIMPLE_ENTRY(nr_irqs);
 
 /**
  * irq_get_nr_irqs() - Number of interrupts supported by the system.

-- 
2.50.1

