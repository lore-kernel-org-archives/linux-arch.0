Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1C43C0A19
	for <linux-arch@vger.kernel.org>; Wed,  8 Jul 2026 18:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783536443; cv=none; b=ZyykispPIIdWsBf2V9xjz1QuzSPCupG3zHw/fB1Qgnj70zclHWiPUiZ+3duWnCiqREV37Yua5rAZRTWrl7Jox3Rv4RDEOHQlFbC85/ImCuDArWnkkMyls90BtSKZ3AySBgzSzTw+nyYgjcgtQBNnuCw11vyZdR7AJWYolw31jU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783536443; c=relaxed/simple;
	bh=mACmuHlZX20bUZH9GBr/hdZ+rwWW1JFJPM3em3vuYQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2a2uPMYhRdZGKSgTpTqh66jQ1VTGxRV6jh6c1shLS2h0gI3j0sbtGkx+UccFHSv/1/2ueWmNgdlMy6VDb2JfUYvKXPxf5vVUxWZWM3tZJIrlimr+vi9+gVh8mgzV9yj63rpea2bI/L7Z3fBkeXUI1daTE+eRqYnMuOgSeu7LYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SMaNwRkG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EYrnNONW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SMaNwRkG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EYrnNONW"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668IlIfK3712195
	for <linux-arch@vger.kernel.org>; Wed, 8 Jul 2026 18:47:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aigJJJhGHgfhaydfVTP5L418
	kGbReJJsoG+/PNyDn6Y=; b=SMaNwRkGGiXFqk3zH2CodUO4ECSjUVFVC/X4FqB1
	j5mLgVbPxoKgorsdxTeZrKaZzGO+m1dKDRYMrOlFTHiEzsHwchmsU7KJFV/je2gk
	Ty9GtRcXbiFk4cowSfqau0ulYADsAZEowTGMSVH4Dw8FbeVrXwezYRlFFkjDDWMi
	tE8d1zFF5BDOEkWaiYDc/L30ikNG3OkTEpcNcZf4TTGMAfTQqioDnhoDfWa7Wb2z
	zev2S/gX7OCu8y67llRcm4+TfgFMAHCO6CGwRJZspTQF2kZWaGUaxJFuW8TTuE9d
	kaxk4wubm7eRKIZvdZ3a0FwF1fuHlHUdPTujqnh/RUzJgQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9v4vr00m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Wed, 08 Jul 2026 18:47:20 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c891ed872ddso1608378a12.2
        for <linux-arch@vger.kernel.org>; Wed, 08 Jul 2026 11:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783536440; x=1784141240; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aigJJJhGHgfhaydfVTP5L418kGbReJJsoG+/PNyDn6Y=;
        b=EYrnNONWGjctW2ydPq5YUXQLZePfCmuEEUkBWhISE5NZLkFLnzJr2J11MsBVUHejwC
         Xv9XzGJeWLpxugWeIrrFmsyeXVav26lOPx+Pp8XpIvh6b1tBBNCy8hFXBoy/mMPFvDIH
         kQQ85TMbAILj/S+ztAP5fJFeVILx8sRkMHP0EIFra3CD0YAMbnD6GTPPYL0KV67hSW/0
         ahzJogci0FF5gV3jc95h2zrQU5W7nV6D5sE4pWaxAsz32+BpIgSAOw56VEZV69QkUd8Y
         hcuaoMjDigvPn3xNtl87d59hWF8MotH30ZqjfPZ4bZRfTtZEf2km4cYzu2Z++mml/oA/
         ZvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783536440; x=1784141240;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aigJJJhGHgfhaydfVTP5L418kGbReJJsoG+/PNyDn6Y=;
        b=BRZtyqSIIMDOXB/Xxcrp/DcsDLkM8u4Oi1x4SXCX2GMxVrljVKYtZsf4/bZckMXMUg
         9XsoFEGTHqEEKEQtOrQHpF9ECBFz7N5N7dqlPKhkfmcD/eQuOoA4lSUvSGMrLru6ZQDj
         xZ/6OP4cXdfYsxu5UTOxAxxe2plmqJliDojZLpVBWGZho0VLLoMz+NVsNsTAQIYiN7F8
         UQyp8fkmBGi1YIJYf4hfcRqzGGxFVFFYjjW6j3Q26vEpKuEbqdAuwdwWJmWza0mCAP4Q
         EoLQIP7ZaSmVuM3yMIJ7/nLJ1ewr2hINfYBNpvv/VxfVPHjEh4euPp4g5162KpheyuMM
         VqZw==
X-Forwarded-Encrypted: i=1; AHgh+RqTR7gphbNPVAQnT3Gi30m5ic5kjSzdJXkGzT3ue9ijHFRlR5f59eYSIFeFez0jni36YTbJ6Y7ZeGQT@vger.kernel.org
X-Gm-Message-State: AOJu0YyU07Gz8F7oScsHhrbODflj/RR7OxW7FN14wnnk13rBcUeBroFP
	6e0YgOI4/f3eNTFrhyDnAGfuocaAIEyYzGtBdy6vWwPv+wtOMEWcN2ccbSeaMD0LdtKiF7mNXVV
	AsDDOIqQq8Bbm500gIYzuEFh3iPeJpWAM0r93oL9N3/0iUCiUYuKiOcN3kFgmaMp6
X-Gm-Gg: AfdE7cljsM4Scku6d84BnApbbB70ICKmOY9QMuw1lajyf4Nd5A9RiJVkLsW1tYDHCVf
	coFjUPHjo8rzTyLgdSEDSeyq4IKnxhdCWLwLvbmRuJWKga3QsT8Sn3TraZVcRhZosZYy0HXETUe
	X3LouCq+gIeN2eqjHS27jzM7zOXJiC08AFKlWTXQvE5CaOdHIAZkS0rq7fjMjNGZYHkUOGNP2B4
	Usp5vJNBQfB30Q7cv8J/6xUj2l8kTjGcNmOMA4eg8jHFAeyeVtThT0Nmn7z36EOdi/IeMqhaO9j
	eWNkwugtksLP6WkSTg59gZ9I//VUoRIE3HhfuNXFQ2aNcU4XUM9rbCnwOsdSZ5sO7MHdU/zk82x
	AaQPFACFKrJQw2uxmm3Ej1xIRQD1T/kDNBpx7aQ==
X-Received: by 2002:a05:6a21:7a9b:b0:3bf:9e25:1a17 with SMTP id adf61e73a8af0-3c0bc8c2038mr4677424637.12.1783536440183;
        Wed, 08 Jul 2026 11:47:20 -0700 (PDT)
X-Received: by 2002:a05:6a21:7a9b:b0:3bf:9e25:1a17 with SMTP id adf61e73a8af0-3c0bc8c2038mr4677313637.12.1783536439597;
        Wed, 08 Jul 2026 11:47:19 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b6594f9a0sm23425858c88.4.2026.07.08.11.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 11:47:19 -0700 (PDT)
Date: Thu, 9 Jul 2026 00:16:52 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: akpm@linux-foundation.org, anna-maria@linutronix.de, arnd@arndb.de,
        andersson@kernel.org, chrisl@kernel.org, cl@gentwo.org,
        conor+dt@kernel.org, david@kernel.org, dennis@kernel.org,
        devicetree@vger.kernel.org, ehristev@kernel.org, frederic@kernel.org,
        mingo@redhat.com, jstultz@google.com, corbet@lwn.net,
        juri.lelli@redhat.com, kasong@tencent.com, kees@kernel.org,
        konradybcio@kernel.org, krzk+dt@kernel.org, linux-arch@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-remoteproc@vger.kernel.org, mathieu.poirier@linaro.org,
        peterz@infradead.org, pmladek@suse.com, robh@kernel.org,
        saravanak@kernel.org, tj@kernel.org, tglx@kernel.org,
        vincent.guittot@linaro.org, workflows@vger.kernel.org,
        atomlin@atomlin.com, ast@kernel.org, aliceryhl@google.com,
        linux.amoon@gmail.com, ardb@kernel.org, baoquan.he@linux.dev,
        baohua@kernel.org, bsegall@google.com, jackmanb@google.com,
        leitao@debian.org, brauner@kernel.org, coxu@redhat.com,
        dietmar.eggemann@arm.com, dianders@chromium.org, ebiggers@kernel.org,
        feng.tang@linux.alibaba.com, yangfeng@kylinos.cn, gary@garyguo.net,
        guohanjun@huawei.com, jack@suse.cz, wangjinchao600@gmail.com,
        joel.granados@kernel.org, hannes@cmpxchg.org,
        john.ogness@linutronix.de, jpoimboe@kernel.org,
        shikemeng@huaweicloud.com, kas@kernel.org, kprateek.nayak@amd.com,
        liam@infradead.org, elver@google.com, mgorman@suse.de, mhocko@suse.com,
        ojeda@kernel.org, rppt@kernel.org, namcao@linutronix.de,
        nathan@kernel.org, nphamcs@gmail.com, n.schier@fritz.com,
        pasha.tatashin@soleen.com, petr.pavlu@suse.com,
        pnina.feder@mobileye.com, rdunlap@infradead.org,
        rioo.tsukatsukii@gmail.com, senozhatsky@chromium.org,
        skhan@linuxfoundation.org, sboyd@kernel.org, rostedt@goodmis.org,
        surenb@google.com, thomas.weissschuh@linutronix.de,
        vschneid@redhat.com, vbabka@kernel.org, youngjun.park@lge.com,
        zhengyejian@huaweicloud.com, ziy@nvidia.com,
        Eugen Hristev <eugen.hristev@linaro.org>
Subject: Re: [PATCH v3 26/26] meminspect: Add debug kinfo compatible driver
Message-ID: <20260708184652.tjbqhvmoqrou3ncc@hu-mojha-hyd.qualcomm.com>
References: <20260708-meminspect-v3-v3-0-7aa5a0a74d5c@oss.qualcomm.com>
 <20260708070809.2660886-1-mukesh.ojha@oss.qualcomm.com>
 <ak4DqBta0boElPak@lucifer>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak4DqBta0boElPak@lucifer>
X-Proofpoint-GUID: -qZdzs055d6e2yimZdEEyYdzX-7a2u4H
X-Proofpoint-ORIG-GUID: -qZdzs055d6e2yimZdEEyYdzX-7a2u4H
X-Authority-Analysis: v=2.4 cv=GIg41ONK c=1 sm=1 tr=0 ts=6a4e9b39 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=Oh2cFVv5AAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=Tty9oNO6AAAA:8 a=1XWaLZrsAAAA:8 a=908p1EQr1GbHt3uppzYA:9 a=CjuIK1q_8ugA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=7KeoIwV6GZqOttXkcoxL:22 a=cvBusfyB2V15izCimMoJ:22
 a=Bts-Es6F1CBXvF7u4C_G:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE4MyBTYWx0ZWRfX2VF7AF/WjlwL
 QQofRb1gq2EnOStAqhK7fmh0aEL4NAEDZQZT1PVlP9o12xvRON0ZqN/mocUZXUttiZT0yudOMgS
 +ozuGB6KdtghWe31GrXJ4V5azOWLGX7Q2iE5DB9garsA4xahUx3PHQXAXrumnaXeAXQDV0a7USO
 xg8eL4GTrKSkvTKKc0ZnXI8K3r+4La50SOimpM857kHPFM84/B80KJrmpZMXXWhItwYruq3EUya
 81QqglAPYUFBhoHEGdGNv0XHOww40+cOVlSQwv+/7vpgObme+9Gxu05t9DUqMyRkqO9LuGjaP+W
 4+yDmpML3Eo+Q9+7tx3ACKiUBjW+xRLVWoby7D6640YnhOtt9odHzSHabk3KUb0I32jUoFFM2/H
 YCjIDi/17sZw82nCsUhRSK3B+vzw6KxXNRPOhPSSuCF0m3cSLdrHWnv9ozCZ46irMw7hZ8EpMXR
 f6gR8+kalYPV6IIAjeA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE4MyBTYWx0ZWRfX8mmjJbedcW66
 lMxMj8h8KSGRHOfIURGUOCWVMHP2lb4983GDRoe9yZO3TS/5mVzcwvHGnnOOIl9sMe5YtV3Avnb
 3D4xSC/t4sr1cyciX/l9RvmcMe011YQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_03,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080183

On Wed, Jul 08, 2026 at 09:06:52AM +0100, Lorenzo Stoakes wrote:
> On Wed, Jul 08, 2026 at 12:38:09PM +0530, Mukesh Ojha wrote:
> > From: Eugen Hristev <eugen.hristev@linaro.org>
> >
> > With this driver, the registered regions are copied to a shared memory
> > zone at register time. The shared memory zone is supplied via OF. This
> > driver will select only regions that are of interest, and keep only
> > addresses. The format of the list is Kinfo compatible, with devices like
> > Google Pixel phone. The firmware is only interested in some symbols'
> > addresses.
> >
> > Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
> > Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> 
> Hang on, this is a driver that exposes internal kernel symbol information in a
> shared memory region for anybody who wants to access it?
>

Yes, this was one of the others we could find in the Android
kernel, which could be another use case of the meminspect
backend.

https://android.googlesource.com/kernel/common/+/refs/heads/android-mainline/drivers/android/debug_kinfo.c

-Mukesh

> This doesn't really seem sane?
> 
> Looking through the code it seems you are only exposing things that are already
> otherwise exposed, so maybe it's not so bad, but it seems as if a registered
> meminfo driver could in any case get access to things they shouldn't?

> 
> > ---
> >  MAINTAINERS                |   1 +
> >  drivers/of/platform.c      |   1 +
> >  kernel/meminspect/Kconfig  |  11 ++
> >  kernel/meminspect/Makefile |   1 +
> >  kernel/meminspect/kinfo.c  | 257 +++++++++++++++++++++++++++++++++++++
> >  5 files changed, 271 insertions(+)
> >  create mode 100644 kernel/meminspect/kinfo.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 2d816d783024..d805ff9fedac 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -16906,6 +16906,7 @@ M:	Eugen Hristev <eugen.hristev@linaro.org>
> >  M:	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> >  S:	Maintained
> >  F:	Documentation/devicetree/bindings/reserved-memory/google,debug-kinfo.yaml
> > +F:	kernel/meminspect/kinfo.c
> >
> >  MEMBLOCK AND MEMORY MANAGEMENT INITIALIZATION
> >  M:	Mike Rapoport <rppt@kernel.org>
> > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > index 53bca8c6f781..f80bd25fc481 100644
> > --- a/drivers/of/platform.c
> > +++ b/drivers/of/platform.c
> > @@ -494,6 +494,7 @@ static const struct of_device_id reserved_mem_matches[] = {
> >  	{ .compatible = "qcom,smem" },
> >  	{ .compatible = "ramoops" },
> >  	{ .compatible = "nvmem-rmem" },
> > +	{ .compatible = "google,debug-kinfo" },
> >  	{ .compatible = "google,open-dice" },
> >  	{}
> >  };
> > diff --git a/kernel/meminspect/Kconfig b/kernel/meminspect/Kconfig
> > index 18ff511ad4cf..7f6436c3344b 100644
> > --- a/kernel/meminspect/Kconfig
> > +++ b/kernel/meminspect/Kconfig
> > @@ -16,3 +16,14 @@ config MEMINSPECT
> >
> >  	  Note that modules using this feature must be rebuilt if this
> >  	  option changes.
> > +
> > +config MEMINSPECT_KINFO
> > +	tristate "Shared memory KInfo compatible driver"
> > +	depends on MEMINSPECT
> > +	help
> > +	  Say y here to enable the Shared memory KInfo compatible driver.
> > +	  With this driver, the registered regions are copied to a shared
> > +	  memory zone at register time.
> > +	  The shared memory zone is supplied via OF.
> > +	  This driver will select only regions that are of interest,
> > +	  and keep only addresses. The format of the list is Kinfo compatible.
> > diff --git a/kernel/meminspect/Makefile b/kernel/meminspect/Makefile
> > index 09fd55e6d9cf..283604d892e5 100644
> > --- a/kernel/meminspect/Makefile
> > +++ b/kernel/meminspect/Makefile
> > @@ -1,3 +1,4 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >
> >  obj-$(CONFIG_MEMINSPECT) += meminspect.o
> > +obj-$(CONFIG_MEMINSPECT_KINFO) += kinfo.o
> > diff --git a/kernel/meminspect/kinfo.c b/kernel/meminspect/kinfo.c
> > new file mode 100644
> > index 000000000000..7451c13bc316
> > --- /dev/null
> > +++ b/kernel/meminspect/kinfo.c
> > @@ -0,0 +1,257 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + *
> > + * Copyright 2002 Rusty Russell <rusty@rustcorp.com.au> IBM Corporation
> > + * Copyright 2021 Google LLC
> > + * Copyright 2025 Linaro Ltd. Eugen Hristev <eugen.hristev@linaro.org>
> > + */
> > +#include <linux/container_of.h>
> > +#include <linux/kallsyms.h>
> > +#include <linux/meminspect.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_reserved_mem.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/utsname.h>
> > +
> > +#define BUILD_INFO_LEN		256
> > +#define DEBUG_KINFO_MAGIC	0xcceeddff
> > +
> > +/*
> > + * Header structure must be byte-packed, since the table is provided to
> > + * bootloader.
> > + */
> > +struct kernel_info {
> > +	/* For kallsyms */
> > +	u8 enabled_all;
> > +	u8 enabled_base_relative;
> > +	u8 enabled_absolute_percpu;
> > +	u8 enabled_cfi_clang;
> > +	u32 num_syms;
> > +	u16 name_len;
> > +	u16 bit_per_long;
> > +	u16 module_name_len;
> > +	u16 symbol_len;
> > +	u64 _relative_pa;
> > +	u64 _text_pa;
> > +	u64 _stext_pa;
> > +	u64 _etext_pa;
> > +	u64 _sinittext_pa;
> > +	u64 _einittext_pa;
> > +	u64 _end_pa;
> > +	u64 _offsets_pa;
> > +	u64 _names_pa;
> > +	u64 _token_table_pa;
> > +	u64 _token_index_pa;
> > +	u64 _markers_pa;
> > +	u64 _seqs_of_names_pa;
> > +
> > +	/* For frame pointer */
> > +	u32 thread_size;
> > +
> > +	/* For virt_to_phys */
> > +	u64 swapper_pg_dir_pa;
> > +
> > +	/* For linux banner */
> > +	u8 last_uts_release[__NEW_UTS_LEN];
> > +
> > +	/* For module kallsyms */
> > +	u32 enabled_modules_tree_lookup;
> > +	u32 mod_mem_offset;
> > +	u32 mod_kallsyms_offset;
> > +} __packed;
> > +
> > +struct kernel_all_info {
> > +	u32 magic_number;
> > +	u32 combined_checksum;
> > +	struct kernel_info info;
> > +} __packed;
> > +
> > +struct debug_kinfo {
> > +	struct device *dev;
> > +	void *all_info_addr;
> > +	size_t all_info_size;
> > +	struct notifier_block nb;
> > +};
> > +
> > +static void update_kernel_all_info(struct kernel_all_info *all_info)
> > +{
> > +	struct kernel_info *info;
> > +	u32 *checksum_info;
> > +	int index;
> > +
> > +	all_info->magic_number = DEBUG_KINFO_MAGIC;
> > +	all_info->combined_checksum = 0;
> > +
> > +	info = &all_info->info;
> > +	checksum_info = (u32 *)info;
> > +	for (index = 0; index < sizeof(*info) / sizeof(u32); index++)
> > +		all_info->combined_checksum ^= checksum_info[index];
> > +}
> > +
> > +static void __maybe_unused register_kinfo_region(void *priv,
> > +						 const struct inspect_entry *e)
> > +{
> > +	struct debug_kinfo *kinfo = priv;
> > +	struct kernel_all_info *all_info = kinfo->all_info_addr;
> > +	struct kernel_info *info = &all_info->info;
> > +	struct uts_namespace *uts;
> > +	u64 paddr;
> > +
> > +	if (e->pa)
> > +		paddr = e->pa;
> > +	else
> > +		paddr = __pa(e->va);
> > +
> > +	switch (e->id) {
> > +	case MEMINSPECT_ID__sinittext:
> > +		info->_sinittext_pa = paddr;
> > +		break;
> > +	case MEMINSPECT_ID__einittext:
> > +		info->_einittext_pa = paddr;
> > +		break;
> > +	case MEMINSPECT_ID__end:
> > +		info->_end_pa = paddr;
> > +		break;
> > +	case MEMINSPECT_ID__text:
> > +		info->_text_pa = paddr;
> > +		break;
> > +	case MEMINSPECT_ID__stext:
> > +		info->_stext_pa = paddr;
> > +		break;
> > +	case MEMINSPECT_ID__etext:
> > +		info->_etext_pa = paddr;
> > +		break;
> > +	case MEMINSPECT_ID_kallsyms_num_syms:
> > +		info->num_syms = *(__u32 *)e->va;
> > +		break;
> > +	case MEMINSPECT_ID_kallsyms_offsets:
> > +		info->_offsets_pa = paddr;
> > +		break;
> > +	case MEMINSPECT_ID_kallsyms_names:
> > +		info->_names_pa = paddr;
> > +		break;
> > +	case MEMINSPECT_ID_kallsyms_token_table:
> > +		info->_token_table_pa = paddr;
> > +		break;
> > +	case MEMINSPECT_ID_kallsyms_token_index:
> > +		info->_token_index_pa = paddr;
> > +		break;
> > +	case MEMINSPECT_ID_kallsyms_markers:
> > +		info->_markers_pa = paddr;
> > +		break;
> > +	case MEMINSPECT_ID_kallsyms_seqs_of_names:
> > +		info->_seqs_of_names_pa = paddr;
> > +		break;
> > +	case MEMINSPECT_ID_swapper_pg_dir:
> > +		info->swapper_pg_dir_pa = paddr;
> > +		break;
> > +	case MEMINSPECT_ID_init_uts_ns:
> > +		if (!e->va)
> > +			return;
> > +		uts = e->va;
> > +		strscpy(info->last_uts_release, uts->name.release, __NEW_UTS_LEN);
> > +		break;
> > +	default:
> > +		break;
> > +	};
> > +
> > +	update_kernel_all_info(all_info);
> > +}
> > +
> > +static int kinfo_notifier_cb(struct notifier_block *nb,
> > +			     unsigned long code, void *entry)
> > +{
> > +	struct debug_kinfo *kinfo = container_of(nb, struct debug_kinfo, nb);
> > +
> > +	if (code == MEMINSPECT_NOTIFIER_ADD)
> > +		register_kinfo_region(kinfo, entry);
> > +
> > +	return NOTIFY_DONE;
> > +}
> > +
> > +static int debug_kinfo_probe(struct platform_device *pdev)
> > +{
> > +	struct kernel_all_info *all_info;
> > +	struct device *dev = &pdev->dev;
> > +	struct reserved_mem *rmem;
> > +	struct debug_kinfo *kinfo;
> > +	struct kernel_info *info;
> > +
> > +	rmem = of_reserved_mem_lookup(dev->of_node);
> > +	if (!rmem)
> > +		return dev_err_probe(dev, -ENODEV, "no such reserved mem of node name %s\n",
> > +			      dev->of_node->name);
> > +
> > +	/* Need to wait for reserved memory to be mapped */
> > +	if (!rmem->priv)
> > +		return -EPROBE_DEFER;
> > +
> > +	if (!rmem->base || !rmem->size)
> > +		dev_err_probe(dev, -EINVAL, "unexpected reserved memory\n");
> > +
> > +	if (rmem->size < sizeof(struct kernel_all_info))
> > +		dev_err_probe(dev, -EINVAL, "reserved memory size too small\n");
> > +
> > +	kinfo = devm_kzalloc(dev, sizeof(*kinfo), GFP_KERNEL);
> > +	if (!kinfo)
> > +		return -ENOMEM;
> > +
> > +	platform_set_drvdata(pdev, kinfo);
> > +
> > +	kinfo->dev = dev;
> > +	kinfo->all_info_addr = rmem->priv;
> > +	kinfo->all_info_size = rmem->size;
> > +
> > +	all_info = kinfo->all_info_addr;
> > +
> > +	memset(all_info, 0, sizeof(struct kernel_all_info));
> > +	info = &all_info->info;
> > +	info->enabled_all = IS_ENABLED(CONFIG_KALLSYMS_ALL);
> > +	info->enabled_absolute_percpu = IS_ENABLED(CONFIG_KALLSYMS_ABSOLUTE_PERCPU);
> > +	info->enabled_base_relative = IS_ENABLED(CONFIG_KALLSYMS_BASE_RELATIVE);
> > +	info->enabled_cfi_clang = IS_ENABLED(CONFIG_CFI_CLANG);
> > +	info->name_len = KSYM_NAME_LEN;
> > +	info->bit_per_long = BITS_PER_LONG;
> > +	info->module_name_len = MODULE_NAME_LEN;
> > +	info->symbol_len = KSYM_SYMBOL_LEN;
> > +	info->thread_size = THREAD_SIZE;
> > +	info->enabled_modules_tree_lookup = IS_ENABLED(CONFIG_MODULES_TREE_LOOKUP);
> > +	info->mod_mem_offset = offsetof(struct module, mem);
> > +	info->mod_kallsyms_offset = offsetof(struct module, kallsyms);
> > +
> > +	kinfo->nb.notifier_call = kinfo_notifier_cb;
> > +
> > +	meminspect_notifier_register(&kinfo->nb);
> > +	meminspect_lock_traverse(kinfo, register_kinfo_region);
> > +
> > +	return 0;
> > +}
> > +
> > +static void debug_kinfo_remove(struct platform_device *pdev)
> > +{
> > +	struct debug_kinfo *kinfo = platform_get_drvdata(pdev);
> > +
> > +	meminspect_notifier_unregister(&kinfo->nb);
> > +}
> > +
> > +static const struct of_device_id debug_kinfo_of_match[] = {
> > +	{ .compatible	= "google,debug-kinfo" },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, debug_kinfo_of_match);
> > +
> > +static struct platform_driver debug_kinfo_driver = {
> > +	.probe = debug_kinfo_probe,
> > +	.remove = debug_kinfo_remove,
> > +	.driver = {
> > +		.name = "debug-kinfo",
> > +		.of_match_table = debug_kinfo_of_match,
> > +	},
> > +};
> > +module_platform_driver(debug_kinfo_driver);
> > +
> > +MODULE_AUTHOR("Eugen Hristev <eugen.hristev@linaro.org>");
> > +MODULE_AUTHOR("Jone Chou <jonechou@google.com>");
> > +MODULE_DESCRIPTION("meminspect Kinfo Driver");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.53.0
> >

-- 
-Mukesh Ojha
