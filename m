Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77865347BA9;
	Wed, 10 Jun 2026 17:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781111142; cv=none; b=uZWqOaPERYnARMMcP9N61Vz5mhg3tS99FHXI/IuxFmwLpwmXbN5TSExcRWznXTq+O8UNza+mdpI6Ep4HCn8cTlc5SiK8uVutG7MikxtjvsRDNAhVmCrJlMILCMcCgUHmd3RZbGmhM/UU0rxnRXf9E+xHgZIs45ZW1WYZ/CrDg34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781111142; c=relaxed/simple;
	bh=FoKUPjVS2yqChr13zxKJmc7Jy67i3fLW1yE95E1Q3lY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ajE2wioFjaRePC0YRIwwWB9KyPoDsH90GRNzKwLcABoUqfG5OwEU5kmCpzsmzbTw1iQ+Y7pJEAECYS0j3gOZoeMFaPuEKNJyNv8qeeHyP+1u2Q+76L53mwO0Ug0ieqipww97m0bwuJO1ZVl6hpI3rvpKhtJZtRIcFWZrj0fSBmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=I/tZjp7R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aNhvtegL; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="I/tZjp7R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aNhvtegL"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B82B314000A9;
	Wed, 10 Jun 2026 13:05:39 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Wed, 10 Jun 2026 13:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781111139;
	 x=1781197539; bh=e8awhWVorz38yIuvReRRJK6Nopj+kEe7dHTRwLJI5YM=; b=
	I/tZjp7RV0TYsh9pnfe6DMZUHwQcC+wcXiyqDAoQQtUf/Aq+mCjSqwu32pKhlv3b
	onel80rL7PNnmZOpErU2CI7Oj9PJxe9FYjfga1eHgXBQFzbMpyGUesIahHEq/yeS
	g7AdmABeM/sComupKewVS3VPdzceyPiugXVN13v3HrFCHMBa3pGGEe9JghfLooZi
	5W9gqiY/DZcgUx6WzuJOFseg0YUdu+ytI0hMpEuG8DiDzMOli6xFBlO2b0UnRkvI
	BCBXhPYXy9jB1MK37KxkaVjbxrlrcy9Qd6vOAkKxhfgRNM7gePSpjajmnW5Qxk8a
	0RCTkqypPsNJLwjm/i4F0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781111139; x=
	1781197539; bh=e8awhWVorz38yIuvReRRJK6Nopj+kEe7dHTRwLJI5YM=; b=a
	NhvtegLQXU6s46KGMlzen0uaqpyegAC6Cmohg/cWcQ4soqYl2MLkpKRHRRGcmB7b
	gvKqs/50BAWOQYn2/10ToN1EgICCqlxcnJwTzpY3Hto97QpxDHWKdvr/Yw84cDsF
	PqjynzdZs+25yS/m2ZTWm/QnOIN9tunxmAntIm8DikV65R5fXpwXXF/5UoJaMWac
	LdHKgmTi26r4L57g4jl4z4qLrJJ8kvRGjUyXFAX6twMRvK6D8JJvwJ08PKy+ZyHd
	Wh8c8ausiun1FZ5VzWTz6RcLmtHovixwyPvjCiCix4qG6Et4TBylFUqKRsk/wfLB
	ZiJDdYR1NxcXk2b+8JUQA==
X-ME-Sender: <xms:Y5kpaj4WSaixdoDsV_-lX7aFHc4GU2gEnwsYMpswZwbVPR1-bVh6AA>
    <xme:Y5kpajsA0XF6bAED2GTLggziOJl3tvbY_gGC_Zj3bZDHSc2jH93VlJZmH3cw0OHb4
    wQ5fRCWhiUt3nn9BMbWgpD9w5mfZ85VP0rc3fgK3lKafGW-T4LtNBQ>
X-ME-Proxy-Cause: dmFkZTFafDG/NYujNQLZNmw+l6RnwHC65slhH5KowelXTirb3dtxT41VrGFN5KepZDPHU/
    ghAssV3R3GHTzhF3Ro38iMoUlgVcxKsVCej1YUAvq6kdQqq6KqK5RmDy5iY3bxmxlpy39p
    myMCbIEeoR2NjKu1PmAN0vpCahdlwuDvSENG91+dHlaOKCZF8uw6yCBR7UtdeKFXScqiUv
    RcYGUJXPimb1hHguyarIsobt4qjudoPRL4SPubZDh3w4bDQ/h2ZqnBg0phVWwOD8vLsDc6
    qWCbB/qdMB/LFzRvv/alehn4he4srgfp0ugOZsMtXMXxkPOOfBIT+nOCfjYicfPQuI2Cos
    4SLULznUNSiZvkWKncPwCtnmLYb7VebZxwabNAN2DR3sfb7VgyG9SKykg421n6YHK2pvWv
    zTOoWc7UYfHmYKhcDK9FdKjWIoqvgfSNjdTwPZocCrbDTiBvmFOkjJeo3mR05LcEG4dwLd
    L7nZXjPTm6YbK7CNIs4D/sj51RmZGwaG4TKPO/vCeAGy2tERrmTa91YEcyqrZ4fx5Lq6EP
    Mlf9ZeripWJZFDLCpjhbzo1GpARAsk2AjcJN9E3V3k6UJzNxmJAgykuGaX/7s7I/2lvmqR
    2xxfykY0mB6xLL8ffsXzBEe2g8hZXw/RFk01b5/dtUU+6DU/plcSzopYQGmA
X-ME-Proxy: <xmx:Y5kpany2M4XzxoKv4QvNbng-k1OTnge25ehljHIeSuqF8fEa194wdA>
    <xmx:Y5kpasPY1IJkWE2_B3xLlxvghAPODRaaiucig6xa_he64d7_CrKg8Q>
    <xmx:Y5kpas-aDFKp-_NDMOODnBzQU8sfEoC5pjsa5aNmZhKQ5fAv-z7t-g>
    <xmx:Y5kpap5yhqMYDZlBcKLhM8BjgUoOF-5xEUgt3iEMQRlfc_1aPmuO1A>
    <xmx:Y5kpanRkpQ8t0xAsyhERvbUQnV14OA9xkmJ9QRLt-wh1TQ_2IJkNc58A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4A2C6182007A; Wed, 10 Jun 2026 13:05:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A35GQ856c1Rw
Date: Wed, 10 Jun 2026 19:05:18 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ricardo Robaina" <rrobaina@redhat.com>, audit@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>
Cc: "Paul Moore" <paul@paul-moore.com>, "Eric Paris" <eparis@redhat.com>,
 sgrubb@redhat.com
Message-Id: <476e0a44-c6fb-4e6a-af56-a9f1d054518a@app.fastmail.com>
In-Reply-To: <20260610164719.2668906-1-rrobaina@redhat.com>
References: <20260610164719.2668906-1-rrobaina@redhat.com>
Subject: Re: [PATCH] audit: add missing syscalls to PERM class tables
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Jun 10, 2026, at 18:47, Ricardo Robaina wrote:
> diff --git a/include/asm-generic/audit_read.h 
> b/include/asm-generic/audit_read.h
> index fb9991f53fb6..8feebc5b4c50 100644
> --- a/include/asm-generic/audit_read.h
> +++ b/include/asm-generic/audit_read.h
> @@ -18,3 +21,19 @@ __NR_fgetxattr,
>  #ifdef __NR_readlinkat
>  __NR_readlinkat,
>  #endif
> +#ifdef __NR_file_getattr
> +__NR_file_getattr,
> +#endif
> +#ifdef __NR_stat
> +__NR_stat,
> +#endif
> +#ifdef __NR_lstat
> +__NR_lstat,
> +#endif
> +#ifdef __NR_fstat
> +__NR_fstat,
> +#endif
> +#ifdef __NR_newfstatat
> +__NR_newfstatat,
> +#endif
> +__NR_statx,

There are additional variants of 'stat' that I think you need
to cover here:

scripts/syscall.tbl:79	stat64	fstatat64			sys_fstatat64
scripts/syscall.tbl:80	stat64	fstat64				sys_fstat64
arch/x86/entry/syscalls/syscall_32.tbl:18	i386	oldstat			sys_stat
arch/x86/entry/syscalls/syscall_32.tbl:28	i386	oldfstat		sys_fstat
arch/x86/entry/syscalls/syscall_32.tbl:84	i386	oldlstat		sys_lstat
arch/x86/entry/syscalls/syscall_32.tbl:195	i386	stat64			sys_stat64			compat_sys_ia32_stat64
arch/x86/entry/syscalls/syscall_32.tbl:196	i386	lstat64			sys_lstat64			compat_sys_ia32_lstat64
arch/x86/entry/syscalls/syscall_32.tbl:197	i386	fstat64			sys_fstat64			compat_sys_ia32_fstat64
arch/x86/entry/syscalls/syscall_32.tbl:300	i386	fstatat64		sys_fstatat64			compat_sys_ia32_fstatat64
arch/alpha/kernel/syscalls/syscall.tbl:224	common	osf_stat			sys_osf_stat
arch/alpha/kernel/syscalls/syscall.tbl:225	common	osf_lstat			sys_osf_lstat
arch/alpha/kernel/syscalls/syscall.tbl:226	common	osf_fstat			sys_osf_fstat

Not sure about ustat/fstatfs/statfs, I suppose those are a different
category, right?

       Arnd
