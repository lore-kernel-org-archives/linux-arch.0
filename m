Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7395409631
	for <linux-arch@vger.kernel.org>; Thu,  9 Jul 2026 11:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783595896; cv=none; b=oArI4Ki6/gatdY0TGPWE4Lmmf/DOXDpwmHcfXbiqHoJC6uKV0D2+obbt0JTE9bHH0Faxak0XQmVxomRurr0QGauB5sUnBbjDCLY5B3ErGBgZcIPrFpcbehL1H+IrjNDl1jlAxPUj76YHYUY5oMAoxk5zSLZDlFL3ElZg/jhWzzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783595896; c=relaxed/simple;
	bh=JIbY68pv3tLScCT8hJ5wD/twH9VZZ6GeM09XMVAWRO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n/7CHcy/BH9nKioTlZIz3gb4q//THWrcyrlQ85bTFDAKxPVqL7OYVyUT1pmM0JBuDHMgUo9mf7nMZmn0y90+0aKLTjy4WnkSOOIV1AwioRMcJX8DcRLycYa47g8yI5tJzrTJ0Uks9ZYrPr6ySTOydctCiiIMS03Eyxl7+WP7uaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fyY0pNu1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a/HUYHsJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fyY0pNu1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a/HUYHsJ"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669AxS6Y1614113
	for <linux-arch@vger.kernel.org>; Thu, 9 Jul 2026 11:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vihb0TqYNakYFNkvFgdqTcLu+5oolASwgMBC4TOzm2s=; b=fyY0pNu1SYakkEnc
	jiua1Bz59Z/HxTO6ZZj7/6VoWVtUtY1ICmo9H1Pd2QjrZWC8gJfOm9T5qkA9XEc9
	zZ/LvhTR9YL1D4FRKeeUPeBJzIH2ig7MkQc5n0wn0ncq5EOUUpyCj9xucWrHafNA
	Mhaf5VX3wvgWTqgyvze8xNYS1i224SoOljNif2MkoC4501PXlkZEU2tlj13tOCVF
	k1OcXw5rO9V9U6F4nqjFTDFlr4SsHrosvOnlojjBDdlvWI+//0MRkxof7+sUSdLM
	DMKQPcPOu2w9XU1PRa+80kn2vAWE27oY8QNhmoRslamfrHh0e5dTRzAtOzXXQfwX
	yQEHaQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9ug6kdv5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Thu, 09 Jul 2026 11:18:13 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c0408254aso9399851cf.0
        for <linux-arch@vger.kernel.org>; Thu, 09 Jul 2026 04:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783595889; x=1784200689; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vihb0TqYNakYFNkvFgdqTcLu+5oolASwgMBC4TOzm2s=;
        b=a/HUYHsJbOFVJwiRG0RQW3NNKqU/49xLeQWT+/4XZQfImsPMD5gE4TyA500tJAQbh5
         lSVhkRGTSMHeFp7jrrELc/EBVaP+vqpvtGCr+IbQUI03ePqJpd3O3TG2L+r2wdu1xxJZ
         7bSiKGtmqWVBZovpbQaJnslJQIy3uPwn5zokQuJ8IXdMplF8QkRk3HeGebnUP+spIa3V
         wvUPRi9IV3PQTixkgnnWVLlM63x7Fx4O1H0JEBDz0sr3std8kiQkO+Qx8dRBK95XsXdK
         cgPRYwdQx9ZDNnPa5Owp0HwVPhtfgEYCNPMaVzMUaNFixzVfVv3vcN0iA+QS19sqnA6P
         B6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783595889; x=1784200689;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vihb0TqYNakYFNkvFgdqTcLu+5oolASwgMBC4TOzm2s=;
        b=DYqI3AdHCo0bVMOgU94MvRjPeGRtpUVqDxeY7X3TVCejMrBAzL+Rb6CMUQ1qh1uZCp
         S4eeYNEFAh66U0BbfflgnAUMBS1b+V/Et4MhS3L0/7pUiZ1WF1LzwGgJkj3645a11j2x
         WQtnehmo8LvI5O7JkxwOU/gpAYP+x7Db+d8xIQDdihdeepB2hY1sqNCndaDo2b/8/xBS
         1MfGqz1r5VGiMayD0hEFg2EWj/ON/9Hpoqs23bd2llx/wq4Clf1nOMbSiQqg3Zk/n97r
         sopJeA2OUXolLrMLT7hYPUn1ZuIsURO1XzgQE2PuAz51H8UCmhjURNYJQ3PgwKX4xu/r
         b51A==
X-Forwarded-Encrypted: i=1; AHgh+Rr7oiMgJT+bHkOhdnRev1T+4alnphvbJmX4l6aTe9b16lZ3ciJyEezGFfnJeNwoJYZdbTdWMJyt0TaN@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2mjIZUgechpczE2MiUucMgeVFvE76eGSehU6cvIYMjULV9bDE
	5QkZ7DHrwmvnt8uIUY0ZbxmsVJOhubguxZIRYRV4bLGEHSTDQQ19h6pTSTOAbW6o682x7mr4ACE
	NLL+TLDhBepQrrYzlvjN2lXz7J5UzXcKf8yhPlll29VBBanThd8qBj/A0dNv24EBK
X-Gm-Gg: AfdE7clGD5jvr5UVhaEKyQY0T4yDPKyvPGvbbBhONL25NpfNT1nLh3c8HJ50ShKTnKx
	NC82wfP1kgHsWZBG5DhF68UGap/JUIp4R0b4zholqCUvA+ZWSRSpNUq8rTwnsBj4Lhwn/k6iqky
	AnyCVMxbLn334Nsw3JVLd99r2a7R95NRuK1REv/gtxOYCMRoZmpHyD4NelSvUIKtH/JwvIt1xgg
	0Q9NFyJGdmzBvaeDh/L+9/EWLG9djQceaFvZ3/FeGd5r3t0KC53ypoiAN1wGSPZcIne1YYhdzHM
	CHK4iRfD3Z3xWr01skV4CyaVyhN1f/koG5GchnrikA0XtFs0rzB/H9eYZupI4SMxXOD1zezROqq
	EAJuedbYy0BgNcqLEZTAFe7rg5kBGjRvPsRChQ0ifP9F8ASa/iZ9guQFh67Nn6A==
X-Received: by 2002:ac8:5d06:0:b0:51c:98f:f282 with SMTP id d75a77b69052e-51c9b9c9812mr22454331cf.27.1783595888714;
        Thu, 09 Jul 2026 04:18:08 -0700 (PDT)
X-Received: by 2002:ac8:5d06:0:b0:51c:98f:f282 with SMTP id d75a77b69052e-51c9b9c9812mr22453591cf.27.1783595888214;
        Thu, 09 Jul 2026 04:18:08 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6d53absm53036115e9.6.2026.07.09.04.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 04:18:07 -0700 (PDT)
Message-ID: <e89995a7-0da5-4581-bce0-5dafc377e9b9@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 13:18:04 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 08/18] x86/syscall: Use
 [syscall_]enter_from_user_mode_randomize_stack()
Content-Language: en-US
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Kees Cook <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
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
 <20260707190254.079478122@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707190254.079478122@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX3cgQuxCw6aIu
 5D4qcH+ON9L+1Dq6912cTElYyYQK0YTcUEoD5KvpIJLibU8L19GvOTH1EPyF05Kewr7usuCe/Er
 qRjx5FY+gfS7PTBy8bC6WmPEl2FIywQ=
X-Proofpoint-GUID: j6uxT2D7KsQVde3hQJZZxptZTqqmady4
X-Authority-Analysis: v=2.4 cv=cL3QdFeN c=1 sm=1 tr=0 ts=6a4f8375 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=wOAZ5We2mjvvK_q5lLMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: j6uxT2D7KsQVde3hQJZZxptZTqqmady4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfXwkyLgiBBi5i9
 QvMAbSX4nk//WBeKVU6wyduo4wpJXZMOsVC9+Jw6c34oW+/r+tfhv2wr1+Gn8nOdk9/OS6trfbi
 R9YC7/Ti4ImHcDgtTLH1DfJy/fE8H9wHSPRmbwjU8Rxq/QIxurW5jZjD2ux4mnJUksnrYOHKxTY
 KjsFo9VvnbI61YEXlJU6QLGxS7Ryn3N4DuPkTPIWf6vfdH2GTISNh1KG5naIW1K2UQIpbARm69u
 ijX9uDPMAw04lUaJickEyo7sDFXE7tmdbZT6JSh2NUN3fgNTBO3xPoxrLddmFuwWU0SgrXfjuWd
 QrNWG2cz7U8CKFDrLy17dWkKhnQGuAt+OtKTDNAnMxv+8IbYYyw5tIcu4rPvK6N7YX7ogIqXBn6
 nIbAu2gbipftcokX9mpRghaX1OQ04TIHfgtW5yqKFOS/nATdC2RcUx8U3rMRxaarFiOPMPFgq/g
 XYWrhgFoqR8SJmD5j1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090108

On 7/7/26 21:06, Thomas Gleixner wrote:
> These functions integrate the stack randomization.
> 
> syscall_enter_from_user_mode_randomize_stack() has the advantage that the
> randomization happens early right after enter_from_user_mode().
> 
> In both cases also the overhead of get/put_cpu_var() in
> add_random_kstack_offset() is avoided.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: x86@kernel.org
> ---
>   arch/x86/entry/syscall_32.c         |   19 +++++--------------
>   arch/x86/entry/syscall_64.c         |    3 +--
>   arch/x86/include/asm/entry-common.h |    1 -
>   3 files changed, 6 insertions(+), 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
