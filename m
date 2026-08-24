Received: from helium.openadk.org (helium.openadk.org [89.238.66.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D54376A0A;
	Mon, 24 Aug 2026 17:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.238.66.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787593998; cv=none; b=Wvj6FscqUOciw3uP+e/ijLx8fcFn0Hjw8x/bNfK5gXUjJ1sSvHjR2kAHBiEJJ8su9NIlIjyIhjTexEh5dNRtmHLq9c+0A5Cq80deZTQ+cqhJAJJ5oCHn00iWwNukkOha2Rjq9tcDjvRJMmxkQ0Yp1PjpgtH7AqfKHYX6XA/5Pzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787593998; c=relaxed/simple;
	bh=jEv+8LI+ZkKRobm78bUV3FxhnD8xjYOpuoWynCJulcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qj1mVDBjvNKYWMoG5Vwxx4dN73ZlTO2ttQdUz4ugMdPVrK9AEGh2mCPUArxkhFbC6ulhaAR2NBrEamriKvb0+zc/nyp0fJ+4IBLL/X1oq5ATRaPloHk6eGsBsM3xYx4VhLovfe7JakuTDyqheon4likVh/MKTuEAFLbG4ouDzYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openadk.org; spf=pass smtp.mailfrom=openadk.org; dkim=fail (0-bit key) header.d=openadk.org header.i=@openadk.org header.b=gXm3Az01 reason="key not found in DNS"; arc=none smtp.client-ip=89.238.66.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openadk.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openadk.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=openadk.org header.i=@openadk.org header.b="gXm3Az01"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=openadk.org; s=2022;
	t=1787593989; bh=jEv+8LI+ZkKRobm78bUV3FxhnD8xjYOpuoWynCJulcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gXm3Az01wA/GjNsFXZNV/EpOjv5Mvl5u/O3DmVqJrV76q8V1rcE4pZZsaeORNmGaU
	 b8hvKCM13PBfd2dz3kg+9QIGnZVnIhVTQTcqa4BzSLZ+RsX07tRdrH+TEbU/z7HcFb
	 zvuADu2BqMKJcp1uLcLniyJX3qbc5ARRCVQA0IvFqoavcpho/p1xJAK68Zuh4OIESX
	 6XoqtL08WznSQ3oD6L2UFwgrFBqtciR3RdQZYi8GmpZCu3AswZWsBJj92cbEda3m++
	 Tbn5hlXp8dp2Ft9rszqBjZRzYmuCHfxVTnOay9jh5PmbK/c7FUQBJA7/mxhddXLbEE
	 YhAJkV+Y82wHw==
Received: by helium.openadk.org (Postfix, from userid 1000)
	id 183B131E0CF9; Mon, 24 Aug 2026 19:53:09 +0200 (CEST)
Date: Mon, 24 Aug 2026 19:53:09 +0200
From: Waldemar Brodkorb <wbx@openadk.org>
To: Ramin Moussavi <ramin.moussavi@yacoub.de>
Cc: Michal Simek <monstr@monstr.eu>, Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, Sam Price <thesamprice@gmail.com>,
	Neal Frager <neal.frager@amd.com>,
	Waldemar Brodkorb <wbx@openadk.org>,
	Michael Eager <eager@eagercon.com>
Subject: Re: [PATCH v3 0/5] microblaze: fix signal handling and the ABI
 argument home area
Message-ID: <aoyFBUZ8MT4-lWTL@waldemar-brodkorb.de>
References: <20260821151809.1233057-1-ramin.moussavi@yacoub.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260821151809.1233057-1-ramin.moussavi@yacoub.de>
X-Operating-System: Linux 6.12.96+deb13-amd64 x86_64

Hi Ramin, Hi all,
Ramin Moussavi wrote,

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
>   - From: now matches Signed-off-by, and the series is sent standalone
>     rather than as a reply to the previous version (both requested by
>     Michal).
>   - Rebased onto v7.2.
>   - Added patches 3, 4 and 5.  Patch 3 was previously sent standalone on
>     27 July 2026.
>   - Patches 1 and 2 are unchanged.
> 
> [1] https://lore.kernel.org/all/cover.1780647609.git.lordrasmus@gmail.com/

Series successfully tested in Qemu System Emulation (little and big endian) 
and on Numato Mimas A7 Mini.
Also works fine on 6.18.x kernels.

You can add:
Tested-by: Waldemar Brodkorb <wbx@openadk.org>

best regards
 Waldemar
