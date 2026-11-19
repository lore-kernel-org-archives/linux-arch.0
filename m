Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795066636;
	b=01tAnODU1cYt5bPOe9Fg68WSvaqV1jlX4tAWJ0KEF9CEeWKEm5akX0wTet7ZieVp8jSm
	 GZ3746Oo1/Yh09jZwAmGTOuwWE04ASvI/qFg25Co6LbIPVSBkrcbUDoFmMoGNZuG+Ufc6
	 yWRoWFzuEdCDrQ3xz+bSabRMNd0TNg2iPYrDIl4pziHUBfHEZdol7dWGc6sosbsDtmr33
	 mm6YTxNKVv2VPHME6M9lO6VnIhjs7YhztdKLgrjCa/X9IeZIf4QoHPbdYul36yK+6KBhp
	 26A2tuZvVpnryMBC/8W507VGVL0ooer0WgQYIxe2Wf1dSq9qWP2jXZ85iMtUTUrUN/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795066636;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=kXuNtSAmr+Pqww7RppGgLBQmvifOl6Hq2LhWjIe71V8=;
	b=U9ncI5M70a6vR6ZTTkkHtHuLgqO0ufg8q8DPcGfK3SY45V2F7ufp4YIlonknDn2P76F/
	 7PP7+uhcDbPRt6SA6iuQj1JY368wXVC42R3WeNzxS2wpxRxJO6wuF6J+08A2xPN6bhfKH
	 x1yI9QPPKhumVoNc8U1JzypdyKw0MXU7AM6IEHZOKl0LnXybiVed4GHRwCl9+XU3HBSUK
	 BX1beDwUnHuxHvSZx0MlvYsEi/iktlQZTBn938WavvP7Te2SVhKKyJ6LDUohZg4J3ZElK
	 Eh95yf4pMJAdXtHXEd/EXjLs5BqjNpYI7JA5kNuuIwW60SVpxRm4QGeYEyGQqSfdxoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aJYwbou9;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="J/KLzxqT";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DB8606B424
	for <linux-arch@vger.kernel.org>; Thu, 19 Nov 2026 05:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12DB8606B424
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aJYwbou9;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J/KLzxqT
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ1BArh786470
	for <linux-arch@vger.kernel.org>; Thu, 19 Nov 2026 05:37:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kXuNtSAmr+Pqww7RppGgLBQmvifOl6Hq2LhWjIe71V8=; b=aJYwbou9o1/UPQ+J
	xkqhiHpIVeQUOiIk8ldF4poGvECw3lXj8r9Phir65vm5e/5s++idTxpRfJFjNPPE
	JEURtN29gzHQNQSASetnPP1GfW/c5f5xuPBRn3nXC8zwPBdBqHllTn55yuy8bBOH
	o69+Ijt5lDp4KZkFRyKcqCDHg3bu3isHex+QxRAjVhg0RSTYwaGUNX4YXItzEQQ5
	RxHGVC1yC0w0HlalEl0DIshJh2bS8iHnrIu0DStpbTRkWTyTQD8oj94JkISWYwe+
	UUGEImr4TVf346/fMp1HvqxG+yV6kfDqOSbt6OQ9dnJf29ao25POkNoCBnCfDmOZ
	lCXhDA==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1dpcbfnp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Thu, 19 Nov 2026 05:37:15 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-862bdb93612so823634a34.1
        for <linux-arch@vger.kernel.org>; Wed, 18 Nov 2026 21:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795066634; x=1795671434; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kXuNtSAmr+Pqww7RppGgLBQmvifOl6Hq2LhWjIe71V8=;
        b=J/KLzxqTtKKC9dfdoYpsG2B5lkevynJHLm/RxhCS6ZIjfxDUurJaCtvRQTj07HFlJP
         6vNiwPccUp0yyzxqXjpfE8xeOyIce0HhZUvETnqze+goYnNYgvXtFBXD+cZcSidHxc0Z
         M1vdzotkiExILkZY8OyKILXnn0C/QYPpEdyEHhMxbQCD2FjTEx+uTR3tBhIiRf97YHcd
         6sIYOPVsZSCNhkHzNVPQh3R8guuLiQcnr8w6vaomELtF7uDdvusgteaSqnebG0Bs7B+V
         D0BhrS/NackusrfLBcMo9A9wpGnZkYV4GQSWWvbJ+P4eXHPkAkkjWaWEvyI6FpCGorKR
         s0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795066634; x=1795671434;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kXuNtSAmr+Pqww7RppGgLBQmvifOl6Hq2LhWjIe71V8=;
        b=r92sdN1BCilMLgA+H7UQUF9Z7AKdYkBdmdiAqdwCzXhiGVydfMinba3X0ENtG8/spK
         VDcg9r3qrYZwwrTDqyPzr5xkKof47DkS962sMlw3Pu96wvzOH2S62CW+4VY2xrD76scn
         yImavusQVTzRhAMZU533o4TyP3MMARoaHprh/B2WDvf8RCSvnNppgfvZSSmOi/uDndIL
         wrvSBWGNqy83zGbMI4Py058lu3abrjHWYX0M1faR4lr432bIwjmu9r/JCpN3uYWUjerY
         HtWcjcviBK9hhBOEpKrWNm5bHEG0BeIeHZsV7KnxmWCw1oJhsfHItIhxWwGPEBaIySGY
         Mnpg==
X-Forwarded-Encrypted: i=1; AL+hErGEF4LuLZWo5Ux7EJcQJoVXuxMH/oR2cFhRUXrFRITx9LI3LYykwQj160+IwpDQoN5ikLMW2R87YMMA@vger.kernel.org
X-Gm-Message-State: APuU4Z9wDsahdMaonPr1tFQk6SK3w4MQwFQwkADg5L+Z2H6OOIfJyyXO
	cO0TCcgR+w4Ge8+wqZjxPFZqfcN36cSCRGZpMxRxQ5TpcH9P5+9zfgnt938/dckkne7KBh/XhFK
	krcacqzBjcHdHyAvPtVgNUtKZR1TJ+9++lT7WXRYgF3otwZE0e1VZRE6iDN3i/zMo
X-Gm-Gg: AYBFou3wvFXMD879jzmJzeMpuZVIHbf28nLrdh0lhCFoc00BO4Wg2L3GIGmb7GtTZ89
	zpjYc4Q0hlF8Ayu0NEihc9YetE0fq1NGvmC/mwr3CYYKLCgNtUDIm/M9Xa/TlbCv45HAw/27jR/
	cH+QXNFL2luiCXhSo2JkUs7bO4KABrOEHYKv23+hyVMno/GEBpgLAVDiU2D5SH49PCdh9mSbVw1
	KCRlzBlVcp7Pj6ZmtQ1MdGbj4kO4JYB/BtLp4zSaOolTtAmcjjNPU0ybPbLSzUilNVbiPP2vrnR
	whBCKu6ye7k4nff7Ezx/gnyrsIZzJ5VhuGMYMSAl6DihHwQ9sUrq5lrBUyclb56p/MzS9d/uqp9
	B8YTmQAEbj1atgyf/Ipl3Bk2BAA6/fbU3utJRlvR1cu928D8u2K8F+RTFQGJy3dox9Ub1TBTv8L
	uIMyyx7FpzwmjBicIBb+uCzrHGT6GAMVAy4/vg4PtvPp9Rcu1hTrsg
X-Received: by 2002:a05:6830:2543:b0:862:cac9:8ed5 with SMTP id 46e09a7af769-86308fe3689mr56290a34.2.1795066634392;
        Wed, 18 Nov 2026 21:37:14 -0800 (PST)
X-Received: by 2002:a05:6830:2543:b0:862:cac9:8ed5 with SMTP id 46e09a7af769-86308fe3689mr56276a34.2.1795066633920;
        Wed, 18 Nov 2026 21:37:13 -0800 (PST)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net. [104.54.226.75])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862f0138042sm3494162a34.2.2026.11.18.21.37.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 21:37:13 -0800 (PST)
Message-ID: <7b19010e-54e7-418d-9fdd-bcab69d8a885@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 23:37:07 -0600
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hexagon: bitops: use the compiler builtins for ffs(),
 fls() and ffz()
To: Tzu-Ching Yang <shingekinocore@gmail.com>, Yury Norov
 <ynorov@nvidia.com>,
        Brian Cain <bcain@kernel.org>
Cc: linux-hexagon@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20261117054939.2126980-1-shingekinocore@gmail.com>
 <av3-Nf01tdGw62lh@yury> <20261119053249.2098578-1-shingekinocore@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261119053249.2098578-1-shingekinocore@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YJ0KWhGx c=1 sm=1 tr=0 ts=6afe8b0b cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=Ikd4Dj_1AAAA:8 a=G0DxCgSbUnPEjjFRZWsA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAyMiBTYWx0ZWRfXyc0s32KuDpNC
 spvsvsZUD+1ccoohEaYlUBvUO1GUQm0lVamXSgbOaWwPJL0i+SFUXeJxkNv8/+HVN/sCDrc4Gny
 hM+r5pOZJZqmw9jtpf4zkPwg+z/06TxH5iYmZXcRDpZl5cakDWTu9OgSRew/vjPXpQ/6Hr3goMm
 VfCbkgHvKyna4yXpi/GcrLUZfgZEXPX63/N3QrDOuTb1BxL6lNv0q1I0/FTL+rMPUGO55PTm8J4
 gR1rq/RefZWnC23pFVIsQkqj7kD4VBcJCEwxxZ3txuFabopzQrdk9nNGYghCUJFvoA+XTgse+T5
 um4t35lO8F904bAib4ilnbWAznbxVenv7UY62yG5YoByPEiXMqObPNWsQZadD5ekveveZVwDx4w
 ikK4L4XhgrqHpwTQESMsm3ZEXzpIp/nnM8yYcJpal8IbzoSYKKepcGiGrIqyvna4x/1fYR4zO2I
 zyRvcy4s55brqrStV9w==
X-Proofpoint-ORIG-GUID: 0nK6kCCeIvaVgGNLy09Tyf1RW1-WPLwr
X-Proofpoint-GUID: 0nK6kCCeIvaVgGNLy09Tyf1RW1-WPLwr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAyMiBTYWx0ZWRfX5RaTnkLmFKe0
 Zx4B9jwSKBZzKl/sDDlonKqQYEIAHvvDtBp7Iiv7acujhHSQSCOA5w+c37jliGCWsofg871NR+/
 yrd142JuL3bli6JOkl2KaMZ3pWf7rk4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190022


On 11/18/2026 11:32 PM, Tzu-Ching Yang wrote:
> On Wed, Nov 18, 2026 at 02:36:21PM -0500, Yury Norov wrote:
>> Reviewed-by: Yury Norov <ynorov@nvidia.com>
>>
>> Would you like me to move it with the other bitops material, or leave
>> it to Brian?
> Thanks for the review.
>
> Either way is fine with me. If Brian has no objection, please take it
> with the other bitops patches.
>
> Brian, would that be OK with you?

Sure - sounds good to me.

>
> Thanks,
> Tzu-Ching
