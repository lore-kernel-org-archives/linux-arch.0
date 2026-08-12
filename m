Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BB83E7621
	for <linux-arch@vger.kernel.org>; Wed, 12 Aug 2026 08:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786523540; cv=none; b=gCXb2XSsPTKg7e2t0oBBu7mHo7JbZm17FF/+VTbJtH/hIEpZVUkY32LvvWvGGQEGlO+mGAFfvnML7Vpghr/9xlA2AkQiaOAfq1gKITR852hM/7DMdyP6wcdbQMjTFVAZXlKjLZmJB2n16QRi8LA3VgKTlH0LcSf7N6i5pscc0JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786523540; c=relaxed/simple;
	bh=A3S1d4xkoEt+tF6cKjXmjHZ/NIiDjyfZkhSRsMbL/Aw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KYMGT0PeHUcCN0Atmk5UgZUK/bLzDOwOPcH57+aUGW74m1v0ixcRBQpSGh8CNA+/YlUkggELqyglhmf3ggahNP7QNBc+JRBm883NMmiSsWNL9G3OVI3blNy/WOG7fD5jdf7gxTWwKhtTmNDTjP/EKWbGiO47P+Xzqm0PQopsFTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b8C9Yqg8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XKCWcWoI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b8C9Yqg8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XKCWcWoI"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C62aEU2948814
	for <linux-arch@vger.kernel.org>; Wed, 12 Aug 2026 08:32:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F/8vPlq+lDaVRVyYzxnX3ia03ZkqYeEvpa9DaYQHgPY=; b=b8C9Yqg8Zv7ud594
	nLhBjn3LD0R2IFoZBphwr8fNk+G3TqgTAuGQRrLfP3UKNc+w9ecbVuIvfdwhgDUx
	MskA2v+orWOZkzQQc5qbsAoL2X/1Ibgu17Rsz0bi7WmtOCjmGpoHHovoyRSvSfgt
	jTafQSFR/yRRt4vo9apKANAlKhmbFAiqH887KCdB6o9SoZf546OmI7m6fYiyPZ7a
	WFCs785nwPsjy22clIkMH1I7BhQxrJiWr554cT8F+65SPndBCqt7Pm1r4Vwg1hhN
	7Ok9ydvCxHueLfYe96jQOcXPNTpqbrv4HLjZXsYIp38gQ6bCWQ2W0o9Ba55y0NMc
	SmZw1g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0hj2rxdr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Wed, 12 Aug 2026 08:32:16 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52cd0374265so13472691cf.1
        for <linux-arch@vger.kernel.org>; Wed, 12 Aug 2026 01:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786523536; x=1787128336; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F/8vPlq+lDaVRVyYzxnX3ia03ZkqYeEvpa9DaYQHgPY=;
        b=XKCWcWoIWoUejmddKjrQnHFexvKnamaGLQsF6kCfiDcz2hBDQcVU8zhQu1CYEkKlRT
         ctT5DttlZJLH1T5JQsEFMJodzZhr0nRCfFIC0RUECNM3jTUS8vO92FISWtZJ04qlDH1x
         pXzZNa/AgU1HbsTkROpnjJObGmxzH5an8fAhqZSQNyNcRJq6PAGyY49Gj8MxoNIjJUzz
         pdUCPruUQ7rvlsdUceLnHnK+RcB/3SIqtPHFkyBjYvCit0d7+0FiUORxhfNFd4FKYM+0
         gk5W8iDglP7TolyEte7NBJCiJiLnhYD9bMjFVNf3pnJmPAOjU6FhpnTLoR3m8KXLmJSV
         O9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786523536; x=1787128336;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F/8vPlq+lDaVRVyYzxnX3ia03ZkqYeEvpa9DaYQHgPY=;
        b=sRVStwvsmnX7pIgr40WoYVfx5Czs//JLY054VeGno5UBFRc7KOEKly6Eh5FKc08FYC
         wKdsgrGavuzIxysrYy5obX3DLCqrAzQRM62C9l6JLqfi3NESC2q/Evfl+1FSkdTysv8m
         YdwWkNI7ya9mQ8AC4Jz3jmXOicVEa0qgHQOaYIYAF3wllSdmq7gj0WeNOxeWLW5LX3gc
         4vwMNnKCEO/wAgKZI0D3HdYK/CfRv/lVgkVtoOAWA4iODQPi/l1UQwijz37LaGZSz/cb
         p+MHtjJVuWKLpqUQIv1IZZSYyLOpYAyActvLIOhnUll4R50KFvVV8WAJZHl+2FKpJC0a
         QxaQ==
X-Gm-Message-State: AOJu0YwfGVldKQbpeejCagA9dgjvRwFj/yoioWuF8OM6Xf98wHGkXKfw
	CsubrJDoNJgB4K/v2OkkELJbG114+0OML5rYO0kXfAy39sc1nfOYOO2zAupARqcmoWniffYmUKr
	FM1f7pzkFz7Sd+y4pTqISbdp0T1SDtP3T7PdCBP8zJPe+U4tCi2svkpyB518Ei5oU
X-Gm-Gg: AR+sD13+6WDaPgCmsmmszfspDI65zsovlxd01UTvR2j10DWyJzS9Hj8bbqThGfDJpQM
	B1B6zgVn4DDQALy1sDjINVI2nIYWSICS4xp7edSrp2F5cErsgnf0Ih/QIO7CAQM0m2wulM0fOwn
	v+NQLk7VdbBtXzT6b2odgs6xyT+DRTn4TGagnMVu3uA7Ki4yzNt4vIPFWcLKoPypjBqC2GfntPp
	snL3ktvq3k6u8UwQMLqSFQTqH1f0OUxPXEG9kemx8QXHgIuU1Ll0WFBiGTn49x+KOWkqYJCqOjp
	n2NX+NIr4e1QmQuDf9qhMksOSTGoBGwxes9UyIWk5Xkpl38o1g14UCuHVg/7CabXBULflwonFKn
	zx0uGlc0P4HRd7t69lOC5r8ZLlnBEdgf7hU6Kah6k7cUtALqe1MrV2c73YKpeedA=
X-Received: by 2002:a05:622a:6082:b0:51c:1ff:2512 with SMTP id d75a77b69052e-52d6482da1fmr25847581cf.33.1786523536350;
        Wed, 12 Aug 2026 01:32:16 -0700 (PDT)
X-Received: by 2002:a05:622a:6082:b0:51c:1ff:2512 with SMTP id d75a77b69052e-52d6482da1fmr25847101cf.33.1786523535827;
        Wed, 12 Aug 2026 01:32:15 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b467:f322:cd3a:615c? ([2a05:6e02:1041:c10:b467:f322:cd3a:615c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997d2e4ce5sm9693755e9.0.2026.08.12.01.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 01:32:14 -0700 (PDT)
Message-ID: <c70e9011-26e5-46b6-aa1f-c7f0c179611c@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 10:32:11 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] clocksource/drivers/mips-gic-timer: Remove
 CONFIG_GENERIC_GETTIMEOFDAY ifdeffery
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
        loongarch@lists.linux.dev
References: <20260724-vdso-arch-clockmodes-v4-0-ddbe447be860@linutronix.de>
 <20260724-vdso-arch-clockmodes-v4-4-ddbe447be860@linutronix.de>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260724-vdso-arch-clockmodes-v4-4-ddbe447be860@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=a8EAM0SF c=1 sm=1 tr=0 ts=6a7c2f90 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=dVVT6RvzqqZ4HvZtmZwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=VT0m5QDJU3gA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: tDbauMnf4Itw7Izw9V25nQWI8nIKyOdp
X-Proofpoint-GUID: tDbauMnf4Itw7Izw9V25nQWI8nIKyOdp
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA2NyBTYWx0ZWRfX5JiKWnm14ype
 LeRnkER+EquCuNGMDrcSnjpfjeZpAu2anCuQFZrhp1UCqg4Yd7mBzqioi5H2nXURpamozs7Bl8U
 7UHJlf5X+IIv2eoD3VgHs5pphHR7X7s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA2NyBTYWx0ZWRfXxpMN/ZpW/kW4
 GaEUU38AjkzBOEL/eI1aeFflMBo02balhwcar7su/T4dHq3edR/C6azJOXEWDQ0aSxUk7oOoY+q
 7aMFirX+ePk/991pCudnBBptLoFqnjq/PLXiNEff+ERneZ97J/9YeJuceT9E2yeTj55dU1NVR4D
 LOj5CaBIKR/KMRAni9Gsvf+3g01JeXT5IA82vrIwgBey+LOsFeOHjE+XSOOCRuWL8tEp138vyWk
 dI4PbCDPtlUhEsXvvJPv1sIjFcLtXyTGA2Wj00nasgyWjwkNEBc1JUNO/AkQkGh5sQ00leEhhl/
 wlWJ1KGf9miAcnG+t6Pz9eSp3kvw7hiHhAZIxYbbVvVRY+81WnvEUqW7Pk1ObwvAKxqBgjNbPwv
 +2UetiZaYreRinjVUaWxn8Ezw0vnO9U3jyoOJAyw/86cpNZU8HaXiOzqXPHh5LHBJ6NsVnrjmg/
 zJz/n5eM6d0lL+apy2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120067

On 7/24/26 15:36, Thomas Weißschuh wrote:
> Now that there is a definition of VDSO_CLOCKMODE_GIC even if no
> vDSO is built, the ugly ifdeffery can be removed.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

Acked-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>

