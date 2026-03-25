Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D621318BA6
	for <linux-arch@vger.kernel.org>; Wed, 25 Mar 2026 19:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774467375; cv=none; b=YJ0iN2aRwis0AVhPYn5y3p2rj7gc+Itnq4j81BmzCTcIpfBzoPeQ2h0wYNJm7axJBT7W3sLMg9eaq+tNid3w6Qsaz06aNSF0HFasXhd2TM1C6J5webjrG3vEOtL1LgVwG7f+JhKE3ELnM14ddmk2t0fS8YE78/4ojPOALwLE+Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774467375; c=relaxed/simple;
	bh=t3vdFCTCCd/mYTmRbH029kf+rM34+Lq6Cw+Vdj1lzxI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YbAWsMwRAH9WEY+U9cPtOEIkH75tzSbh/mDG7W7j0Ef2n1gaJkpXUicDW4QVdqzXDgW1rF8epXksgNp/35ZOr00NjGRIqaFBzRl5xT+uLj05s9SrO3b70upFOU82K7SERFFPGP2ZOvNCpQy0jzEM0MPUf6AD09+D39BZCIfuL4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFUJQFLM; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFUJQFLM"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439d8dc4ae4so148470f8f.2
        for <linux-arch@vger.kernel.org>; Wed, 25 Mar 2026 12:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774467372; x=1775072172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xbLSrdYpjpwOAwc60D31b27IF6Zr0PDhPWePECVS50=;
        b=jFUJQFLMQf3rtZYSyRGu1wRWWlFbMCsKPFtf6gFH+dqAxRQ9ywiUmSJcyT8najtaRM
         68A+mpPZauHCLvMUXvZJiqU/MRdqDWwexT/6EtNJ2Q9EQpdPLqFq/LDwxEpCz8k3pbCc
         a5bj/RIsth1DFrirmLypIdsNXBf1DE7faOoA9U/u7ii46ERZYhYg/DC45p9j5zxgYsUD
         GOKjKoRvF8xgNRS6vD0TYWigpjZPaJf/BOJPyxfee4AaagYSHPVw0VgotUsa2bhEv1Wp
         S2LKU9qR9jnEEGeGOWiLaaxMi/dpIHD6Yw8Br23Y01sRLnX21CElWkgyaa70jHC6URnF
         UXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774467372; x=1775072172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0xbLSrdYpjpwOAwc60D31b27IF6Zr0PDhPWePECVS50=;
        b=XWr/vmm2kqaYUicgh7yBqStxgcbCfuhddR7EV8c2tS6+MN0VJIl7BRI0J23zd9KiLB
         83dspvfnvIlr3oRKp89RJXNdJdOlhI52S1+7y+TpmoAFlixY3Qhrc8DMCeSM0Ny870Mn
         HzCw+N/FrmZ1cn2i+xJrdDmwlkW9wwec5HRguk8Vj68ukfE2x4D4qojSZ7y1guuS4Epf
         93KgyQgnRXQnkWuPqnz9PrHs5gJlFk3ebpOdMZAj3266hLQvXIZo9pJQyh4VjBFOFsee
         Gcb3E8OIeg6YWqO8EvtGSgXltn+COHJCGjwWz0Yi6eDhHKLuU30ZKzkVXSgxHoMEusBA
         Z42w==
X-Forwarded-Encrypted: i=1; AJvYcCWDOpYra5+qIe60hommv45XAaAVUHzTsLfT4J3ERLt7OdF3bmSVgrlHQXKoyOxisCWdYdhFctSk+D5p@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ1kVc1pqQpW13PUqXOfNynXeGzQLzEe2TZlmgMQcMM3SHccZL
	yn02B5cYzEVRPC+7UDRsvMCk5dKKCx6hJcbc036e6jw2fDUvWBy0ny9Y
X-Gm-Gg: ATEYQzxyG8SFiAywADn5449x49z8IbGgh7AJ9AMUbavg3MrHRFCqBHjTaDP4+pzyARX
	t7Dk+x3Azv2XP/iWFHr7c1bW9Z1wBQWKWme2QUkHgJZV1cZXt/F7sZGjbhdVHeMErNL9tfHT2k6
	0+1nmiaQdYMGpNo11DnR3QLf5RLi57qCHx5uAqMJjrrBf3kaQo7/Lw27ew0DCA6QCTtjsha6nCn
	gE1muorMcLYOlDktfUEVZOyMXYmkDFOeHXxm3sYsgBI7MgQnKC56pBOM/7QGPrHlJlmcBZz/KAI
	Fxn6fwZkoURihjSomoySh5P0xop6+NhPrkBI1zclpPDWaXaRa/Ns37ZurwW9Kxyib4E8Ov27unD
	nE6r3b2ToozUBxcnfSOhzbzHO0TWLp8U/rNblKry4SDOrbd3xFL8a1e1I19nghFtJkO8Qk0sgJu
	KosjdVxiFxrTeZ/FubVk244WsFkdBrklkxVxOxx7iZp00b+JHN81RSdmomXcV0YsGIwoUa19rkM
	3I=
X-Received: by 2002:a5d:5f47:0:b0:43b:8823:c12b with SMTP id ffacd0b85a97d-43b887e6cb0mr7083427f8f.0.1774467371899;
        Wed, 25 Mar 2026 12:36:11 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919dfb54sm2097287f8f.31.2026.03.25.12.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 12:36:11 -0700 (PDT)
Date: Wed, 25 Mar 2026 19:36:08 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, bpf@vger.kernel.org, arnd@arndb.de,
 will@kernel.org, peterz@infradead.org, mark.rutland@arm.com,
 harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
 daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
 xueshuai@linux.alibaba.com, rdunlap@infradead.org,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 konrad.wilk@oracle.com
Subject: Re: [PATCH v10 00/12] barrier: Add
 smp_cond_load_{relaxed,acquire}_timeout()
Message-ID: <20260325193608.10e9eca5@pumpkin>
In-Reply-To: <acQFaVR_bGZU2JmJ@arm.com>
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
	<20260315184925.b6f93386e918ca79614843e3@linux-foundation.org>
	<874imftol4.fsf@oracle.com>
	<20260316233712.7cbfac27@pumpkin>
	<acQFaVR_bGZU2JmJ@arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Mar 2026 15:55:21 +0000
Catalin Marinas <catalin.marinas@arm.com> wrote:

> On Mon, Mar 16, 2026 at 11:37:12PM +0000, David Laight wrote:
...
> > For osq_lock(), while an IPI will wake it up, there is also a small timing
> > window where the IPI can happen before the ldx and so not actually wake up it.
> > This is true whenever 'expr' is non-trivial.  
> 
> Hmm, I thought this is fine because of the implicit SEVL on exception
> return but the arm64 __cmpwait_relaxed() does a SEVL+WFE which clears
> any prior event, it can wait in theory forever when the event stream is
> disabled.

Not forever, there will be a timer interrupt in the end.

> Expanding smp_cond_load_relaxed() into asm, we have something like:
> 
> 	LDR	X0, [PTR]
> 	condition check for VAL || need_resched() with branch out
> 	SEVL
> 	WFE
> 	LDXR	X1, [PTR]
> 	EOR	X1, X1, X0
> 	CBNZ	out
> 	WFE
>   out:
> 
> If the condition is updated to become true (need_resched()) after the
> condition check but before the first WFE while *PTR remains unchanged,
> the IPI won't do anything. Maybe we should revert 1cfc63b5ae60 ("arm64:
> cmpwait: Clear event register before arming exclusive monitor"). Not
> great but probably better than reverting f5bfdc8e3947 ("locking/osq: Use
> optimized spinning loop for arm64")).

Could you change the order to:
	LDR	X0, [PTR]
	SEVL
	WFE
	condition check for VAL || need_resched() with branch out
	LDXR	X1, [PTR]
	EOR	X1, X1, X0
	CBNZ	out
	WFE
  out:

that closes the timing window for the interrupt provided the condition
check doesn't change the event register.

I must get back to the osq_lock code again.
I'm happy with the code - the per-cpu data is down to two cpu numbers.
(Apart from the acquire/release semantics in a few places.)
But the comments have got out of hand.
Writing succinct and accurate comments is hard - too verbose and they
hide too much code.

	David
