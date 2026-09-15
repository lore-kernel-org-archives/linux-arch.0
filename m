Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8475E39A7F4
	for <linux-arch@vger.kernel.org>; Tue, 15 Sep 2026 08:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461245; cv=none; b=uYJn5dBc8lmYcMPaE5IM6suEI+pSm6dZNUj2uA9KpxRId8Y++xzsUOmSjOL4FYmb7ngIgqc6SiPTS0hO2Bf7d5ARTZE45ndd5I2hp28+ZowfWtckkSNgkdDtKuI4J0yo4LmElvd9IlsdlC2SoCZXjv3bjQBUsrmA9ZmPA0K7RLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461245; c=relaxed/simple;
	bh=6oazE5lyXKugirOnKSHAnIRQytAaJZ5lnjV8psy6s3o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=E3UTZusMuFZAHhUn/QePXWLWbxU5FzuZ+aEZ+heYwXEzy13xD4GgpuXUhg5Lib15qQ0kJVD0nOC2dHkEt5PyQtVfvLyEyOuc4uY7yLOh7PPG0cyNE6PEjvlYTO9zZ5irs6X4+IPC/KA6+RUrI6OsSaRI8RXTfnotQ7LkSsvP7nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lv9HSILP; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lv9HSILP"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd5cf02so14324a91.3
        for <linux-arch@vger.kernel.org>; Tue, 15 Sep 2026 01:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789461243; x=1790066043; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hpbLL6EWSOuJK30L0ZNRx6vvSYbzSqSPnWalwqYVt2E=;
        b=Lv9HSILPLnHuKbxt6mga2pl32QOF55q2Kqi4InTfgt5dc2LKcxHM2kMp6pD/bufxGR
         IYNErJ6dWYlED2qwNRyK2xzX6jcdK0cFXoDCHeMXqR6WNUQWFc+0A3QRp/mdmDjzqPip
         etwN04Z4Vu7EGQzWZswRS1GXXixhQme3U/an0cpeEzBPAl0xolIlH0d4IiRlwDzJMP34
         EmmTX+5VAZCeRMe7hPRcET+WbjYqbZdhxJJcHnyz28h/ZlkA4b4ca/qS2v9QmDgZbbnf
         oPsWUTwbjJqnzMu03wFKec+PhZ2nJOsoRiWTFS7tWrKAyIXe4YzMNFxEBfjH4NIZziX0
         evPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789461243; x=1790066043;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hpbLL6EWSOuJK30L0ZNRx6vvSYbzSqSPnWalwqYVt2E=;
        b=P1okH4yDaq/j+Auchzp4Z3+THwZipQmQxyx6i5V/dHAX03RdzsxwIcmY8CaEsY4fv7
         gKz1Er20eP53cj8bwClsL4K0U3lVPor8Xvn1xpgNj7gt9qjChuM+rU41M7DxaEK40nEo
         5ci5zqUGJHDiCo6mugwJLmBhpeEO8tSbltqCbGV+SnEXPjjBkv26Jn6KSmUJOjbsvNSG
         0XUUzUqxvea3H+vnPbbDoURhzYCXdUOmyf2jacRPrRkjikuhTrWwhFzHXZJMby60ki0u
         eT+cfHh+ihnZfSyGwsEnEnuSN6zXCmqLyLmzPxslyhI02VrF7dLvCRASvzKkWOhVzHiC
         iymQ==
X-Forwarded-Encrypted: i=1; AKwUvBzabUPV6w+yYqSvLvomPb7aKBTQlQnCL4sE0+QUzZtZ1FiJOixy7K4Q8swC7dWgUlAGq4MnetQigNHK@vger.kernel.org
X-Gm-Message-State: AFuF++nMS8w7HioK4Rxt/suSl5QwEE6+nhTnyD/1NBEG0CrK7pQj4EVQ
	nv5PLRW+INvYUyky9kPQ3vXW8zB0I8PO67RInD3fJbLUkBmveomT7zNf
X-Gm-Gg: AYBFou075rceD1gvK/5mM+KQmbfey/zKAi336E5t48liPVv/PBCQefTWNoIeUZOdRQT
	hzAI20RSghF3iz03HxVVgvo5pvIdzYcNJv+DVj7OtcpG1iwvUZMq4oxfLiFVXKVFXRb6l0C4zz+
	avpf91WjtOCcBHBMH3l+kFfPFTm9fdGhpED+WKwevUCWf9r72X9Ul4Buo/Gv25jZ+IpRn5uZhXT
	a/tSgUQ47xb3+VjDwLH51fItTMNf0BbD5d+5GEgJPcL/fcFTOq5yq+XQFpWn/VELR83FOc9HSYO
	q39zJQkNxIPMu15qUnUesI+2vl2JqSI82+2XcaVyNv8ASl+V03wIGQbivhJ8lmvWvcUBhI1b2ZU
	Wak9mOQsnGu9xCFBNy3OlZnbq2m0dBJIIuwbukrvzAkw7n44oRyMcmpaRUOc4Uj5iVQIvwq9bKG
	TXRmbaw7zXAb6vEby13VAuYh90Or7WD9aeL0hc1ueyfG1LLW96C+BfFnYZTmnxiuJBkTd3ZtDFA
	BlnU73KsC3O2hGaFxDqiFscn6uy3Ig4Ji5GBwL7BpLQIg==
X-Received: by 2002:a17:903:b88:b0:2da:e967:7953 with SMTP id d9443c01a7336-2dd8384d004mr1520765ad.12.1789461242775;
        Tue, 15 Sep 2026 01:34:02 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4fa50e3sm34165946eec.29.2026.09.15.01.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 01:34:02 -0700 (PDT)
Message-ID: <9106d07e-a8e5-4379-bec6-eb4ee9f0df5c@gmail.com>
Date: Tue, 15 Sep 2026 17:33:59 +0900
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v3 1/2] Documentation/litmus-tests: Add SRCU fastpath
 anchor-before-scan test
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: linux-doc@vger.kernel.org, lkmm@lists.linux.dev,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 rdunlap@infradead.org, skhan@linuxfoundation.org, paulmck@kernel.org,
 dlustig@nvidia.com, joelagnelf@nvidia.com, corbet@lwn.net,
 luc.maranget@inria.fr, j.alglave@ucl.ac.uk, dhowells@redhat.com,
 npiggin@gmail.com, boqun@kernel.org, peterz@infradead.org, will@kernel.org,
 parri.andrea@gmail.com, stern@rowland.harvard.edu
References: <20260914143943.1503066-1-kunwu.chan@gmail.com>
 <20260914143943.1503066-2-kunwu.chan@gmail.com>
Content-Language: en-US
In-Reply-To: <20260914143943.1503066-2-kunwu.chan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/14/26 23:39, Kunwu Chan wrote:
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
> increment and its smp_mb() from __srcu_read_lock(), which orders
> the increment against subsequent critical-section access.  P2 models
> an observer that sees the reader's increment before seeing the
> anchor.
> 
> The outcome is forbidden by LKMM, and herd7 reports "Never".  See
> SRCU-fastpath-scan-before-anchor.litmus for the reversed ordering,
> which permits this outcome.
> 
> Tested with herd7 7.58 using linux-kernel.cfg.
> 
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> ---
>  .../SRCU-fastpath-anchor-before-scan.litmus   | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/litmus-tests/srcu/SRCU-fastpath-anchor-before-scan.litmus
> 
> diff --git a/Documentation/litmus-tests/srcu/SRCU-fastpath-anchor-before-scan.litmus b/Documentation/litmus-tests/srcu/SRCU-fastpath-anchor-before-scan.litmus
> new file mode 100644
> index 000000000000..e0492a4d8e07
> --- /dev/null
> +++ b/Documentation/litmus-tests/srcu/SRCU-fastpath-anchor-before-scan.litmus
> @@ -0,0 +1,58 @@
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
> + * increment and its smp_mb() from __srcu_read_lock(), which orders the
> + * increment against subsequent critical-section access.  P2 models an
> + * observer that sees the reader's increment before seeing the anchor.
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
> +P1(int *ctr, int *x)
> +{
> +	WRITE_ONCE(*ctr, 1);
> +	smp_mb();
> +	WRITE_ONCE(*x, 1);
> +}
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

Another knee-jerk reaction with exaggeration  :-)

Why does P1() have an access to an un-shared variable x ?
smp_mb() in P1() can't pair with any of other thread's smp_mb().
This doesn't make sense!

Let me rephrase.

Litmus tests is supposed to be minimal.
Every memory access and memory barrier is expected to
have some effect in the outcome of the test. 

In this case,

P1(int *ctr)
{
	WRITE_ONCE(*ctr, 1);
}

should be good enough, I guess.

(That is, IF I understand what you are testing here...)

Regards, Akira

