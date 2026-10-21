Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602392;
	b=KhuYGVb/GmMSEYSv4CDnhHYk5vP2VMZvZmL5CEqjZMx+j+YWDFh2FIOmISODhdzV3Tz5
	 5aa00I4P0aGei754h67hA5vblY5NSOq3WuoQgVOHZxcqAXrv+ReuD2jzMzTz2ipKDuwhu
	 pblGZUJvFoKlPVcu9DliH4WLPMmAnSIcp6/CdFnQnVyVpo9DOzN7mIG2OULCOJhU+3EcO
	 JzxKXaHSsFSPccw9FfO/mhkBblyt189/9S50X4eUEEHAF3cnD10W8ojn79RLSE5sadS6F
	 pIMjgDJhqvIvXZU6aYhxfuV5eruqLBs6NBs73nED4dJaIigNybNh5RJN5T+iXqd4Kdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602392;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=4KgtddslSOEOaN73E6Xh0kX0j9JGBALLWlHj4vZIcu8=;
	b=c+d3sJA0pOjr9fWBqEq/nJS2oRdwwGHkZocaeB22Zo484wEHqHAOGG+VadRoOTB4HN4b
	 m0FApTzctaaMshFpFZquCI+N4i2GEUd2cxgrJBY0zmXWdmaWgDwH1T/fc3Ip7g0Axnd7N
	 vhLju/T4Ev5VFvES3ZJEt+yZkyim7xVW2r0zYj3vye84H5PwkGXLMvQVZn3Yt/+nODqEQ
	 PS3PdyCWEdKL0K6Zu7dSl6LUAqApvNmOMsDejM1nEiaLMRy7QyrTNLgRE/muOOZjkZ9bB
	 aYtdJAqP+9cWEaEMCSVc9GOkd3ZfPEgUlDvDM8FRxk0CYNOYBEcFidULZyZYq/6hUnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OSlcL8cO;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S0lM1fWI;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5508606A331
	for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 17:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5508606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OSlcL8cO;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S0lM1fWI
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LFoIBT524343
	for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 17:06:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4KgtddslSOEOaN73E6Xh0kX0j9JGBALLWlHj4vZIcu8=; b=OSlcL8cOU5zXbryB
	8fphfV9zo1XreQA4OpWxV/h7tO89Sx+6X2Zl5p6+0ULsUn90taN9eGxYH16jm+qk
	L0XZJ7Dn3v8XGxu9eL4AUwpW89Q08hqaGYjoQLd+s7IfocWo3yT9caDh8KNWlz5H
	s2wvu8IN32qEW3e4b+swbEmyIx4Sb7Bfs53jhsZpFAhMxFVFGH/lhgrGUhOIl9na
	ZHCzsoC6k5dyzggh321+7NzEQC0sx6z0Q589PxqQBdkJCqG9N/vTM/t84N6WLpwZ
	XNzQ4yeKMJxtggMzRJOTsDyC0PwIrehi/AU/krpfAg39mwEvzewP39PNMVc/Bg+a
	pxwNPQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0cv0bnd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 17:06:30 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-35a04491c56so58092eec.0
        for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 10:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792602390; x=1793207190; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4KgtddslSOEOaN73E6Xh0kX0j9JGBALLWlHj4vZIcu8=;
        b=S0lM1fWIw6Y5hJNpLN3G50Ucns5COX1CrBE5hbyjPvJoSWfaUU74zEBfK5Y9LOfw2o
         3qJuezojUa7Gwuxzpuy/sRiQzyLvOc9/wbbwX7fNFq1fLWNTYoqZf2H0HrpG76BxzJkd
         j4NEOGLlwqNWTzlkJzpYzISQUweCoK4ctrM0+yYr/nhRkxxHwelCf8Yr47GhsPdS/Gh/
         VebX6ND7e/SueIFT8iifQkT50U24TtcvbyCvGuKBnDq3FtCLV80e+kGT9AWueohj3ns1
         ZLNryXgd9nc5t4EbUsKv7TiPfGLjKNrhfFHKWolwtgbwMqQR6ThArwPN1LlmwKKUPgZc
         Ru6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792602390; x=1793207190;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4KgtddslSOEOaN73E6Xh0kX0j9JGBALLWlHj4vZIcu8=;
        b=TE6dkF2pR0uHBauq9cdc4NAlPpeRIonFCsI7ebLb6fTyfTHlYssn32WpdAAyLmWFfT
         ICMbtDkGXsHsuF7k1dbGd3AzAUmUbsyf+V3H05/cpOKR6jqbotYIPVSRxfeqx1IYep5N
         Gc4cOSgid7xyjJQzjLpM9wEMgOuGhx8e0hZDfl2ikunBmfumbBoWCtLaRl7ntGRLyWYX
         Ubc6iSGSe5IQ7EP1n6yNRKwaOhvqgTIaS7lGVBf03foTkdMDCr8dx3I3agXt6fIH5WlH
         F3Afrb7/TIlfWqEtPDSQsWdKZgMGhHptfcqbjXw1gGFcirFWSaA7155FnBpjHlr7KE/y
         qjsg==
X-Forwarded-Encrypted: i=1; AKwUvBwFT9C9Fd9UE5kaHfkxRbZlBnd5yYO8UYzkwx40eeBxsp2SxwFDs4JTAevcqRAiGS4n6doIZ7Ataumy@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3BKpIzQWqAiJpbZQzlvw4mPjRCNOpiJQ0vqls+ccNpqi3uAiC
	jw81+bG0bM5avOY3EKfdesD2plRDVCgigBRFDNBN/5i2AW/fE0IoWNEw06wH8T5p+qdjlTZNoHy
	mnNWAi1v3Q7jEltHMUYy9W0vzb52ymXaUu1nfxhuSuaW6d+F49a2tAYNsHr5dHNIp
X-Gm-Gg: AYBFou0TagKzoDIhxH8MjfHP9SMFssJ0jdmVVfSoG9BfwlIlikXSke85JxohIgUstBg
	6O7kMrtvsVSb3PO2TW6KZNbDxZARrAaFEHAmkMgrHrTeUCT7L3PyIiqZTpvRxFVQ6XI0rWb1NBk
	fyVUzDg2jHU7i+xFeu8G+iJBAWTRh4Le5WzCa2V8BsF4RdKUwJG6DNbpFUMYYOUPjpSwBFyb6VH
	9Ny/XVbSxt2NxR8fgl46s1cZgu6pScm9xkRkeva4b8Uq2sdHkGUORAgaV0LBxVnlUFK6c3kjFgn
	mXFNBEx1eSqyAU67gAc5u78FwfRpKifSvQhtOQv2tPi/zbOPaykp96Y8G2NRnYd6frDSbjDamOW
	Rbt8QPkajrZxSAxfvqV2/cpd2yzFXHUVRTh1bsp1ZcQ==
X-Received: by 2002:a05:693c:20cf:20b0:363:a45d:10b1 with SMTP id 5a478bee46e88-365fa49061dmr6847149eec.5.1792602390112;
        Wed, 21 Oct 2026 10:06:30 -0700 (PDT)
X-Received: by 2002:a05:693c:20cf:20b0:363:a45d:10b1 with SMTP id 5a478bee46e88-365fa49061dmr6847104eec.5.1792602389510;
        Wed, 21 Oct 2026 10:06:29 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367f52ce166sm5334511eec.29.2026.10.21.10.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 10:06:29 -0700 (PDT)
Date: Wed, 21 Oct 2026 10:06:22 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Albert Ou <aou@eecs.berkeley.edu>,
        Ard
 Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin
 Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, David
 Sterba <dsterba@suse.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
        Randy
 Dunlap <rdunlap@infradead.org>, Simon Glass <sjg@chromium.org>,
        Shuah Khan
 <skhan@linuxfoundation.org>,
        Nick Terrell <terrelln@fb.com>, Will Deacon
 <will@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Conor Dooley
 <conor.dooley@microchip.com>,
        linux-integrity@vger.kernel.org, Palmer
 Dabbelt <palmer@rivosinc.com>,
        patches@lists.linux.dev,
        Piotr
 =?ISO-8859-1?Q?Kr=F3l?= <piotr.krol@3mdeb.com>,
        Ross Philipson
 <ross.philipson@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Song
 Shuai <songshuaishuai@tinylab.org>
Subject: Re: [PATCH v2 08/15] efi/libstub: Have efi_kaslr_relocate_kernel()
 handle extra_size
Message-ID: <20261021100622.00007ae5@oss.qualcomm.com>
In-Reply-To: <8-v2-989a18390eb1+486-arm64_drtm_jgg@nvidia.com>
References: <0-v2-989a18390eb1+486-arm64_drtm_jgg@nvidia.com>
	<8-v2-989a18390eb1+486-arm64_drtm_jgg@nvidia.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=NrRE4MdJ c=1 sm=1 tr=0 ts=6ad8f116 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=Ikd4Dj_1AAAA:8 a=EUspDBNiAAAA:8 a=z1Vexnt6jiiBlSUV7TIA:9 a=CjuIK1q_8ugA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: P6ghof15hgwsb7Gon2BOWxrj7CraoAul
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2OCBTYWx0ZWRfXxph5TXlFMh8G
 xLMxpuWAvfbWhvXlWpKuzxPchuqe1wdNpW6As4gZoaQEiFTo3gWIDIkXObWrCPkiG+GrLOgJ74q
 UODjuRdT9y9I24cEL54gpMiuVRnX8aQ=
X-Proofpoint-GUID: P6ghof15hgwsb7Gon2BOWxrj7CraoAul
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2OCBTYWx0ZWRfX+VlUKuo0U2Fw
 tlI3IVkplOBoyFqP8bkxSShlqZtUpHp4nSOy8uaQReXv9ISAwW4NFuJq4vwuhBAgfX/mXipk4Oe
 HBoZmkaMEl96d/btrC8TnKwLnaB47+JtKirr8OL/YVC6Di6PnJdSWzcxiqFb2q9i14TX8VvOpfB
 pOzgsNlfkH81JfMGcgFy8aNgWRzkEDM4wH8b3P56thlv0qD4PQvRY6rFoQc2eiG78KPb2610aFM
 pfQX9x+7E3a/bjxRE5UXC/o1Zcwce7/q9pyHmvWzhW6Pmg5nYnwzMzP6sKtvMwDgRClpV+UliDJ
 mbWXzCX5Tih/G7qgZOoRbuuAVRf4DsGWzQqZW1FpAXLVTolqbNGAHsKIpYEjH9Wl78lSZ6dn7v4
 j99IccCgD/opP8XmR/Uu045WU6SqAeEz5iJFL7iar70RCsFsCwJjKEkzJWPGtPFTg2a10ZFjW84
 ZnRVblFQx2XvJ5vdw1A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210068

On Fri,  2 Oct 2026 20:31:45 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> There are three possibilities here, each a little different:
> - relocating for kaslr, just request extra_size like the zboot flow does
>   when allocating from EFI
> - in place, attempt to allocate from EFI precisely after Image to
>   confirm nothing weird is there, failing that
> - like any other error with the in place EFI location allocate
>   non-randomly with extra_size included
> 
> Remove the callers' assignments of reserve_size since
> efi_kaslr_relocate_kernel() now does it.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
A couple of trivial comments.  Otherwise looks good to me.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> diff --git a/drivers/firmware/efi/libstub/kaslr.c b/drivers/firmware/efi/libstub/kaslr.c
> index 4bc963e999eb97..e419f3800af517 100644
> --- a/drivers/firmware/efi/libstub/kaslr.c
> +++ b/drivers/firmware/efi/libstub/kaslr.c

> @@ -125,16 +164,29 @@ efi_status_t efi_kaslr_relocate_kernel(unsigned long *image_addr,
>  	}
>  
>  	if (status != EFI_SUCCESS) {
> -		if (!check_image_region(*image_addr, kernel_memsize)) {
> +		bool image_region_ok =
> +			check_image_region(*image_addr, kernel_memsize);
> +
> +		if (!image_region_ok) {

Why this change?  I don't particularly mind but seems to be churn that isn't
necessarily needed.

>  			efi_err("FIRMWARE BUG: Image BSS overlaps adjacent EFI memory region\n");
>  		} else if (IS_ALIGNED(*image_addr, min_kimg_align) &&
> -			   (unsigned long)_end < EFI_ALLOC_LIMIT) {
> -			/*
> -			 * Just execute from wherever we were loaded by the
> -			 * UEFI PE/COFF loader if the placement is suitable.
> -			 */
> -			*reserve_size = 0;
> -			return EFI_SUCCESS;
> +			   (unsigned long)_end + extra_size < EFI_ALLOC_LIMIT) {
> +			if (!extra_size) {
> +				/*
> +				 * Just execute from wherever we were loaded by
> +				 * the UEFI PE/COFF loader if the placement is
> +				 * suitable.
> +				 */
> +				*reserve_size = 0;
> +				return EFI_SUCCESS;
> +			}
> +
> +			status = allocate_image_tail(*image_addr,
> +						     kernel_memsize, extra_size,
> +						     reserve_addr,
> +						     reserve_size);

I'd move reserve_size up a line to group it with reserve_addr.


> +			if (status == EFI_SUCCESS)
> +				return EFI_SUCCESS;
>  		}
>  
>  		status = efi_allocate_pages_aligned(*reserve_size, reserve_addr,
> diff --git a/drivers/firmware/efi/libstub/riscv-stub.c b/drivers/firmware/efi/libstub/riscv-stub.c
> index 725b634c517919..a88b2d275e5bb0 100644
> --- a/drivers/firmware/efi/libstub/riscv-stub.c
> +++ b/drivers/firmware/efi/libstub/riscv-stub.c
> @@ -37,7 +37,6 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
>  	kernel_codesize = __init_text_end - _start;
>  	kernel_memsize = kernel_size + (_end - _edata);
>  	*image_addr = (unsigned long)_start;
> -	*reserve_size = kernel_memsize;
>  
>  	status = efi_kaslr_relocate_kernel(image_addr,
>  					   reserve_addr, reserve_size,

