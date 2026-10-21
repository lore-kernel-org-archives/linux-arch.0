Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792601530;
	b=0wpyCiJsGN0jmvpsGOhtOhA+wRuVXq8crEWJkk6oL/BT+wwkJUpwDOHOnmR2OCd1rfTw
	 GfS4ayiccbGMXAwmHwENQo+XApBXcgijdWK/ptVqG++OOGwFgq4BWXz2G3lWVv74k9wFE
	 17u4EgUR4m7dqWmPqf6qt04IYQ4e6has/4aArBZPdDpOf+5IcIO0OhcM8IrfyCoc6giij
	 xMpXLwcHpvyKq3nYEUj7VvRozJud7vDSYX+nHuBBYFbpEgzhlyz0kyfg6x1Y5QzFBI8rp
	 T8/vDZeprHVIhOFfo+s90+04VvL/GhqmUqGMxCV34J8YeEiwssVkv4X1zPi8OSr8cNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792601530;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=3Qwd5IeDpUYoKVbi14CXRmp0vCTcpiIpKFvrCb+PUaQ=;
	b=hRN8KxXedcSU06ND45/8B134FHUJI7cIcJISG6i8HLpQUwNXatgTJRgn5ESYLXf1414+
	 eDBsJBCLWeLC0fxkoiIWhNGWIlo3uqmzvYEdAgRmberqVLWT2Yv9XqLnjKtE89rRczTSw
	 TYSxI0N275/D6fIEOOzaNba1JJX719831obUG8xJZQO07c7Nv8BrWquIplYNqetMQSwju
	 PCTMmlgGQ9s4DiMarqwbtT0O0d5Ac+dhNXuWNYiYNyRqGTRH+vXZZ6/Pd2SBGyfJsY5ni
	 w0ULJGmyfaiFeJsqbAFSMSG7lt9LqEU5LnTLQo1NfXjgTPzzREEqQ0tWu1h1GV/rNsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fGBW0L6P;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QQjpQpmx;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FDB606A31D
	for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 16:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42FDB606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fGBW0L6P;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QQjpQpmx
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LFUAtw4158961
	for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 16:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3Qwd5IeDpUYoKVbi14CXRmp0vCTcpiIpKFvrCb+PUaQ=; b=fGBW0L6PCB1n3raX
	d/aUhPmemf5kyrJMb2V994vfSQxb8ZW1AUflWoJbMqxkNdQMkyX60NaRpWzwG2ZR
	dyDNPyramva9fABPmwqppOy5x+y3G2Xjpzu+HJAQ8qTdGMQEDtxA5BLJJps0Gfbc
	0RS6PuOx2PIHdwu3bJdDo33JYwkVD1p+N8Eahl+8OsJIsrCWmXNci7Ks5pmN/stb
	gumg0KOS4MOx3tLDNhDJjMnuFbAjLxfI2H6AicbgZ1SvXdgPAikr3eeNDm/5NzI1
	ReUtxdLTy3hBPhb9/wjImsppuSRvPHiJNWyrz7U7vS8e4LyChMQCIA5S5oPDbcDF
	hGURjw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hex5q8xya-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 16:52:07 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3510d0baf63so2170747eec.1
        for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 09:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792601527; x=1793206327; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=3Qwd5IeDpUYoKVbi14CXRmp0vCTcpiIpKFvrCb+PUaQ=;
        b=QQjpQpmxczgrpr2meAC6qTgPsJ4ZmJ91pnxGxL09Sesa1rfJJ+QmYIiqzX/3ZN2Whc
         PGHUczg9OAvRA0sX9sIDqu77sBzAiBbu7jGYKhjLqjsw2zunSyFSZrk/9dIw43rWgx87
         IVATm2JqsZfxBJA4hz7gvE+ZQkKi5tu3ZcAv3WPj72XLC61Kfbn/vxwFtyI0+LKC4Fg9
         N7c6i0MEQt4EgFAEAjH6SeD6iQGD2AApA1yq+2zxXGXf/7tUfU8F3yLM6Mcr02afFF0F
         fC6EP1lR68xmmprG7i052+aNcNNEAIDBPU11lgff4/LOklidQA8lbZ0lsxRZbkFmV+xj
         424g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792601527; x=1793206327;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Qwd5IeDpUYoKVbi14CXRmp0vCTcpiIpKFvrCb+PUaQ=;
        b=xO0/9kcO1OHD8D7XLy+InpvxeWCQszxWJC4P4kCXbRVdlQItJ1JI7hWxs5JDz0gHmt
         VyJ1b13/GXYlxaRW4AQSafH8XszRF+KwMZn3zAqgtyAQo+pkJ3lV8ZWZQdScQlW3PlFb
         9xqv+myCB1RZx3q2sEWdiiAHZSoA0g+Wc4vOT95bpZS1OaVIWt/hHNu1vne3FS1lN6ek
         3z4Moimxdvmclcg/EqEv7vzY+vSDl986FgeQYfBohp2ZtiM2clxEHE7U2D2fCxiNi0AE
         olHqCxx/7m4gWe8/X631WgXlwJ5+g5+adzm0QDQa5QkJf6PU5mcXoxReNd7r8ctjqMmD
         Mg4w==
X-Forwarded-Encrypted: i=1; AKwUvBx7LRjFjvpsQYcW7fPvcgm3vwyiXvKa6+ULE1BuSAvLh4muwHIR1VJilVuXghRB/DhWUfKKwIz1evz6@vger.kernel.org
X-Gm-Message-State: AFq9FYI8La7wgIkj5WSb44/uNhfQLSjEz9cU7bR5PHD2XIpIkvj5nmaW
	hB48nzn1NscnCGhzX5Wki3j3fCBsxKOKlLoWf1M//VyWgGIjiCTbPL94UzPPqmHN+RknTiJyZdt
	sURroYTJZm6UasENjPpPn/87sAnFoWd++Sz1Vegvliq9DlsZzXMD/TE1JLcbr5edp
X-Gm-Gg: AYBFou3v/mOF+yAnpplydZMtXIbsW6C9++O3AUKez0LaZJ4i2LTpoGzUFAMCGySeL3L
	AWh8z3Bw4PlqUfpXQ0iHwwp64ksG1V9Ija0db9K0dhF1ShMg8ZDZUrkcpxV7KBMb+jNgAqss8V8
	554Piyyl6eVw7qOTqoFGgdlMbBYm0UYW6TmTAOZaiO9S2RfLDQzWX1WExY7HF2zPpH7DraFMU6+
	oX1KWoiXPIWlukcfTLfeOUWSeLD9rscB0MQYV0kN8uQIFK6mZNOUoGtpA4+w4mpnuNV7t0sEdGM
	eVFmtiMOt3XZCeejHkqKPCb2ofPBLazjbn3eCxNSHi4UEeB5a7V41gmykb/aDD4snCqnJp+7NMs
	SYePQvaHil/M+Mqr+DzC1ez9d2flVSSOB3GEpXA/TlQ==
X-Received: by 2002:a05:7300:fb83:b0:359:8492:2107 with SMTP id 5a478bee46e88-3674c43c286mr5506637eec.10.1792601526871;
        Wed, 21 Oct 2026 09:52:06 -0700 (PDT)
X-Received: by 2002:a05:7300:fb83:b0:359:8492:2107 with SMTP id 5a478bee46e88-3674c43c286mr5506599eec.10.1792601526326;
        Wed, 21 Oct 2026 09:52:06 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3674206d1f1sm8700283eec.28.2026.10.21.09.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 09:52:06 -0700 (PDT)
Date: Wed, 21 Oct 2026 09:51:55 -0700
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
Subject: Re: [PATCH v2 07/15] efi/libstub: Add generic arch callbacks for
 DRTM
Message-ID: <20261021095155.00003fc2@oss.qualcomm.com>
In-Reply-To: <7-v2-989a18390eb1+486-arm64_drtm_jgg@nvidia.com>
References: <0-v2-989a18390eb1+486-arm64_drtm_jgg@nvidia.com>
	<7-v2-989a18390eb1+486-arm64_drtm_jgg@nvidia.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NyBTYWx0ZWRfX31abhh4fWsRT
 X/HYG/49kw33E4DaoYHLT8US821lyTPGNTtj4Qo5fmwBCcqItclvgteyx/1PRFI5fwdlmE1g6Vr
 DzgDs2Q8DP365pXmc4D9nXyu0psJWzw=
X-Authority-Analysis: v=2.4 cv=eJaGH3p1 c=1 sm=1 tr=0 ts=6ad8edb7 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=Ikd4Dj_1AAAA:8 a=EUspDBNiAAAA:8 a=PZHjKiIRVRR-A8qzlogA:9 a=CjuIK1q_8ugA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: GGiKmlH7Z6-6LGRyQaAwS0bCNGzQanpn
X-Proofpoint-ORIG-GUID: GGiKmlH7Z6-6LGRyQaAwS0bCNGzQanpn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NyBTYWx0ZWRfX2eFJzDocnplo
 x8+5Li04sEV2tWQW1nTyL4sbTo0+iNbIGXa1XNfE1TAI6I/8deqBaHzMLPpdxRUdLIKp4DdKiAC
 ZFgx155fi+SPgsYcRbK/eQzXPCOr9YHeWobZN+fgtVQ298uvY1VDNH05BW5E955YHZquGXS4cU7
 LxYEBvT0LKQ4OM4JDOvxNYdOKjG3OTi5aHpGu3eZ3NP93nvuW2ddR5d2zHChGUpZipe0vmLY6RU
 biNSnc6u94KregMU8N9wdJUvjmS61OW8bIo77zrN0UGSZfLmDjZxH5r3EtVmfgCrtmuZTns+Zoe
 Q2nZmh3VXvjGqKCl9ea7yFXEDETiN/bqT7hUaqM8nhQp3sw2oTQnaznbolss0wzJpg1+eMFfMJX
 t+bHuj/09x/NPyCFsAAQOKwu/I0gHU9BBj37ZSVBywvRF6FJcpJsEJcvy+mPKTaC6I4/YZzCxof
 rx4C4NFeifSE/o57T7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 adultscore=0 spamscore=0 clxscore=1015 bulkscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210067

On Fri,  2 Oct 2026 20:31:44 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> If the architecture supports an EFI stub launched version of DRTM, it
> can select the kconfig and provide the hooks under its architecture
> build.
> 
> Have the common code parse a drtm=enforce|auto|off kernel command line
> parameter to set the boot behavior. Support commas in the args list since
> there will be more options here down the road.
> 
> efi_drtm_prepare() is called before doing any decompression or image
> relocation. It should figure out if DRTM is supported, policy-permitted,
> and how much memory efi_drtm_get_extra_size() should return.
> 
> The image handling is revised to allocate extra_size at the end of
> the normal image. The architecture can use this to store any
> information needed for the DRTM flow. It is always contiguous with
> Image, which is a requirement of ARM's specification.
> 
> efi_drtm_prepare_launch() is called while still in EFI boot services after
> Image is fully prepared in its final location.
> 
> efi_drtm_launch() is called after exiting boot services and must
> jump into the kernel through the DRTM flow. If it returns, then the
> normal launch is tried (auto mode).
> 
> The extra_size is allocated directly after the Image. Handle the
> trivial zboot flow now, and vmlinux in the following patch.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Seems fine to me.  Some of the functions affected have annoyingly
complex flows already but this isn't obviously making things worse!

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
