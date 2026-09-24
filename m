Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F9A3EDAD2
	for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2026 22:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790290651; cv=none; b=Yqk1uhKjX4694TfuUOmssnt+9zu8OOzHu4A6Lxu//1M3gGEqabfuAL71JSQ+6hAvGUaIR/XHYIcjaNoUVeCFNB8H2Vaf9fLwgR1rZE//uZMoQNqyQdHaoAKwx7BFu6jOQSUD/GZBYDvSqzCq2T97nA9SpPpVFs+oLijiYsYX5D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790290651; c=relaxed/simple;
	bh=fpfPQgsOtOc9WLlVwD3MxGuJHzdHkV63pmZ7ZwBuyzg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZXJyQJ7cyuEJmuTTnSLU7DaABCm2Wgtt9YQ6VLXilRWkWDueVeqmQu+ZkhfMD9ghOfs8o0fC79i2Ou3gsISqtKYqfwmbWAqrnwcm+WhIX6EMgNSYDVTInkcdOYKQAFSeAF0RoszFAoLhQD8ggWjkNFB9VFdQVlqbtHfJwIQHbMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BI2Gayz/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JFg2BY/l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BI2Gayz/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JFg2BY/l"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OMP7Jk3718217
	for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2026 22:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WdAcd3jJW9o4oT6W8Pd28WqwPKx89e7FKJveLvjxmTM=; b=BI2Gayz/LjxSc6mE
	Kg+MLNOusLPeYnOxYOG9xy/G6ynTgm5i8HXcMPcVaie12keAjyA2Oz1Cf0fyIkw2
	1iPHcxBnFcP9qOOkZ07f07f5aQw1qPFKV8ApXthFNkR53KsFmNN+apNakWPmF9KB
	GZ4On06jpyBc5aTWoomkmhaScQbrjk2k5yn95Es0ViLT4dyJ6vNbt0gJYJ4jce1c
	XIv1evwdRyzJbK4ev5ygZd0QRpNzogYF0Tn6LwzUygOtjjPo7wa0hzGZ8ulMQwj8
	1Dwm44i8PH1iR4SnWFtv/Stn36RWYL43Nv8n7mH5JL14F6v+yiIOppzxFkJgDYi0
	2R3TpQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw881s5dq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2026 22:57:28 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-32861f5448cso965615eec.0
        for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2026 15:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790290648; x=1790895448; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WdAcd3jJW9o4oT6W8Pd28WqwPKx89e7FKJveLvjxmTM=;
        b=JFg2BY/lxuAu5jy1YajhRoDl2AglObRJGzaW5Q4zGg0qujD/P6pBhA5nuf35UMYjMh
         HSeTj1SDLOso48DVdhcy5CXFBUeICzX22Bk4KaKt29KNnHS5nT2m2Xhhj1drWAxleTcW
         RZzK4hH9EcIHpNph73V8H+w6F9DyDowEYlK8SfRlqEYrypJu/142rSxWTgd9/xBtzrtc
         MWwF1v31xrM4hHUbb9Q5fR/ssZVCvEsqxHBHV+KfkE7R/vNep7jxC7XHe0czZ52BVeUs
         hR9bOy6k4GdC94M6id/e3dm2ywoa8Qq7+biKmc5+IAck3Ve4vKW2eN3oV/29RO3UGJWh
         eoeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790290648; x=1790895448;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WdAcd3jJW9o4oT6W8Pd28WqwPKx89e7FKJveLvjxmTM=;
        b=tGPMdtqDYWhEaXJVRv4CfjbI2l0h5AMGku0ZBJvlt8EiY5/oqvWWGFSitugqvm5IL6
         h7eWBbmd/FHLjH4cXezNSxuGlWg1BYmgd/M0qV8Mv12zqYgqQeDx/o1+r2XPmddJrihS
         uZSwshbtkEznHF72og096TmgJpJBZH02sHZTkRM2A5abzcklvvRpas53NSs8lfYGBOPz
         Xl1bppIPM500Me7PTuE/wZIW7xOOVkZjmIiwTnKJ/jnAdcslm4EQlEQsaG/7pFRKY+gY
         kPuJX3WmNdAOjerw6lkTfPd9i8cNIRQ0P1/JLa9BtNxF+fYi9+mH0xFybkcQdQ1UaMXp
         ru5w==
X-Forwarded-Encrypted: i=1; AKwUvBwVGpQSy5LhZN+WWY648nIRc86nH/q3+bT/OXRrxn6mocCZkavofDX4O1AYxLOemfnC6W8/hnhsxfYs@vger.kernel.org
X-Gm-Message-State: AFuF++nOCeL2YjGpskS5p1WaDVMriuwc4+CyzamXOGV19hs8mUw6W8kn
	1HG3erOdKqV3tTSw4J7qSlotQDOq6Mxnjv5kOTWBtuZ8iwUHFQouyP7mm0huci5iJtmjOP6q6BK
	PiYUa5R2b//9iUWUATcojL0MsXlpNa7tOtQkaAt8Yj7EYvoYrpeOFOeFxOKSIrB6d
X-Gm-Gg: AYBFou13ZFvPiccOr9MVzLLGrTr0W9dlCQPqi81Ns9sHHJ0Ww9P1Y0P7tY6hb3Ib3pV
	BFafAVfbEuUWbxMdLvO0vPPMjSEkRloaRYI6zh03R3yVWQ6hdq7FXLXlA4fz8F+bYIIonvAPzZb
	YmuaDucogV+A9Rwcnbq1VDyP9gCKhV54Lp8oJOWOhZbgjyVzaBLiV/6s98rFGWp5ekvpO7b5/mj
	ZCMCNzIvL7Wx+WK4K4ZgnWzg0XziBfRma1riQ+NfsJioxkwABiNtk7zjRlIcZuZ7AHLu8+4ZAUA
	lVILqM53UYygpWOWRKU2HdpoC3XiQOexBLW5VA9ZK385LHu4kyU7QONWAQdcsWO3pGbjsZpiJV9
	YxDmwx94wNzOWauri9ls/Umd7991v61VmXb8TEFXRKVL6uKnT2NHziw==
X-Received: by 2002:a05:693c:621a:b0:33c:e61:e201 with SMTP id 5a478bee46e88-34002edee42mr4033415eec.22.1790290647514;
        Thu, 24 Sep 2026 15:57:27 -0700 (PDT)
X-Received: by 2002:a05:693c:621a:b0:33c:e61:e201 with SMTP id 5a478bee46e88-34002edee42mr4033386eec.22.1790290646954;
        Thu, 24 Sep 2026 15:57:26 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144757f31sm2046484eec.14.2026.09.24.15.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 15:57:26 -0700 (PDT)
Date: Thu, 24 Sep 2026 15:57:21 -0700
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
Subject: Re: [PATCH 07/16] efi/zboot: Lift efi_cache_sync_image() from
 efi_zboot_decompress()
Message-ID: <20260924155721.000016a9@oss.qualcomm.com>
In-Reply-To: <7-v1-27d06b313981+8b-arm64_drtm_jgg@nvidia.com>
References: <0-v1-27d06b313981+8b-arm64_drtm_jgg@nvidia.com>
	<7-v1-27d06b313981+8b-arm64_drtm_jgg@nvidia.com>
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
X-Authority-Analysis: v=2.4 cv=TptzFzXh c=1 sm=1 tr=0 ts=6ab5aad8 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=Ikd4Dj_1AAAA:8 a=gav0J8kFgDfseqtY68YA:9 a=CjuIK1q_8ugA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA5MyBTYWx0ZWRfX4wW1AMi5UpKY
 XPkJ7YBH41Uwf588d9MC9LzEH4mHe16CEv5q8+j5EaBF+8KHs4PC9dk4bigvpCaqbs+5U2INgt1
 w0oU3NdfhWkRK3m6Ci8RCgeICZYPeTa+PkWa54T1vonXvi4riOoXA/PxATsq575fatiF1aIFoBa
 Pxq8+CbH09CWWwcDbUw8GXpAwh1KY7QVo7e5O1B7yHYENpP3ya1A7MN8FonjSC6ng9fCcHsI9pQ
 bceRYxgdZr89J83fYHt1ULSzjKF209L9xdU4UuXn4GUXSsCzJ5X5edVYQoHcwbQrMIPmNnlwTWO
 brwQropetYM9O8wvUx1l17n/qyIiAbg4BHw0CFR5Gl6zac9AsVBrZSBnhKxknWznEcDfQfrNGha
 nQsnUOrUL95KVWeWS3qGltE/xCdI0dNNl6z4u+uShTU1RjeObGUQQyGQHZJ3e1rhJNRS8Jb7qAC
 +tkmyH8Bz4x3XW7NXMQ==
X-Proofpoint-ORIG-GUID: GQ1EXnBOLavSHF3BbVDfCiA33NyTcdi_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA5MyBTYWx0ZWRfX0KNROegmTZFw
 7OSerfdk3gANgrsLqWpDnXiGoOHv5KZuIbgAiHALtXyrg+r9nmtZ/O0hKyMfnaCXiJiGbib6tT1
 SNHqAXxckRbTQjbiqqrTHnKBQHG62Vw=
X-Proofpoint-GUID: GQ1EXnBOLavSHF3BbVDfCiA33NyTcdi_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240093

On Thu, 24 Sep 2026 10:53:10 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> The two decompressors duplicate this call and the next patch needs to
> change the argument. Hoist it up to remove the duplication.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

> diff --git a/drivers/firmware/efi/libstub/zboot.c b/drivers/firmware/efi/libstub/zboot.c
> index 4b76f74c56dae0..960a542881d875 100644
> --- a/drivers/firmware/efi/libstub/zboot.c
> +++ b/drivers/firmware/efi/libstub/zboot.c
> @@ -92,9 +92,12 @@ efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
>  	}
>  
>  	// Decompress the payload into the newly allocated buffer
> -	status = efi_zboot_decompress((void *)image_base, alloc_size) ?:
> -	         efi_stub_common(handle, image, image_base, cmdline_ptr);
> -
> +	status = efi_zboot_decompress((void *)image_base, alloc_size);
> +	if (status == EFI_SUCCESS) {
> +		efi_cache_sync_image(image_base, alloc_size);
> +		status =
> +			efi_stub_common(handle, image, image_base, cmdline_ptr);

Just go one character longer!

> +	}
>  	efi_free(alloc_size, image_base);
>  	return status;
>  }

