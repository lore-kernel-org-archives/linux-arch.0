Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F14B23EAAF
	for <linux-arch@vger.kernel.org>; Sat, 28 Mar 2026 12:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774701172; cv=none; b=pWDG20QUme4vjMY//O1U8t+lqEkt4b7mGNkKxBM7t9g1Dk75tVghxnZtdUjI+emhVPqg5nPgbZpo9Jg2Bsyo9KaRtRjBuoFnnjMEkmTidMnUlTbCkmVi0FPuHxGfAZt2WqhbCO6Oec79ylU2mPYJv5DNrwd3kDKuSfjeDSWp9iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774701172; c=relaxed/simple;
	bh=h5TrP4HN02KJUDnjZEZsA19W+HvT8LfgynD9muruNjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SQqCU6/QHBm4D6ePWP1EM+OtDswTDgAxMfmwTS1mAQLAEuG0tPlKZIVf1kZB9LpaAcmgGgdutIAJPzrLlqoI1iWOWocWwALmDynlC44zPWpHqXO/sSYw+HVo68OdudWJRgxv1A139JG0kRRPPMlXKIAu1J8AO5wYH2SFGXRmCso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l3xVJ+w7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l3xVJ+w7"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62S5wOML3917521;
	Sat, 28 Mar 2026 12:32:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=twaxjd
	Z7UwKuF4pXzDJ0cvuYE3JM4HnZaKdgBXSwkWE=; b=l3xVJ+w74gFABHOKfmljEH
	X0x8g1/rmvEJHOKX8z8J6qKmT8Tfi+dL0uzddfOqVb1oKruIfV9XWyhoj3yABm2S
	GQIisL4DR6iO2QRUAVPdxUFLNFrDYMu5/v/UfuIrghzK+UDbQVd8KbAAxKeDupnC
	6ZnhYh4xo5227KBd3MgoXYJJ/o8NYQ7uvORIcoq2EnpqUL0mnoDvqWOxYpEM8y7n
	l8KyZgXb3faoK+n8fPagnlvIf3XE4Z29K/x3PKquvn+SIMwqHDmNzGxcouWNVnUm
	3GbZUhAuVmQSAtHkvVF47rMSN0KvTQuWMNK5D0msg19kepSrd7n69Kp7JgkS07kQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dc13f1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 28 Mar 2026 12:32:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62SA5GPS026900;
	Sat, 28 Mar 2026 12:32:39 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275mb0n7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 28 Mar 2026 12:32:39 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62SCWcme62063092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 28 Mar 2026 12:32:38 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F72658054;
	Sat, 28 Mar 2026 12:32:38 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF5235803F;
	Sat, 28 Mar 2026 12:32:34 +0000 (GMT)
Received: from [9.43.28.205] (unknown [9.43.28.205])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 28 Mar 2026 12:32:34 +0000 (GMT)
Message-ID: <d3b027c0-29f9-4669-b732-385aa44860bc@linux.ibm.com>
Date: Sat, 28 Mar 2026 18:02:32 +0530
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Attempting to unify some user space copying APIs
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
Cc: Russell King <rmk@armlinux.org.uk>, Vasily Gorbik <gor@linux.ibm.com>,
        Helge Deller <deller@kernel.org>, Huacai Chen <chenhuacai@loongson.cn>,
        Will Deacon <will@kernel.org>
References: <CAHk-=wgg1QVWNWG-UCFo1hx0zqrPnB3qhPzUTrWNft+MtXQXig@mail.gmail.com>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <CAHk-=wgg1QVWNWG-UCFo1hx0zqrPnB3qhPzUTrWNft+MtXQXig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69c7ca67 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=4U90LtwIbhicxpYthx4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: fhvAc_x91hF3lxODsn3wFeTZELWu2Z_A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI4MDA4OSBTYWx0ZWRfX9ervN4ONKL+H
 fPAeuktiJJkvEojz8NhYd0B7saQV+Rso9i3w4Q8tAbeeEQnwa8ilGhk9xcr4ku3dqOzwRqoJL5l
 MKi5ZaE6vv6u37+ioMjjSDuyA48lRDfTZiQNbvrvU49HcyygtRo7mjZh7XkjmWXsgVblSU/gwDv
 pcUwLTA/C8gK9k8tt+Vhy4EcU3Q0C/ZiVjl2gRaksMQKVPWAMawcCJ1HcJu+uHlBY0GyxtaYwn3
 DsyqszWmFMQ8HekrCaAU8ANKNM0PVCkCTRqdQ+IL2a8ocf9baZWu5qF8Qv43ZDBwoJ5PHuxXoBh
 Gma7wOErnxsGEYgM6ByeZBkXRlcrKvuGOCuJkQLgXAkI5JIhd+hIMj89wEfAJENopiBD22hGPlO
 XSj+rizF16d1NRhF6E6GjwEiTz3XRdbc99pftZ4+vTGkpvtrvniCZNk9pWLQt70CYo/wk4gMYIZ
 /uHR1/FE3hSElyuEW5g==
X-Proofpoint-ORIG-GUID: fhvAc_x91hF3lxODsn3wFeTZELWu2Z_A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_02,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1011 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603280089


On 3/28/26 5:50 AM, Linus Torvalds wrote:
> I'm sending this out to the architecture maintainer list (and a random
> collection of arch maintainers that I just took from "recent pull
> requests") in the hope that people can test this on platforms that I'm
> too incompetent to check myself (read: I haven't installed all the
> cross-compiler environments).
>
> The impetus for this was trying to have some shared code in
> lib/iov_iter.c by having a common wrapper function for a couple of
> user copy functions that most architectures don't even have. But when
> doing so I noticed that even the common function that we all *do* have
> doesn't have a consistent calling convention: raw_copy_from_user().
>
> So the compiler ended up being unhappy just because I want to pass a
> function pointer around, and different architectures had different
> types for the functions (and in the case of arm64, used a macro to
> implement it, which really didn't work for this).
>
> So I fixed it all up, and I think the end result looks better, but I'd
> like people to at least build-test this on the platforms that I didn't
> have immediate access to. I've tested this on arm64, x86-64 and i386
> (and then I made changes, and didn't necessarily test all the changes
> on all plaforms, but it LooksGoodToMe(tm), and some earlier version of
> this patch did work on those architectures, so it must be perfect).
>
> The patch was generated on current tip-of-the-day, but I don't think
> any of this has changed in a while, so it should apply and be testable
> pretty much on any half-way modern code base.
>
> I fixed up powerpc blindly (we really had very odd types for
> __copy_from_user_flushcache), and as mentioned the arm64 and x86 side
> should be tested. Everything else lacks the flushcache and nocache
> versions of the user copy functions, and it *looks* like only arm64
> had that odd pattern for raw_copy_from_user().

Compile- and boot tested for powerpc.

We also did a quick basic test via fsdax pmem device (qemu+TCG)

             bash-1759    [002] .....   532.873958: fc: (__copy_from_user_flushcache+0xc/0x3a4) dest=0xc0000005027a0000 src=0x132c01400 size=0xd
             bash-1759    [002] .....   532.874021: <stack trace>
  => __copy_from_user_flushcache
  => _copy_from_iter_flushcache
  => dax_copy_from_iter
  => dax_iomap_rw
  => ext4_file_write_iter
  => vfs_write
  => ksys_write
  => system_call_exception
  => system_call_vectored_common
root@buildroot:/#

Patch works as-is.

Maddy
>
> But maybe my grep missed some case... Considering that three
> architectures needed some header file fixups, let's make sure it's
> _only_ those three, ok?
>
> My initial version tried to use 'size_t', but the type of that is
> typically - but not always - 'unsigned int' on 32-bit architectures.
> And since I didn't want to mess with this low-level architecture
> function more than necessary, the traditional 'unsigned long' it is
> and most architectures should JustWork(tm).
>
> [ Traditional, that is, except for those cache control versions, which
>   just used completely random types with wrong sizes and signs and
> everything.
>
>    Not that we even allow IO that big in the first place, but it was
> still a 'that shouldn't even work' kind of reaction from me ]
>
> Anyway, could I please ask architecture maintainers to check that
> there isn't some odd corner case that I missed? I could put this in
> linux-next, but even before I do that, I'd like to do the basic "it
> won't break anything" smell test.
>
>               Linus
