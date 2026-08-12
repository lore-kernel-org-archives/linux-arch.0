Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C386C3C1083
	for <linux-arch@vger.kernel.org>; Wed, 12 Aug 2026 08:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786523576; cv=none; b=lvc9KEBJHZbSB1/OZsC9Z9qLaf0LTXGhm++6ja6hLwodb+ypYAEVq3WLSNezl56y1iQnIJwmL6EmMYYPZJHahptlL1I8+dqQidYW+ZHdQEGpsGMeaN+gvLDlfOdVwa4RsNnwD4TFNTKDFlnwGeGK+eLsRz0VMiCBvk2B29Yw9eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786523576; c=relaxed/simple;
	bh=cEKiSBw2QbvrcAeKiJosKgJ2MZ1tbNUAgE61HVjHyJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pbAJMS/1gsdVUvk4DOvLJdS+xUuirJY4RCmk/miSvSeAi3wGFfP9SFCU72Yy7hXar61kwO1fiODY71Cfq47M0NU1NSsJcW2tgOFYQTsGDWCOKWEBu7TUKXngulks5PQnzZcOo9x3lFxmalyBqUA+tOBUgs/00ELh5tpmBWTFlAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CkDL8DAQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EGpUxKQT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CkDL8DAQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EGpUxKQT"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C62ZrC2948765
	for <linux-arch@vger.kernel.org>; Wed, 12 Aug 2026 08:32:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AFIM07BsWUmRXowFn9qQEjJQwSE915UpKVvsGJRFiu0=; b=CkDL8DAQ7U5HJ5gu
	1wiZk6P3XYhm6d4d9Pl6AKoAm0ojpYY6+9yiDJZDagzLZQTj16HDJomqpc5v54hm
	GjSEyRKSdQVk2j9FpqyOAoeTrOP+p+wWdbUdRWU/yYx0PWT8D8Et1aCgK4asxrLu
	BUA0QVwgeHqElbgMD6ra5qsvjO5su8wj1OYt0H/jivqkQ2lv9ithdF1oBONgCcid
	f1xHlOKmxkuRrcEQW+w3H5tgD3Dj6/hJFlo1HgELfglRLWrUSkx5BHrqFLUnHTIe
	s6AnqvpNyLsUsHayG1koazsaHDRh1sv/8JPb3KIjgGv77U1cYm15NtMwmv6XYC1y
	Ee1l7A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0hj2rxgr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Wed, 12 Aug 2026 08:32:53 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c01ff996dso10744391cf.2
        for <linux-arch@vger.kernel.org>; Wed, 12 Aug 2026 01:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786523567; x=1787128367; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AFIM07BsWUmRXowFn9qQEjJQwSE915UpKVvsGJRFiu0=;
        b=EGpUxKQTTpiQozoVMlPIBlmbkNSBOTkQsqU2EWTnhO8CvZNLLcRejMwSj/02G6Brqy
         wfzxRRfnOjSn3p39u8Lvt+zdYZugxV7PFiD5uSTUsR5+FzWx4geCXfDIngGHIaJo+u1x
         bxuXWkzitaqgyWB/HHF3dnccHNcsWnWOvpbJX4k0OwWUAu8fW/la87pAjmZQmPg2l7/E
         r1LTs1Nq+PcJgLoKDz3eCk33nB8eGiNzGQQo2qrjTrGqNcKbA+yCwlT9ql8i3AURGMRe
         fWj2K9FkmfR9gJYcFIjx+DD85g3+pVGPQ0TnWl5er1AmDLUg2mOlCmqF9mRiH6hUQCIl
         vGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786523567; x=1787128367;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AFIM07BsWUmRXowFn9qQEjJQwSE915UpKVvsGJRFiu0=;
        b=aaE+/V4h6gavZOzwLlhcEdUvCE0/JGiVaaopziXSTsGbj13AysotSh9qjXvatpGO3h
         Kg7jfp4yrBOpZZiATBIB02538Iub07U6lgJpr/zD8gJ7A0bwimNj5CfWxre5rr/FWmhy
         VCXoe2nBKcVUx6Bk8c9KDtLekIGErNaARmA3/dfCIcDrrM09Kdmlpi7xcqIhRKf5de23
         Je2NMp9MNoKYNsfnGAOPbCC9Axy9aXz6U41lTOZybY9KCoasKUJNbokI5LZF95yJwkao
         JC0z9BCrt9uXOuwFc+8VzWGSVXT4fbf5a7C3HZAZEH+owKVGfywLMQ+11OnbZ+2aphn0
         Mgow==
X-Gm-Message-State: AOJu0YxU2JOB8reoDyKP85SgSSObX87yRevuA4PnK9MZj7Fqb9SC8P1j
	1ETwerhLr6TbFCkKvkPtueWngmeSmEJNnodjpq2i+jr2z6SA1a1J5o95IviJpCDE3AvOFrKoS0B
	x8iQFvXstOza4pN6Lj/aQpXm+7VzCcM36OEqxf717nVIhRDntjUlKlt2/qnwKW5U+
X-Gm-Gg: AR+sD1058uvPucyK7iq+oz4BoEbNyAvtn3/N284GmeUcfXPGKDFZqDMn4h6fZIaj+5U
	rtMO08lcXkzCdGmHT4xBLRNv/VPjirYnGvsoSzERnFrZr5szpQOjQ6Pz8x7TY0g2gWLNIhJIOt2
	UN3QNTfMjAoJYEBeo9QQkPlb/bdmjzy7U0+IMNq89GoxVnF2dPlAMGloeGDHDZi4isJJuL6FiJs
	IImh1DB6v8ht2fr0/u8L0D/jylaveryXMkTM+6YAX5AO4dVpnIPC9Lq20+YblvWhjjUMqkf7Es/
	MTD+Ge8VwBS8hg3v0dA3OW1gYYcXAtrHNLog/lcsDz9pyFYFRDiBgYvTgBmSCDWwYpOgpVGvlq5
	wkSK15aKhrQBFdDP65d7TcyylenJhUbSJMmpdFKKBlV5+qj2QkgCtOgKqKpNi+CY=
X-Received: by 2002:a05:622a:4d91:b0:51c:1d18:2fe9 with SMTP id d75a77b69052e-52d6469cf4amr25908991cf.5.1786523567373;
        Wed, 12 Aug 2026 01:32:47 -0700 (PDT)
X-Received: by 2002:a05:622a:4d91:b0:51c:1d18:2fe9 with SMTP id d75a77b69052e-52d6469cf4amr25908681cf.5.1786523567010;
        Wed, 12 Aug 2026 01:32:47 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b467:f322:cd3a:615c? ([2a05:6e02:1041:c10:b467:f322:cd3a:615c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997c8fa1c7sm47131155e9.0.2026.08.12.01.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 01:32:46 -0700 (PDT)
Message-ID: <447b83e2-5bd0-4b7b-ba4d-61a0fe400195@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 10:32:45 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] clocksource/drivers/arm_arch_timer: Remove
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
 <20260724-vdso-arch-clockmodes-v4-5-ddbe447be860@linutronix.de>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260724-vdso-arch-clockmodes-v4-5-ddbe447be860@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=a8EAM0SF c=1 sm=1 tr=0 ts=6a7c2fb5 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=eCx_7nzpRrifSLxMv2oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: Jq_3tFqIQpRn-EWRT-Jz_pu6q_O0E06a
X-Proofpoint-GUID: Jq_3tFqIQpRn-EWRT-Jz_pu6q_O0E06a
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA2NyBTYWx0ZWRfX3mHN3D3Hirux
 u1GrpRkw/dT+F4CZNPGWmqmGb8YNONaFPxGctvy09yP/JN3C8hNQcgBGUpwxCKnlyy2cCmpV63D
 E8YtDamVzjo3UJQLo1KMZgucBJkEjz4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA2NyBTYWx0ZWRfX9vG8XQEsXQwc
 kh57iTEWq5pi84fPxlUofCFlvSFuKizVYV+/PWxb2ros8wOth1aGj5t/kCxxoodqFLJNGBfbMn4
 /zZ51VZ6D9j63POS6ZMHnhKvs5TkZWTYoMm0Qi6ceS/byi2ITvfBNPQ55kAwvNhxv5v3aBRfiQn
 9FajIe8nAjUxqiaWLWA7mRL0liQ+5lhjt543pN+NfAwYoSz7DnfFrSrrPhWBfaCKmPpNNTPmR/5
 JX1rMttxcDmDfyQiTmzrKDSaACwDqjkZaQvIBJmRKlgFgfdkQ9+yBnAy2KLolXRIQ3YDNp8Sn4K
 COMe/sZ673+3nv9A4a09w73g1J9iYoCUMww6mm8kog0xaRcbA52G0fBV0G3k92l/D971LXAjKHS
 hVUQj0SZA2jYHIi8WN+YobCTPvMgJNU+21kMrDweSl2vM6NgHh8031sdCO89yXq5nE7/c++R11q
 9gL1iuIClGqq81RLb/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120067

On 7/24/26 15:36, Thomas Weißschuh wrote:
> Now that there is a definition of VDSO_CLOCKMODE_ARCHTIMER
> even if no vDSO is built, the ugly ifdeffery can be removed.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> Acked-by: Marc Zyngier <maz@kernel.org>
> ---
Acked-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
