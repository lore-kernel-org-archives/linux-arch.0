Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BF839A7E0
	for <linux-arch@vger.kernel.org>; Tue,  1 Sep 2026 11:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788263501; cv=none; b=Umy4Tko/fhMCEgLgF7iJOMKu1/vUI1s5HXeKvV54zMSOdZXsgpHb8IFo/vuUbpLfzRWG7OCWmWu6LFUf8Nc3MEA3ZCiYKxPeGGHetkL7AXnGGya/N7hIba6oKlwH+deSd+DDvEPUygkJAKLuTsS3llKehs2tRxH5YCAvE8IwxRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788263501; c=relaxed/simple;
	bh=KUoF0djquNJoX9WdZcqAnWNO7Ly+uh4J2nhw9kk/jmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iut//ZzCG6eKevaA+OyiuJa04CRiGDKsd3JPobeO6WWg6Rpr0e+x/GZ35kUqeEyGNvb6VunV/eIO9uu0GvasCnSZh+i+4twnswwa93GdjZBKjYAQm0uITJbIe4TLb3c8BotV6s2Xsl9mvlA/wIpsmE/ahNh7EEzyM+eOMZdEbV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu; spf=none smtp.mailfrom=monstr.eu; dkim=pass (2048-bit key) header.d=monstr-eu.20251104.gappssmtp.com header.i=@monstr-eu.20251104.gappssmtp.com header.b=n2iX5pTt; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=monstr.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20251104.gappssmtp.com header.i=@monstr-eu.20251104.gappssmtp.com header.b="n2iX5pTt"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a5ded53570so1159958a12.3
        for <linux-arch@vger.kernel.org>; Tue, 01 Sep 2026 04:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20251104.gappssmtp.com; s=20251104; t=1788263496; x=1788868296; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cugye/pfcKYPPCeGDa7Vo+9AJhMGlAjboRgfu611ryw=;
        b=n2iX5pTtLdvDT/88+fmZ3Lm6E1zHG4i0V9yl7EPXcszRHj4xnvxblbgS9t/9SW782u
         YyYVqQUqYcqEQpZBVqyTn/18R0ZASa9tG1oywL3e1DST4DTrnlWvGPgtxg1g7h6XJ7Lr
         LVrj/DG8LsQZXPTXSkxREtcNnTQqouhHXbVV5LL0qODLFzJS3OufIbBonPpOuEF0uYsu
         qq9fjbbFEblju8HtUR06FB89tTHIMVmPoZvzthU/fY7nXTfvZpcD59E0k1xAGlIWLHKx
         JdqPWJUCG6Zf+RmxdjUADxLVSwVUFnm3bSatsFuSc0HvoGFFkOlFBnEDWbKc5aRKV3dr
         0Rnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788263496; x=1788868296;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cugye/pfcKYPPCeGDa7Vo+9AJhMGlAjboRgfu611ryw=;
        b=C6+zBPQoPDxAlrEJKHx7ZI4odJOwcwG+xu5hsENqTq13VI8/FnSZL+hYbvYpkRbRf5
         8iHDMNxeALqGQKFmBg1+yIhhYvW6ODO+AW1b2MIjOBZxOXVXGnN01VzvTBfQfdTBDlcL
         qdKkqe//g5mL1FMiJqu/1Cn2O7frDNC49F5um5sVPJEbk9VISz6t/73N6vsgaUBK6jrO
         xXApBsk5eNI0XTa2i7PzYyRXJ2QdMEMvEERrCg86xdQAqMu/Ph+hPcOOMKI5If8oqL/7
         ZSNogDJZ5fUYjBKUW5MN5tg9kCg/yG0sNgZYej7l1gZ5HBJ1SGHJBwQ+gLmC+I5JP+XV
         tUEQ==
X-Forwarded-Encrypted: i=1; AKwUvBwPL/rEt+bFvH7hCSXmQu/Xgqu4gjJsINj7VFyWhquTxOVLrQVtjVZak6mHKzPb3tZkWEpoRkAXLIqt@vger.kernel.org
X-Gm-Message-State: AFuF++nYt6E3Z536AiQ4UoZSfjyx5QaeSOSDJCzZ1f6/nfRSP7cC2Gzn
	oeuQCm8QFR2ZAwi22jUdN86gFBBjFjNxpH21PJBYDpCIqVUSWjeYkPUS4/D7DiNRTw==
X-Gm-Gg: AYBFou2vAD2IFoPM85xC/kdQ8XKFX5371Uf9fGzgdFtjpRRePSfw8SoBk38ySrHbwGN
	w86IDdZIMxnsCVpPJkt+AA/KQ/Gb1ddgQkQvuAr5b1mh+lzsGF/o+JUdBZnpPftrP5LD2gXEnjl
	TcrsB0BMJyXktKC7Cfr4nkCI/OSVxeZLUYsJTgmSWljCR0FIlNo8YGzym+m56sVdrNUvrFikmSt
	0VymeL6RayUSt1l8qoRlzJl/PtL7Oe57kAkBO9yIx8fwEh4GjaxAr5lt7gBBW+dlh7DTuqyIAPm
	8zT+/poHQjD/jt2jDLn2AfxnwIVWVYJ268jGYJ6TuDGnmjwq1+kBStevMcnfQkQgfOetkZuiW47
	qa3Ai/a7YfS1Nlawc3ofb5NoeTlL6NHcaOv5HKditYI2a34eTGO6g2GcDMPThpH+2mcOfIkcFrz
	2r0geeXz+Ur/w9e7imKDihF7QzAQumQyWAk8H7uB2Fm2SaoFVp3VT8hJOIC5nBJtNYkLgR14A/w
	RpjGFbtZBNpCb6LN/LE9kRUgt4ITquqdOZk
X-Received: by 2002:a05:6402:44d7:b0:6a3:87b7:b5a9 with SMTP id 4fb4d7f45d1cf-6a60d3b4e36mr16170100a12.12.1788263495726;
        Tue, 01 Sep 2026 04:51:35 -0700 (PDT)
Received: from [192.168.0.105] (nat-108f.starnet.cz. [109.164.53.108])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a66d16362fsm718430a12.29.2026.09.01.04.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 04:51:35 -0700 (PDT)
Message-ID: <1bea6e00-1917-4544-b8ea-f28415e21db7@monstr.eu>
Date: Tue, 1 Sep 2026 13:51:33 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] microblaze: fix signal handling and the ABI
 argument home area
To: Ramin Moussavi <ramin.moussavi@yacoub.de>,
 Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, Sam Price <thesamprice@gmail.com>,
 Neal Frager <neal.frager@amd.com>, Waldemar Brodkorb <wbx@openadk.org>,
 Michael Eager <eager@eagercon.com>
References: <20260821151809.1233057-1-ramin.moussavi@yacoub.de>
Content-Language: en-US
From: Michal Simek <monstr@monstr.eu>
In-Reply-To: <20260821151809.1233057-1-ramin.moussavi@yacoub.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/21/26 17:18, Ramin Moussavi wrote:
> Five fixes to the microblaze signal-delivery path, found while bringing the
> uClibc-ng NPTL test suite up on microblazeel under qemu-system
> (petalogix-s3adsp1800).
> 
> Patch 1 wires up sigaltstack(), which is routed to sys_ni_syscall even
> though the signal code fully supports an alternate stack; microblaze is the
> only architecture leaving it unimplemented.
> 
> Patch 2 reserves the ABI argument home area at the top of the signal frame.
> A handler may store its incoming arguments r5..r10 into [r1+4]..[r1+24], and
> r1 points at struct rt_sigframe on entry, so those stores land in
> siginfo/ucontext and corrupt the signal state.
> 
> Patch 3 stops ret_from_trap from writing r3/r4 back into the saved pt_regs
> after sys_rt_sigreturn() has restored the full register set.  Only r4 is
> actually lost -- the usual *rval_p = regs->r3 idiom carries r3, but a C
> function has no second return value for r4 -- which corrupts any register
> live across a signal, e.g. the address held in an lwx/swx CAS loop.
> 
> Patch 4 restores the same reservation in the kernel's own frames.  The ABI
> rule applies to the kernel's asm-to-C calls too: with r1 at the frame base a
> callee may spill over the saved registers, and PT_R1 is the first slot it
> hits.  This was latent until GCC 15 changed register allocation
> (3b9b8d6cfdf5, "ira: Scale save/restore costs of callee save registers with
> block frequency"); a kernel built with gcc >= 15 without the
> TARGET_CALLEE_SAVE_COST workaround dies on init's first syscall.  The kernel
> had this reservation until 2011, when commit 6e83557c38b4 removed it as
> suspected v850 leftovers -- this brings it back, with 28 bytes rather than
> the historic 24, which was one word short.
> 
> Patch 5 is Sam Price's: MSR is not round-tripped through the signal frame,
> so the interrupted carry flag is lost across signal delivery -- the same
> failure class as patch 3, through a different register.
> 
> Testing: v7.2 built with gcc 16.2.0, which carries no
> TARGET_CALLEE_SAVE_COST workaround and so reproduces the allocator change,
> userspace built with the same compiler.  The uClibc-ng test suite reports
> 759 passed, 0 failed, 7 skipped, unchanged from a known-good reference
> kernel; without patch 4 the same kernel panics on init's first syscall.
> checkpatch --strict is clean on all five.
> 
> Tooling, per Documentation/process/generated-content.rst: patches 1-4 were
> written with the help of an AI coding assistant (Claude, claude-opus-5) over
> several sessions and carry an Assisted-by tag; patch 5 is Sam's, included
> unchanged apart from a blank line checkpatch wanted.  The assistant was used
> throughout -- reading the microblaze ABI out of the gcc backend, finding the
> gcc change that made the bug visible, drafting the patches and changelogs,
> and driving the qemu test runs.  Everything was reviewed and tested before
> sending, and the numbers above come from real runs.  Two mistakes it made
> were caught that way and are worth naming: patch 4 first used 32 bytes with
> an alignment argument that does not hold (STACK_BOUNDARY is 32 bits, so 28
> needs no rounding), and an early version of patch 2 was folded into patch 4,
> which made the test suite blame the wrong change.
> 
> Changes since v2 [1]:
>    - From: now matches Signed-off-by, and the series is sent standalone
>      rather than as a reply to the previous version (both requested by
>      Michal).
>    - Rebased onto v7.2.
>    - Added patches 3, 4 and 5.  Patch 3 was previously sent standalone on
>      27 July 2026.
>    - Patches 1 and 2 are unchanged.
> 
> [1] https://lore.kernel.org/all/cover.1780647609.git.lordrasmus@gmail.com/
> 
> Ramin Moussavi (4):
>    microblaze: wire up sigaltstack
>    microblaze: reserve the ABI argument-home area in the signal frame
>    microblaze: don't clobber r3/r4 restored by rt_sigreturn
>    microblaze: restore the ABI argument home area below pt_regs (PTO)
> 
> Sam Price (1):
>    microblaze: preserve the MSR carry flags across signals
> 
>   arch/microblaze/include/asm/entry.h           |  13 +
>   arch/microblaze/include/asm/processor.h       |   2 +-
>   arch/microblaze/kernel/entry.S                | 346 +++++++++---------
>   arch/microblaze/kernel/hw_exception_handler.S |   5 +
>   arch/microblaze/kernel/process.c              |   5 +-
>   arch/microblaze/kernel/signal.c               |  26 ++
>   arch/microblaze/kernel/syscalls/syscall.tbl   |   2 +-
>   7 files changed, 232 insertions(+), 167 deletions(-)
> 
> 
> base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f

Applied.
M

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs


