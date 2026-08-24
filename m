Received: from quail.birch.relay.mailchannels.net (quail.birch.relay.mailchannels.net [23.83.209.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E5D28B7EA;
	Mon, 24 Aug 2026 19:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.209.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787601463; cv=none; b=KUjO0PP02ooPyPV9nTkIjyQzIxtw2ZC8N+iUMYdbVL69JrZkZTV0jbwD7zxoDI/D4Xv3mZ+H2DZb2Z7ULnF+uKArSRsqabxl7zMdya6ag2F3xzXdtpCa3YeVMTR2yDARP+xtkIXYkTh7cRpWszdwIAVLYmT3lCOP++oyqABPk80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787601463; c=relaxed/simple;
	bh=KdqG2tCKHnTkZRVQq3TpISlC+3mndUD0p4Yo/cpDBDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IU3oj4pZ/T8CT19tCoHUEqZZyhoq/cy2sH6lTmasWxZiwxbVv/P7DmJckcqThqtNy7HLEl/gQqOp1D5uHwWx2Kc3P5Cc0gAXsrSMLhnZ9/rhjx4EDj4IRuKNFlRLjbkCHyzeH6Fs/olfrEATRvjZzaXpRHHVAwdH/48C0ahCuSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eagercon.com; spf=pass smtp.mailfrom=eagercon.com; dkim=pass (2048-bit key) header.d=eagercon.com header.i=@eagercon.com header.b=mxoFjS2B; arc=none smtp.client-ip=23.83.209.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eagercon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eagercon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=eagercon.com header.i=@eagercon.com header.b="mxoFjS2B"
X-Sender-Id: dreamhost|x-authsender|eager@eagerm.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 1F34D7E21CC;
	Mon, 24 Aug 2026 19:57:35 +0000 (UTC)
Received: from pdx1-sub0-mail-a209.dreamhost.com (trex-green-6.trex.outbound.svc.cluster.local [100.96.7.109])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id D05B47E1B63;
	Mon, 24 Aug 2026 19:57:34 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|eager@eagerm.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|eager@eagerm.com
X-MailChannels-Auth-Id: dreamhost
X-Cure-Attack: 15a3a6dd25d0b5a6_1787601454960_3670685100
X-MC-Loop-Signature: 1787601454960:1841064337
X-MC-Ingress-Time: 1787601454960
Received: from pdx1-sub0-mail-a209.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.7.109 (trex/8.0.2);
	Mon, 24 Aug 2026 19:57:34 +0000
Received: from [192.168.20.10] (99-119-193-198.lightspeed.sntcca.sbcglobal.net [99.119.193.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eager@eagerm.com)
	by pdx1-sub0-mail-a209.dreamhost.com (Postfix) with ESMTPSA id 4hTMC22xCczkn;
	Mon, 24 Aug 2026 12:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eagercon.com;
	s=dreamhost; t=1787601454;
	bh=XW6esErVQr/QjUlgf16CPFkgO1hF/WSd2oKTPSMM8DM=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=mxoFjS2BCDJ7rxD8vNX212hN14yjOKif9vfZkjjUGPzTwnR5LxdCiR7Culf3qHkqT
	 fWmN+FWLeYLGuIXVjToFoL8YkVyVSSOmQfqpRec3rz6h08qR0+5AhdjhfAhcigcA+z
	 q59OREXP2wgpqIM8plxmJJkoc06recm/EoXbD6T4nX2SwxiFch7Zv0kbl4dEKAqwzz
	 0dDBb1CZsKKTe1Qk0bU4m1G9LG29+lzD4Q2dqmy3K3VjykGXBwOtXOkSWONm+m+EBl
	 NOp3zEr5670JCKqjAeYA2+acSOnQXW1a88U+zHEgTct45Vl4Iu/DBpdKCYihRl3iv0
	 sDLEfQAV6XfPg==
Message-ID: <0179b3cd-d6a9-41be-bf16-2772e27ce16b@eagercon.com>
Date: Mon, 24 Aug 2026 12:57:27 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] microblaze: fix signal handling and the ABI
 argument home area
To: Waldemar Brodkorb <wbx@openadk.org>,
 Ramin Moussavi <ramin.moussavi@yacoub.de>
Cc: Michal Simek <monstr@monstr.eu>, Michal Simek <michal.simek@amd.com>,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, Sam Price <thesamprice@gmail.com>,
 Neal Frager <neal.frager@amd.com>
References: <20260821151809.1233057-1-ramin.moussavi@yacoub.de>
 <aoyFBUZ8MT4-lWTL@waldemar-brodkorb.de>
Content-Language: en-US
From: Michael Eager <eager@eagercon.com>
In-Reply-To: <aoyFBUZ8MT4-lWTL@waldemar-brodkorb.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/24/26 10:53 AM, Waldemar Brodkorb wrote:
> Hi Ramin, Hi all,
> Ramin Moussavi wrote,
> 
>> Five fixes to the microblaze signal-delivery path, found while bringing the
>> uClibc-ng NPTL test suite up on microblazeel under qemu-system
>> (petalogix-s3adsp1800).
>>
>> Patch 1 wires up sigaltstack(), which is routed to sys_ni_syscall even
>> though the signal code fully supports an alternate stack; microblaze is the
>> only architecture leaving it unimplemented.
>>
>> Patch 2 reserves the ABI argument home area at the top of the signal frame.
>> A handler may store its incoming arguments r5..r10 into [r1+4]..[r1+24], and
>> r1 points at struct rt_sigframe on entry, so those stores land in
>> siginfo/ucontext and corrupt the signal state.
>>
>> Patch 3 stops ret_from_trap from writing r3/r4 back into the saved pt_regs
>> after sys_rt_sigreturn() has restored the full register set.  Only r4 is
>> actually lost -- the usual *rval_p = regs->r3 idiom carries r3, but a C
>> function has no second return value for r4 -- which corrupts any register
>> live across a signal, e.g. the address held in an lwx/swx CAS loop.
>>
>> Patch 4 restores the same reservation in the kernel's own frames.  The ABI
>> rule applies to the kernel's asm-to-C calls too: with r1 at the frame base a
>> callee may spill over the saved registers, and PT_R1 is the first slot it
>> hits.  This was latent until GCC 15 changed register allocation
>> (3b9b8d6cfdf5, "ira: Scale save/restore costs of callee save registers with
>> block frequency"); a kernel built with gcc >= 15 without the
>> TARGET_CALLEE_SAVE_COST workaround dies on init's first syscall.  The kernel
>> had this reservation until 2011, when commit 6e83557c38b4 removed it as
>> suspected v850 leftovers -- this brings it back, with 28 bytes rather than
>> the historic 24, which was one word short.
>>
>> Patch 5 is Sam Price's: MSR is not round-tripped through the signal frame,
>> so the interrupted carry flag is lost across signal delivery -- the same
>> failure class as patch 3, through a different register.
>>
>> Testing: v7.2 built with gcc 16.2.0, which carries no
>> TARGET_CALLEE_SAVE_COST workaround and so reproduces the allocator change,
>> userspace built with the same compiler.  The uClibc-ng test suite reports
>> 759 passed, 0 failed, 7 skipped, unchanged from a known-good reference
>> kernel; without patch 4 the same kernel panics on init's first syscall.
>> checkpatch --strict is clean on all five.
>>
>> Tooling, per Documentation/process/generated-content.rst: patches 1-4 were
>> written with the help of an AI coding assistant (Claude, claude-opus-5) over
>> several sessions and carry an Assisted-by tag; patch 5 is Sam's, included
>> unchanged apart from a blank line checkpatch wanted.  The assistant was used
>> throughout -- reading the microblaze ABI out of the gcc backend, finding the
>> gcc change that made the bug visible, drafting the patches and changelogs,
>> and driving the qemu test runs.  Everything was reviewed and tested before
>> sending, and the numbers above come from real runs.  Two mistakes it made
>> were caught that way and are worth naming: patch 4 first used 32 bytes with
>> an alignment argument that does not hold (STACK_BOUNDARY is 32 bits, so 28
>> needs no rounding), and an early version of patch 2 was folded into patch 4,
>> which made the test suite blame the wrong change.
>>
>> Changes since v2 [1]:
>>    - From: now matches Signed-off-by, and the series is sent standalone
>>      rather than as a reply to the previous version (both requested by
>>      Michal).
>>    - Rebased onto v7.2.
>>    - Added patches 3, 4 and 5.  Patch 3 was previously sent standalone on
>>      27 July 2026.
>>    - Patches 1 and 2 are unchanged.
>>
>> [1] https://lore.kernel.org/all/cover.1780647609.git.lordrasmus@gmail.com/
> 
> Series successfully tested in Qemu System Emulation (little and big endian)
> and on Numato Mimas A7 Mini.
> Also works fine on 6.18.x kernels.
> 
> You can add:
> Tested-by: Waldemar Brodkorb <wbx@openadk.org>
> 
> best regards
>   Waldemar

Thanks Waldemar, that helps.

-- 
Michael Eager

