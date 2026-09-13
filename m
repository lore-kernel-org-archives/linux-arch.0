Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED86238552C
	for <linux-arch@vger.kernel.org>; Sun, 13 Sep 2026 09:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789292903; cv=none; b=hTEQ4puY47c+PzgA2Kea8WyX0wvoSgHJwOLM60RfzWDXgVVkdiCZfW0SKX/RTLwH9vw1FBa4gL1wYM51Qgufj8QZMReQ+tupBtbPXCXtNSZaAi5DjvmjPSXa7BR9hZz+RYnecqOIlXcIgaTbduA7VLGWJC8cGjhL08OUaFwSUbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789292903; c=relaxed/simple;
	bh=owsxUV26+TugNfbC4Bz0+KGKiRcbdSBwVMp6oIjgyi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FGUuUbsLKGwgc9vFIvNtESLrKbKpgrd4bF2JndxKkkwgbkb4974P7c/COmlvitLqZC3udHWqUanK2Q08fvl3lZbn/SF0d1Wc5hwOzDYPjlr9IaN4QZrjDX5Nd8dyB1j02beYiH9SEiXczuS8cw9u1zutxFLa9lDAFjgxNCTWcEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERyJEzhx; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERyJEzhx"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb652d7so664225a91.0
        for <linux-arch@vger.kernel.org>; Sun, 13 Sep 2026 02:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789292901; x=1789897701; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V6u+Sjb8r7xjY6JptTsujS7yPcyjNk7vFPdDqkz69nM=;
        b=ERyJEzhxiwVFNLLVAKtsqa3XQSYbhWLnwT8ROTveg+9z9uD7AhHl3NebFlLVHyN/ZL
         VPIloOBQn12QjLehJfrwLlrwHjD4btGVXax96vlyioanACf3EdN3qNWORuyE91FIb2qX
         YhyI1QT36C7vBgXEYWhSQ/brx0Qr1yt2StoF7nxSNKwQs/4GazhqdjRY9lB8oTO3xmIC
         rGlB3VJylrSIrTn9IfIwSlJRgsxl+kdGtEfFvOyeYWn9OpAqFYWujhGiho5bP8WZl9BV
         Ta5/JmyHjIjS4CREBTawY8c45Mzagat6pNVZZlR84uuKTcOjslJ+fWzLdSFBSD3qjaG4
         n25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789292901; x=1789897701;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V6u+Sjb8r7xjY6JptTsujS7yPcyjNk7vFPdDqkz69nM=;
        b=mPQaFOLpls2373/raybv5gQ0AvwAa/duhkKW+5ot+p6ZcWtVZQseIOF5pcDdXb+pi4
         uPEbiHrlzSW8ej06Lk6BCVWNEbjh7Kiq6gtTHZDZLyIB7X3kjX4y0Z/G7+pOJiBEDCND
         BLW0FmkjLaLI0ixhA/dPNz+cH2s6f7ao08yTWSCWubUtF3B7nMT+KfZZlSqvrfNed6Ur
         0TQ7tz4Ez9C32eVf7rHB02gMUJmSvs7DeizglA6HLskMYSytQp3fImMvx8reeXsPLEFN
         jquf68lF9n2RxBzoD2HT855/MT1g2myWbOhX1MmMS4wN9IJss/FTQ0b4uUEphWNDzRqZ
         nP+Q==
X-Forwarded-Encrypted: i=1; AKwUvBwvKgbiVOGDupE6N8v9kkpGE9FX+EMlWxGieMwMdzpKz/RQSmZwmfF5OaNloHJwCjkDKhJSFJQS0kOg@vger.kernel.org
X-Gm-Message-State: AFuF++kta+LIOwHc5hiRrsZfw7iUJIEyMcLKxYjRRHvNmNx6ynzxsGcD
	rQCdkrzye26N5sIRayV9/HfX9hq/GTZvcNisrN/34eSCGGojrVMQ5LyF
X-Gm-Gg: AYBFou2iyFtKJ6LBCd7lAYFaIrdzaZMdmQz4OKRw+hg1b0A+WFa5HmW56HNKoypP0Ml
	pm81GA4HO/te+7xTzvEAZJvG2fhXLKj08iNMQKZLgfATLyJeq/Vu+DYcQWj9WTrdkZQIZp9+8LF
	JHtJOZqnMqn8QbAP2Zl8OUZhp47dAmHm/m+ANbCU4xnQCvnOdtjs8jicBLD6S9n60kXv/EBhosF
	Tnk72UWGtwOIyQKyCDyuRUtiC54s27Kb1Vt+mwUOGd4FZr1/V1QDRsyrjFlk0uTBy6lNaCc8Oha
	0lBmGjmFPvl9V9QClb6Cs+d9EQXNqei8KAYTFV36OKXOUpqxFuvOHn9Oeg6P4MlR1MIOSxA3Xn9
	J41zFOAn+LURM1RO6XU9eX5ug0TNBFLQHa0zxwZu3n6p71nT0bDBYWmcLeWwKzf51zeM66EJMjw
	ZwFxfpI62ItvkUgv6ImvzQa7lyc5xOqusXlxNuvceHh2ao960qJALdV/DhP4DGf3ulN5aQQ+WlJ
	BJBb9Tq5yp/V5CvpbpAy4/FG38aebfZ7MbXTmoA46Vt
X-Received: by 2002:a17:90b:53cf:b0:380:540:d499 with SMTP id 98e67ed59e1d1-39dbbeb3c67mr11040631a91.6.1789292901241;
        Sun, 13 Sep 2026 02:48:21 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d994cf9a6sm14389647a91.10.2026.09.13.02.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Sep 2026 02:48:20 -0700 (PDT)
Message-ID: <892d82bf-aff4-4b0c-9585-8438280b45b1@gmail.com>
Date: Sun, 13 Sep 2026 18:48:18 +0900
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] Documentation/litmus-tests: Add SRCU fastpath
 anchor-before-scan test
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: linux-doc@vger.kernel.org, lkmm@lists.linux.dev,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 rdunlap@infradead.org, skhan@linuxfoundation.org, paulmck@kernel.org,
 dlustig@nvidia.com, joelagnelf@nvidia.com, corbet@lwn.net,
 luc.maranget@inria.fr, j.alglave@ucl.ac.uk, dhowells@redhat.com,
 npiggin@gmail.com, boqun@kernel.org, peterz@infradead.org, will@kernel.org,
 parri.andrea@gmail.com, stern@rowland.harvard.edu
References: <20260912024225.2872265-1-kunwu.chan@gmail.com>
 <20260912024225.2872265-2-kunwu.chan@gmail.com>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20260912024225.2872265-2-kunwu.chan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

This is more of a knee-jerk reaction, but

On Sat, 12 Sep 2026 10:42:24 +0800, Kunwu Chan wrote:
> synchronize_srcu_atomic() may end its grace period immediately when
> its scan of the per-CPU lock counters finds no readers.  Correctness
> requires the grace-period anchor written by srcu_gp_start() to precede
> the smp_mb() ordering the lock scan.  This ordering ensures that any
> reader whose lock increment is missed by the scan cannot have
> incremented its lock counter before the grace-period anchor, and
> therefore cannot be a pre-existing reader of this grace period.
> 
> This litmus test models the key ordering between the grace-period
> anchor and the lock counter scan, where "seq" models the
> grace-period anchor in ->srcu_gp_seq and "ctr" models the per-CPU
> ->srcu_ctrs[].srcu_locks counter.  P0 writes the anchor before the
> smp_mb() and the lock scan.  P1 models the reader-side counter
> increment, with the smp_mb() of __srcu_read_lock() following the
> increment.  P2 models an observer that sees the reader's increment
> before seeing the anchor.
> 
> The outcome is forbidden by LKMM, and herd7 reports "Never".  See
> SRCU-fastpath-scan-before-anchor.litmus for the reversed ordering,
> which permits this outcome.
> 
> Tested with herd7 7.58 using linux-kernel.cfg.
> 
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> ---
>  .../SRCU-fastpath-anchor-before-scan.litmus   | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/litmus-tests/srcu/SRCU-fastpath-anchor-before-scan.litmus
> 
> diff --git a/Documentation/litmus-tests/srcu/SRCU-fastpath-anchor-before-scan.litmus b/Documentation/litmus-tests/srcu/SRCU-fastpath-anchor-before-scan.litmus
> new file mode 100644
> index 000000000000..efa9c0c4e047
> --- /dev/null
> +++ b/Documentation/litmus-tests/srcu/SRCU-fastpath-anchor-before-scan.litmus
> @@ -0,0 +1,57 @@
> +C SRCU-fastpath-anchor-before-scan
> +
> +(*
> + * Result: Never
> + *
> + * The synchronize_srcu_atomic() fastpath may end its grace period
> + * immediately when its scan of the per-CPU lock counters finds no
> + * readers.  Correctness requires the grace-period anchor written by
> + * srcu_gp_start() to precede the smp_mb() ordering the lock scan.
> + * This ordering ensures that any reader whose lock increment is missed
> + * by the scan cannot have incremented its lock counter before the
> + * grace-period anchor, and therefore cannot be a pre-existing reader
> + * of this grace period.
> + *
> + * This litmus test models the key ordering between the grace-period
> + * anchor and the lock counter scan, where "seq" models the
> + * grace-period anchor in ->srcu_gp_seq and "ctr" models the per-CPU
> + * ->srcu_ctrs[].srcu_locks counter.  P0 writes the anchor before the
> + * smp_mb() and the lock scan.  P1 models the reader-side counter
> + * increment, with the smp_mb() of __srcu_read_lock() following the
> + * increment.  P2 models an observer that sees the reader's increment
> + * before seeing the anchor.
> + *
> + * The outcome is forbidden by LKMM, and herd7 reports "Never".  See
> + * SRCU-fastpath-scan-before-anchor.litmus for the reversed ordering,
> + * which permits this outcome.
> + *)
> +
> +{}
> +
> +P0(int *seq, int *ctr)
> +{
> +	int r2;
> +
> +	WRITE_ONCE(*seq, 1);
> +	smp_mb();
> +	r2 = READ_ONCE(*ctr);
> +}
> +
> +P1(int *ctr)
> +{
> +	WRITE_ONCE(*ctr, 1);
> +	smp_mb();
> +}

As P1() has a single memory access, this smp_mb() can't have any
effect on the outcome.

The one you see in "__srcu_read_lock() following the increment" is
there for other ordering requirements, I guess.

Ditto smp_mb() in P1() of 2/2.

Thanks, Akira

> +
> +P2(int *seq, int *ctr)
> +{
> +	int r3;
> +	int r4;
> +
> +	r3 = READ_ONCE(*ctr);
> +	smp_mb();
> +	r4 = READ_ONCE(*seq);
> +}
> +
> +filter (0:r2 = 0)
> +exists (2:r3 = 1 /\ 2:r4 = 0)
> -- 
> 2.43.0
