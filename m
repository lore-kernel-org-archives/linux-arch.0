Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792629107;
	b=FlwcNrXcXN26GYA6OxLQOV5XCLY4lc7EkDgRmEznMcVISJEn0bgNV2hFeB+6ISxr1nKT
	 6Ppiw8XOlS+2HUD4nQ7FeQkltt6f3tll8wYd+mnFmg/F1egGYhU9YydZvAPFPSxDl2uY2
	 m0LZXkovkZzVh7JbQw+W7EIHgHrabxCQUS7khQfUe3ppZNgOEmmOlqXLXDVht1jqN1nmF
	 ltY7Px9nUTM7V4+1tm44JOZKjzeorpMpRoZjr45JHO9jBpQtYQLOT0z96ii/PupWQqQh/
	 kNmgaiGSVQhQmT8fCJ+SV5hcXx1iVcup1L345MLSjK7LoIa9hmp5PFpf9y1KCjl/1Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792629107;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=H/opNow+kHytu3G/NcD0sUoEO+o11bnVvWNwj42+U14=;
	b=GdUUCS+EyLgOYDeMYHKegrcRaDyezNDa1iT579gWeZkJJFMfL/pRMeQ7ChzbQU5RY20X
	 2sFGypZ+gRZwD0/k+rwlsMfqmMHmz32bLTYT9LmRgNcvr7j26zOani1a3IodjyQ+0DdqL
	 b2snk8TDXrdF9vmBtXZiub0PgBKDNdWDpivAKgIjLR73t5IueQDeevaRDP7Mdz1L3c4qb
	 13T3v++8q7PwFxqIHFLUUM/332SEi9RP0jZMJd0k+lremLT0LUAJigE7sMFs30n/oUJ+Z
	 hkenxlYoM5Zlzk67s2j+Dgzw6Z0F5B5SfeAjY/oy+f1zCf7UNWhoiCgnP/81BnocEDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CKTmObd9;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BJLbtas3;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62294606A31F
	for <linux-arch@vger.kernel.org>; Thu, 22 Oct 2026 00:31:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62294606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CKTmObd9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BJLbtas3
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LKeMkO642461
	for <linux-arch@vger.kernel.org>; Thu, 22 Oct 2026 00:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H/opNow+kHytu3G/NcD0sUoEO+o11bnVvWNwj42+U14=; b=CKTmObd9EYBRD8Es
	JW8RP6hHE2nV/jriTWLFK4Tj07MD2YQ/d+k3krx0ltsunPU1Cqkd265kNM9yKAU3
	GEnCNnmIZVqdzmOaFvqwUFGMkR3jhOrDwVbvYrdhKxx40y/3PqS6OEdz4Y1mzA5r
	nc8kaRtBDStzSfIldolLvF/dk667tyPSl7AI/LeWGSrXbgSZl2mpo3K30Ew21v2d
	6hYLTLvPXuNcUx8Ous6bX1zJ4wVog4riLz0NNXpV98/XnWjGQDy4Iramm7tFASVm
	hQQeeHZq2uT1zz50gd3ihZtkQZ1hZa24QON53S/ZDK8f4lAV6Lzg3Nt099ldullS
	qho3Mw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hex5qah8u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Thu, 22 Oct 2026 00:31:45 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36696c9f55bso370581eec.1
        for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 17:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792629105; x=1793233905; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=H/opNow+kHytu3G/NcD0sUoEO+o11bnVvWNwj42+U14=;
        b=BJLbtas3WiTC6waWhgjBmGpy+nI14/5zPCjcXpDPSk7e+jtXoCiTpt03tXxIfPsW4s
         9oy/phuFShedWgE7isVYgCJaBy9Rm9rBruByH5kbnwELxECLPupNNKoxrZEdWdsxyWT/
         v4ZflTF4oXu6ehCAfpt1KYoEV5NacAPlt8hK/AJgHVtZYUTvL/92bHz5b8mODLOffSw+
         86+vi9goRPV6iFCIHEUJRCI+cK0YVbzfqunLmJfryEu9PKq/4ww+REWFd56EqPXhWMJt
         /w47lkYTbaVnxoWCzycvWcDQXridcvswPmbdO7VEB9HI+uEhxjHEE7hC2gBHXrBM6jtP
         dYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792629105; x=1793233905;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H/opNow+kHytu3G/NcD0sUoEO+o11bnVvWNwj42+U14=;
        b=0RdaftJ9OIDwIbNjXHOHQ1iO5a+MA/jbg5bTUEjnCm2bUOSdpYkTR6/9gL1iIBxBR3
         6jcPdJ8lXLsaOpkPDfFLaLKByhZOGWG1OMwFEv82+oAbftjHx1+zSlVpVRL9fgug0tFn
         18ioeQkeAhbOg3Hu7nGLHizkC+KUYR2veNTi70Y6swgo/lsoVJkF8w2FEhDEnjjv9bo+
         3rSPbX2Jg/S6/9Tpz+NpcwKJfAM1rhq/rvaTnXLrPBRR2+YnEFVPYYUdvkSqSVTwoKjO
         ay0ndYwibcuKbSjQV+EQNVSgs/MmwyI9g28DNlrosiD70SIK7ELSuDXUO1W4TQ4o7m4z
         4UbA==
X-Forwarded-Encrypted: i=1; AKwUvBzuILSOCcBICJ5QbuhKWwJuZY8vpT1wnWWr1MVcOppCcMWBi1+vbpo66nNfKx3bCnPW+6BY45HRM2gZ@vger.kernel.org
X-Gm-Message-State: AFq9FYJiRE9nJqi5T3QT5UruocMZnxueFCSs1HPXwcontto0+SSDFEVK
	RlSZiRltIOYSk7ZjDiC1risaoyTU1T/fbgpnuo5x5aLDvCPQLlkdbUiPdJHUQoIPLBjguEXw7Rr
	/hm9zklEhfAx9gXkjU4J2khlavsflxaW4XFD7NwYrhK/avkk5Qpx1j6lZaveRm8nF
X-Gm-Gg: AYBFou3gYoyWqdzSsVrtjRbB064NnekUSsbKKllLj3yhyyh/yzY3O9JBkFqIhbT/mH1
	DG7BYaSodRZhZikHXQ5JMfv4B5/x26VxljFFalO3JL0+qi338zC6hLnddpdg7vco935xirerVst
	g0HFdvrUFW3A4LPcxqy9IOi2V1JxxYxUUj0v6qprLTif0N6+8ovHiBtwMIGDxb/uWYNMc7o/Ocf
	FCBXfZslK5pfd6/pKkQxrnE+ypqCXcmrpzPGx/WU4c/i1I5N0uwlat1C9iRA3Muv0T75xKYakOe
	CGMI9QB0nB/+jRFmpvoVEhfgYqalk7Qyx7jJqF0eMGkOBuVh53an0cG218rAbgkT4OgbgnwAr5l
	65moUAitFZC64xNrplqjm1sDb6p6hlB1sgUeIFewIPJfVKRdcvjjlzw==
X-Received: by 2002:a05:701b:4192:10b0:143:808b:b178 with SMTP id a92af1059eb24-192f5c29bf4mr1174141c88.26.1792629104437;
        Wed, 21 Oct 2026 17:31:44 -0700 (PDT)
X-Received: by 2002:a05:701b:4192:10b0:143:808b:b178 with SMTP id a92af1059eb24-192f5c29bf4mr1174090c88.26.1792629103886;
        Wed, 21 Oct 2026 17:31:43 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903a180ca2sm8819002c88.6.2026.10.21.17.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 17:31:43 -0700 (PDT)
Date: Wed, 21 Oct 2026 17:31:16 -0700
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
Subject: Re: [PATCH v2 15/15] efi/arm64: Implement ARM64 DRTM in the stub
Message-ID: <20261021173116.00000df9@oss.qualcomm.com>
In-Reply-To: <20261021233909.GX3008132@nvidia.com>
References: <0-v2-989a18390eb1+486-arm64_drtm_jgg@nvidia.com>
	<15-v2-989a18390eb1+486-arm64_drtm_jgg@nvidia.com>
	<20261021111115.00004c5c@oss.qualcomm.com>
	<20261021233909.GX3008132@nvidia.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAwMSBTYWx0ZWRfX2Bmhzv4SyVX4
 O4yo5JIledXL9PN/BYU6CWz+h6cYv4fPX0WARHhV/3Dv7Ofk9AHAm1bpG0pJzdTDZRF+M/dkay/
 zBlvTwFh+2Zq0IlMc4/HRy4/lGBlj1o=
X-Authority-Analysis: v=2.4 cv=eJaGH3p1 c=1 sm=1 tr=0 ts=6ad95971 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=Ikd4Dj_1AAAA:8 a=j7B8HJC98GV4A_3RkYkA:9 a=CjuIK1q_8ugA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: xVwCPQ7LTETAJW9GHYvNUjkjegQDlgD7
X-Proofpoint-ORIG-GUID: xVwCPQ7LTETAJW9GHYvNUjkjegQDlgD7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAwMSBTYWx0ZWRfXxpAr95dIbycI
 gzgOTWJscH0ENKg4eiJSnhRC9GBiI7TE+FDqbhUSc7tFsv2LWcbnIO8ZTDQuchcAkiQjww0NY0u
 4JwoI5MLJt92ycbf4n7yRWSMpYEsYf7sotEC2Aomjpj+PPJsKDpYi5Clw/W3FMcjtpFiInxtK6z
 zZy3f70MWHVqoRsiEld614tI3dYz7qBpy19H2bh6KtQthcTy5ypxHAiie3reTPsUyC3c2xYn+4y
 YOfzu1t1FULQZlbmOMxy8bnoMJy20zU9h/pl5tRfQg8jVeueJl1moUf1McKD0aqVQ013KnUsFiB
 +2DGI5C422FWFuVyMJ0BUYo5r6QY5qdFrTbGd8O/9JRCVe1DK2VQ9w1RNQsFoAPN/QCuAd0d+hQ
 BD3bDkiXyPwDuw2e03Th1T9PZGzwrDJPstazhLaFnxAuqR2ZRFpsTSes66/DitGnCtP8fqDcZUu
 LkCh8+ajO9eChrRSe/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 adultscore=0 spamscore=0 clxscore=1015 bulkscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220001

On Wed, 21 Oct 2026 20:39:09 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Oct 21, 2026 at 11:11:15AM -0700, Jonathan Cameron wrote:
> > On Fri,  2 Oct 2026 20:31:52 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> > > Provide an implementation of the CONFIG_EFI_STUB_DRTM protocol for ARM64
> > > DEN0113 >= v1.1.
> > > 
> > > First, it queries the FW for support and collects all the
> > > information. This is needed to compute the extra_size, which comes
> > > from FW reporting how much memory it needs during the launch for the
> > > DLME Data and DCE-owned data. The generic stub ensures there is
> > > trailing memory after Image for this.
> > > 
> > > Then the DRTM_PARAMETERS launch structure is computed using the
> > > offsets in the efi_info.
> > > 
> > > Finally, the stub does ExitBootServices and calls the actual launch.
> > > 
> > > The feature discovery process is deliberately fairly verbose to help
> > > debug any FW weirdness in the field. Enable it with efi=debug
> > > 
> > > It looks something like:
> > > 
> > >  EFI stub: DRTM: interface version 1.4
> > >  EFI stub: DEBUG: DRTM: TPM algorithm 0xc, TPM hashing unavailable, PCR schemas 0x1
> > >  EFI stub: DEBUG: DRTM: minimum DLME data 73728 bytes, Normal-world DCE 0 bytes
> > >  EFI stub: Decompressing Linux Kernel...
> > >  EFI stub: Generating empty DTB
> > >  EFI stub: Exiting boot services...
> > >  EFI stub: DEBUG: DRTM: will launch, selected launch features 0x0
> > >  [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x000f0510]
> > > 
> > > Eventually the launch'd kernel is going to require built in crypto
> > > libraries that match what the FW is using so it can validate some of the
> > > information left behind during early boot. Refuse to launch if these are
> > > not built in and build in the most common ones from the ARM64_DRTM
> > > kconfig.
> > > 
> > > One nit, if the platform does not support SMC then using drtm=auto may
> > > crash on the SMC op. As far as I can tell there is no way to discover SMC
> > > support through EFI. Learning it from the ACPI FADT is doable and costs
> > > about 250 lines of code.  
> > 
> > Ouch. Sounds like a must have if there is no easier way.  
> 
> Yeah, maybe so. I will include the patch in the next version. Though
> I'm not keen on it and I don't know very much about ACPI.
> 
> > > +/* True if SMCCC 1.0 or later is available. */
> > > +static bool efi_arm64_psci_smccc_compatible(void)
> > > +{
> > > +	struct arm_smccc_res res;
> > > +	s32 status;
> > > +
> > > +	arm_smccc_1_1_smc(PSCI_0_2_FN_PSCI_VERSION, &res);  
> > 
> > A function that is meant to check for smccc 1.0 is using the
> > smccc_1_1 namespaced calls?  Maybe add a comment on why that
> > is ok to do.  Is anyone actually using SMCCC 1.0 on systems like this?  
> 
> This is a good point, I didn't quite get all these details at the
> time, but yeah, technically we have to use the 1.0 calling convention
> due the register clobber differnces. The other reason is we can't use
> the kernels 1.0 helper since it is an asm function not an assembly..
> 
> Fixing everything I came with this:
> 
> /*
>  * Discovery must tolerate SMCCC 1.0 clobbering x0-x17. The EFI stub cannot
>  * call the kernel's out-of-line SMCCC helper, so issue these calls inline.
>  */
> static u32 efi_arm64_smc_1_0(u32 function, u32 arg)
> {
> 	register unsigned long x0 asm("x0") = function;
> 	register unsigned long x1 asm("x1") = arg;
> 
> 	asm volatile("smc #0"
> 		     : "+r" (x0), "+r" (x1)
> 		     :
> 		     : "x2", "x3", "x4", "x5", "x6", "x7", "x8", "x9",
> 		       "x10", "x11", "x12", "x13", "x14", "x15", "x16",
> 		       "x17", "cc", "memory");
> 
> 	return x0;
> }
> 
> /* True if SMCCC 1.1 or later in the 1.x series is available. */
> static bool efi_arm64_psci_smccc_compatible(void)
> {
> 	u32 version;
> 	s32 status;
> 
> 	version = efi_arm64_smc_1_0(PSCI_0_2_FN_PSCI_VERSION, 0);
> 	if ((s32)version < 0)
> 		return false;
> 
> 	if (PSCI_VERSION_MAJOR(version) < 1)
> 		return false;
> 
> 	status = efi_arm64_smc_1_0(PSCI_1_0_FN_PSCI_FEATURES,
> 				   ARM_SMCCC_VERSION_FUNC_ID);
> 	if (status < 0)
> 		return false;
> 
> 	version = efi_arm64_smc_1_0(ARM_SMCCC_VERSION_FUNC_ID, 0);
> 	return (version >> 16) == 1 && version >= ARM_SMCCC_VERSION_1_1;
> }
> 
> efistub can get away with this inline asm since it isn't 32 bit and it
> doesn't deal with quirks.

Smells plausible to me.

> 
> > I a bit surprised we don't have a common helper for this -
> > I guess the version checks are often explicit in a particular
> > driver being bound.  
> 
> The PSCI stuff in the kernel is all very early when establishing what
> the channel is and is done only once. Here is a bit different
> since we only accept the smc instruction used by drtm..
> 
> And even if there was a helper we can't really call it from zboot..

True enough. I was just hoping there was code to compare this with :)

> 
> Thanks,
> Jason

