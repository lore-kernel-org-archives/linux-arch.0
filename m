Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81CB39734A;
	Mon, 21 Sep 2026 17:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790013436; cv=none; b=CipGWFylV3EqCHlcK6PqwxXtcZPZETCzXcjjT21rBWlBbL20yiYkfFLtuSGKaDb/7WUzZ+8/NgzdK3lZxO4XF+KHdkSNN1D5PBpcsltnvHDcFzATqJhDTE81mwdly3Yb6LcTB4uH1VUvu6ch6bIxR61NBKbNiu9WfMaBy3bKQMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790013436; c=relaxed/simple;
	bh=XW2kMLggkRWNkVt6ExhJhc6qzBTBSihv+LUgIX5RMcA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RivnL9I70PG7Jjm0kZLD8uMmlzbYsUMY1DP4bWyqeI1uL6FI0u0Wlf27TCvXmyLXWI7Vi21SCeZRSvVLcj+0kx+8XLaTERuZxRsMqpkxbjyLNUn6pEbqVGSBEjXq0g3RwYfDKxyz676Gqvc8Sx23KoXKvO2jUqguq8RSWBd0WjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=DsymiE1M; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="DsymiE1M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1790012833;
	bh=XW2kMLggkRWNkVt6ExhJhc6qzBTBSihv+LUgIX5RMcA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=DsymiE1MQAtmEN6uUB15xdAYVJDZfNgJnj2uprYa57YqGKxBPw/trT1vR1DDzhUmO
	 mG9CZX/7ouqOPVy1PfkrG6LJZR68SWo47gb09EdLmAGiAeSYTe398ITRq5Z08JDXrL
	 1zi94uzbdB0Ko5/ITaTybb562kwpWXK8p179l0Rc=
Received: by gentwo.org (Postfix, from userid 1003)
	id 85E8E406E1; Mon, 21 Sep 2026 10:47:13 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 82BF2406DE;
	Mon, 21 Sep 2026 10:47:13 -0700 (PDT)
Date: Mon, 21 Sep 2026 10:47:13 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
cc: Haris Okanovic <harisokn@amazon.com>, linux-kernel@vger.kernel.org, 
    linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
    linux-pm@vger.kernel.org, bpf@vger.kernel.org, arnd@arndb.de, 
    catalin.marinas@arm.com, will@kernel.org, peterz@infradead.org, 
    akpm@linux-foundation.org, mark.rutland@arm.com, ast@kernel.org, 
    rafael@kernel.org, daniel.lezcano@linaro.org, memxor@gmail.com, 
    zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com, rdunlap@infradead.org, 
    david.laight.linux@gmail.com, broonie@kernel.org, 
    joao.m.martins@oracle.com, boris.ostrovsky@oracle.com, 
    konrad.wilk@oracle.com, ashok.bhat@arm.com
Subject: Re: [PATCH v15 12/16] cpuidle/poll_state: Wait for need-resched via
 tif_need_resched_relaxed_wait()
In-Reply-To: <878q58z2ej.fsf@oracle.com>
Message-ID: <3e8bda45-0aa7-d0be-8aad-dab95902dcde@gentwo.org>
References: <20260831202251.305046-1-ankur.a.arora@oracle.com> <20260831202251.305046-13-ankur.a.arora@oracle.com> <178908146776.2725577.2613699832033292946.b4-review@b4> <878q58z2ej.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 11 Sep 2026, Ankur Arora wrote:

>
> Thanks for retesting.
>
> > The new unit tests all pass on both metal and virt variants of the same machines.
> >
> > I hope we can merge this soon.
>
> Yes indeed. I'll send out one more version which addresses a few minor
> bot comments (and patch-1 needs a re-review because of changes.)
>
> But other than that this is as mergeable as it will ever be.

I dont see it anywhere. Is this patchset scheduled to be merged?

