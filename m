Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3552212554;
	Wed, 22 Apr 2026 13:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862980; cv=none; b=NoToir3nDrqGhKd0qCVE5HAtYJUzFQsIU+LLKdXPZoQ8vbArL89BfxfrS/Fc8OhOxpXCi9A3rXEO3/9IaC9IxwELuSd9YcpFrz8RR2zCw1+HDJScjF7lJJpUcGPnv1tTUYcweAL2HeVMC8JxjiVISQfhUbsa8N7wMCFjiXo/LfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862980; c=relaxed/simple;
	bh=YxTCrsTvYuYgr0tQA2Yg1Vpe9Rkih4RQ70ymWk8Yu8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2o9JlmZPVdnd+wpBShxs71pWprdUF7YZAw84VafwUpMV8M6Bu/8y7o7VejZs+x0eptFUummxWJ0yH+1SrwVAzFm1bA0cHmqYe2lptD6Tk/u7W6Ay7lVYnAY06rGOUO0ZapscafVVGumVGcx/HvgZzvV/6v8EWob+Pv5+L46ESk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=qoQp4eS2; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="qoQp4eS2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1776862965;
	bh=YxTCrsTvYuYgr0tQA2Yg1Vpe9Rkih4RQ70ymWk8Yu8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qoQp4eS2INnQCUgXAQh4ZuRJfkGZBj2UjrOul9Nbke6mpuR9MWPPykDVEQTomElc3
	 4INUtLFdaTdZrdWPVEQgw9BiTyqeY9w5IN1Jj03wlwVUZFhbVwlQxSIbrs8Ev1PxGY
	 KfxRPFCDytFyDg+QWCvhegZjboLyEL8JvKmYz6hg=
Date: Wed, 22 Apr 2026 15:02:44 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Carlos O'Donell <carlos@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Florian Weimer <fweimer@redhat.com>, 
	Rich Felker <dalias@aerifal.cx>, Torvald Riegel <triegel@redhat.com>, 
	Darren Hart <dvhart@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Uros Bizjak <ubizjak@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	kernel-dev@igalia.com
Subject: Re: [PATCH RFC 1/2] arm64: vdso: Prepare for robust futex unlock
 support
Message-ID: <e0ee43e3-725c-4b99-80b3-956d24beb1c7@t-8ch.de>
References: <20260417-tonyk-robust_arm-v1-0-03aa64e2ff1a@igalia.com>
 <20260417-tonyk-robust_arm-v1-1-03aa64e2ff1a@igalia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260417-tonyk-robust_arm-v1-1-03aa64e2ff1a@igalia.com>

On 2026-04-17 11:56:10-0300, André Almeida wrote:
> There will be a VDSO function to unlock non-contended robust futexes in
> user space. The unlock sequence is racy vs. clearing the list_pending_op
> pointer in the task's robust list head. To plug this race the kernel needs
> to know the critical section window so it can clear the pointer when the
> task is interrupted within that race window. The window is determined by
> labels in the inline assembly.
> 
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
> RFC: Those symbols can't be found by the linker after patch 2/2, it fails with:
> 
> ld: arch/arm64/kernel/vdso.o: in function `vdso_futex_robust_unlock_update_ips':
> arch/arm64/kernel/vdso.c:72:(.text+0x200): undefined reference to `__futex_list64_try_unlock_cs_success'
> ld: arch/arm64/kernel/vdso.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `__futex_list64_try_unlock_cs_success' which may bind externally can not be used when making a shared object; recompile with -fPIC
> arch/arm64/kernel/vdso.c:72:(.text+0x200): dangerous relocation: unsupported relocation

arch/arm64/kernel/vdso.o is a kernel object.
__futex_list64_try_unlock_cs_success is a vDSO symbol.
They live in wholly different objects, which are never linked together.
Look at VDSO_SYMBOL() to get the offset of the vDSO symbol in kernel code.

(...)


Thomas
