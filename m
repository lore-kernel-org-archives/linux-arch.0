Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491EE411699
	for <linux-arch@vger.kernel.org>; Thu,  9 Jul 2026 11:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783596051; cv=none; b=GlIOnqjedY0jNFnruhnumlwBG99wpiefTxnAdD3KOvavHvrbbKGJGc/T3f+VpMOLZW4rfyHVPe3yUOzv3/PQZxZ5ys+Ipojwb/XEHH8CcZINEGqIxJ/BPbN4WbdtMI0KhCXoiHbM3kLm2LVa8oGO3oJDNAlXeimlbmCaEPhVAHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783596051; c=relaxed/simple;
	bh=R+aFi5Oqdv0TDSr7wZR2WAPngeBl4pJ5LsNFoxiZF8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C7NsetSPneEZDu2q25KQg5coiHdpcKc65aBXuErjuf7me9LD6JyQQz+JBzrzFjTCbwPRDaJ/xKt0VLWYrhAlBit1JlOnUpkkgqzN4/bBDySritxh17qUdnKLnMYJJpSjjWOzIWrvXt2NVumzC1RAo/+9Dvi5Iiu63W7LogdKAxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iOWfjmK8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a7clZpL6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iOWfjmK8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a7clZpL6"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669Ax5Op1483553
	for <linux-arch@vger.kernel.org>; Thu, 9 Jul 2026 11:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E2VXUkO/1Nfb5542An87XlKwD9GRDm4PLC6Ooi7YQSk=; b=iOWfjmK8f8Y+DVJW
	EcnBVbRqoFetWpR+MvbIm0rNsCYEYiCVdv/jb+r7ZZuAst5pdACVTyVPX1hk4M4R
	UloW32yrnx0br0O0OZPBTsUXsGcPSz6fo0b7Z9SsSAlawkneGV3knPcGuKS4ecbQ
	qUgL7kJ1kZwezKuA1OHch6fG0wR/9IjoD0gaRXopgi656DtKQN7lmNG5nDcMpELo
	+2tydKrnvkk1mYPsPWN5nD/hRUDpTxejd9pRgo55t5XyFzKGEVSWfHJeObs1qXCX
	o+wuU7kKSC/wnWW5kZ8U0x7Pvu4fl9GPrm5rLmSBf6RmcKnNqHf8RgkEBJ09ZjsD
	t7y3cw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa1ydtb6d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Thu, 09 Jul 2026 11:20:48 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c01ff996dso17579631cf.2
        for <linux-arch@vger.kernel.org>; Thu, 09 Jul 2026 04:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783596047; x=1784200847; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E2VXUkO/1Nfb5542An87XlKwD9GRDm4PLC6Ooi7YQSk=;
        b=a7clZpL6nOtGSdXl/9VMFzxG3FX6J7Jpz5oRTdF3Ud3LP62vUE/2zfduFUE/Wg0Sqm
         w1xkr6dEnyY6T6tXj74TWHvp55bSy7Gu9OSAbXU+V8JTqHMHIG92VFPihlaUxK0k6We6
         suDfZ7lTXPJpRhiIrk/t18bDczgSnwKr7QZYvherjAIymulLlj6kidlUwdc2GZDQ4o40
         7c2tSW0WD7rNUUnlb2XWaPJv+kv92FjKKxiIEgZLP2juJ90L5oEGTKW1vW9KeDnzN+2B
         W4/I9Kif0Idgk83Lb1M2eQkLA1l1kX/2DMrxOMccuXA772LF/TW/pR7thgHMiiY0edpu
         SkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783596047; x=1784200847;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E2VXUkO/1Nfb5542An87XlKwD9GRDm4PLC6Ooi7YQSk=;
        b=RZ1IJtpYHrHbubN2lMSl+E+pr4ufKJvJMyJu7u3fEjF0Vvm0ZvuuphEL3/goKXjmZ4
         Z+s7uKlXKNpjg6iJyXXjHCTdCLZ029LasLX2Dh/PI/2kWCRtjcp53zj5PoJLaU0zMuLH
         n+KQuRqooiRYKulje1IYWgar3vGAEZ0rpUx+7XE8fTXqG9p1Vw5m4vTWJTHR0w102ZHe
         IUhftmjI7etWcdqysJXwwbQWVbb5qubDggu+IsNPCtzQlA+IOQhb6dF8WMhvvpZsCxA0
         Zn+EFMvSQWs8yH6bFS39kw9c9Qv36Ij1+I3X482tGNRIKc9IiEaEKpN6msj4N58iuPI2
         s+Tg==
X-Forwarded-Encrypted: i=1; AHgh+RqGUTDn4TdMTP7BrspwzjIDmmpE9UpzC8PswXyGQpHrCGi7ifwLpHWRsyfVjCoxoCeL1rykI7QDkZ43@vger.kernel.org
X-Gm-Message-State: AOJu0YzyVIS8Y96/z+QMrTWTotHJEFrMTzyc6F8i8d9LNA1ZRUuBU+9V
	02q4NbtCuREHukB/3W05M6JigCWNkSqH+GqkK9s5TY3xhmwYqDmPLVefNS2my2cpuRwHYmFXa+I
	p2ToIFJ0iDeBhh0ZM16URTOZOW69dKsCatB4v0GauY/i4auw9kWSljzLKlE5qeaJV
X-Gm-Gg: AfdE7clcA4VhBJpqS6N/M3qE/+R+DIx0mHaZYaHstEz84cZkzPwxXLOhpjt+yhklgMX
	ky3qwP3ZMN9iCQb2kaImc6/6qoikcYP1+9VK+dqXHshqMa4AMUlT47jkjbKQUACN88bnZIFuL4P
	bmBChNeE8U66+fMc8W+hfPvRbRMQ8SA4NaP6Hnes8KF9mQEy27zXhgPbDXWc8Q5EcB0fIYKcVOo
	+ZyNiNqeYnSBAxPWF7lvjgZLuyb1wQWvZ/QoiUgCUNOcJ01PiO+tAhUcbMQwhzg0QgiQt5JdaoG
	ZnWHweAiGmYDbqpM40QBc4YzdQDgwQdaqmagMvS1DMyOM+sAFkgVmfSPyE1jPMBwxwiWgx3hsta
	QkzXXQZ2LX5lfWyldE2mEqeOg5sVCXTUASqBpoAWy91FgCHxV53YAp7iL47PaVw==
X-Received: by 2002:a05:622a:251:b0:50b:4491:a2cf with SMTP id d75a77b69052e-51c8b30365emr71754591cf.27.1783596047548;
        Thu, 09 Jul 2026 04:20:47 -0700 (PDT)
X-Received: by 2002:a05:622a:251:b0:50b:4491:a2cf with SMTP id d75a77b69052e-51c8b30365emr71754181cf.27.1783596047072;
        Thu, 09 Jul 2026 04:20:47 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69acd1d32c6sm1861799a12.31.2026.07.09.04.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 04:20:46 -0700 (PDT)
Message-ID: <73b82749-2df3-4c12-bc2a-ff7628dc8292@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 13:20:43 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 10/18] entry: Use syscall number instead of rereading it
Content-Language: en-US
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Kees Cook <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>, Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller
 <deller@gmx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
        Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>,
        Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
        linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20260707181957.433213175@kernel.org>
 <20260707190254.181086755@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707190254.181086755@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX9sFA4NbpfJxq
 KKE65/A4eJK/muPZbZ8rgw8dEozTt/PE23tHAF26mGPyPd8s0T5YsRO4lLne6McAuKup4ePaSsS
 /NGvpBePrF0T2jZSzX/F49MPB5hQA+E=
X-Proofpoint-ORIG-GUID: CnISKOy3eI7rh0UvApM68n90eBamYS0R
X-Authority-Analysis: v=2.4 cv=cOLQdFeN c=1 sm=1 tr=0 ts=6a4f8410 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=uucGcSui7XbmpEV0VHgA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: CnISKOy3eI7rh0UvApM68n90eBamYS0R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX7zpgR3GIU3jr
 hw3qN0/mttfgRRPnc6JgBa3id5P0OXWR5qiQHfIRtuKgpWX/YW8Ddg/97ProtaZYdxG3N8SSh8V
 jBimLUQXl1ut3avHkCcoX54Tp1/y4Hznj2yfj7PYrKuagyla8Rheq1cB7BuMU1tFGcb2YhtK0dX
 2ZYpHVS+6XvLhRd0cJZlxFoGA1W3vzV6nVBEVNXnt66Rb4qyjST1vfpEHBS/ukAcnok8O6fHvWE
 mejB/UshnM8Z/qkyp8vCWJ7ulf4hcMOxim5Xqgx0T1t12gkclPyOH04qsZC9tMJewXGQOCPJ8lo
 yMFAqt1AD61JdyiMDxT/AOJlyRDi4uluVaYxoxDJxBGFh3M9kP9J+VWnIM66JX3NhqbvaZnGsFy
 znE1e7BqMtoGoGFx82+wGTWLCAUDnTZN6oiajCdXPSK6WZmswolBfTYsMvnEpDUaY2IdT27IrIP
 ARVrGBvLehnwmZ2drng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090108

On 7/7/26 21:06, Thomas Gleixner wrote:
> rseq_syscall_enter_work() is invoked before the syscall number can be
> modified. So there is no point in rereading it from pt_regs.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
>   include/linux/entry-common.h |    9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)


