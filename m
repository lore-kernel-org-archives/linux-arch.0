Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582DC43B3E5
	for <linux-arch@vger.kernel.org>; Fri, 25 Sep 2026 18:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790361445; cv=none; b=BwcBhxoqwCNLR6/IJ1EN9f+ltTvmLx8ycHU2+/6Mf6BeW4bEntX+dPJQys+RvyBQcOYUPWxgjLc1EnGVoRpQk0HKdNzVj+c65zHlpUjfWZ4cbO7t2h6fVXAjc81MB00lu0RbzNgLXj9MgtO6YLqnykuiCyKShCqs8Q0EV6QGsFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790361445; c=relaxed/simple;
	bh=Zz/8bIE4/JjIRagR4VS2gdwCyA+iHhw/k/7LSkO28R0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/IqgR25RjiJvrr0suoeCrvx2cgdOekErYL/4gTBNaTIcYjRKpmQ5K6g10FLrtsFTsFV3VgJjKOlfzqdFITqW77n8I78GSeQHGBJ6H1ahJmHmLyWgxp9Rmb7ypCJI3cnMgLVB/K4wJJsu/ogzo85p6uN9U8x7+gBK8dSa9G9NHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LDJZtO9N; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Fikg24FS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LDJZtO9N";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fikg24FS"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PGsipn2083185
	for <linux-arch@vger.kernel.org>; Fri, 25 Sep 2026 18:37:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qU9jfIhz1O12zDKLeEbU8SmuONKTAC52riWnQ1m5YyY=; b=LDJZtO9NqW208Kqd
	3VP1kfzgKaoXRi4TUkLtkZP//Cc0v+0CjPyv+Wd93Z2/Z3rdo/t/yhX63zxsUEvT
	qt6/16w/9/Kt8YdMzJsJdJNzG6QOzrgoBuTbaeRRpQJMXqGnDVHTlM31/yfCSUdR
	ecbNvirWlqSUL3gNn0pjC+BUnml42AR6fUykbAbpjdAEIV7lNTjlgcW39dhoziCn
	WwWHu4dtMr/H0QWiDSybuZoD+Lni+KjTZXnQj+heQ8BJLhF1YnuUELyYgqIKhnYF
	hfDwDQZ25P0pfoBHdtfZgWvboFW6c+n6PArKrWbfpqRc63PjfO31OC/I3sv5RkhB
	SUCSWw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwvw1gdrh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Fri, 25 Sep 2026 18:37:22 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-313d1015161so4088384eec.1
        for <linux-arch@vger.kernel.org>; Fri, 25 Sep 2026 11:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790361441; x=1790966241; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qU9jfIhz1O12zDKLeEbU8SmuONKTAC52riWnQ1m5YyY=;
        b=Fikg24FS3Q16rDa/mZJeAfsHTfb1X8Ea15+KmdxRSiIRNoYiX6rDJTla2CXtAGLTfj
         ABCybSr9dJxnsmjc+vY62VpFdSnX7yAfkUg0n88ipTmvqSZm1pYVNFiB1mxiV/ip39Va
         jDxpm7Z6g5NmjiyDJeLgEILRvpgWWUiXaF5Tcz2B6vQLMtpHTcYuLZR9LPZgv+cqDIzD
         Uuc1tZhpIEM+25Hx0WbJqO8lDRBLbJ7Y/HjxiJwJVSi2Z2IjLxuSrWhQIoOkg/ktdwJq
         kVwAU84jeooonz1vCMsJoLJLUyEyoDF34DJk7RikdoUD2qvp4LtiXqhNYaL9rohdMIIs
         HAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790361441; x=1790966241;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qU9jfIhz1O12zDKLeEbU8SmuONKTAC52riWnQ1m5YyY=;
        b=S3uQhmxXr6nWV00noQ13PPru6flmDp5lv784p0iQUzwb49yReVLp4ZTP+8Y2xCRPRW
         PzlzrwiytrqSNRhLq5DYKjUf6GRyyI3P188mnOURUM5LZfSv7OjML7hfTlHYY8J5T07M
         DTvrowjRrEfCZWiRszNEb3vBm3bV6GyxAZNhWB9YE4pz+VQ8El3YynAOfcephSJIW7fF
         SgylA9S06CkmvwrQJOm6tNmDcCLVt1wI5ue3q7VeaLNfNBo+suEIp2OK0f56Zr1i1WEz
         XbNFnLM2RpCntcwIrbDoI757T/RewFu+MNuuuztuUEwf2Tj6D3Yvfkiy2nft4/15y5Bv
         mtLA==
X-Forwarded-Encrypted: i=1; AKwUvBxpEXL7YPZh7oObIQvTog2QSF8ba1DvEZbBI9LSj8DbsojLv5QFMRDYe8fgGkyJh8S791IEBQeY2ilS@vger.kernel.org
X-Gm-Message-State: AFuF++kfRNpcISrLwaEyYH7T53pAh0hfQ1JU7FiDdqmI3PqgOm/WfTsC
	5V4JTOr8O087AgsB9toE9W/fg/gq8VMnPIJ3tIhQ7v348508mTNngR+pWSsbfhlZ/CHSSlJd7xA
	7dd5bk/rOvbt61gcJVK6eB6EfxHTKFTdyXgtiWtilCTzGseuS+1CW38Mb9Eb0tXOM
X-Gm-Gg: AYBFou0Rwy8djqtfdbykHcAyJcAXhJBwQUan9/LPuPPAREKSgdmYGpBELxqGTBNHDAG
	2y8V2ORDydUD6rUs8OnDabys0/GqQTJ5Fr0MAWxfU6zt7Fg+LCGuvsFDZoY/2NCPRoO57o/TyS6
	GePuYXhD3rdTa/T90qPEecXhBr/9OllW/clqPbd4gHkLuP8f+L+pvxWpXfulTMlzNqkU1XTW92P
	8E9MxwEktsoJ0FJ+y/Cw2Zih0qtpZ0rM1UHS4PwBViIJ+9yLBRI1qWtMycv/ny1zCTdV4tknjbB
	z7VXPp4J0bQOjSJdO8407IB+j+8exvE4T9u4MjTRnnOtDURqDSvm5DTCdbwyxW5n7hmvu2hjRK/
	5RRkM+HfimfmCUlJeg+OIUE21NQRLhCLy4om4tx6yByXQalIyLIFJxg==
X-Received: by 2002:a05:7301:4d0b:b0:331:89d6:80e7 with SMTP id 5a478bee46e88-342703c0860mr981593eec.13.1790361440873;
        Fri, 25 Sep 2026 11:37:20 -0700 (PDT)
X-Received: by 2002:a05:7301:4d0b:b0:331:89d6:80e7 with SMTP id 5a478bee46e88-342703c0860mr981521eec.13.1790361439446;
        Fri, 25 Sep 2026 11:37:19 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3414407c548sm7322093eec.8.2026.09.25.11.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 11:37:18 -0700 (PDT)
Date: Fri, 25 Sep 2026 11:37:09 -0700
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
Subject: Re: [PATCH 16/16] efi/arm64: Implement ARM64 DRTM in the stub
Message-ID: <20260925113709.00005cd1@oss.qualcomm.com>
In-Reply-To: <16-v1-27d06b313981+8b-arm64_drtm_jgg@nvidia.com>
References: <0-v1-27d06b313981+8b-arm64_drtm_jgg@nvidia.com>
	<16-v1-27d06b313981+8b-arm64_drtm_jgg@nvidia.com>
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
X-Proofpoint-GUID: NmImrQ-niOuMzf2l_WlDSff2ybj9o-eg
X-Authority-Analysis: v=2.4 cv=YqCa1IYX c=1 sm=1 tr=0 ts=6ab6bf62 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=Ikd4Dj_1AAAA:8 a=jWgNheo0oZ5oaBA2q4oA:9 a=CjuIK1q_8ugA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: NmImrQ-niOuMzf2l_WlDSff2ybj9o-eg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3NCBTYWx0ZWRfX3jnufLFrofSx
 5A8A1uqfQNEedKMOqybszgiPI71Mr1pP0j+9gu+ySzrxRLtnXe8L62DfAzQpwLnkBZ4f5WFFMjp
 Bznipk9vTyclBhbAyHx2LoOJquipYoPAogIyR1xLjdrLxP2PBQKP9LApeKq0AIfb+RJo0SPIMPG
 1ICF0tiMGkzgHet7YkZzaAc34H/7olUrhLYtdQIfumX/VhL8d25VKk78HMUUVTYNfz16L0zNhWe
 e0ws/m0t9xRftID6LUr41otSETXeLSgCzNjH5kyP4vhSNX835ov2tGnIk9eYyXtjsGrrNBerauc
 p6Eaw3nbm4seMiSCQR7JEk94vUHIo30DYj1qTJ1biSqvOYBt+rHxUkJD9AE8OjMwZuTO5/lFPAB
 ToBmhptsIrnFW/RrAFGIvyU8z4qKDCQ2DB9E6CcwU/VUY7M2ad8tiJrM6ETMyNKJT8/nf6eI7DA
 LnFIdulyy8q+1Lw9Nkw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3NCBTYWx0ZWRfX4fJHLbcEZk19
 6MVTb+Ih1TGSoYR3TrLH/cgGk4OnLEDoTzW0j20PMdxWz3pSwIvbR8pi0X2/ooP0Us+IUN3UG/f
 +ht3FTUL1Fea50yiTz76MA9axxA4ZHI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250074

On Thu, 24 Sep 2026 10:53:19 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> Provide an implementation of the CONFIG_EFI_STUB_DRTM protocol for ARM64
> DEN0113 >= v1.1.
> 
> First, it queries the FW for support and collects all the
> information. This is needed to compute the extra_size, which comes
> from FW reporting how much memory it needs during the launch for the
> DLME Data and DCE-owned data. The generic stub ensures there is
> trailing memory after Image for this.
> 
> Then the DRTM_PARAMETERS launch structure is computed using the
> offsets in the efi_info.
> 
> Finally, the stub does ExitBootServices and calls the actual launch.
ARM_DRTM_FEATURE_DMA_PROTECTION> 
> The feature discovery process is deliberately fairly verbose to help
> debug any FW weirdness in the field. Enable it with efi=debug
> 
> It looks something like:
> 
>  EFI stub: DRTM: interface version 1.4
>  EFI stub: DEBUG: DRTM: TPM algorithm 0xc, TPM hashing unavailable, PCR schemas 0x1
>  EFI stub: DEBUG: DRTM: minimum DLME data 73728 bytes, Normal-world DCE 0 bytes
>  EFI stub: Decompressing Linux Kernel...
>  EFI stub: Generating empty DTB
>  EFI stub: Exiting boot services...
>  EFI stub: DEBUG: DRTM: will launch, selected launch features 0x0
>  [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x000f0510]
> 
> Eventually the launch'd kernel is going to require built in crypto
> libraries that match what the FW is using so it can validate some of the
> information left behind during early boot. Refuse to launch if these are
> not built in and build in the most common ones from the ARM64_DRTM
> kconfig.
> 
> One nit, if the platform does not support SMC then using drtm=auto may
> crash on the SMC op. As far as I can tell there is no way to discover SMC
> support through EFI. Learning it from the ACPI FADT is doable and costs
> about 250 lines of code.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
First read though only found some superficial stuff.

Generally looks fine to me.

Jonathan

> diff --git a/drivers/firmware/efi/libstub/arm64-drtm.c b/drivers/firmware/efi/libstub/arm64-drtm.c
> new file mode 100644
> index 00000000000000..12ddf7c2dd056a
> --- /dev/null
> +++ b/drivers/firmware/efi/libstub/arm64-drtm.c



> +
> +static bool efi_drtm_probe_memory(void)
> +{
> +	u64 value;
> +
> +	if (!efi_drtm_query_feature(ARM_DRTM_FEATURE_MIN_MEMORY, &value))
> +		return false;
> +
> +	drtm_cfg.dlme_data_size =
> +		FIELD_GET(ARM_DRTM_DLME_DATA_PAGES_MASK, value) *

> +		ARM_DRTM_PAGE_SIZE;
> +	drtm_cfg.nw_dce_size = FIELD_GET(ARM_DRTM_NW_DCE_PAGES_MASK, value) *
> +			       ARM_DRTM_PAGE_SIZE;
> +
> +	efi_debug(
> +		"DRTM: minimum DLME data %lu bytes, Normal-world DCE %lu bytes\n",

That code formatter loves the silly.  This is definitely not more readable
than a slightly longer line!
I'm reading upwards and got bored now - will assume you'll take a look and tidy
up other such silliness.


> +		drtm_cfg.dlme_data_size, drtm_cfg.nw_dce_size);
> +	return true;
> +}

> +
> +static void efi_drtm_report_previous_error(void)
> +{
> +	s64 error_code;
> +	s64 status;
> +
> +	status = arm_drtm_features(ARM_DRTM_SMC_GET_ERROR, NULL);
> +	if (status != ARM_DRTM_SUCCESS) {
> +		efi_debug("DRTM: GET_ERROR is unavailable (x0=%lld)\n", status);
> +		return;
> +	}
> +
> +	status = arm_drtm_get_error(&error_code);
> +	if (status != ARM_DRTM_SUCCESS) {
> +		efi_warn("DRTM: failed to read previous error (x0=%lld)\n",
> +			 status);
> +		return;
> +	}
> +
> +	if (error_code) {
> +		efi_warn(
> +			"DRTM: firmware reports previous launch error 0x%llx\n",

That code formatter is being silly again.

> +			error_code);
> +		if (efi_drtm_policy != EFI_DRTM_ENFORCE)
> +			efi_drtm_policy = EFI_DRTM_OFF;
> +	}
> +}

> +
> +efi_status_t efi_drtm_prepare(void)
> +{
> +	s64 feature_status;
> +	u16 major, minor;
> +	s32 status;
> +
> +	if (efi_drtm_policy == EFI_DRTM_OFF)
> +		return EFI_SUCCESS;
> +
> +	if (!efi_arm64_psci_smccc_compatible())
> +		return efi_drtm_failure();
> +
> +	/* VERSION must be the first DRTM call. */

Words like 'must' should be backed by a specific spec reference.
I couldn't immediately fine one other than common sense suggesting it should
be called to check we have a version we understand ho to talk to.

> +	status = arm_drtm_version(&major, &minor);
> +	if (status != ARM_DRTM_SUCCESS) {
> +		efi_err("DRTM: failed to read interface version (x0=%d)\n",
> +			status);
> +		return efi_drtm_failure();
> +	}
> +	if (major != ARM_DRTM_VERSION_MAJOR ||
> +	    minor < ARM_DRTM_VERSION_MIN_MINOR) {
> +		efi_err("DRTM: unsupported interface version %u.%u\n", major,
> +			minor);
> +		return efi_drtm_failure();
> +	}
> +	efi_info("DRTM: interface version %u.%u\n", major, minor);
> +
> +	efi_drtm_report_previous_error();
> +	if (efi_drtm_policy == EFI_DRTM_OFF)
> +		return EFI_SUCCESS;
> +
> +	feature_status = arm_drtm_features(ARM_DRTM_SMC_DYNAMIC_LAUNCH, NULL);
> +	if (feature_status != ARM_DRTM_SUCCESS) {
> +		efi_err("DRTM: dynamic launch is unavailable (x0=%lld)\n",
> +			feature_status);
> +		return efi_drtm_failure();
> +	}
> +
> +	if (!efi_drtm_probe_tpm() || !efi_drtm_probe_memory() ||
> +	    !efi_drtm_probe_dma() || !efi_drtm_probe_boot_pe())
> +		return efi_drtm_failure();
> +
> +	drtm_cfg.launch_features =
> +		ARM_DRTM_LAUNCH_HASH_FIRMWARE | ARM_DRTM_LAUNCH_PCR_DEFAULT |
> +		ARM_DRTM_LAUNCH_DMA_COMPLETE | ARM_DRTM_LAUNCH_NO_AUTH |
> +		ARM_DRTM_LAUNCH_KEEP_SECURE_IRQS;
> +
> +	return EFI_SUCCESS;
> +}
> +
> +unsigned long efi_drtm_get_extra_size(void)
> +{
> +	/*
> +	 * DEN0113 Table 6, feature 0x2 reports both minimum sizes in 4 KiB
> +	 * pages.  The linker places the DLME data at the 4 KiB-aligned end of
> +	 * the static Image as required by R314030.  The DLME region must
> +	 * include all of that data (R45200), and an optional Normal-world DCE
> +	 * follows it at another 4 KiB-aligned address as required by R312080.
> +	 * A final page holds the 4 KiB-aligned DRTM_PARAMETERS required by
> +	 * R312010.  Only the first area is part of the DLME region.
> +	 */
> +	if (efi_drtm_policy == EFI_DRTM_OFF)
> +		return 0;
> +	return drtm_cfg.dlme_data_size + drtm_cfg.nw_dce_size +
> +	       ARM_DRTM_PAGE_SIZE;
> +}
> +
> +efi_status_t efi_drtm_prepare_launch(unsigned long image_base,
> +				     unsigned long fdt_addr)
> +{
> +	const struct arm64_image_header *header = (const void *)image_base;
> +	const struct efi_image_info *info = efi_get_image_info(image_base);
> +	struct arm64_drtm_handoff *handoff =
> +		efi_get_image_symbol(image_base, arm64_drtm_handoff);
> +	struct arm_drtm_parameters *params;
> +	unsigned long measured_offset;
> +	unsigned long measured_size;
> +	unsigned long image_size;
> +	unsigned long dlme_start;
> +	unsigned long dlme_end;
> +	unsigned long dce_end;
> +	unsigned long entry;
> +
> +	if (efi_drtm_policy == EFI_DRTM_OFF)
> +		return EFI_SUCCESS;
> +
> +	image_size = le64_to_cpu(header->image_size);
> +	measured_offset = le64_to_cpu(info->drtm_measured_start);
> +	measured_size = le64_to_cpu(info->dlme_measured_size);
> +	entry = le64_to_cpu(info->drtm_entry);
> +	dlme_start = image_base + image_size;
> +	dlme_end = dlme_start + drtm_cfg.dlme_data_size;
> +	dce_end = dlme_end + drtm_cfg.nw_dce_size;
> +
> +	/* Quick checks something didn't go wrong during image construction */
> +	if (entry < measured_offset ||
> +	    entry - measured_offset >= measured_size ||
> +	    !IS_ALIGNED(image_base, ARM_DRTM_PAGE_SIZE) ||
> +	    !IS_ALIGNED(image_size, ARM_DRTM_PAGE_SIZE) ||
> +	    !IS_ALIGNED(measured_offset, ARM_DRTM_PAGE_SIZE) ||
> +	    !IS_ALIGNED(dlme_start, ARM_DRTM_PAGE_SIZE) ||
> +	    !IS_ALIGNED(dlme_end, ARM_DRTM_PAGE_SIZE) ||
> +	    !IS_ALIGNED(dce_end, ARM_DRTM_PAGE_SIZE)) {
> +		efi_err("DRTM: final Image layout is invalid\n");
> +		return efi_drtm_failure();
> +	}
> +
> +	/*
> +	 * See arch/arm64/kernel/vmlinux.lds.S for the DRTM Memory layout. After
> +	 * the DLME we choose to place the Normal World DCE region followed by
> +	 * the aligned DRTM_PARAMETERS structure.
> +	 */
> +	memset((void *)dlme_start, 0, efi_drtm_get_extra_size());

Is that efi_drtm_get_extra_size() adding much?  It is a little irritating to
have to go look in there to figure out that this memset actually covers
the params. If you were to just have the sum visible here that would be
more obvious and align with the comment immediately above the memset.

Maybe it is worth keeping for the big comment in there, but it does
feel like that and what we have here could be combined.

> +	params = (void *)dce_end;
> +	params->revision = cpu_to_le16(ARM_DRTM_PARAMETERS_REVISION);
> +	params->launch_features = cpu_to_le32(drtm_cfg.launch_features);
> +	params->dlme_region_address = cpu_to_le64(image_base);
> +	params->dlme_region_size = cpu_to_le64(dlme_end - image_base);
> +	params->dlme_image_start = cpu_to_le64(measured_offset);
> +	params->dlme_entry_point_offset = cpu_to_le64(entry - measured_offset);
> +	params->dlme_image_size = cpu_to_le64(measured_size);
> +	params->dlme_data_offset = cpu_to_le64(image_size);
> +	if (drtm_cfg.nw_dce_size) {
> +		params->nw_dce_region_address = cpu_to_le64(dlme_end);
> +		params->nw_dce_region_size = cpu_to_le64(drtm_cfg.nw_dce_size);
> +	}
> +
> +	/*
> +	 * The DLME Data contains its own size in a trusted header, so the
> +	 * handoff doesn't need to include extra_size. The DCE Data is only
> +	 * temporary so the kernel also does not need to know about it.
> +	*/
> +	handoff->fdt_addr = cpu_to_le64(fdt_addr);
> +	handoff->drtm_enabled = 1;
> +
> +	efi_debug("DRTM: will launch, selected launch features 0x%x\n",
> +		  drtm_cfg.launch_features);
> +
> +	drtm_cfg.params_addr = params;
> +	return EFI_SUCCESS;
> +}
> +
> +static void efi_drtm_fallback(void)
> +{
> +	struct arm_drtm_parameters *params = drtm_cfg.params_addr;
> +	unsigned long image_base = le64_to_cpu(params->dlme_region_address);
> +	struct arm64_drtm_handoff *handoff =
> +		efi_get_image_symbol(image_base, arm64_drtm_handoff);
> +
> +	handoff->drtm_enabled = 0;
> +}
> +
> +void efi_drtm_launch(void)
> +{
> +

I love trivial. Pointless blank line.

> +	if (efi_drtm_policy == EFI_DRTM_OFF)
> +		return;
> +
> +	/*
> +	 * No cache maintenance is required before the launch. DEN0113 R42130
> +	 * requires the DRTM_PARAMETERS to be accessible as Normal Write-Back
> +	 * Cacheable, Inner Shareable memory, so the DCE reads them coherently
> +	 * with the writes made above.  R45220 then has the DCE clean and
> +	 * invalidate the whole DLME region to the Point of Coherency before it
> +	 * measures the DLME image, which covers both the Image itself and the
> +	 * handoff struct placed in the DLME region. Thus once we jump into the
> +	 * kernel with MMU and caches off the CPU will see everything the stub
> +	 * wrote.
> +	 */
> +	arm_drtm_dynamic_launch(drtm_cfg.params_addr);
> +
> +	/*
> +	 * DEN0113 section 3.4 returns from DYNAMIC_LAUNCH only on error. Boot

I'd use a spec version for references + ideally title of section.
As much as folk may try, sometimes these things move around.

Also tweak the wording.  Failure sure the section doesn't return from anything :)

> +	 * services and their diagnostics are no longer available, so hang.
> +	 */
> +	if (efi_drtm_policy == EFI_DRTM_ENFORCE) {
> +		for (;;)
> +			asm volatile("wfe");
> +	}
> +
> +	efi_drtm_fallback();
> +}

