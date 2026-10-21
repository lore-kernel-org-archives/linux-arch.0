Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598432;
	b=dNHEIXgr3cVy3o0/1gjCS1rX9IfO6F4Wqm07SXXG+fcF68zFwbsPXf8YLG30Iccats6z
	 365QcW/flfKbpITQOijqrkiKgVMJ8kf4S2fQK+kXyq1p6EfOSXiZs/f9L4PBKkXeVdjsh
	 XJFN4bv1QjBnJK4AkhwMsC3K0HmutB5Gk9xELyXD7218xZfeY0xFLdTwDzRFG+Vm69blJ
	 zIadKtiXfxEQWPLQ4yyqkh9qiiVJGo9Ceb0pKlwW8MkiQmSB/KKLYJ7ddQnMprfpA+6IQ
	 7MlShCqttwqrgpl9GtYXBeoCrvNOPwKcpThshxeLAs8KCApGJUU4jkkA19CpzPN5N4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598432;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ZCSVqnmCg2tgiS2qJzUGfrVmwaXnekD3uvjwV9akWpI=;
	b=Slb79XFRru/a0roVX6490huOkGBNmgaCBQqBUBra/g/EkYc/P7YB+Van+eirFFwBAdp3
	 iaCLrTBj8uX7zabNNnXPcVrGMgKsNEOqsX1L485V/tb9LjlmFIkpTzF8cVN0VTWsoYxjg
	 f2wOXk1nL+ErtN3q0DnWrTPtsypIOfJbD8T6V/B76kQcYdfFIKWsbEGlY/FU6hmifKL2y
	 CWA+52vH9dSi2VH5O5/VdDCa9UtHuCGgMyPYSDp5g8hK81WzulJBnSvaNToWn88w3OBSv
	 RVa8qGRbB772zk8f/n7FYv4lRcCx3f1meH17ANxAmlrF2CGYHBg86RylF5V+Uq47JUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fwgbev1Y;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aI1Pbv2R;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1D7606A331
	for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 16:00:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB1D7606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fwgbev1Y;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aI1Pbv2R
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LFTwE84158360
	for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 16:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZCSVqnmCg2tgiS2qJzUGfrVmwaXnekD3uvjwV9akWpI=; b=fwgbev1Y755yo0Wk
	UtrQff0d+SDedqVBkyUwA25GdbsQr1gedtRARzdBI/EmAOe0XsQToYsDxG3dcNo7
	WzxSgYac/ZGOsmY8agUmPRwldZjLtqwf49ThqvX1StCK7jmI7HXPKz+sOHF/9RsX
	d2pytN0NJDGCo1MhMPxlfFPfca6UKvw74dPxLEl0uCzKdYPb+HZyLX3GECv4+38B
	1RGJ0zWdQGHzDf3e0b63brnwjxFoTAwfwuugTBfdk1u7TM1ZeuovSwyIH11w2+ZW
	SdnPxbpBiqOcHpBXKX9x9UDSHSBDxYFiyv72OFxlygXqyI/101YubsytU9S9Gndm
	8d/hEg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hex5q8q5s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 16:00:30 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36803927a49so1320538eec.1
        for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 09:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792598429; x=1793203229; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZCSVqnmCg2tgiS2qJzUGfrVmwaXnekD3uvjwV9akWpI=;
        b=aI1Pbv2R61rR7g3E5aHm74ExnmzULdGi6MzBBH6Y2w7RAZAN6oIhfgnUk7n1md1UD6
         B/+I9ddppVLnwuKpm2KDvIb57zzMMbHNy5+WOpvycIuqWtoBMFIg1rL9wEYgXNoJUIBX
         V+tUIhNu6ke/VEEQKeXaZnxUviSH/r38NMTCgBmMF3CufxVbXEfV5wndxSflP6osvOTK
         nlVQlfEVKQ54dXAtrQs68yW5dTZRn1ju0FeNgVprQuqdwu/dmXpGJG8yJCyMWkTJaxV4
         GImgwjrs5PDDB4f01STWhYJW/dpze9ORmYD120VEqnyK/xbgQc9DLva7a0Hvw/2+MPow
         3gfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792598429; x=1793203229;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZCSVqnmCg2tgiS2qJzUGfrVmwaXnekD3uvjwV9akWpI=;
        b=eu/1EAg0HKyzfjsm6st+zaVf/YuVcGaFvceNgRvw6TbMF9NNq4FAN6PmQKp1SiE2cA
         niAsS32QirUO44N9TIVej6mmemDtMEtsdc1v8p3W2pGllp7Vog+JWpZt65P2uc11I5J7
         PYcmHe+w49r4vrAPfsZZ5Ui3OULQb4Wyok1WWE/locx5okzDNBxEjiqPtjwQBEmEiUts
         xKfhWXgE95LqapARK2FOHf8vs/BIh1R9QWM4Edn69TcJKYwnb3VE4xY1k3J5H/etBIME
         uq7ubthIxGxhP2tZhWlbK8lHfuLtHKlBojQkAC910GsgfFeSHwdkqCC5bJZ9KgEQL+Ii
         ukWw==
X-Forwarded-Encrypted: i=1; AKwUvBx42BPweSeEaymk4g4qTc0NHVNCEGPT4fIm8M+x5MF6FRDEiFa1wH4NjjbZwa69ZOwmvN53SLZKGh6w@vger.kernel.org
X-Gm-Message-State: AFq9FYIg6Z4SG3lyMKS2DlM3fxKGocckatTGRAzp4j+CJHD0Zl3WK7I/
	tPYnyS2lvzuBKSgB1oJAEVYZiQuA6USQmktPAHItFejXGs18f4W3a/MvROJwyG2u2HEok2/S8/G
	Hg8gywu75QcCzpjoy96756bug3MrM0fbWAfIzfY+V+XA7EwY5crglW0Tf0LXUdMv6
X-Gm-Gg: AYBFou1FmrpjqeNZMSOPniYPnK23G8mFzVhtGWQvMYtEoNB+N0Iulse/HPzepbZAU7V
	bW6Ibbs1CWRJbnipqjmvjWjBluRyc56W/+q883xY4T4w9oFl9tnpsfKH+uOZiRdBoC+1gDcVLpG
	hudiP9JsQtSP/f6GDF+zT4898gzWC6XeTv4pdidWLMDz5+X4vf1LdPLWVnH11jMRiENoQIGtP/u
	s2qXocMDkTTzsdY9VvAFvIBavLlUOPMx567NzqR2Vx7d/sgnk4De9/A9zrwcO+dMHyQjxi8+UQR
	7jKXmFEBaRk1Ly9qkKQKvagmC7QTDMy+iFC4MzaM0Pszl9LxayMajJvemBylFCbawZWL+8V+hG3
	vpYSujrbon0hAd1+P9B1Jm6O0JzzXfenw+TYmxev3EA==
X-Received: by 2002:a05:7300:106:b0:35d:d9a9:e455 with SMTP id 5a478bee46e88-3674ef292b9mr4299672eec.21.1792598427208;
        Wed, 21 Oct 2026 09:00:27 -0700 (PDT)
X-Received: by 2002:a05:7300:106:b0:35d:d9a9:e455 with SMTP id 5a478bee46e88-3674ef292b9mr4299533eec.21.1792598425455;
        Wed, 21 Oct 2026 09:00:25 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367405ed2absm10188327eec.5.2026.10.21.09.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 09:00:24 -0700 (PDT)
Date: Wed, 21 Oct 2026 09:00:19 -0700
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
Subject: Re: [PATCH v2 02/15] efi/riscv: libstub: Don't set image_size in
 handle_kernel_image()
Message-ID: <20261021090019.000060c4@oss.qualcomm.com>
In-Reply-To: <2-v2-989a18390eb1+486-arm64_drtm_jgg@nvidia.com>
References: <0-v2-989a18390eb1+486-arm64_drtm_jgg@nvidia.com>
	<2-v2-989a18390eb1+486-arm64_drtm_jgg@nvidia.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2MyBTYWx0ZWRfXwhA8dmvb05td
 KOFKu8F/QBfaLIDLmswyjV8NYBWllecldwXnlaiZX/O0wZcQqHexGj7OtFFancJ6+keirMIT8uz
 6lnGwDk4EWTccDO5QY0QrmbsWmVRJjE=
X-Authority-Analysis: v=2.4 cv=eJaGH3p1 c=1 sm=1 tr=0 ts=6ad8e19e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=Ikd4Dj_1AAAA:8 a=xbFV6RGmdEKkzbgyJ_QA:9 a=CjuIK1q_8ugA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: -G1wd6VTdOSnbE6TXRh9y6HiIZ1JMGDj
X-Proofpoint-ORIG-GUID: -G1wd6VTdOSnbE6TXRh9y6HiIZ1JMGDj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2MyBTYWx0ZWRfX80PKSGebOsl2
 Zsk6or24Cs0papLjzlleik2CGwZc7Y0P62UBkCchgMTaW95bI6GLVgOYJbzNIdPo6Um6tn2YSq2
 Ril4DurDx04uUo1Lo9j3h6DC+m+DqYswj8IP5RQXIi7+++lLJR29A8fQ9Rpx5NFl1LHboLtiais
 57BqARFrQ8twJmKAtJlh6VzohbIKUD2r9MjBGGWszZ85IcD4VdPaXuQLxvfj49Q6H0Yn0RzJHA2
 jOQ0bYumUqtnRqrZWaOUV1hVFt8I9m2DCOFK6buCcBBhMNh1OmD7cYUFkGg89rOrja/HKiv7Kh+
 VqnoRA4znapBXJBG6ttO6efFQmFo1mXa/ozlytg59YKV8q1TINiouzSXMCwbjTxtq7nqk5JxBIY
 PyRD2n19LtH9iF/G320AK1i97QYzFqugv/9tN+pyqVFapSxaMOu34H7EWSpjAF55MJcnXFpeBnD
 lS8woHkz6gPG3cb6cYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 adultscore=0 spamscore=0 clxscore=1015 bulkscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210063

On Fri,  2 Oct 2026 20:31:39 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> Sashiko points out the image_size should only be set if image_addr was
> reassigned to some allocated memory. If image_size is not zero then the
> caller will free the image_addr pointer.
> 
> efi_kaslr_relocate_kernel() never works like that, if it changes
> image_addr to allocated memory the free is done through reserve_size.
> 
> Fixes: b7ac4b8ee73d ("riscv: libstub: Implement KASLR by using generic functions")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Hi Jason,

This made me curious on the differences across architectures...
Looks like there is perhaps some room to make them look more similar at least!
One small step below.

> ---
>  drivers/firmware/efi/libstub/riscv-stub.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/firmware/efi/libstub/riscv-stub.c b/drivers/firmware/efi/libstub/riscv-stub.c
> index e7d9204baee312..725b634c517919 100644
> --- a/drivers/firmware/efi/libstub/riscv-stub.c
> +++ b/drivers/firmware/efi/libstub/riscv-stub.c
> @@ -37,17 +37,14 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
>  	kernel_codesize = __init_text_end - _start;
>  	kernel_memsize = kernel_size + (_end - _edata);
>  	*image_addr = (unsigned long)_start;
> -	*image_size = kernel_memsize;
> -	*reserve_size = *image_size;
> +	*reserve_size = kernel_memsize;
>  
>  	status = efi_kaslr_relocate_kernel(image_addr,
>  					   reserve_addr, reserve_size,
>  					   kernel_size, kernel_codesize, kernel_memsize,
>  					   efi_kaslr_get_phys_seed(image_handle));
> -	if (status != EFI_SUCCESS) {
> +	if (status != EFI_SUCCESS)
>  		efi_err("Failed to relocate kernel\n");

This print is replicated at the caller, so can drop this as well I think.

> -		*image_size = 0;
> -	}
>  
>  	return status;
>  }

