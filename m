Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D15D23507C;
	Wed, 25 Mar 2026 13:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774446838; cv=none; b=kt9cf0mBD//WlM1Nl+uqAnlwWQFLtQEbXXW4dGxl3AkyNagjljdjbjFQkMmKLnaiHYaejKBdJ5PsbH4DgacnQw/Dtfoiu5grs+mjX0JiduTww/8M0CcZwB8l53uD1/DtLI4NujlSQgechx1aVZg2MNz+tFS3CcHjrElqzGOlVzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774446838; c=relaxed/simple;
	bh=rTpz50E+4PJ6RioGt1JBhmHx0qMuH5Sl7wjDXLEJHn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMRZlpF2zRU9HoCFfZqHpJ/iNtrs2TnVoTtRBpUzsBN+wUe4DR2qZV5fSVMOKkKkXqKwsPWicNINSSs8BRuxbbhs5RSeXW7I4TlZuLoltb0nXjapX8yG6vLACxvYQbm+hSRQsLdd242HC41JtAC7Mqh4k02iXIsysD69Ljpolw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=F3S2Aixy; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="F3S2Aixy"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA21E1CDD;
	Wed, 25 Mar 2026 06:53:50 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 712F83F836;
	Wed, 25 Mar 2026 06:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774446836; bh=rTpz50E+4PJ6RioGt1JBhmHx0qMuH5Sl7wjDXLEJHn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F3S2AixyqhIuvb8mv8t2FHXLeYL9B2PwbydxQJsk+j50mWFPm3DNRdGMWKQ16/2k6
	 weCqqFChyZQPX537W7n5cnvAWcGK9jd+cQdtzw8wzA9Eh5HfC5UyqLTWEbBLh/76EH
	 xjaFdyHFtCq85BBXLQ7eZIVbpTx5hrKWok8PXOv8=
Date: Wed, 25 Mar 2026 13:53:50 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	bpf@vger.kernel.org, arnd@arndb.de, will@kernel.org,
	peterz@infradead.org, mark.rutland@arm.com, harisokn@amazon.com,
	cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
	daniel.lezcano@linaro.org, memxor@gmail.com,
	zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
	rdunlap@infradead.org, joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v10 00/12] barrier: Add
 smp_cond_load_{relaxed,acquire}_timeout()
Message-ID: <acPo7l_pd5rnHpSX@arm.com>
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
 <20260315184925.b6f93386e918ca79614843e3@linux-foundation.org>
 <874imftol4.fsf@oracle.com>
 <20260316233712.7cbfac27@pumpkin>
 <87ms07rlp9.fsf@oracle.com>
 <20260317091705.5a64fc56@pumpkin>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317091705.5a64fc56@pumpkin>

On Tue, Mar 17, 2026 at 09:17:05AM +0000, David Laight wrote:
> On Mon, 16 Mar 2026 23:53:22 -0700
> Ankur Arora <ankur.a.arora@oracle.com> wrote:
> > David Laight <david.laight.linux@gmail.com> writes:
> > > On arm64 I think you could use explicit sev and wfe - but that will wake all
> > > 'sleeping' cpu; and you may not want the 'thundering herd'.  
> > 
> > Wouldn't we still have the same narrow window where the CPU disregards the IPI?
> 
> You need a 'sevl' in the interrupt exit path.

No need to, see the rule below in
https://developer.arm.com/documentation/ddi0487/maa/2983-beijhbbd:

R_XRZRK
  The Event Register for a PE is set by any of the following:
  [...]
  - An exception return.

-- 
Catalin
