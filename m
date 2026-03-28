Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFCBF9D9
	for <linux-arch@vger.kernel.org>; Sat, 28 Mar 2026 04:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774671266; cv=none; b=TN3BYxWGZjYuYYcHPzDyXlqJ/N7w3cC3rxJlnqjDMBVKfzp3o6IK7lyIByYWRGdjMtxwPgHx11BXgYXObxmrCdkQFxgop5vM5SUzGLAaaKfgTa2lRZGwiC1Xmjlc9Cwwgw2a+AvEkBRi2wY8aXDU4xQIee6cfmChWgmVs2F93sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774671266; c=relaxed/simple;
	bh=HU2mGgVRurvyY7KlnbbHDh6pgV3zh+qFMB/JCBX33v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/F6tkRgvPPKeEO2b41eZ8pAtpikfSd7ugTQkOi4yK/U2aTo4woR0/5vFC0xsJlOCPF+Zuqz1PW0pVqodWMzv3+iCIjTGttXrVgr4eXCwExnPIg7zvLExUvrrg+BXPYM5dZU3riTylpGVagw7ASlAW+ymiosfgPaDVWQ9xbdA4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ge4Rmap1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ge4Rmap1"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62S30wAf3610297;
	Sat, 28 Mar 2026 04:14:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=iUBFxqn4785mbXw3mwQPp05PDsiZwI
	hV5QpTYNFgYlg=; b=ge4Rmap1B23C/5Q7exvKFRdgjeFBAX3/nZVx6/w+Gnshb9
	NUjTvWzXEfFwQi5hjXj7uvUCsybTg/I+ITMOqL/tsrrEwE1dWkEhKigWCp/CqrcF
	/ChSdMkBiEEdwCGtCoJfzOzjgT4CDVBozcsUDO96mT0WFDNEZIkv77gnHTg8wDEI
	tPw7wsP1SAV494jTouBZX/f5ieFuH+LmuPEJhd9Z+SoLlRHAb4W3dv06hkBSkg2N
	3I+BkaDUDxj0XONUGDWszqGhOwmOviEWFtNIHwj6kdKcX/0eQ6BeClL+Y3vctrtC
	GiXtePRl2OgiSe6g4h5p0C6gKvBve+IrBrU+8T8Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q2r443-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 28 Mar 2026 04:14:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62S3IcfG004398;
	Sat, 28 Mar 2026 04:14:11 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c2hwjn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 28 Mar 2026 04:14:10 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62S4E7wf52232504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 28 Mar 2026 04:14:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 039112004B;
	Sat, 28 Mar 2026 04:14:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81E9520040;
	Sat, 28 Mar 2026 04:14:06 +0000 (GMT)
Received: from localhost (unknown [9.111.25.211])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat, 28 Mar 2026 04:14:06 +0000 (GMT)
Date: Sat, 28 Mar 2026 05:14:05 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>,
        Russell King <rmk@armlinux.org.uk>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Helge Deller <deller@kernel.org>, Huacai Chen <chenhuacai@loongson.cn>,
        Will Deacon <will@kernel.org>
Subject: Re: Attempting to unify some user space copying APIs
Message-ID: <ttcld3h@ub.hpns>
References: <CAHk-=wgg1QVWNWG-UCFo1hx0zqrPnB3qhPzUTrWNft+MtXQXig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgg1QVWNWG-UCFo1hx0zqrPnB3qhPzUTrWNft+MtXQXig@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nGREzsULDRVfebZiHL5rPkKWJGAvVuHk
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69c75593 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=N8dKGZiN4r3fCvzjxP8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: nGREzsULDRVfebZiHL5rPkKWJGAvVuHk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI4MDAyNCBTYWx0ZWRfX3sTIUv73z7Ao
 L73kD+7ndc7N8xbC8LBBRJhiGCBcZjhEcoeqQdWd/9kAElMbOZLgaaDRPiejjOey6TPmYL9repx
 pk9vqB0V+dySFC46njehJ7Kc/w/3klANz40N0jEPTr/KbPnwzjuEIrLVGA1+guGb5e0X3aJGhET
 sre8qHLhFAq2nT39lZ3H7D4kWfkbh1XESm1mE2n/SY522y3bEuPtBC5VS5paZRzZ9x5qJpdrG/k
 uG+b1M2i26XSK3iqKTkWl26GRNTY7f/s2l1/TpT6kDjN7XPMqzVzG/+g4SpMD+OTid9YoB4x8i7
 y31emkpAb3/jIJs8RYmw4kkjKtOkqYqBGeAgKIWdKSnKdoe45tA+3TsbWMELXrrL8N30iL+KKN7
 TzLwlS0nTdmozL/CLqxyfC6xDds/nUGJNXlVRPmRCMF7LWD98XpS3Jt2IdVpaINEtJY2b3HwuEO
 Uewp1yO13ObkM9i3/Ow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_02,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603280024

On Fri, Mar 27, 2026 at 05:20:57PM -0700, Linus Torvalds wrote:
> I'm sending this out to the architecture maintainer list (and a random
> collection of arch maintainers that I just took from "recent pull
> requests") in the hope that people can test this on platforms that I'm
> too incompetent to check myself (read: I haven't installed all the
> cross-compiler environments).
...
>  arch/arm64/include/asm/uaccess.h   | 36 ++++++++++++++----------------
>  arch/powerpc/include/asm/uaccess.h |  4 ++--
>  arch/powerpc/lib/pmem.c            |  4 ++--
>  arch/x86/include/asm/uaccess_64.h  | 13 +++++------
>  arch/x86/lib/usercopy_64.c         |  2 +-
>  lib/iov_iter.c                     | 19 +++++++++++-----
>  6 files changed, 42 insertions(+), 36 deletions(-)

On s390 this builds and runs fine.

One thing I noticed: copy_from_user_iter is clean - the boilerplate just
wraps raw_copy_from_user which has no instrumentation of its own.

copy_from_user_iter_nocache is a bit different: the boilerplate wraps
the actor with instrument_copy_from_user_before/after, but the nocache
actors already instrument internally.

On s390 (and all arches without ARCH_HAS_NOCACHE_UACCESS) the generic
__copy_from_user_inatomic_nocache calls __copy_from_user_inatomic
which does its own instrument_copy_from_user_before/after around
raw_copy_from_user, so we end up with double kasan/kcsan/kmsan calls.

On x86 __copy_from_user_inatomic_nocache only does a bare
kasan_check_write(), so that one gets doubled, while kcsan and kmsan are
newly added through the boilerplate.

I only looked at s390 and compared to x86.
