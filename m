Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453753;
	b=HIA0MWz58DN9araqzjpwJUIgsaE7ky+Cw/Y27UDHTAvHTcHnxvKIGMWjWzN5eT3bayWE
	 MsliMprTz/qJI4IuW/JAi6mYEhwOcbmRR8GQXz1P3QekdWxHzyEHKZdUuAWUBqAzjv1n6
	 sjaMom6yIf7VVE0VSWBSzxS5rIqeE87j2sLpZtzm93xh0E/tkmg/AT/oNEN3bAU2ji84q
	 tZlrQU2bdXiz8f8urMXs/dwYzJCXbX8miDSMZcf2SiXu+mMo2FTG4zNPp2uhwD28Kx3Zj
	 UknMluRDROLIBgSdUgHrE7ZsmxJDWI0jZvclqDfFVLvcWxiKBgbuno5lHpkbYGK/R5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453753;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Nia/3Fejzq/8pwGFpOYXDtAfbAIiNtIbDIVtuujz/Q0=;
	b=Vw9IRd2LGTccgSxMj0IQwPSFG93oTLebV38WDrcVVSWY7GmWV16To2Rr/JvhWInD9OCk
	 pmwBDUPLuxkzxMZIrTQmjvwLEtpDDJRLJPTdrwDw9pDW0yuvwT8/4Q40YO6qx5MEnoid8
	 AHlsik4Ra/zXehK4dbfnNoUDXwZ0ZUjvDej0sN5IjonSdhRy0pemzDdxKGNLm/TmzGjpw
	 C2OvPPTGX4qOYaHDWLEgY0Lu7XGIPAL1aEdR9BP25C9wmrmiPQPuw7wM4NUKGboPVxLpY
	 3CBC5kBSPinUZ0X9BW91Bgff1SKT+4Wlc7fdBTDsAShn8lflMh935CiADiQh5UouNig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LOpIkJFk;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hKJTmD8A;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF87606A330
	for <linux-arch@vger.kernel.org>; Thu, 12 Nov 2026 03:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCF87606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LOpIkJFk;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hKJTmD8A
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2aWIZ1475396
	for <linux-arch@vger.kernel.org>; Thu, 12 Nov 2026 03:22:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Nia/3Fejzq/8pwGFpOYXDtAfbAIiNtIbDIVtuujz/Q0=; b=LOpIkJFk1qcw9dNR
	IGn4sA5UCOtmAyOLiqsLJomBSihf4tRG/wVsCktehqAKlkuNZgtYphQhJjW6Y110
	kTG5YWTTru2Y4kr1/8Qaz2fJNsQUA5m5Ka/oMwTdFZcaTTHwgtDbyWShJX3YM2kD
	EmjFp/er0dKt0SxCLGtWua47LlVvaLI2blykILXXkO3UwS+VXzUWZRxAMyr0kUAL
	D2ZraxIHHVBA5T54djHiEvNFaJ4a29MejhkgHnvgHbDKd2hHf1ktkpCFc9c1JW8w
	HlSYTbk1ggYxW2ytlV2rCexQSaEEvjbUKJ7IAbCnqhsZMIW4j1I8fuadDWk7094Z
	MUoEtQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvtymtdwf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Thu, 12 Nov 2026 03:22:31 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2eaae8d29e0so49239975ad.2
        for <linux-arch@vger.kernel.org>; Wed, 11 Nov 2026 19:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794453751; x=1795058551; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nia/3Fejzq/8pwGFpOYXDtAfbAIiNtIbDIVtuujz/Q0=;
        b=hKJTmD8AodPUvHcOjitGgCh9MoQUuv7i4Kiftg+Dl1qtZatee4EQiQ3M2mNFxjbFL+
         776wuU96k+YfpRD744QkPEcwxnAww5DAY1Lh2ePT/tjGZuX6SG2w1gYDnLr2s6nOqmyk
         I0uMbmJkazlSFIuzLZBcKXGQfu3ltEGGOXJpTCpnQfrd2HLVdlAvHenPy95iOupO8Cmr
         PBn74O6eWXePLV/vTXrEYnI17hJeke+8jI5sVReK0ujhZA1K+rqegR+XOiFlI2eQwar3
         5DtdOoaxLS1534l9Y27q8m4kmb4+70tpKBz0VBi14oPWRXrpoT7VWJUksHzoCkTExHT4
         rzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794453751; x=1795058551;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nia/3Fejzq/8pwGFpOYXDtAfbAIiNtIbDIVtuujz/Q0=;
        b=hM5xenOsKyqHOjDLslqXoiFVUWgqBbM630Z7OJAnmD+cbEmf/KGPwq6xp7HI5tEsYT
         gp21f5j+bg1f6TwW9yO9XPTRS8L7svQcXGavcOCagWRa8ky2XyRa7MFRDVR0g6jq3697
         H91HsdQ8wgUlNadPC79tNB+ZMO4bJEsYh75sQ/XIZaLd4yEEGcSkPRfmyvwjV69Ek0aK
         ln5h5SkyCUHM49MSDl2kdb3w0gxaWeW+2qO+QjVGuK6kAslTtdwSMa/qlZNXUO6cvR8P
         aEzizGjgBFeeEX5Ylm7oUTt83u/hEKouba+EbKDeVZ3yI0GgXkIOrzWqbUKCbf8hvapb
         qJDQ==
X-Forwarded-Encrypted: i=1; AL+hErEppP8uTl4lCVdao/bJxJldZYaBX07VH2aaQKy5aopyIl4syB/ZJFsHX2y1aoPA8BzbOj1aAuSnxNl+@vger.kernel.org
X-Gm-Message-State: APuU4Z/gJpgfrXT6mnlPum5M3eWpXkjf7O8GADQI4EzcyzUKaMk9/T9Y
	d9/U2eMhQRmSyGmaqhzVmCC9z/FMtwSK2qcerIX2zEBpd+TcLfcR5Y5z/mqgJON8Q3v8pQtUYe6
	5XjbQzFUUDeK9SMVRVCjcqJrJ2FtsuEF77H8S5LRB0nOG0SbAjCDEVPziJ9k0uucg
X-Gm-Gg: AYBFou3l0z128w2vmWfc8pikmHjMZdajuu2KcZM7HZujg6+t/Q6e1o1tDfaoHhOFeKA
	ivYW135G7OCyp1SnJ6ZrTsXvqI29GpBmVYLPKhw+toVI27SWaktrSqucBSQ3tvo4h0U+12h/w5y
	ymq56S7QQIo9PpM82AtgWuOJSUYMKH76BPtrTdQp/e4pPf+sZly8ISeRDCsHoqP5tRSOCYFpNMa
	JG2y+596+1ZyXVrWTgUHnYRRM7xhs8aKjXRRYJbT3OsW1oc2I7NrJU5oHP7RV/KnpPgAv7u/XUz
	P7rF91yMcQsAZnPgVzttOonT0c4xaAf1m0uIRGb7u3YNUQUywhmWmV4bFT0dqKUZAOreMHqVeGQ
	PeJpE2TR5mHgGcUAxkZXPrJbO3DWL04VaQbNpCKz8R88KVaAieYS+d+pzvC0JpTPtfc5vPdENjU
	foZz1YSX9c0dwg4qAXoJTTMBJH2TonM88mutzGdTVlWsGeuQ==
X-Received: by 2002:a17:903:2ad0:b0:2e9:58c5:8c68 with SMTP id d9443c01a7336-2edd7acfcd0mr38209265ad.54.1794453750668;
        Wed, 11 Nov 2026 19:22:30 -0800 (PST)
X-Received: by 2002:a17:903:2ad0:b0:2e9:58c5:8c68 with SMTP id d9443c01a7336-2edd7acfcd0mr38208695ad.54.1794453750048;
        Wed, 11 Nov 2026 19:22:30 -0800 (PST)
Received: from [10.133.33.220] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6dfb58dsm26134275ad.66.2026.11.11.19.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 19:22:29 -0800 (PST)
Message-ID: <acd476e0-fb24-4f11-b917-c4e86f86171a@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 11:22:16 +0800
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
Subject: Re: [PATCH 4/7] cpufreq: ondemand: Include <asm/cpu_device_id.h>
 unconditionally
To: Pavel Popov <pavel.e.popov@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin
 <tursulin@ursulin.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Hans de Goede <hansg@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>, Arnd Bergmann <arnd@arndb.de>,
        Len Brown <lenb@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, David Airlie <airlied@gmail.com>,
        Simona Vetter <simona@ffwll.ch>,
        "David S . Miller" <davem@davemloft.net>, x86@kernel.org,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
References: <20261111234821.4814-1-pavel.e.popov@intel.com>
 <20261111234821.4814-5-pavel.e.popov@intel.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20261111234821.4814-5-pavel.e.popov@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: fnZIa0Ddd-lGUpfH0cizJsUEFRBUjGn8
X-Proofpoint-ORIG-GUID: fnZIa0Ddd-lGUpfH0cizJsUEFRBUjGn8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAxMyBTYWx0ZWRfX3m3tZYDhrOk6
 e0AHbMz4K1Vb1pGXo/u3WXfjze3N61yaBk2YZhCf4nMj36b9oAzmCNrG3juKeLCK9KhFwortoRi
 ME3MeVXqc7pcy8fxJL6k6MI4+SkDQE0ZWVuRJnoJUkoB3vweGp1b6UHdU3bHq0RxxdBCr6A2zHM
 gdPAD0wMcU9pC8C9Iw/TdbBebbnN/i/49zR/srHxU41ngRAyGdY4gRtml0sb4+uqhgKWNHLoLGW
 SLBgL5ogKPXIGhoGwumWfqmDkjr0wnUBLbnszOPwMP3HH38Gw/dOT/MNjBlR7bUr4DcRz/UquDr
 Fdo6AtvlW45jf4IZT7cwlGIwvVAsuqss1UC6fHhyQJRXVmXF/da7RCSrPEssdK2GCaWBXykknU1
 w3EtIzsVlek65SoPQphmdGCtf7zu87Dpau+cEj7KO2ptr8VBP6w34Z6XroTz9zh2NXsgNQG7maI
 6f1tQjFjvdhxNGAtOeA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAxMyBTYWx0ZWRfX3abCgObSP1dH
 DXEU8HeKMb/PlqPY8sOo6F5x7ofimuIModMegpdf9fvA+rZOFUQQBm/fT+nvCpDyBCSsT6p0XRr
 dashnwhd+0XTxbGDtYJUP+A/gx/nYiM=
X-Authority-Analysis: v=2.4 cv=Q4BHcI2a c=1 sm=1 tr=0 ts=6af530f7 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=L27Nr_72VT4YvYD4_PkA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 adultscore=0 suspectscore=0 clxscore=1011 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120013

On 11/12/2026 7:48 AM, Pavel Popov wrote:
> <asm/cpu_device_id.h> now has a generic version, so the #ifdef
> CONFIG_X86 around the include is no longer needed.
> 
> od_should_io_be_busy() still needs CONFIG_X86 for boot_cpu_data.
> 
> Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>
> ---
> Depends on <asm-generic/cpu_device_id.h> from [1]; please apply after
> it is in mainline.


Yeah, this patch strictly depends on [1] (series patch 1/3) being in
mainline first; otherwise non-x86 builds break.

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>

> 
> [1] https://lore.kernel.org/r/20261111234439.4098-1-pavel.e.popov@intel.com
> 
>   drivers/cpufreq/cpufreq_ondemand.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_ondemand.h b/drivers/cpufreq/cpufreq_ondemand.h
> index 2ca8f1aaf2e..0e33865f9d3 100644
> --- a/drivers/cpufreq/cpufreq_ondemand.h
> +++ b/drivers/cpufreq/cpufreq_ondemand.h
> @@ -6,6 +6,8 @@
>    * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>    */
>   
> +#include <asm/cpu_device_id.h>
> +
>   #include "cpufreq_governor.h"
>   
>   struct od_policy_dbs_info {
> @@ -26,8 +28,6 @@ struct od_dbs_tuners {
>   };
>   
>   #ifdef CONFIG_X86
> -#include <asm/cpu_device_id.h>
> -
>   /*
>    * Not all CPUs want IO time to be accounted as busy; this depends on
>    * how efficient idling at a higher frequency/voltage is.


-- 
Thx and BRs,
Zhongqiu Han
