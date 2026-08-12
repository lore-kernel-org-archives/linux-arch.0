Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458463E95B1
	for <linux-arch@vger.kernel.org>; Wed, 12 Aug 2026 08:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786523599; cv=none; b=XJqk/ea0otoG7OhLZeoYcF0Pk4gejmuCb6cITnSZ+xtaeoi1FKR+SQzFix908nOxLFqLY4bH84HIltG/Ej5B0WRxhP8VU52clq/YBz1kI6p9fBuYKzBxpETta6QEgWtoYwXP6KKf+lkTijisWwR2R8hSG2YwkDrwkFdmSdVsItA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786523599; c=relaxed/simple;
	bh=AfnvPvByM7NhMG46kRUkDxivAFcGgmGj9xeqW0owLps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IDj8BTckoEHCDMGLEdPCQnWc2NyfLn+jnnhcBqONOIX7cUcC7c2/cmZJDjG72/K1RDtM3qsccLbAUTJ4CXO44Igh5Y+91zaPXHiFCnvXcTQ/9gil4dvV7cVilDZKRAUO1tBMWE/QAm+Zddz7Y9TliV1IKDNXp7v0OeGikzoZSPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CMi+xbV8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gGye7pGk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CMi+xbV8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gGye7pGk"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C62SEN2641636
	for <linux-arch@vger.kernel.org>; Wed, 12 Aug 2026 08:33:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HAvLO0GLp2loAsKy0xyKwG5aLfgTFlT7QknME37DmoA=; b=CMi+xbV8rlZ997l6
	8ymfyCRnjTVDNYMTFbQHDvUOjeReWM0cMy1Nw29jxh6/EDU8FzIYaqrlwgV6Dugn
	Th7xAreT9RbRpZiaZNk+Ysied6XpVbJFURZv2SgQTM/+JG5tUZWc3Lr/c4Vf7A5d
	l6jMNpk5fMu0/wKwGbZkUeDeUixWNfMRkRazXLD0J8FxCUGrAjjVIhnO7GBU5dQD
	bvumQhfhc1mO+doLBf+WbbcnepCS6H5Ic6uwaJaHFNlixse9tH3RAXjawBbJR5fQ
	hO6a5Chx7vTh8a3CJdlOdTlrQnchK70Mpj7t7/gHEA8jL3rmO0tDthA+ANAZEa6T
	OdEjbw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049mm86w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Wed, 12 Aug 2026 08:33:16 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5174a23afcbso9745431cf.3
        for <linux-arch@vger.kernel.org>; Wed, 12 Aug 2026 01:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786523596; x=1787128396; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HAvLO0GLp2loAsKy0xyKwG5aLfgTFlT7QknME37DmoA=;
        b=gGye7pGk/uSd/fTCybtmLPEIQ4Njj5JUVw5hzOu//ZxoMLTaslt6r3EpfAeKrk7TSQ
         QvsHR6jrJYE4P/nTcBjddr5Zh4C1cyfe2rYvQiCE3VhotXQEoE2GQvFDOcK/0PvitBkr
         Z8cIUDiKa4hNjAWu+zFJHRHQifzvelnOeTrBK5zwcziBvXB/hJ1VigzoMHfwrWOQMoo3
         WqNkM1hW2ZzK/9Jk8xvYfN9+0o5zr0tVn7ABz+RoNMd+D+KTmXm6m1WkPdSCmAnglE5P
         WcNEshf0h/tp5WpYlg81kISjvUaOb5XUuczMXEk56THuO4JPp4UWUkazq+GoeuIQ10Gj
         451A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786523596; x=1787128396;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HAvLO0GLp2loAsKy0xyKwG5aLfgTFlT7QknME37DmoA=;
        b=m+ttHnRTt/gMGC8nCc60/iMXats3DxXm0jK2eHULn5Y18G9FeL1HzU3HXqt8WBmTf1
         csFaypUpTkADI6WJxmz0unouvQT6p0fXlov+o5sNYm/MqBic14O7NMN7XC8qtU1HsCJo
         wOSJNRCPF1No6V/AFpEtxafxXrwftBWejF1cRg56E6rEd9DaBSNqv777CmGjUD151ahy
         /H8p4OppEVVnIN1lasvAJkOl4EJCpNyIcbr3nXwiCLBboP91qpSAl3FFyXe2ig7p8685
         d8rM18Gl7DjSI4/mX1QG6/X9gP1iJgAU61p8PrKt4GEKBOIt0B1e+v3rjPdPDsw5EwAl
         UsLg==
X-Gm-Message-State: AOJu0YzLx+eUnTZfGivoExfjgojnbxUjJFrCueY04Ori9B+fpHWKFLo8
	ESoQ6XFFw/VAtoygFLlihDoeM1bbAPXdSalmhLXFZ2YgiMsyxcSjkZkWW+DQ7FSb9/iTYurYVxj
	X3aAIwEbF4SGFdNUjKx4iCG86/OflQ17FpQcaibLIRWOYwSmUzMYFN8TSY857YG2j
X-Gm-Gg: AR+sD12/eLPly4N+5/1QAcVdIgy0RwsxdYWj4AlQm/zMVn/gW3Wm8L3t3ysM93EmEq6
	ENtgo5Su1LLQHDxPFxjhUfIcIaMeycJnFj5lk1sd0hCuVyM/ly5p/lrcTpu67ha4QgQAmJ6KEQu
	ACKMMRGyRfuwEDu+jJyp8zt0oCc4GSwndDAJqzrC21zMxhclfepk4hnLJslKEZHhse9wy5DjUgZ
	9pJissCPFL3LvhutsIQbAqgrL18lxG08wsvOSrYPKYpPdS0QcoH6sMA2oKM9yNaaMYwJJ5Md6PV
	7AuzkfjAdRRKJMuOwG7UczuKAcHQ2FVPzdgMkwOiH3wy3oTwUIP9RyFBk1vCbuS0P5iAbCrolAR
	SVoQoN1RxCMjqWNfCK9c90G9Xui87qOdDBRPYveERRlPoASPAaK4C+mpaeMxk3OY=
X-Received: by 2002:ac8:5d16:0:b0:517:76b7:7b3e with SMTP id d75a77b69052e-52d64823701mr25115301cf.38.1786523596198;
        Wed, 12 Aug 2026 01:33:16 -0700 (PDT)
X-Received: by 2002:ac8:5d16:0:b0:517:76b7:7b3e with SMTP id d75a77b69052e-52d64823701mr25115061cf.38.1786523595799;
        Wed, 12 Aug 2026 01:33:15 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b467:f322:cd3a:615c? ([2a05:6e02:1041:c10:b467:f322:cd3a:615c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997c998f27sm28031395e9.15.2026.08.12.01.33.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 01:33:15 -0700 (PDT)
Message-ID: <16d3f0b9-2a12-42d0-93b6-b9da3f540256@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 10:33:14 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] clocksource/drivers/timer-riscv: Remove
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
 <20260724-vdso-arch-clockmodes-v4-6-ddbe447be860@linutronix.de>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260724-vdso-arch-clockmodes-v4-6-ddbe447be860@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Fqh3hZ6jS3luIm-PEKRGvMRQtlNRdq7v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA2NyBTYWx0ZWRfX6usQ5+DOvAlA
 XKjuBMsuHrGE94j5/j5c39ShFQhFukxGUbCYvvdun9mqZccLy/MnzjIULJ7sxIp7Hfr8VWcDhqA
 KRkPKO/hNf1L1n0PUpOkeSsWAQcSTpmRnsXgaYWsyp9gAq3/A8jCi+IxHTpe+U1L5Hipmy5p23f
 cF/Z/Nh+Lplt+OG5HoZPZmBz40gicLogSc31rmMAs8zh4bVvwHuX/u0onHtNZKtB8/gcdHoQmrJ
 PzTkMl45MWVWk0m2rUHNOg6HIlPOSq+WyDvDa4/rgmVX6HzNPoUBak06K75FIZ+NnOShYwr+AwQ
 l/r+T/WJpQ73NvzuoZSL92fA2P7ezbkMKakAbAXu20GvVESbI0OxU8SN8NW9lEvu+Sm/2L2Onzh
 b5hk/+LMA99O0dGByBfBPsr6+JX29qi2BjDK5XTiWFNxWNL5yD2Wcaeu0I2SU+XVYAuCpwiqWp7
 3EYNCymghkwsxPOewXw==
X-Proofpoint-ORIG-GUID: Fqh3hZ6jS3luIm-PEKRGvMRQtlNRdq7v
X-Authority-Analysis: v=2.4 cv=FbkHAp+6 c=1 sm=1 tr=0 ts=6a7c2fcc cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=eCx_7nzpRrifSLxMv2oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=VT0m5QDJU3gA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA2NyBTYWx0ZWRfX4GzsKx6rwFsE
 mPWPdtUyHNOSy8owPcWVdi0Uq3doXhAVXQ31Z1H8EBUTDDPQG5Qtn7pJDlpfcmme56pDKaH6akf
 hAMg+0lp4jzslgsk37XN9h1ewxFrT70=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120067

On 7/24/26 15:36, Thomas Weißschuh wrote:
> Now that there is a definition of VDSO_CLOCKMODE_ARCHTIMER
> even if no vDSO is built, the ugly ifdeffery can be removed.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>

