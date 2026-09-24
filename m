Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3883EDAD2
	for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2026 22:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790290151; cv=none; b=Bf4+npCsOaoBy8Bod0skiohCwAzVy+kSXcPDPZfvNb3kCvpllXjC9a0W7n48kiv0tFambE0jmObr4+Oia5+TMF8xpP4ovfv+NxruLKJrKq4OARMDUUOW8m8AKjzpK5UhL+zPRv4zovIxXPII8Glw0FaQQcgt0Ms6P6JKoqDeE6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790290151; c=relaxed/simple;
	bh=EsE+bP4ImbF198tRF/p/BEO5nlCx3+LrGeUaFu0gIWU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZIN9OAITbBTQjCh0a33/qT2zIuJcm5+O4hxhQa1fDlMahiGxLD6nBH7yez5ovAX5uOjOIs1mheiUJZfs+L/iO2/vv8AI00m5D0llswrZjiR0VfsBuHQnO2+gVawP6tddKEjlWvXmoa5I0QNUNo4cVRzoWlLwKXao2cDCQoQV43M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UnwyqbzY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TE/W4E2Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UnwyqbzY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TE/W4E2Y"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OMPZ3h2145200
	for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2026 22:49:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oo8YGRfyp+kAVxf53tgrQWeKF/gkFQ1vpq3RnEKr7OY=; b=UnwyqbzYYs+KvHQI
	pdaCx1jtw5ZY0g35b3TDHY1cZfUiyOOybRzb2dGrJpMmxlONRNVSQrHCIK6+AoC7
	QnvuyVkfsbutTtg/yDMfBQUkcTg+g9F3yaain8P0Plp1XMrZxMEFtivmZwU0CQSe
	ofHBo1aKp2Fj7gieTJXChc0guhXjz78g5/YQm8yV6jdF4DVlAjn/ZKGezuK1U1zf
	EgGFGjtO6diq8oxU1+jfEQZtkOeEUAA1QQjM+IUboDFRrPF9yqUpJATk3M3VjNOY
	A8FRKURil3a5aaVAiLtj8asDhAlxSaEDtDqf0iqQI5xndVjM8Dveu39DfcoA+QTX
	4xyL3w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1scb1ha-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2026 22:49:07 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30c0d568830so506398eec.1
        for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2026 15:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790290147; x=1790894947; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=oo8YGRfyp+kAVxf53tgrQWeKF/gkFQ1vpq3RnEKr7OY=;
        b=TE/W4E2YA7DdQDjtoKa9Ohy5kUi+xAKvSnseMcMtfdSdbuoPntoIv73orzyxWN4IuC
         2oePRdpPasRiq6vVsCfUbvmsX2alW+qlKKX0UKAX89xkaWkb0KhGwesg2bQuV15mUiZV
         U2KpG4683JUoUkaXslkWhxiLu2r2Lh1CUKo+LPzK756B6CRK28mQsWOX4r5+PV3v73zw
         sI25zXrD+7mkZw05ruaX+DWfies/8zF5Pgr72KoohmGqNLICIVEvNz0tLj85efg6EmvC
         CiYpSFon1t0TmqgQxUDzlKxZ/q/X30MN8Zgc5bl05DNJYB2dvA8lm0jlnRGzcFXobNGl
         XvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790290147; x=1790894947;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oo8YGRfyp+kAVxf53tgrQWeKF/gkFQ1vpq3RnEKr7OY=;
        b=ZJK1wpK6BTDHX9oOl2LKUO1TMw18VZEfk+5DylaapJSOiQcFB3iBOmnxDQ1mMwgPR6
         wU1yeEtjFcELjJnZcVGV01wZLwekKbm4U9NsR86LR9HMra/+AKB270LJWues8cC0UACl
         Xss85SaJ75+EfREqcmwZ62OYqCOhomM6Odtt6ByowY8NFcMT3BUyQ9GCTeH2txGdh90v
         QAwXTCvkwiuwi3SuU3G2CI5drR9xrPF+5PPefRKmyMwoxWE5Mm1yF4h+pUBcn2UShcLp
         lyrI+VBx4rFq8hyoWFN6E7oA8y1+WBvFdc4DgXr4vGBtKOoC3HCdcHfMYeNYn5lXKcqc
         8PDA==
X-Forwarded-Encrypted: i=1; AKwUvBxtr0d/elqPcVGD5/jxQldVpss+XpuHWkMc/G9FV5oDh6mS3ogfWRdtaIeCtBb9zYodFxJPjTyZRR8y@vger.kernel.org
X-Gm-Message-State: AFuF++nERNbyp7SPioBBSPwqtzgXvWEJ1OVuB0WQmZnivDInQQ9bnYkL
	v77b0Nh5OLRW5OjsXOiBBp1UeLNYT4mCZQA5gjeI1gG2RDxd8/+wEWHtRLI1BB5/Oq/J67o+XjK
	+IyChXdc/MP3FuD2iEkXAo4qOyLwEOZ70yr5Vgn4CqgeXXFkcCfJe/sxV3AoCK+19
X-Gm-Gg: AYBFou1l1dukh8aiZSoiuM/+AZILDvVs4gWHbUivrpEhfWlFq1sfuNsze2CmXe/BFOl
	q5w99vyGVOHrk/2b2/Heib1nnBQR66tEDVlNsi3UmyEf4KaJQDdtgOZyt65Q+MNhK0B3zNhziy/
	NGOBwcXayIPtL50b3xuktyYHjsptFa8VZBHhYCtbF7FE+KQ3Sb7DWE6AsZ/vXCezV7PNtu2jNbm
	B4VAj/6pNTh+SRqtjDLNRdVZSMk0VklOL72JzCmNSRPCPBQfAgLdelq80OdZgub6oU4YuMaCU4v
	eh7NRvVZvVpll2zFmfnP66MppHPaA4hX0MZBrDIFhf+VsXey8mWMZKV03K3OoImpEPKsbTBvKNV
	4Ihk6ejrDu5COSAYBLHHGXakuQGvl0mTICN4qRiSvmZT+hUAoJom+RA==
X-Received: by 2002:a05:7301:8614:b0:33b:dcbc:6046 with SMTP id 5a478bee46e88-33ffe341a5fmr3054546eec.7.1790290146789;
        Thu, 24 Sep 2026 15:49:06 -0700 (PDT)
X-Received: by 2002:a05:7301:8614:b0:33b:dcbc:6046 with SMTP id 5a478bee46e88-33ffe341a5fmr3054509eec.7.1790290146115;
        Thu, 24 Sep 2026 15:49:06 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3414407d18fsm1417100eec.10.2026.09.24.15.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 15:49:05 -0700 (PDT)
Date: Thu, 24 Sep 2026 15:49:02 -0700
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
        patches@lists.linux.dev, Ross Philipson
 <ross.philipson@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Song
 Shuai <songshuaishuai@tinylab.org>
Subject: Re: [PATCH 03/16] efi/libstub: Free cmdline_ptr in efi_pe_entry
Message-ID: <20260924154902.0000528b@oss.qualcomm.com>
In-Reply-To: <3-v1-27d06b313981+8b-arm64_drtm_jgg@nvidia.com>
References: <0-v1-27d06b313981+8b-arm64_drtm_jgg@nvidia.com>
	<3-v1-27d06b313981+8b-arm64_drtm_jgg@nvidia.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: HaDdGmCBX9R8R7IB4ZgnGXo14UWt51V_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA5MyBTYWx0ZWRfXzuUZsvUIEsaE
 ZJfSRH+hHG10fklvPA5pfU8ZWoBRN2eT/7tfdAd+hkTL5efDj1y/nQ24RfrLKoQQo0yA6n8Vv1y
 Rmw7FU0H8bAtYinpXoN6KJFSHuBybW8mzdP1HEcAaowXFQtRv1i7+kLrrxJWsbkblGzyDgk33yS
 7E2Oe0wkv0Kx28pWQuUR1v8Ff+kxX8Bwga4Z638u+vfkVtrNtxBx6tiS8pOB0NOcShnxKCuolRl
 LgUiVi7HUFOkHtypKz43xndO8ad8KUO/1keT5t0rRSnRhTnSP/pcnFH3rDQ2TSMsWiP7m+24JNh
 bUwNB9gdH050VpC9qZnkK/18EMJhb4nP2jZYhz8TZewaej7Rv5soPd1elX/pM9Yq+u6XNHOXWaT
 bKvg9b1hvIHWX+pAhKQgUP5rNsNN4Dfmh+qmvj/120HUY8UmWLwZWcDm3QcW14SU68IIsXsU63S
 svgQ8Az42GsC25/5cQw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA5MyBTYWx0ZWRfX33ox8L6Z+pk+
 xbCF4gc0AOrBaa6RW/tQ4vNvx2X8nPzS+AcocYyCg21xVhtu9OF3Xfog/U9FT8ZEr/hLgKculmF
 s7NUokyfg7LNrbWtya6eFTE166TEYwE=
X-Proofpoint-ORIG-GUID: HaDdGmCBX9R8R7IB4ZgnGXo14UWt51V_
X-Authority-Analysis: v=2.4 cv=GI+dgeNK c=1 sm=1 tr=0 ts=6ab5a8e3 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=Ikd4Dj_1AAAA:8 a=xhtQj0KKqAk-GveBB2QA:9 a=CjuIK1q_8ugA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240093

On Thu, 24 Sep 2026 10:53:06 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> Sashiko points out that efi_handle_cmdline() allocates this memory and
> hands it over to the caller. If efi_pe_entry() ever returns it should be
> freed. Add a __free annotation.
> 
> Fixes: 42c8ea3dca09 ("efi: libstub: Factor out EFI stub entrypoint into separate file")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/firmware/efi/libstub/efi-stub-entry.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/efi/libstub/efi-stub-entry.c b/drivers/firmware/efi/libstub/efi-stub-entry.c
> index aa85e910fe595e..83fade2b0d3b84 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-entry.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-entry.c
> @@ -40,7 +40,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
>  	unsigned long image_addr;
>  	unsigned long image_size = 0;
>  	/* addr/point and size pairs for memory management*/
> -	char *cmdline_ptr = NULL;
> +	char *cmdline_ptr __free(efi_pool) = NULL;

Can we move this down to just above the call to efi_handle_cmdline that
does the constructor side of this?

I see none of the efi stuff follow those guidance note that went in cleanup.h.

Ah well, not my problem :)

J

>  	efi_guid_t loaded_image_proto = LOADED_IMAGE_PROTOCOL_GUID;
>  	unsigned long reserve_addr = 0;
>  	unsigned long reserve_size = 0;

