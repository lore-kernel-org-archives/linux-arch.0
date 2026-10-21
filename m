Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792604854;
	b=OPoYMhOnDjodL70cAhkXpu6pshs6YM8YDNj9fSZ22s9Nu9p8BKjG4QIolclda+0XQ3cO
	 6qs15fum6fa27pqP5SrwbgxMUKXpb2QN4UVe/XWUV4AWh2ibOVG9U+QMRH4RthFSOgSKc
	 RS0en9WRjG47yFOAZ0pDyVgWXJbcyvDfoNGXmsZLkDlbf5KHjpLx1/w1FQHnMNu9DA3NK
	 v91o5qJoYdoGHCRktlLuK25Cdi9b/3RKLyQO/Eh3FT5oNgTjCs3+l44gdevICJNVkdAi3
	 F1sIxH4fcdO4OfWRN8q2IX3aKV+xLWYTA54bh1DtTgBsOz8jAxvxk0OimnAryRMzJkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792604854;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=kD15e1tCEFZb0oDM+2xTBELmNwYQTz7QW2OQ3oM2K7k=;
	b=TFgD7tdL/b8KIiTNPJ7jKn5/EoKd5T0eB4iUvY4yOz5uw/6AsPiRXB0VgQX7nAt510TE
	 v8Xp6wuQqn6DBjwwaMWy2vV2BizrL54SMMebKozI1uMcXnfDpS08ncOU7vtzBQAbkNbJN
	 kaqVkbMgVcNIzlvKm+/rtBT6PNveKDpPhuIjg8I0z2MpTH0wL7UI3AiE2D+2aKUM0IRTU
	 jv2Im71u35mDmODfD8dWlxJq94VdBZujroVO6cOLShgP+0twA0yM4gnfN6eKrEhy47bhY
	 9zj+32PeKlnWOqf2Qyyk0ceICAJV/h6wRkjwDbHDa0b/JhXDG2WuZ8Bc8Aw/0MGvOQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hfpCRj+j;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LxyvmbLd;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6F3606A319
	for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 17:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A6F3606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hfpCRj+j;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LxyvmbLd
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LFU9P43727462
	for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 17:47:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kD15e1tCEFZb0oDM+2xTBELmNwYQTz7QW2OQ3oM2K7k=; b=hfpCRj+j2KxWdKAB
	AHRIXbKs8512TkOfMBg7uAuf4pQwBrgHnCXqjXGBqRwBoq/H7P7OrFgZF0Zfi+tR
	vu+VfuJDugBApslvid6veWNBEZZcyRXJAke9i6292jK0t0YZGi9NrNaWSpT8tY+V
	s0gVcVKmPr81HHIdp7X7HflfO6HpD/K1SRGxm3CFbfoBQBPSdCsoYQ7ODmPPoU7T
	R3UtMzJ9hljMDpG1WZQeQQuRgdzWHC+h+yxC/BvbZHBOb3CssvTUbrb7Z5UqBp16
	83IkxTQ0zg67ak7mU7qRBBySHW1fHCbjzIGN0Kp3HDrdNz9pEeOQETK0hUBs98qx
	h9bHVQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hesy7ae70-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 17:47:33 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1383723dfddso1643641c88.0
        for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 10:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792604853; x=1793209653; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=kD15e1tCEFZb0oDM+2xTBELmNwYQTz7QW2OQ3oM2K7k=;
        b=LxyvmbLdOsZxUwrTx1onxCooip8x4q/sb4QyCokMkc2qtq/N9VNCawNfuzRzDY3WnN
         5VH0FCiN5eAUTOseG5A5LiFEcHt7L1nKqsnbyN/oZBUMidpiJLhBXxTIBIqbzwNzbfje
         8waG3/t7QFmpiDSsk9gNWJvToE2lvN+2WXT0MmTYCpMScTs5bTRLTQCM/09zx4wUj3xN
         35hYYe5lOoPNAyk2buaHqcY9GgRrktpCpggEtZcemKKfFaKr87K60I9rQba3EB59we7m
         ZNv3Kb2PQIaAIR035ItnPyK7XduTXioO2l0Gv/RpFaBL9ghrY5ST3Wrbudn4WtW4g6u5
         NUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792604853; x=1793209653;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kD15e1tCEFZb0oDM+2xTBELmNwYQTz7QW2OQ3oM2K7k=;
        b=ckLzMGQajdMNJxaY3razYWD4HUv4PgXlh9i4ZFbqQX/TROa/qe2jwcSJRNe3t88+Qn
         uWsuji1CGXUFs5/5gsViST44jdTU+dl0pD+umTkNyIRwQPivz88oEphGSi5GzcWPjaPU
         df0hDuiqWXF3jhJPy5q1oFpHUY3FH+SdaxeNusNiBbUiDQUuUfnpJ0mCNP8pNzfepSgt
         cdbDzjM0u36vei90F6knFx9ezbDQFTDjjOZjWymAFBypVHzwU8dQklLf7sDp60IOiuNK
         RN3RvXLOqRoz3m0mjOZJrgP1qtuRzUMqKo0A3LG3FiMPIbvpoGz/gZ/4qEyM+2RybC7s
         CikQ==
X-Forwarded-Encrypted: i=1; AKwUvByXlyPbcxEdxXe2MtpDOQIs5l00J/uYqfMXnOsexvWyNn9ZStgWTWTjXNew4E178B09bhyYgOI8vB3+@vger.kernel.org
X-Gm-Message-State: AFq9FYKL3uVlgNAVwHLresle1CkTsIaW9VbW+jFw6OUNg1wZOsMS2jCP
	79jbYVn3lfxRszH5pM13MAdXNkbUYuJswem2xeasTXHcjQ57BI6G6ZwJJShxgWAfocQYYKJ0Wss
	JuFKrOUO5Y9sgRR6gACh1zqA2u8LFqbIREKHt+1by0vWBOKA29slUNniE8DGjJkXZ
X-Gm-Gg: AYBFou1JighXyelcMSGxywMLJSBsmhA6+XcSijVjSlqtzeeQCalj88dP6IzCfBz0/Ez
	YVbaD0uvC4C5OG04abtKbNqol28kIBjix8aHDDh84LfygFE4NV8xi9M4b22gzPZcS0wc4RjGK0O
	uMNonNbtV0Ko5CGJkktLvaDme9e4zndjCJLpx4gNarBYUxLLjyjNwiOtuKz7hDSPH2EYfd7Rbzy
	dDEeyt/uaH4rFeDF5QO/aE3Jj1tT7VExdIw30PNPAeNe/QMsaftgk23j0zLDkaqbqAjy7PNkrpl
	kWHwEVYMuVOJNWpNQeQyUu2Hpn47/vqJq3gQ6DMoceugZcXIxtAJw49p0Lykju4d4mVyaxpWVJz
	ZlAEhni463P0U4IR4KaYk0r2vg6kTomD1kvWfm5RoKA==
X-Received: by 2002:a05:701b:4214:20b0:143:297c:276c with SMTP id a92af1059eb24-190a5d6f349mr3478013c88.33.1792604852523;
        Wed, 21 Oct 2026 10:47:32 -0700 (PDT)
X-Received: by 2002:a05:701b:4214:20b0:143:297c:276c with SMTP id a92af1059eb24-190a5d6f349mr3477983c88.33.1792604851896;
        Wed, 21 Oct 2026 10:47:31 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36740cc848fsm8915123eec.13.2026.10.21.10.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 10:47:31 -0700 (PDT)
Date: Wed, 21 Oct 2026 10:47:26 -0700
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
Subject: Re: [PATCH v2 14/15] arm64: drtm: Call UNPROTECT_MEMORY
Message-ID: <20261021104726.00002640@oss.qualcomm.com>
In-Reply-To: <14-v2-989a18390eb1+486-arm64_drtm_jgg@nvidia.com>
References: <0-v2-989a18390eb1+486-arm64_drtm_jgg@nvidia.com>
	<14-v2-989a18390eb1+486-arm64_drtm_jgg@nvidia.com>
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
X-Proofpoint-GUID: tbKTsMT_QcGhX5rKnefPCBc47hphfAXR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3MCBTYWx0ZWRfX+N3INZ7LtbkJ
 M8tvHZJ/hF7KmWNAs+LVgk/OSyck9UtUiNwew1catqDI0bIFluPrNdISYPXUPN1H9xWAdOi9oWU
 grV8vOnn56tcEDYTIa3pcSjarxjdD4wBSfxEZGYnxJ49LmMwCkz4MMmYXY9XNCvSSrogKn53EWp
 1QEOtis9yZ0mZr4JiBAGQNoQ5vtF6ADKRK6f8b1jGo2NVvxyHIA1vG6fJIxJzXm2TDMNHVMw9jV
 4Sw6MrOP+3gBGjvKQADmPF49Bn/eMb2Ga/KnZ/O8qyM1EdAXc4o7FgX89dPSNRZdUIxATdPIzvW
 3Q4ZM6lWKOZk4vjIx/x2viQaDZ7zm1SvmImumy0yQ9wzO4ONtjDpjNKbtQlWTOXu8B5Gtcnf7YU
 CoEe0PvtRXDzEXObLv888piE8z0QxZucr9I8IBQQKPF1p6MY+q70UeX/TDu4xx6JqgHNnKwxhrQ
 55pwmbshYsUPDhWM87w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3MCBTYWx0ZWRfX7YsHqj7uq94y
 E3lTxbMMCA2rlnKESabPF6x0Vk2oy/1wsvCusxNKJ2ZmVwkxRUzr9dimoylruTdvzLrk5thThPp
 P72HBVYBS5ZhQOmbTb2QZypo+OCaI6Q=
X-Proofpoint-ORIG-GUID: tbKTsMT_QcGhX5rKnefPCBc47hphfAXR
X-Authority-Analysis: v=2.4 cv=IPaXmQvG c=1 sm=1 tr=0 ts=6ad8fab5 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=Ikd4Dj_1AAAA:8 a=4lc54p1sSd76nvOad-kA:9 a=CjuIK1q_8ugA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210070

On Fri,  2 Oct 2026 20:31:51 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> The stub always requests ARM_DRTM_LAUNCH_DMA_COMPLETE. On a system
> with an SMMU the COMPLETE option is sanely implemented using the SMMU
> global abort register. DMA_COMPLETE should be mostly a no-op. It
> seems to be designed for the region protection mode that Linux does
> not use.
> 
> However, the FW can still do something interesting under it and we
> should call it. Choose late_initcall as we know the SMMU drivers are
> loaded by then. If some platform does actually block DMA beyond the
> SMMU, then this would result in a noisy failure of built-in driver
> DMA, not a silent security gap.
> 
> The platforms I'm aware of are OK with this placement, and it is a
> reasonable place to start.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  arch/arm64/kernel/drtm.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/arch/arm64/kernel/drtm.c b/arch/arm64/kernel/drtm.c
> index 14493948a27f0d..6062980a5d9e53 100644
> --- a/arch/arm64/kernel/drtm.c
> +++ b/arch/arm64/kernel/drtm.c
> @@ -3,8 +3,47 @@
>   *
>   * Support functions for ARM DEN 0113 "DRTM Architecture for Arm"
>   */
> +#include <linux/bug.h>
>  #include <linux/efi.h>
> +#include <linux/init.h>
> +#include <linux/printk.h>
>  
>  #include <asm/drtm.h>
>  
>  struct arm64_drtm_handoff arm64_drtm_handoff __efi_data_handoff;
> +
> +static int __init arm64_drtm_unprotect_memory(void)
> +{
> +	s64 status;
> +
> +	if (!arm64_drtm_handoff.drtm_enabled)
> +		return 0;
> +
> +	/*
> +	 * Currently Linux can only fully support a DRTM implementation that
> +	 * relies only the SMMU.

That sentence doesn't parse.  relies on maybe?

> This should be called directly after attaching
> +	 * a driver to every SMMU but before binding any drivers that want to
> +	 * use devices attached to the SMMU. Our boot flow does not have a way
> +	 * to do that, so for now call it here.
> +	 *
> +	 * For SMMU based implementations their UNPROTECT_MEMORY is probably a
> +	 * NOP since touching the SMMU here is forbidden, but they may still do
> +	 * something interesting so be sure to call it at least.
> +	 *
> +	 * The stub excludes the most likely case of non-SMMU by only using
> +	 * ARM_DRTM_DMA_PROTECTION_COMPLETE, which is defined as:
> +	 *    Complete DMA protection is hardware-based enforcement at the SMMU
> +	 *    that blocks all DMA from Non- secure devices."
> +	 *
> +	 * For now if people have such systems they cannot include built-in
> +	 * drivers for any DMA devices, those have to be modules to be ordered
> +	 * after this.
> +	 */
> +	status = arm_drtm_unprotect_memory();
> +	WARN(status != ARM_DRTM_SUCCESS,
> +	     "DRTM: failed to unprotect memory (x0=%lld)", status);
> +	if (status == ARM_DRTM_SUCCESS)
> +		pr_info("DRTM: launch completed\n");
> +	return 0;
> +}
> +late_initcall_sync(arm64_drtm_unprotect_memory);

