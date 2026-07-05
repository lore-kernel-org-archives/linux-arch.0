Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B44E357CFC;
	Sun,  5 Jul 2026 20:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783283040; cv=none; b=ns8JBcGh+Y3Uh5bT9+xUxyJ9H+btvjp1oaIKsoreQSKQuWk4zAjZ7QHuefyRP0XYGAePL0j/Xs0Xzfpfa68iUKJ4UJ3IfOLsYMfCmm2QMvM+hWThdVKh3T6Mk2CJDZKqr3T3sWGCHs9JR9Vr2X2bsuvtStUqwh5YjXjIpgviP5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783283040; c=relaxed/simple;
	bh=/Ai519gO+IYf7SVaXsO7Ey5uiRfQsQRWUJpfzprqAbo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dCvsFUVO+eSyEMXTkpuyunrIrpmmlVc6ReBPCbC9BlzaEvBZCkpj3Y4kLzTbD9Gkegx8tXuz1TQBEUYIay7DT/PwoFTxPT+OOBibvy8f+ASxDZYiSFubDqJSxkPZ/hfokxL42IZfj4EIvrX9oCZebT3+rOv3DYeOIFcfbS2BRMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlOcVFnf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlOcVFnf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839EA1F000E9;
	Sun,  5 Jul 2026 20:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783283039;
	bh=G9NTi9C2RBjYtOfgOCY0ugvBRf+G48O3KUNLGnuN+E8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=YlOcVFnfhkPwgN/y4FUNIckKpvHJmY6lCcSYvUzpOO44HOBXc38zVWSaK+TewrTMi
	 czIvtQfpeEav65qbUJD/dLrw2lub1UR5b/p8dd8VYJJDCYzlUbu0g7w36eCPq03k+T
	 ya8xEO69XujGlZlAVeWvuRozXE2bHHblCziJAUPAMrmT2m6Q1Ep6a5TjhAjPnEwFr+
	 kFl1InnS3RsngVOPsh6LofpBRVtB5QzcfI4I5aJxYqacBkAIWV2rCZYWPveEJwGprk
	 FiWnqik5XCHee6Hiep3vbVo5p1HTkaH4jDCXG4ajBcdECO/HIFmCeRf6DIJA+1KK8K
	 B1GiyWKhARJbg==
From: Thomas Gleixner <tglx@kernel.org>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Carlos O'Donell <carlos@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Florian Weimer <fweimer@redhat.com>, Rich
 Felker <dalias@aerifal.cx>, Torvald Riegel <triegel@redhat.com>, Darren
 Hart <dvhart@infradead.org>, Ingo Molnar <mingo@kernel.org>, Davidlohr
 Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>, Uros Bizjak
 <ubizjak@gmail.com>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, "Liam R.
 Howlett" <liam@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, kernel-dev@igalia.com, LKML
 <linux-kernel@vger.kernel.org>, =?utf-8?Q?Andr=C3=A9?= Almeida
 <andrealmeid@igalia.com>
Subject: Re: [PATCH v4 0/5] arm64: vdso: Implement
 __vdso_futex_robust_try_unlock()
In-Reply-To: <20260705-tonyk-robust_arm-v4-0-e0fd0fa259d3@igalia.com>
References: <20260705-tonyk-robust_arm-v4-0-e0fd0fa259d3@igalia.com>
Date: Sun, 05 Jul 2026 22:23:55 +0200
Message-ID: <87qzlhjick.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 05 2026 at 14:56, Andr=C3=A9 Almeida wrote:
> As explained in the Testing section above, we developed a test that puts
> breakpoints in the code to test if a user code being interrupted really c=
lears
> the op_pending pointer. This test wasn't initially working because of thi=
s check
> at futex_fixup_robust_unlock():
>
>         /*
>          * Avoid dereferencing current->mm if not returning from interrup=
t.
>          * current->rseq.event is going to be used subsequently, so bring=
ing the
>          * cache line in is not a big deal.
>          */
>         if (!current->rseq.event.user_irq)
> 		return;
>
> rseq.event.user_irq was always false during my tests, and it prevents the=
 fixup
> to happen. I figured out that arm64_syscall_enter_from_user_mode() was the
> issue because it doesn't set user_irq to true when the task comes from a
> syscall.

I have no idea what you are babbling about.

A syscall enter never sets user_irq to true. It's only set to true when
an interrupt/exception entry comes from user space, i.e. via

    irqentry_enter_from_user_mode()
        rseq_note_user_irq_entry()

No?

Thanks,

        tglx

