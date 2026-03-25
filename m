Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0423C7E01
	for <linux-arch@vger.kernel.org>; Wed, 25 Mar 2026 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774453335; cv=none; b=k68FDHEZ2Lx2b6i0vwoxtpkvkMtwSql84YAXEuiEjdxlsImGHNWBiXAxA/9OxArHEhxXjWKrD3Eycw8UR4z6kVFmrXI7stXK3RZT5zwPQiNOY9xMo/bqnZM/PWP/R76m0YkiPgQugto33r0SRdLC7syHyOf/Fhtj2Z1Ri4C9lAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774453335; c=relaxed/simple;
	bh=toS7UUE6wFJTL19DVzAONQ7Jlc/gULcgXL/ZAbuTzdI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t8+0VqmAb7Y1BouTexPqK8MUsTP1QBsBjgvMPkNTWt4UMxWDzqOXgMFeAlTbGspJABz8wRFP0MYJYsVIJjYu73KP5nEEZ/HknKCqMx5v/hUDiATz5CjubO3sTf8uPHAuFtRZ4P+tnqVg6pcc8AcRz6A0MALNFolke/DdtXUTVG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEfzyRVX; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEfzyRVX"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439cd6b0aedso4429555f8f.1
        for <linux-arch@vger.kernel.org>; Wed, 25 Mar 2026 08:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774453332; x=1775058132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqPXz+Sa/AY6Vo8qNYqeoHSuweF/2Tg4HA9dNOaxg0o=;
        b=cEfzyRVXwJ/ySEXBaH7dTEKa+C/dffXAg3dYTU4ISN+5G7nGIy6gaiHG2qN27Sb1GO
         5ztsPBRKljNUh1EHk2gNyMo1uaeS90HecqwBallrs1LVldeN+mvQiWXCR6GT33osJeYH
         grc7YQXeCeqc/4L9wxIkLU1Z7KsU2A5VsefstjsGQxPHEg6Mz5dJtTX1IBMfxcAc1p+P
         6XQPmBphvVJagA7Egq2r+sfwIrAJHkFKF7MK5YhZmyWFR5mt3s09I7MEtX2s+niYaAgN
         TxFXD9cdk4pOL9dfTyVf8GkKghXRyy4rszeeTH/yKe8fJRId2wZDHHFw1zgGa0EvrMS5
         6U4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774453332; x=1775058132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZqPXz+Sa/AY6Vo8qNYqeoHSuweF/2Tg4HA9dNOaxg0o=;
        b=Q/nfylSz687nZETpB3UDK89bj65ErfU5wmzQreNJEG+KWRHoWDnvVFS1nK+1Q6kPbp
         TR6grAF/yTAogZGzF9AKAryXHyhyv/PI5F6vRwPFLSUK7ujFSIOgV6J3EUv5KNoE0ciW
         YjL7gnVyOyoDs59+nNJyjnwK3nleC9avtZfv95lmGEz6dhL6PhUVa+sXouswRGsV+2vU
         z2OZ/J/Xc81SpVsRljK4/EluSP/B8hgBBtyOlrVAM4u+3ZoaWMv15BHT6TGkmlS1Q/8u
         Lh7lqBTpjJ+MbTDuvEa+cuqyygRJvS7Evj2yu2M77YrRnHk2ePL3o5GxET35W+FQssKy
         zzsg==
X-Forwarded-Encrypted: i=1; AJvYcCVNDvV4aph9qVyi/rX7xgt1kZXzcu7G3WvAHzqCd5+2+HYkjwKWFIkYAO81eZzehoVXeAVNNoNqKJkr@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8goH6L+cSkk8T15tfGAQf2/SKRrAObwjMKRR1K+I5YSFYdoqj
	DapLIt04FaC8wvuD8D2NAebcVbed/HOCw2gd8mWZd0+rrGbym5nCPMMY
X-Gm-Gg: ATEYQzzG2Aa/mzPz/Uy55+EOGH0mImuE12PH+jZGUWLs+NqBI8/GTpgfpDmPQ7ffWvF
	wuuehK1Rrc4PwV1As88/Mhhr8pmPEJ8cGM1NIPi029JHpiNVruFpVXXd50WCx0X5vSHSqxgolr+
	BguH+JQ9zyg5+vYZ+1DFWtUk15Rgfn5dAjdAL13+U/4Y5FKeUi2i3GCas9UWoOaWq8B4kbE5X4o
	IxIfKf0pnHtBsRH7enfJUGAuDsf2NdYwq1+X6QAs8DgqEggQvG8vQMoBRhOmjgodCApaPqX49mi
	eOAg20OWndr1KAJEduqzHNwsBDys3p3tdgRIRZCPqWRtL4AAPy070u66UQFKdtER9GqE2oVr5kX
	P/KXwzbUw2Uen26f/eXxl0brltr8BNUAolrIBiY87jtQQ9N8+PucbFzKcLxxLmTwhhI1/iv9kf1
	VPapYCs1SEgO7CvGJgSfa6XZQUNUTEbl9WG3pDZRB/DumLfMZOWLSK1A/RoWbc7jNR
X-Received: by 2002:a05:6000:2912:b0:43b:8766:6005 with SMTP id ffacd0b85a97d-43b8899d143mr6042308f8f.20.1774453332131;
        Wed, 25 Mar 2026 08:42:12 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919cf2b2sm609925f8f.18.2026.03.25.08.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 08:42:11 -0700 (PDT)
Date: Wed, 25 Mar 2026 15:42:10 +0000
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
Message-ID: <20260325154210.79a621df@pumpkin>
In-Reply-To: <acPo7l_pd5rnHpSX@arm.com>
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
	<20260315184925.b6f93386e918ca79614843e3@linux-foundation.org>
	<874imftol4.fsf@oracle.com>
	<20260316233712.7cbfac27@pumpkin>
	<87ms07rlp9.fsf@oracle.com>
	<20260317091705.5a64fc56@pumpkin>
	<acPo7l_pd5rnHpSX@arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Mar 2026 13:53:50 +0000
Catalin Marinas <catalin.marinas@arm.com> wrote:

> On Tue, Mar 17, 2026 at 09:17:05AM +0000, David Laight wrote:
> > On Mon, 16 Mar 2026 23:53:22 -0700
> > Ankur Arora <ankur.a.arora@oracle.com> wrote:  
> > > David Laight <david.laight.linux@gmail.com> writes:  
> > > > On arm64 I think you could use explicit sev and wfe - but that will wake all
> > > > 'sleeping' cpu; and you may not want the 'thundering herd'.    
> > > 
> > > Wouldn't we still have the same narrow window where the CPU disregards the IPI?  
> > 
> > You need a 'sevl' in the interrupt exit path.  
> 
> No need to, see the rule below in
> https://developer.arm.com/documentation/ddi0487/maa/2983-beijhbbd:
> 
> R_XRZRK
>   The Event Register for a PE is set by any of the following:
>   [...]
>   - An exception return.
> 

It is a shame the pages for the SEV and WFE instructions don't mention that.
And the copy I found doesn't have working hyperlinks to any other sections.
(Not even references to related instructions...)

You do need to at least comment that the "msr s0_3_c1_c0_0, %[ecycles]" is
actually WFET.
Is that using an absolute cycle count?
If so does it work if the time has already passed?
If it is absolute do you need to recalculate it every time around the loop?
__delay_cycles() contains guard(preempt_notrace()). I haven't looked what
that does but is it needed here since preemption is disabled?

Looking at the code I think the "sevl; wfe" pair should be higher up.
If they were before the evaluation of the condition then an IPI that set
need_resched() just after it was tested would cause a wakeup.
Clearly that won't help if the condition does anything that executes 'wfe'
and won't sleep if it sets the event - but I suspect they are unlikely.

I also wonder how long it takes the cpu to leave any low power state.
We definitely found that was an issue on some x86 cpu and had to both
disable the lowest low power state and completely rework some wakeup
code that really wanted a 'thundering herd' rather than the very gentle
'bring each cpu out of low power one at a time' that cv_broadcast()
gave it.

	David

