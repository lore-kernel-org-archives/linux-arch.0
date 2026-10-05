Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107EC49B21D;
	Mon,  5 Oct 2026 14:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212061; cv=none; b=evuDJ0w+MinmDCFFPoR+l+DOL3QwTvQEfUH/yPHq0PIL73AC40nbnbMIdBmr7NG0+ohmecnJltsQu9veDQ8SXNOs0R7yY/KtKQt8ZNRwNY+IzYjYtzbVzybNvAfkSTSFC0SK3V5p9FG5EDpzDULgMYcIjA480/tulo7xG52bFrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212061; c=relaxed/simple;
	bh=nRmkUAiJquGXyaBqXrGxDvzrTNdrXzehZynjjgY6Arc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTowBziW/BSx97k4r5oShXqbF9qBoyFQ+2jjAwyFQeTwwVLoyS39S3gjqjYOLA0j26kjl8pGdR1+gkeIT1pi0EFXu8qL8xg5m3Cpcafa/Svtja0wA79Syc6n+LynstkCTAnhhuZWN/dZab8OywDSYMCWsZudjYxNnP9JcGgygzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwCkGRTZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwCkGRTZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0511E1F000FF;
	Mon,  5 Oct 2026 14:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791212057;
	bh=ml0bJq37gNah4nriSIxxfE2gWQxnHe7Kbi/7fwa6U18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XwCkGRTZwYx8gWHVO+Ok74pAsXqNKrj6FS3afHzOl/T2sRkgvtAarRk6ZWUjssgrr
	 K6i8BGaNfkR5N0Nk+wLHFINwNTX9eK6fJ1TRzbcbHv0k6dNoXMiA8Mnvmvx27Brhg5
	 Fdn4prvDFENiIcbudg6P4vGFtDwABfg/G0fJU1Y65MnYc8gtq31cORQ6qS50wxjCNc
	 MFKnMatrZLpE54I9jyUBOZf6F77eVNW2mlLLq50SF9fz+EvkjyDaZjAfC/8h6ivfhS
	 tV76cxqlzCDqvV4SWoAOi0L63STALFuuf28IKBKlr9Eg1LH6PY+QILvO6ZT2eJ+xPQ
	 XB37MyRpg/qAQ==
Date: Mon, 5 Oct 2026 16:54:14 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: arnd@arndb.de, anna-maria@linutronix.de, mingo@kernel.org,
	tglx@kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] timers/nohz: Mark got_idle_tick accesses as
 same-CPU races
Message-ID: <asO6FntKFaxnTYX2@localhost.localdomain>
References: <20261002151757.3605081-1-kunwu.chan@gmail.com>
 <20261002151757.3605081-3-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261002151757.3605081-3-kunwu.chan@gmail.com>

Le Fri, Oct 02, 2026 at 11:17:56PM +0800, Kunwu Chan a écrit :
> got_idle_tick is a per-CPU flag set by the tick interrupt handler in
> tick_sched_do_timer() and read and cleared by the idle path in
> tick_nohz_idle_got_tick().  The flag is intentionally accessed without
> ordering or locking; a concurrent set can be overwritten by the clear.
> 
> Use WRITE_ONCE_THIS_CPU() and READ_ONCE_THIS_CPU() to identify these
> as intentional races between execution contexts on the same CPU,
> rather than accesses that may race across CPUs.
> 
> Suggested-by: Thomas Gleixner <tglx@kernel.org>
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
