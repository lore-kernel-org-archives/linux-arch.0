Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA0C1D435F
	for <linux-arch@vger.kernel.org>; Tue, 24 Mar 2026 01:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774316851; cv=pass; b=hEshMc5oArZ2HQmzcN6r7SUqRRuJ2eu9ZdZfzpqimoYFjKVlHSUin2D6EfaiJp2MVPFWIV3dbMr2MX3qyVnhcKD3bwkYkJ7EI3mRDi6ZjmXJAMdnv23WtkJ+LrkUdx9Z5aoKNDhu5bwsGfW9el63k0dJFOwvCToCGa5w8NCwRMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774316851; c=relaxed/simple;
	bh=MUfi36ea7f/nz/pbaSwAf4o+ALXT/+r3vcfoR6Zt4jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dnd7EkvOx4jLfTthaS5m/rzm5Y3rT/Jlo6OqbWJBPWoONjWlL8KmIKzMkhdPujihg2VF2QjEkIpZM5DVRAxZcz93rHvQWWDjvGqRC2913S3p2JwHhjoIzs35LHMbyXm65SMWhxLsWL/lhW60OQv999zoPK+1PILzeD9u+fCY9/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2Ra53+w; arc=pass smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2Ra53+w"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-43b3d9d0695so4390893f8f.0
        for <linux-arch@vger.kernel.org>; Mon, 23 Mar 2026 18:47:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774316847; cv=none;
        d=google.com; s=arc-20240605;
        b=OpaNAhTxdRG0k+Pe3133LpnztSUndwbKm685RvALJl/lpbaQtsN6b2xCBkgw32+fpX
         86HvlCMu1nrkc0sChYs2uTHxhXfigyPSe2a0GiZFIKwHft5ZuyuaexLbtO9cS59ZPkmh
         XiW48WStOKMzHBU8ECgNXoNKtPodp3aCORX7qwXeRCDL1gYtyR78AXhmdnl3rrP2CP5b
         7uqTg88Nxr5P7zcF/eL//4LJw3qswyI2YAtKAedzFrxUyNGNTxzX3jA0tyGCMtL4A2mX
         ewp5zBrRZE/OIO7KG7uHlmlMWL1hhiv4WYP8pnHZHRbEfvN0Sx/LSAvtzuTyWvQSk2an
         3kNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=E05DQ8tPZZh1ybJbqcTlYE6PvwcKKcHXiXsgT1UEl+w=;
        fh=bHszTM2dLERjDIUvNbakkaoq29Ivi51CaDXBSa4xTzc=;
        b=YRHE1sFfOiLnMBaMNfQY4wIz1x6JPS6KzVrw/4tW4HWOZE4st7oy7yCJBE2T8tBLJ7
         j9baEDe/f8zi0BKD5TIjZQDWBdntQXRVLbOq5WUGYPMJx/MVBcNKM6f/L6QdEe9tRP9O
         t5VH3lpdvCoScd9zzu6ocBrDPFZuhJ9w8HrBfd3J1uLMR/hMon3KATDDkNbBfTo8Qo8A
         rz3oGvQr8XJ8Y+V31jZOQXPo2IHSOZJIGu8gImOafbQ5WMBUjj+unU7kTvRifuxypiTx
         nVBS78/TAE+sgfxUHoO0iZ+dN8CZ6HiXrfLJqVmjoUMvdWvDOheaPHkQ1Eq/GsSsTHmE
         furQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774316847; x=1774921647; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E05DQ8tPZZh1ybJbqcTlYE6PvwcKKcHXiXsgT1UEl+w=;
        b=R2Ra53+wTqe4fKM0YowcYvj30AagsiIUCnlyrF/Byb9Z7ZfYIYs1cOyvsTQT9KtaBe
         F29JEmIo0dGfEC7ePCHm+PQ4vd5ldCNJcs83CyZxvRRNHOjFUDm6mNIEG+kGrPN80ZYo
         H6JKZBXZhk9U7DUdGSNIZmEAu3gRAItOfACzkPfXwh6U9SAWZMeYejoOrM0cfSAyALfD
         vKbkSp9hkqQfn7X6YRR2++cVG88E2eotlNTmD+owYMGDwBl0aoXfDhomZZUjGgsOPoew
         s/B/SeMJL12hyK31kgSqu8WBOjnMmZl+zIDXL5f1gLFgdwX0Dr0xhVWDH4PqAo8nSRrT
         5nyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774316847; x=1774921647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E05DQ8tPZZh1ybJbqcTlYE6PvwcKKcHXiXsgT1UEl+w=;
        b=R+fJx/6yK3Qa3Q0tyMNasNETjRYYM+e5U7YL4wNNrIeB2AETFZLwhCkDJg6OE3ssWr
         XSVnDG6mecumHmQujELmLi+r8A4Z8z64GfZtoBvBfmZgs2an5cLXvSNl6YqJjEvfH2sA
         a+iPuwUPZG4tZA+JCqQH5Wz4Lv2ESVdYNq/fauxX8Yerk2G+9veWf1rQ1L6J3n+aiybt
         dh7zs3hplNo8FrSntGmv1tLkSUNhOMn6Bbgn4KUGfZgpXoMMKRQRlF8b88KbsaKe7AFI
         +hhZCS55+FmbssmfgPksnhclESsIXKkcVljxB+kuDy499fEIT/GYVE6ZKRgUZK67Rt9V
         Mnnw==
X-Forwarded-Encrypted: i=1; AJvYcCXtAPZL9wVO56pbs6zDcKxx2XXMQz9bI4gHo+PM5nGzQRyDuvP0H/5hKILGxCKQAJJwbK8SWWTrNell@vger.kernel.org
X-Gm-Message-State: AOJu0YxA3H7mZO9nIzkbwS3wyokBh/vD2LM+mAjoq0xyiWCVltxoJaYq
	7jhIQsO8O8ppifVOTamnt0jdMGNB+qM86Eb00FprwKauQHw2U9M4U98oPoTeL/4h1wHWjmjwlGK
	daim57Imn8jr9Bj7jM/oMRWIk0EsFQxc=
X-Gm-Gg: ATEYQzzGJ0iLSQVLJEfRvD46+0hdiSsNRkTF11h8RgpPSOxUsCrwmApxsDHXyGjAvyZ
	1eIMDU3pMWcjLqiPDbVBk5m5XVnXtOGs/aMUyT2s/3ToyzXecAGpNAclM3Vg9fPGDK0AOK81MD6
	2OZxvyB2apX/SQ0EiSZStM8Kg6eEo/nfj5vwm0jqWSbR+BulqY9tNyRXJEio1WmQTHtrbICwrzx
	N4We55jiwA5Lb81d58pVq3pl8uxdz8kpHVASxS1NqBtDgBueE873TWGA1XBzSwt8rt966VG1xdI
	vlKxY9CNKp5w6eOXf8CRvpsw2C9CVQBsUG6lkoWbTGWJgOH/FPc7ht9Gcic=
X-Received: by 2002:a05:6000:5c8:b0:43b:4951:6b37 with SMTP id
 ffacd0b85a97d-43b80592328mr2021634f8f.15.1774316846771; Mon, 23 Mar 2026
 18:47:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com> <20260316013651.3225328-11-ankur.a.arora@oracle.com>
In-Reply-To: <20260316013651.3225328-11-ankur.a.arora@oracle.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 24 Mar 2026 02:46:50 +0100
X-Gm-Features: AQROBzDT8zHTe-cnXwc3ToHi1r8Z06VC2JgJudU67Ap-gCTlXPytLAmMbqYbD7w
Message-ID: <CAP01T77qL1SF_-FFjbT4wJaYAe8g3XRNO0pyPs9c54qdcN5MGQ@mail.gmail.com>
Subject: Re: [PATCH v10 10/12] bpf/rqspinlock: Use smp_cond_load_acquire_timeout()
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org, 
	peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com, 
	harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org, 
	daniel.lezcano@linaro.org, zhenglifeng1@huawei.com, 
	xueshuai@linux.alibaba.com, rdunlap@infradead.org, 
	david.laight.linux@gmail.com, joao.m.martins@oracle.com, 
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Mar 2026 at 02:37, Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
> Switch out the conditional load interfaces used by rqspinlock
> to smp_cond_read_acquire_timeout() and its wrapper,
> atomic_cond_read_acquire_timeout().
>
> Both these handle the timeout and amortize as needed, so use the
> non-amortized RES_CHECK_TIMEOUT.
>
> RES_CHECK_TIMEOUT does double duty here -- presenting the current
> clock value, the timeout/deadlock error from clock_deadlock() to
> the cond-load and, returning the error value via ret.
>
> For correctness, we need to ensure that the error case of the
> cond-load interface always agrees with that in clock_deadlock().
>
> For the most part, this is fine because there's no independent clock,
> or double reads from the clock in cond-load -- either of which could
> lead to its internal state going out of sync from that of
> clock_deadlock().
>
> There is, however, an edge case where clock_deadlock() checks for:
>
>         if (time > ts->timeout_end)
>                 return -ETIMEDOUT;
>
> while smp_cond_load_acquire_timeout() checks for:
>
>         __time_now = (time_expr_ns);
>         if (__time_now <= 0 || __time_now >= __time_end) {
>                 VAL = READ_ONCE(*__PTR);
>                 break;
>         }
>
> This runs into a problem when (__time_now == __time_end) since
> clock_deadlock() does not treat it as a timeout condition but
> the second clause in the conditional above does.
> So, add an equality check in clock_deadlock().
>
> Finally, redefine SMP_TIMEOUT_POLL_COUNT to be 16k to be similar to
> the spin-count used in the amortized version. We only do this for
> non-arm64 as that uses a waiting implementation.
>
> Cc: bpf@vger.kernel.org
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]
