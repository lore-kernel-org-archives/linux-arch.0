Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598917;
	b=iyupl6pdZKpFzgMnC7sESGZLQ4vtcwkXa9NPdQHTNG4JP+IijW4rBjvyXzIE3bFzwOvZ
	 t5HZMIkFqZ+2APcO/0HIAELQhBJTfg8z1QtEqvroKO+mAsntl3wlNUTC5Gr/gbgTRIlEx
	 xP5RnYARZ1bUtndba46aw9tXZVA38Ssrgh1K9OY4cfvwafZM1FhzhRgwQwmTN0avM4Q2d
	 X6KvzTv8YCYsCpTfXBzhq9/+NTW3DVXxu21sSJ6C6jNUN4aXX5iZj0fW5wm7YucXi6yAj
	 /1TRPe8V9M0Mncsm3JPUp9tZBpO/23g4JGxi0MKjVIlmhWDCbKUMTAT1s08zSPMqq8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598917;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=xpcFx5Tgg5MtNBAEwITPf99dESr1dNj5mhlvVGEZ9HE=;
	b=2pf9VW1roMeEm8s5wwvOtVzZDqPyaTIkdjMRdxlx8T/kCmrkXWmfCV3Wd85MoCiJBvwm
	 lDBbQFs7qdjqDPfiVhZQ6lRMIYW0rly03jrNCc+lZGqE2AnL5htEuQyBqCR0yeny0Z17D
	 wZjuiN49qEGzQP99DVHZ2rgM9367QewDWGIFHXTiPug7SbiHcGAER8YX1y8OZYx6+rJjp
	 oMe8uUAr3njdNSc/RKGrW5GwcAsFQu5Of+2GMtoYmrR4dbg32MJchtlXedjec2by13frR
	 1vxSViNluSZmAKb1Zii68F255+ZP92swl6HoABgLb7Tnu8yaNryXJuSux2d3Gx3Fi6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ppsqazaf;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AlgG2yKd;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1A9606A319
	for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 16:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F1A9606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ppsqazaf;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AlgG2yKd
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LFoCDl524220
	for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 16:08:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xpcFx5Tgg5MtNBAEwITPf99dESr1dNj5mhlvVGEZ9HE=; b=ppsqazaf3z/Ovnn1
	SzWOwFC6FBH4fWPIj1FFpw1+MfbxoKTpq3L+dL3Z+e3w7356YZ6RysSOxUSlT+jE
	QJ63VeLe4fC9YoZU8/wWjZGfXODKSBwllcZGiYbUnENdNs5V4JoZtOO0xT0uHd/I
	xWphiIy5SHHmhNox7zwzrK2Vqs+UWLy3gU0nXuyduCWSyhwAtJrrWHEuN+VRgTMm
	hlzoca2KU2LPeFWWVXhGFOSPOe97rBtnG8yGmM71Gq6BNVbN2C1Iwmwrje5lGBva
	VCVasiUkD3EzsCgdmldMxwRAjdIFHG23zVG5vKxeMRaRrlso7XF2npL2q3GBF2Sc
	GdYlJQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0cv02q3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 16:08:35 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8a0688a43d3so686697b3a.0
        for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 09:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792598915; x=1793203715; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xpcFx5Tgg5MtNBAEwITPf99dESr1dNj5mhlvVGEZ9HE=;
        b=AlgG2yKd9rezGDoVAK8tHC1EbYhTk2vdFncR/cM32rw1R4Kg3pGEJ0vzzMUUx7am2N
         86uFG8yz6c1dkLP+e0mlLOW74Aii11LwnHh6fizV8MJzmvSB9foYSYt7B6+SfKXOmlOU
         Y6Cd4lU5EU+M/yf9x4qe2bkTw4WDOkMAUJHSr6XLAbH8+Y8BH17FStqqZhf/2q8FscJw
         cB+wBWGPasCxLlurN9xiTMFpKGvWaFBONYji6K3D+LV/lFZp1gWdKI7v38J83C01YMr0
         gyz0RChxfsYPVwnpEgXAWOU5LDy9m3J/wYoFEU1tDek9N9ZCBN27nPim2GM+ANVs7qIi
         W2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792598915; x=1793203715;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xpcFx5Tgg5MtNBAEwITPf99dESr1dNj5mhlvVGEZ9HE=;
        b=F7p+nGxCT7qrXR2Y30MSMaS+ohtcAZvRVzo2Ij3mV+J6empvQcVLIlCp4ybgv57nEo
         z6KrmC5tkbLG9GtIW39O+nMPudCkN4SemXbcedeTXVqkKZiNX8RVPggO/QnUGrhocFFp
         GRQ4XKFATyVHdCyEnGyNvSycK23xNHA6uqM7vF6g6vZVdGmAXpe8kMI3mLoV7VWlb8EO
         cvUN3zc0Y4S0ka51ehWlRAPY/52CMwVkwjPPI4E8rYSrcvAVGQGCPtabX7HUHv6nHu4w
         es4Jo12buLPzL1qXPlAwKUmMkpPkW35+lK/60H5cwOWlmiIhMJE0s0ph/7rmKPZhPqvh
         KmQA==
X-Forwarded-Encrypted: i=1; AKwUvBzFO8cI0XGjz9pGtD2fDXkQrx+OfX3KZT/H3G5zBDdkYZKifK7cAMLVShWGMCLF0ad32VciiYtVKiLM@vger.kernel.org
X-Gm-Message-State: AFq9FYIXaEltXuKdo7sUn9fM7oHF9ZdiRDPTZAbjZs9NAiOszELqhwEF
	u2mw0dyb9oqfY8lkcLnY01FbKcmM+xS7nsYQXX+gjG7sVCKKcMj7vYmXXDuXDI17jV3pkHOLPZs
	uZb8C9QpApYxu8BNKFYUHG2IKjfwZUuPkOzwj4NDCPO5Hn9ZC905h9vQQvhvtfX69
X-Gm-Gg: AYBFou2pEvdFdxMT6N3UPpgfaeq+VvnE3WzgcUJhMC5G7cIMhqrCndkU5DvRRdPFDZt
	wVt+MJOLLK9bPRrmHgxX5EqLkIaJvgXP+VOe3iEDHlf3DZwNZKAYLmUe2H7U5qbwyxRCfO765Ae
	XWpzlqeMkKU9NEWAwHBsFyrvHvF0ENxhsVldbV+QWWknON/mdbq834ggr1Bq5J9sfQwImTn/a4p
	rh8GwaIaEjHj+N634A/8KU6eLjRpyM64FTA/2/hCx1zrgZJzqHgTOIBomy5j2FUJonymH/B4GMA
	cskDR4gzLspHK5pFw1VaPork9EooFko/A1WHCruQl/6LI4c64VyVoMqPVxNuNcd0hSiWjNr3/w5
	LT3tGvZF/2b0wigeyJqA+G962NHk0gZ/VooEJJ/6M4A==
X-Received: by 2002:a05:6a21:3288:b0:3e2:2b76:bf23 with SMTP id adf61e73a8af0-3e287eda189mr2084273637.68.1792598914882;
        Wed, 21 Oct 2026 09:08:34 -0700 (PDT)
X-Received: by 2002:a05:6a21:3288:b0:3e2:2b76:bf23 with SMTP id adf61e73a8af0-3e287eda189mr2084221637.68.1792598914240;
        Wed, 21 Oct 2026 09:08:34 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6b861c7dfsm188964a12.25.2026.10.21.09.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 09:08:33 -0700 (PDT)
Date: Wed, 21 Oct 2026 09:08:27 -0700
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
Subject: Re: [PATCH v2 03/15] efi/libstub: Free cmdline_ptr in efi_pe_entry
Message-ID: <20261021090827.000078b8@oss.qualcomm.com>
In-Reply-To: <3-v2-989a18390eb1+486-arm64_drtm_jgg@nvidia.com>
References: <0-v2-989a18390eb1+486-arm64_drtm_jgg@nvidia.com>
	<3-v2-989a18390eb1+486-arm64_drtm_jgg@nvidia.com>
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
X-Authority-Analysis: v=2.4 cv=NrRE4MdJ c=1 sm=1 tr=0 ts=6ad8e383 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=Ikd4Dj_1AAAA:8 a=EUspDBNiAAAA:8 a=gCM90IwNaqpJe8xd-nwA:9 a=CjuIK1q_8ugA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: Yf4na-FkZ_dDydHRV68yDg1WZvDABmA6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX4ZbiNP6EGonF
 hdFyBEWlJLlndy/8KivPeP/BcjS2X2fhzW+YYJJmiLVb+iXPCD7fygfa8LKczWucRBW/98+dVcj
 50VGwBcPotNxs9k7s503kDHCQbNF1aE=
X-Proofpoint-GUID: Yf4na-FkZ_dDydHRV68yDg1WZvDABmA6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfXwmR6X9FYMOwo
 ZKE9qcPzKuaXm9z63rjWgegQsFwZIpi7G0OdcJfM/1+IuSams9IQw7mqUDFfxS4MvHgQtTutiMV
 DUlkP/T+dMPUdzxjc79qK277zUgHzCLKSvim9HpTYZzMr1YUfDUD4iN0AZOzEZzpTT78XXfmgJZ
 XI81lP9O/BXWGDlEqtqV24PjNCjCqh7ZngT64u6ZGaXvrtZU33J8IO83D8a9+vMu4wJ66BseNuX
 L8yT8WOJumFHtFEWXHsHKOuKSaWyzBadbyNL7ezHms55eZ6cdsioAOmT48vILlgYdQFoU39LuVl
 dlp6rtAeXPTA97mLUc/DTxCxMXw99beCPw7IHDsukr5AHw/czJGO3VS5e+YyXbYmSEVOl5AopPj
 FNT7JjGz9bAD2yyNzz+KUJ+dows69RRDQGq4WR0Tp7CnDibfJq9eYsVeoEAg3CFEsqfw4ApKi8c
 fSlLjxBK2HjqPvDzcUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210064

On Fri,  2 Oct 2026 20:31:40 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> Sashiko points out that efi_handle_cmdline() allocates this memory and
> hands it over to the caller. If efi_pe_entry() ever returns it should be
> freed. Add a __free annotation.
> 
> Fixes: 42c8ea3dca09 ("efi: libstub: Factor out EFI stub entrypoint into separate file")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Seems sensible. 

If anyone has more time than either of us, I note the efi_handle_cmdline()
use of __free() should move down to the point of allocation.
It's only a couple of lines, but none the less...

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  drivers/firmware/efi/libstub/efi-stub-entry.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/efi/libstub/efi-stub-entry.c b/drivers/firmware/efi/libstub/efi-stub-entry.c
> index aa85e910fe595e..fc1282fb442e71 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-entry.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-entry.c
> @@ -40,7 +40,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
>  	unsigned long image_addr;
>  	unsigned long image_size = 0;
>  	/* addr/point and size pairs for memory management*/
> -	char *cmdline_ptr = NULL;
>  	efi_guid_t loaded_image_proto = LOADED_IMAGE_PROTOCOL_GUID;
>  	unsigned long reserve_addr = 0;
>  	unsigned long reserve_size = 0;
> @@ -63,6 +62,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
>  		return status;
>  	}
>  
> +	char *cmdline_ptr __free(efi_pool) = NULL;
>  	status = efi_handle_cmdline(image, &cmdline_ptr);
>  	if (status != EFI_SUCCESS)
>  		return status;

