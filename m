Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D92B3E7160
	for <linux-arch@vger.kernel.org>; Wed,  8 Jul 2026 07:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783494538; cv=none; b=FfVwgrsnWAHUdAFfcMHf6UT4MDNjJzVcplXc76kg5dwzELQjn+l/4HBD92ddm6Y0OQFWrH6Kx8XFhS3KbYF4JeoR+fNJfLAOehby2lrOftLVh1BPxg/6Prida5SfBfLVnYv4CE4/ds2XGuPi9DGRM1+di61zaFRtnw6cCLh6zzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783494538; c=relaxed/simple;
	bh=RGp5QueaPiZd0P6W8KCH9xrLiM6DbSkJnCCzWwCQ2yU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tT/vRBTTC0DKN3rh3WmxuF5UDR6aY2GxLc+K+HRGA1UDYaPAJU++tD8dBZXtzhFcMEsMUATtR19UvspcIP8sTF48pRnKtrr4OBfUc+2A0cUA6CWnC7FN/mV5Y9JWR8fSlijA+DS9uiBstTiXRg2lOozne/mKAeZ5G03k6uOY3Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dWA6Inxr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D9WCai9+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dWA6Inxr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D9WCai9+"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66842PkN1695676
	for <linux-arch@vger.kernel.org>; Wed, 8 Jul 2026 07:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=nJqYhVncBU+
	d62V+AHvnJXoOTo03C+xWxG51CnST7TU=; b=dWA6InxrM1RDSuiXJWA8wNLflNn
	bjANDuPY7kJ2Uiv12Ah48NqX8rczX8ICeD49ThCPjfrxwDYvjDxGKz9TTTt4lcSy
	6CdqHUbjjbBrjrcFaa7ppQC+kldPN6iJVr8ovr6Cpw9lYjW9FNo6UzysXJkoMdQn
	W4wwr6HHJyeLZeFOsIEMQMGKFVmIw/83kT8n75XoFBAnTZyE15fA4huaUutPBeZz
	IxXwuRpA3MMGvJyii3Ju74nPN3LN9N7nfhkIaOFrr3wk31zMpV0WVtG4i+GAduni
	FbUnjHxWmv+nWZzRz0zqBeTgIvQ8ZII1udWS9nED984qtdCzvsPdUDYXx+A==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9csw94sg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Wed, 08 Jul 2026 07:08:41 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c98a4ded1d7so382386a12.3
        for <linux-arch@vger.kernel.org>; Wed, 08 Jul 2026 00:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783494521; x=1784099321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nJqYhVncBU+d62V+AHvnJXoOTo03C+xWxG51CnST7TU=;
        b=D9WCai9+7I+IOHtnXwNqjGgUHa5eGfOOdXs4JsPyooBFEXOy/2hRJIlTYH6sMZ6ke6
         DuqLtFUQkhKqjb8xh5IWzgeLFckTi9tzxIKAaq9eaaRkRfGkKk9Q2z31xKLhSd9YZaL7
         NE8c8ugHfYjH9yBjUdqqhRuFpNqcYXqyT66MPwymBIghsbgKzBNg8C3mV3vF0jOZXbtV
         6x0ZMubF0BkdzsQW66Mxl7PnjxfAI4lL86purI06ABe7cmovHVVDV21/yULd+ZSDhNXr
         YOeadjQvEflAnxlJB0jq0FfLC2wlleJ2gWPz0QdaqJZlalDSVNEzZ4r6zD+wRgz18MgZ
         GDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783494521; x=1784099321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nJqYhVncBU+d62V+AHvnJXoOTo03C+xWxG51CnST7TU=;
        b=h4wQ5+LOdkigyFzD45Qt5jD+ukgWgG1Dx3eKdiNOx6M907O+b71sgFdTe2FXPYZy6O
         ZU0x5tLtRnUdvjGZqfQQ3wMvghJZPNYau9z+dSYWkEje8ugKeuYqHT4hJXMXeGZKb13/
         rZLbqwO/ACjSjsbO6voggbLhOG8PMsQZGbWxPCQXPqSA6iHC+oYGgOBzL/l8jntRcw8R
         HCTKgrvoOJUgj/ZwFGWAYWWjMbMSfHKBpJigW10wzwAfgqlBQWGExGXgCc6p9+P5D+wG
         snP3J3VYxXVrudr8fMTIoH6VtTQF0F6CoGFR+gf5a7sYmTjkCvvsWVxEg10qLpV1Nulu
         K0Sw==
X-Forwarded-Encrypted: i=1; AHgh+RrLk4aoWQNQMrSvRATtSBtcNJFDn8FT0A6DQphnPFeBmIm6im7jM4ifLA1KYUyjfgBwFwW/YePA4Dkn@vger.kernel.org
X-Gm-Message-State: AOJu0YwAtO8BmWeVspPwNvI13R0G1fsHE9nfq1WPw8o8s/uoChynm/WU
	N8O1gOHrC25tnw3osyRwx+zLJtJBiVLyH1LTpp09MVGxMEjusL9d1ycR3JK/ip8xxVmaqVsSELZ
	Dn6J/S+S/CP3McuFj3us8CfbNVm1NAEQ37zgjaVI/dMbZqmrkR5hfpx4HDHC1PpcS
X-Gm-Gg: AfdE7cnczvtlr/ZxikfRllHDR1UbRnMY4FHBFBce748zrrqZMGV78Aai5Y6i32Q8/nU
	nM3AFz6uUh3CbI/43O8qdOUrK0ATqBAYNjw/WWwCr44gUS8+ogaXSAyT0JVvGdkdaxNplRubGEy
	SVbBhcxAKvETtRjDrsQNTeF83dG7w8i9xHJB9Nx7bfgYoukRQONc6XBt1ss6a6zkwAe+7QDZVjA
	tmxBuo67QDLxxt9EXDw4Ecuoi162/KnDhpU8qkuJsStZPETnX4hJiNSeqIhCnSPzAYvk2FDzs1P
	TPt3h0Mnj4OTQJ3710MyQBaVhLjgZo79/uyBzoOPAaA3moQrGrjDfgZip/TKU4P0rLaw06YlTDe
	GzTMoN8yq6y9NDgb1CYRnVnGzP1RiXwNTt1/hBQ==
X-Received: by 2002:a05:6a21:10e:b0:3c0:9c19:65b1 with SMTP id adf61e73a8af0-3c0bd3acfb6mr1445448637.73.1783494520994;
        Wed, 08 Jul 2026 00:08:40 -0700 (PDT)
X-Received: by 2002:a05:6a21:10e:b0:3c0:9c19:65b1 with SMTP id adf61e73a8af0-3c0bd3acfb6mr1445323637.73.1783494520337;
        Wed, 08 Jul 2026 00:08:40 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5afdb754asm1893624a12.13.2026.07.08.00.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 00:08:39 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: akpm@linux-foundation.org, anna-maria@linutronix.de, arnd@arndb.de,
        andersson@kernel.org, chrisl@kernel.org, cl@gentwo.org,
        conor+dt@kernel.org, david@kernel.org, dennis@kernel.org,
        devicetree@vger.kernel.org, ehristev@kernel.org, frederic@kernel.org,
        mingo@redhat.com, jstultz@google.com, corbet@lwn.net,
        juri.lelli@redhat.com, kasong@tencent.com, kees@kernel.org,
        konradybcio@kernel.org, krzk+dt@kernel.org, linux-arch@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-remoteproc@vger.kernel.org, mathieu.poirier@linaro.org,
        mukesh.ojha@oss.qualcomm.com, peterz@infradead.org, pmladek@suse.com,
        robh@kernel.org, saravanak@kernel.org, tj@kernel.org, tglx@kernel.org,
        vincent.guittot@linaro.org, workflows@vger.kernel.org
Cc: atomlin@atomlin.com, ast@kernel.org, aliceryhl@google.com,
        linux.amoon@gmail.com, ardb@kernel.org, baoquan.he@linux.dev,
        baohua@kernel.org, bsegall@google.com, jackmanb@google.com,
        leitao@debian.org, brauner@kernel.org, coxu@redhat.com,
        dietmar.eggemann@arm.com, dianders@chromium.org, ebiggers@kernel.org,
        feng.tang@linux.alibaba.com, yangfeng@kylinos.cn, gary@garyguo.net,
        guohanjun@huawei.com, jack@suse.cz, wangjinchao600@gmail.com,
        joel.granados@kernel.org, hannes@cmpxchg.org,
        john.ogness@linutronix.de, jpoimboe@kernel.org,
        shikemeng@huaweicloud.com, kas@kernel.org, kprateek.nayak@amd.com,
        liam@infradead.org, ljs@kernel.org, elver@google.com, mgorman@suse.de,
        mhocko@suse.com, ojeda@kernel.org, rppt@kernel.org,
        namcao@linutronix.de, nathan@kernel.org, nphamcs@gmail.com,
        n.schier@fritz.com, pasha.tatashin@soleen.com, petr.pavlu@suse.com,
        pnina.feder@mobileye.com, rdunlap@infradead.org,
        rioo.tsukatsukii@gmail.com, senozhatsky@chromium.org,
        skhan@linuxfoundation.org, sboyd@kernel.org, rostedt@goodmis.org,
        surenb@google.com, thomas.weissschuh@linutronix.de,
        vschneid@redhat.com, vbabka@kernel.org, youngjun.park@lge.com,
        zhengyejian@huaweicloud.com, ziy@nvidia.com,
        Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH v3 26/26] meminspect: Add debug kinfo compatible driver
Date: Wed,  8 Jul 2026 12:38:09 +0530
Message-ID: <20260708070809.2660886-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708-meminspect-v3-v3-0-7aa5a0a74d5c@oss.qualcomm.com>
References: <20260708-meminspect-v3-v3-0-7aa5a0a74d5c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: oePcAgfN9XbcP4OQN5-besEXbJYhD2wU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA2NyBTYWx0ZWRfXyUUTeg3eCGGb
 6i+rnpzFZuvg+5L2OR2r8RGLGNEEDW3jCrploNYu0zcSXcTI/GXGZ++qJI3rz1HXF4NnDLdXZYw
 U0X8dnshL0EFU/THEzfbB1OdOr3IjGY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA2NyBTYWx0ZWRfX/wGX+hWitiA2
 MaWxBc25iJlK2dbyEuWkq1SLWCJAfl5Afj/NzoqCvgvFq+9NCqBYW48uynYB/OJ7VZjyz/GHG/s
 tr1FxGrEqh4O+KglSxidXLhvklA9XUkT5X91bLMD77tGBf1BM49cB7PXBjiwaYmW8mQhlk6BXlI
 JCNj8ODlSkuFH2/t3lBwO5OoihcoV2cD/cY95vpy33IL8/zjlLqLhnEQ2cVegvZvX4IH626leQZ
 rxCGof6h+9LjAUyY/rW4G2yxK+Q2YDEZ9oTdSVlx3weoeKMZ6jQfvNx2uCOTwikqkfBLkVhnR1b
 GHcqEhxJ2+uidEUpaZiZoTKubn9UrZbhhH7ODyVDg624nGfje3TyDsI0OUpvXKWOI5CJg9ryeIo
 O+juJ8TcTV/HxZu4UOQam/g0K3QQB8QEgYG1TKVpNIF+eCjXyk94hSdhgeq0R0w2DYaHevOK+RV
 b0oen6/D9c3fpDDbNWQ==
X-Authority-Analysis: v=2.4 cv=HaYkiCE8 c=1 sm=1 tr=0 ts=6a4df779 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=Tty9oNO6AAAA:8 a=1XWaLZrsAAAA:8
 a=rSYwI8UV6N779v-tbp0A:9 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22
 a=Bts-Es6F1CBXvF7u4C_G:22
X-Proofpoint-GUID: oePcAgfN9XbcP4OQN5-besEXbJYhD2wU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080067

From: Eugen Hristev <eugen.hristev@linaro.org>

With this driver, the registered regions are copied to a shared memory
zone at register time. The shared memory zone is supplied via OF. This
driver will select only regions that are of interest, and keep only
addresses. The format of the list is Kinfo compatible, with devices like
Google Pixel phone. The firmware is only interested in some symbols'
addresses.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 MAINTAINERS                |   1 +
 drivers/of/platform.c      |   1 +
 kernel/meminspect/Kconfig  |  11 ++
 kernel/meminspect/Makefile |   1 +
 kernel/meminspect/kinfo.c  | 257 +++++++++++++++++++++++++++++++++++++
 5 files changed, 271 insertions(+)
 create mode 100644 kernel/meminspect/kinfo.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2d816d783024..d805ff9fedac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16906,6 +16906,7 @@ M:	Eugen Hristev <eugen.hristev@linaro.org>
 M:	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/reserved-memory/google,debug-kinfo.yaml
+F:	kernel/meminspect/kinfo.c
 
 MEMBLOCK AND MEMORY MANAGEMENT INITIALIZATION
 M:	Mike Rapoport <rppt@kernel.org>
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 53bca8c6f781..f80bd25fc481 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -494,6 +494,7 @@ static const struct of_device_id reserved_mem_matches[] = {
 	{ .compatible = "qcom,smem" },
 	{ .compatible = "ramoops" },
 	{ .compatible = "nvmem-rmem" },
+	{ .compatible = "google,debug-kinfo" },
 	{ .compatible = "google,open-dice" },
 	{}
 };
diff --git a/kernel/meminspect/Kconfig b/kernel/meminspect/Kconfig
index 18ff511ad4cf..7f6436c3344b 100644
--- a/kernel/meminspect/Kconfig
+++ b/kernel/meminspect/Kconfig
@@ -16,3 +16,14 @@ config MEMINSPECT
 
 	  Note that modules using this feature must be rebuilt if this
 	  option changes.
+
+config MEMINSPECT_KINFO
+	tristate "Shared memory KInfo compatible driver"
+	depends on MEMINSPECT
+	help
+	  Say y here to enable the Shared memory KInfo compatible driver.
+	  With this driver, the registered regions are copied to a shared
+	  memory zone at register time.
+	  The shared memory zone is supplied via OF.
+	  This driver will select only regions that are of interest,
+	  and keep only addresses. The format of the list is Kinfo compatible.
diff --git a/kernel/meminspect/Makefile b/kernel/meminspect/Makefile
index 09fd55e6d9cf..283604d892e5 100644
--- a/kernel/meminspect/Makefile
+++ b/kernel/meminspect/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_MEMINSPECT) += meminspect.o
+obj-$(CONFIG_MEMINSPECT_KINFO) += kinfo.o
diff --git a/kernel/meminspect/kinfo.c b/kernel/meminspect/kinfo.c
new file mode 100644
index 000000000000..7451c13bc316
--- /dev/null
+++ b/kernel/meminspect/kinfo.c
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *
+ * Copyright 2002 Rusty Russell <rusty@rustcorp.com.au> IBM Corporation
+ * Copyright 2021 Google LLC
+ * Copyright 2025 Linaro Ltd. Eugen Hristev <eugen.hristev@linaro.org>
+ */
+#include <linux/container_of.h>
+#include <linux/kallsyms.h>
+#include <linux/meminspect.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
+#include <linux/utsname.h>
+
+#define BUILD_INFO_LEN		256
+#define DEBUG_KINFO_MAGIC	0xcceeddff
+
+/*
+ * Header structure must be byte-packed, since the table is provided to
+ * bootloader.
+ */
+struct kernel_info {
+	/* For kallsyms */
+	u8 enabled_all;
+	u8 enabled_base_relative;
+	u8 enabled_absolute_percpu;
+	u8 enabled_cfi_clang;
+	u32 num_syms;
+	u16 name_len;
+	u16 bit_per_long;
+	u16 module_name_len;
+	u16 symbol_len;
+	u64 _relative_pa;
+	u64 _text_pa;
+	u64 _stext_pa;
+	u64 _etext_pa;
+	u64 _sinittext_pa;
+	u64 _einittext_pa;
+	u64 _end_pa;
+	u64 _offsets_pa;
+	u64 _names_pa;
+	u64 _token_table_pa;
+	u64 _token_index_pa;
+	u64 _markers_pa;
+	u64 _seqs_of_names_pa;
+
+	/* For frame pointer */
+	u32 thread_size;
+
+	/* For virt_to_phys */
+	u64 swapper_pg_dir_pa;
+
+	/* For linux banner */
+	u8 last_uts_release[__NEW_UTS_LEN];
+
+	/* For module kallsyms */
+	u32 enabled_modules_tree_lookup;
+	u32 mod_mem_offset;
+	u32 mod_kallsyms_offset;
+} __packed;
+
+struct kernel_all_info {
+	u32 magic_number;
+	u32 combined_checksum;
+	struct kernel_info info;
+} __packed;
+
+struct debug_kinfo {
+	struct device *dev;
+	void *all_info_addr;
+	size_t all_info_size;
+	struct notifier_block nb;
+};
+
+static void update_kernel_all_info(struct kernel_all_info *all_info)
+{
+	struct kernel_info *info;
+	u32 *checksum_info;
+	int index;
+
+	all_info->magic_number = DEBUG_KINFO_MAGIC;
+	all_info->combined_checksum = 0;
+
+	info = &all_info->info;
+	checksum_info = (u32 *)info;
+	for (index = 0; index < sizeof(*info) / sizeof(u32); index++)
+		all_info->combined_checksum ^= checksum_info[index];
+}
+
+static void __maybe_unused register_kinfo_region(void *priv,
+						 const struct inspect_entry *e)
+{
+	struct debug_kinfo *kinfo = priv;
+	struct kernel_all_info *all_info = kinfo->all_info_addr;
+	struct kernel_info *info = &all_info->info;
+	struct uts_namespace *uts;
+	u64 paddr;
+
+	if (e->pa)
+		paddr = e->pa;
+	else
+		paddr = __pa(e->va);
+
+	switch (e->id) {
+	case MEMINSPECT_ID__sinittext:
+		info->_sinittext_pa = paddr;
+		break;
+	case MEMINSPECT_ID__einittext:
+		info->_einittext_pa = paddr;
+		break;
+	case MEMINSPECT_ID__end:
+		info->_end_pa = paddr;
+		break;
+	case MEMINSPECT_ID__text:
+		info->_text_pa = paddr;
+		break;
+	case MEMINSPECT_ID__stext:
+		info->_stext_pa = paddr;
+		break;
+	case MEMINSPECT_ID__etext:
+		info->_etext_pa = paddr;
+		break;
+	case MEMINSPECT_ID_kallsyms_num_syms:
+		info->num_syms = *(__u32 *)e->va;
+		break;
+	case MEMINSPECT_ID_kallsyms_offsets:
+		info->_offsets_pa = paddr;
+		break;
+	case MEMINSPECT_ID_kallsyms_names:
+		info->_names_pa = paddr;
+		break;
+	case MEMINSPECT_ID_kallsyms_token_table:
+		info->_token_table_pa = paddr;
+		break;
+	case MEMINSPECT_ID_kallsyms_token_index:
+		info->_token_index_pa = paddr;
+		break;
+	case MEMINSPECT_ID_kallsyms_markers:
+		info->_markers_pa = paddr;
+		break;
+	case MEMINSPECT_ID_kallsyms_seqs_of_names:
+		info->_seqs_of_names_pa = paddr;
+		break;
+	case MEMINSPECT_ID_swapper_pg_dir:
+		info->swapper_pg_dir_pa = paddr;
+		break;
+	case MEMINSPECT_ID_init_uts_ns:
+		if (!e->va)
+			return;
+		uts = e->va;
+		strscpy(info->last_uts_release, uts->name.release, __NEW_UTS_LEN);
+		break;
+	default:
+		break;
+	};
+
+	update_kernel_all_info(all_info);
+}
+
+static int kinfo_notifier_cb(struct notifier_block *nb,
+			     unsigned long code, void *entry)
+{
+	struct debug_kinfo *kinfo = container_of(nb, struct debug_kinfo, nb);
+
+	if (code == MEMINSPECT_NOTIFIER_ADD)
+		register_kinfo_region(kinfo, entry);
+
+	return NOTIFY_DONE;
+}
+
+static int debug_kinfo_probe(struct platform_device *pdev)
+{
+	struct kernel_all_info *all_info;
+	struct device *dev = &pdev->dev;
+	struct reserved_mem *rmem;
+	struct debug_kinfo *kinfo;
+	struct kernel_info *info;
+
+	rmem = of_reserved_mem_lookup(dev->of_node);
+	if (!rmem)
+		return dev_err_probe(dev, -ENODEV, "no such reserved mem of node name %s\n",
+			      dev->of_node->name);
+
+	/* Need to wait for reserved memory to be mapped */
+	if (!rmem->priv)
+		return -EPROBE_DEFER;
+
+	if (!rmem->base || !rmem->size)
+		dev_err_probe(dev, -EINVAL, "unexpected reserved memory\n");
+
+	if (rmem->size < sizeof(struct kernel_all_info))
+		dev_err_probe(dev, -EINVAL, "reserved memory size too small\n");
+
+	kinfo = devm_kzalloc(dev, sizeof(*kinfo), GFP_KERNEL);
+	if (!kinfo)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, kinfo);
+
+	kinfo->dev = dev;
+	kinfo->all_info_addr = rmem->priv;
+	kinfo->all_info_size = rmem->size;
+
+	all_info = kinfo->all_info_addr;
+
+	memset(all_info, 0, sizeof(struct kernel_all_info));
+	info = &all_info->info;
+	info->enabled_all = IS_ENABLED(CONFIG_KALLSYMS_ALL);
+	info->enabled_absolute_percpu = IS_ENABLED(CONFIG_KALLSYMS_ABSOLUTE_PERCPU);
+	info->enabled_base_relative = IS_ENABLED(CONFIG_KALLSYMS_BASE_RELATIVE);
+	info->enabled_cfi_clang = IS_ENABLED(CONFIG_CFI_CLANG);
+	info->name_len = KSYM_NAME_LEN;
+	info->bit_per_long = BITS_PER_LONG;
+	info->module_name_len = MODULE_NAME_LEN;
+	info->symbol_len = KSYM_SYMBOL_LEN;
+	info->thread_size = THREAD_SIZE;
+	info->enabled_modules_tree_lookup = IS_ENABLED(CONFIG_MODULES_TREE_LOOKUP);
+	info->mod_mem_offset = offsetof(struct module, mem);
+	info->mod_kallsyms_offset = offsetof(struct module, kallsyms);
+
+	kinfo->nb.notifier_call = kinfo_notifier_cb;
+
+	meminspect_notifier_register(&kinfo->nb);
+	meminspect_lock_traverse(kinfo, register_kinfo_region);
+
+	return 0;
+}
+
+static void debug_kinfo_remove(struct platform_device *pdev)
+{
+	struct debug_kinfo *kinfo = platform_get_drvdata(pdev);
+
+	meminspect_notifier_unregister(&kinfo->nb);
+}
+
+static const struct of_device_id debug_kinfo_of_match[] = {
+	{ .compatible	= "google,debug-kinfo" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, debug_kinfo_of_match);
+
+static struct platform_driver debug_kinfo_driver = {
+	.probe = debug_kinfo_probe,
+	.remove = debug_kinfo_remove,
+	.driver = {
+		.name = "debug-kinfo",
+		.of_match_table = debug_kinfo_of_match,
+	},
+};
+module_platform_driver(debug_kinfo_driver);
+
+MODULE_AUTHOR("Eugen Hristev <eugen.hristev@linaro.org>");
+MODULE_AUTHOR("Jone Chou <jonechou@google.com>");
+MODULE_DESCRIPTION("meminspect Kinfo Driver");
+MODULE_LICENSE("GPL");
-- 
2.53.0

