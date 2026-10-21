Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792599395;
	b=yb4biCng0BO1cK/YNjM9kFTiBvRfcUzPMHiQtzvDWnK5grp+AJAoKxrTb7Qr+nrEzQWI
	 xterpGHtfTfsrMpDzb7dWaLOOdhRq7vhR3dfsCBkos3dABfzhgDYehKBfUnf+Sbr9SToC
	 wRegmEqhz0ORUuWXUAjBaUf9JWw2oKTGkPa2AeEw0/BSVBHH6GXnMOWUnhVIwsUcHyHiA
	 hE9bPqJk9zHJ9I0Qg8JLMPuP6lixkp7lUmFcHtRLnOYTw4bsO6L59vl+Y9Cl6hRCQrCBe
	 aToTS87ai276OHIYnBY60+65zrA7hFUSVn9G4rs9c6qkE1hgl9OOXee/84CwPIL9kdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599395;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=9hWqXEuq9iUvICKJmtCYJXRTGUsjg4czRSsoSn+YADM=;
	b=0VP37Vg49aLzaBylEWnkZwqH3Lo1nrofh/J5mPIJ4Ymeny2nm+PudYKdViydil+vdiAf
	 i/kuL1Zh2cknjhylme8QZLFn8s5TauAJlzi9GRQkwe0TodYvpIkivVpZhwMt6AOYHwbE6
	 NgCFN36XLqbqtEkS9ucEXPuwCPjA6iIMTxhDEGU58MAwX1oCV6TQFVRAbr84H7DlT9L5n
	 Tz55Zir8j79MhIeIK3Mu2TB8A6BqgZcTzyVrqHMCQ9O08LOJ3apTstKwSuB1FHqZvtKwv
	 i0XYUikL3Cmi1ePvb5X+1/Nb2qKSO7tpT58udUvhvM2Bt/eglH51NZ28CEpM3+RyEkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i9+3PrHW;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HnlJbmWx;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF47606A56A
	for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 16:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BF47606A56A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i9+3PrHW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HnlJbmWx
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LFoBvP524174
	for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 16:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9hWqXEuq9iUvICKJmtCYJXRTGUsjg4czRSsoSn+YADM=; b=i9+3PrHWHdY9KcEx
	Rkizp5TA6LO3x6JHCBfisbZ0xVIII/InNbBxuEouoj5Gl5TOhuvbQWrw8eL06u4X
	qiHRcvAhNmVYdbjfFVOwPWC3tQY0bR5kWrXLzQ6N++TpSf/0W4Z9TASh0cWZS0a4
	Xr9AZ/sJJsXeg1+6ffdBlzPEUJbhqfq/9wHvJh7xsRqxJSeMNgDYFH12igwOZIPc
	9Ae4kXTrb8SAFEmNoQRNByJbkPWjKBdcjRrRz6EVRgeBw92KcZMZBQC+kZVat+X1
	ZWlx2gub9lucHtn0mdnHsO852q/e0aPYuMDdx068yiGnUphUu4BvJDEy1BXUn9xg
	8ukbIQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0cv03w2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 16:16:33 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd65070d3feso8888a12.0
        for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 09:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792599393; x=1793204193; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9hWqXEuq9iUvICKJmtCYJXRTGUsjg4czRSsoSn+YADM=;
        b=HnlJbmWxheT2gXIIjcxthAC/H1+57UtsxmUxyx+vccU9Ep3I9hxpJXeWGHordJbqWu
         mxrJNr1Qjrz+GPYJhwC543D/FR/xWwBeMhtMNPU2oYRyGY65Ves5ed1yTzwT58zruClh
         e1biPaX9kRMaKlncicouX1Q3sUh1I8ETUPNMehINjSDX2ofI8gI7Ytc4R0PGEv/DhgxM
         WDjyeDA6Ox5vIp4TKjrb6Fam6OaEAfF9uPr2wumCyuHYre0Wl1XGa1Y/chTGb1kExVZI
         yDk664y1iTShBv59Jaz4slCuc/SnbLQDoqcqN9cdsXscy4GHBydOwxDDZTqqQYUu62GO
         eHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792599393; x=1793204193;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9hWqXEuq9iUvICKJmtCYJXRTGUsjg4czRSsoSn+YADM=;
        b=Z5rhuW23Jga0jAXFeL6k0eQeQ+3oqOdlB+sEx+LF4O4kUu4xl0yUifhmwzC6hf0PyK
         FANMRzzRMuzvHl84Plc4XuZFRRdmXgwofyOiZv8p7Krlz1z0JmWNbpXOUBCGruIX2zOe
         CR+/ADC9DJc8gjHjHWaw1ibTGfGL4ijrUK7y+yFyYD0ddHmXBnRmpn2QcPHpT46ln158
         5n1ZsDvV4aA866Zspxd+jpWcOAO3rlC5NKwk07H52Pywj9MFT+g6kh3GwRV/I0FxD+oz
         bGs3V64IUfm52dqXArwALk0NLVPLoM0xtyGhUXLfl+Ub0KFA3X0QFZUfi7VEi2HGo0Aw
         AFBw==
X-Forwarded-Encrypted: i=1; AKwUvBz5LgLnby5FaGHDKRFjeIL48zWoLM/kjvhLsuLz6DOUPSQ7YIqX4KofNtLBNfLWPzCYsWuhDjURqX0O@vger.kernel.org
X-Gm-Message-State: AFq9FYLha9wSVUNhGaXvkdEoezPoUWeszZkxWIr2XtV8Ux6w+y6qecDs
	tuV2ZdqEDZgBCjsGALPB9wDeH9mRGjQNxAb5ZtmbH3H2p3YF9+SzSh8ARSevPTU3yzgs9SieJZv
	jp7+vGk4NRplEW7sMTaU/85KBa1zJUuAOrxDHCPTBd381ZzO6JI5zNV6ZRVdnHB6t
X-Gm-Gg: AYBFou1iFKRhLCFAWp+vUx/tSMRt33+Djh1GX/Idzx70ZPEhe9qbb7LOIgOe1W5TjN8
	eMb9OqwUQ0pImEVe+g5IUjPK8XpPIxDIYD+jVSVnlTHhZRv+H/EfoeAdcjSrv1LJH8pgFZUvNxl
	WX+nwprwDfD+lScJermNGm5N7pfhmkh/17AOg8Qqa/uVtYQQfv0lu57uya/M6f8jTqwISjoBH1Z
	WdNwJLu0qt9kPW/zr3UTcq+HicfDnM7hMrdUQ93qnuRL+RSuHfZJcyiB4B2lBgHz9x0opoac2bF
	ekNORvWXcJ+GbWvmTDo3mtNBe2tjoq1K4q0o738ol/aEZce4O7yqBbQk9OC8D02On7zACNjgY6r
	k8SHaaE/Eelqo0s3bJDPp3PGGfEjs9XriBonMnEGZ6g==
X-Received: by 2002:a05:6a20:2f98:b0:3e2:6653:149c with SMTP id adf61e73a8af0-3e26fc04d39mr3512927637.10.1792599392776;
        Wed, 21 Oct 2026 09:16:32 -0700 (PDT)
X-Received: by 2002:a05:6a20:2f98:b0:3e2:6653:149c with SMTP id adf61e73a8af0-3e26fc04d39mr3512915637.10.1792599392315;
        Wed, 21 Oct 2026 09:16:32 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6b84b6b17sm205866a12.13.2026.10.21.09.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 09:16:31 -0700 (PDT)
Date: Wed, 21 Oct 2026 09:16:25 -0700
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
Subject: Re: [PATCH v2 04/15] efi/libstub: Add a general way to get symbols
 from the vmlinux into zboot
Message-ID: <20261021091625.0000515e@oss.qualcomm.com>
In-Reply-To: <4-v2-989a18390eb1+486-arm64_drtm_jgg@nvidia.com>
References: <0-v2-989a18390eb1+486-arm64_drtm_jgg@nvidia.com>
	<4-v2-989a18390eb1+486-arm64_drtm_jgg@nvidia.com>
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
X-Authority-Analysis: v=2.4 cv=NrRE4MdJ c=1 sm=1 tr=0 ts=6ad8e561 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=ah4THgOBrJhmsRMU:21 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=Ikd4Dj_1AAAA:8 a=_GvItbcUg7J-DuPKX2oA:9 a=CjuIK1q_8ugA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: isx7Du_lfTwhjhIbf6l7rAfUpeMK1SoC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX17cR1ED4j9NO
 5rsRpdjjBT6rraxilhFWFN3aO+SDKY/yqw+FLmlX4MziJYFnMUes+X63t7mh3GYfqZA5SKb7FmX
 lIZJfNhmFHXPAWE4CyTAuvgwIdxcGXA=
X-Proofpoint-GUID: isx7Du_lfTwhjhIbf6l7rAfUpeMK1SoC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX0emEwyQIG9gG
 yF95NYCC83HRmuaDM8UrCqFYkYjXEfkXjfZ5i1K/m1x86Jb8/8kgb+MOZwGtO7muUmf5FkQjKE1
 OqF46cPmSxwUNVYbTkLyizz7/i4npXZo3KCziUyD127YboVZF+4QQ1M4B/00Q3zIm/jwPWUhanz
 DpylLlkNaX/mqvBzzlue+rX6dKCRzXRDakJhLh2kVAhsMONi/01vfkfbHwPGmibiWHYku6ocW8g
 FnkmXXM6QQVwjdHErQSZHfHpvKh3Qx3//QpgITE2fsefhAOjcLr57Un8evRoQdPz29+GTp6uJNM
 vo7tuibgMbUyvZpVIymPVZfJj7vzBjVBLxN5eGC5zYR0CSv+qegG0XoSaaIm5USV9sbQ2R0XxCE
 FyO9B3ijCl1FrdsL8z3nEqRX4F1N+bIgC9wsftbTNhqT1XMk2d64pnlRLZS9nf+aQVAHEmoRmc/
 RLTRFXgu4hSyK7DfmJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210064

On Fri,  2 Oct 2026 20:31:41 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> Currently the zboot stub has no access to symbols in the vmlinux. In
> contrast x86 has a voffsets.h header that allows the stub to know whatever
> symbols it wants for the decompressed image. ARM DRTM needs another 4
> symbol locations to work, and it also wants to compile the DRTM libstub
> code once and have it work in both zboot and embedded.
> 
> The current solution in arm is "code_size" from commit 45dd403da851
> ("efi/zboot: arm64: Inject kernel code size symbol into the zboot
> payload"). This is neat, but it makes the zboot and embedded cases
> work differently.

Not a real review as linker fun is not my forte.  So just some
trivial formatting comments.


> 
> The x86 voffsets.h approach is also nice, but it can only work in zboot
> since it relies on 'nm vmlinux' to extract the locations. That's a
> circular dependency for the embedded stub.
> 
> One idea that meets the requirements is to embed a struct of offsets
> inside the vmlinux and then have both stubs know its offset from the start
> of the image.
> 
> First, each arch defines what information it wants the stub to have in a
> struct:
> 
>        struct efi_image_info {
> 	       __le64 code_size;
>        };
> 
> Second, it populates the struct with the linker:
> 
>        EFI_IMAGE_INFO(
> 	       /* code_size */
> 	       EFI_IMAGE_INFO_OFFSET(__inittext_end)
>        )
> 
> This approach with the linker is guaranteed to emit a value and not a
> relocation. I looked at writing the struct initializer in C, but that can
> result in relocations inside the struct. That seemed sketchy so I stuck
> with a linker script approach.
> 
> Finally, any stub code, either in zboot or embedded can access the struct
> through:
> 
>   const struct efi_image_info *efi_get_image_info(unsigned long image_base);
> 
> The makefiles arrange that both links have a "u64 __efi_image_info_offset"
> symbol that contains the value. For vmlinux this links to a symbol created
> by the EFI_IMAGE_INFO() macro, for zboot it uses the same technique as
> code_size through the zboot.lds.
> 
> Since this needs arch changes, protect it under
> CONFIG_EFI_STUB_IMAGE_INFO. The arch should define the struct and use the

Odd line wrap as moving the CONFIG up a line is still shorter than some of
the lines above.

> linker macro before enabling that config.
> 
> Since everything is linked together, and the actual location of the struct
> is not fixed, this is all private within the kernel build and can't become
> ABI to any bootloader.
> 
> As some follow-up work, it seems interesting to standardize on this
> mechanism and remove the PROVIDE() and voffset.h alternatives. This would
> also avoid needing to pass sysfb_primary_display through EFI from zboot,
> for example.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>


> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index b2988aa12f6645..4dd52ddb148401 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -83,6 +83,44 @@
>  #define RO_EXCEPTION_TABLE
>  #endif
>  
> +/*
> + * Architecture specific information made available to the EFI stub, see
> + * CONFIG_EFI_STUB_IMAGE_INFO. The architecture describes the data with a
> + * struct efi_image_info in its asm/image.h and emits the matching bytes here
> + * through contents, using linker expressions the compiler cannot compute.
> + *
> + * Place in the same section as INIT_DATA.
> + *
> + * The architecture must also define EFI_IMAGE_INFO_SIZE to sizeof(struct
> + * efi_image_info), and that definition has to be visible to the linker script

I'd wrap this to have the whole sizeof() on one line line.

> + * before this macro is used. Keeping the two in sync is checked by a
> + * static_assert() next to the struct and by the ASSERT() below.
> + *
> + * The struct's offset from _text is emitted as a u64 at
> + * __efi_image_info_offset. The architecture aliases this location to
> + * __efistub_efi_image_info_offset for the embedded stub. The absolute
> + * _efi_image_info_offset_value contains the offset itself; Makefile.zboot
> + * extracts it with nm and zboot.lds emits it for the compressed image.
> + */

>  

