Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C9D32AAB5;
	Wed, 24 Jun 2026 06:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782282407; cv=none; b=Fd91PGEpf4mmT9yt7kdCtT765NO7YzzDRLKZhG46CqBiBZ8H2KO97rz0TnGCzdh7kfR7tLGpQnhp0t3oqkRXuy+r3Mpmm9wO53/wUVNkVa7fRAdbYXca2cY3F6ybIhdjcrnnFqWWhT3ZCSwFd6t5prCeRtAvqDN0KQNWTxuAZaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782282407; c=relaxed/simple;
	bh=0vjDpm2bKnUhT+EfFPRfJ1u5DQc74zrXkPdzkXOX5Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wgzchd06k2f5cQEqZdVLybbOv5rCBY6d59voXKyYXDAP7OxlgRql6+eM3aRw0e2104qkM6CYhU468MFFREccsRq57ys8cONkDOi6ZW6QAOADjpOu6p43l1nrjlnEJvrcPR3GSVycX+gS4q7ln5A4ws2butiiEuj1RUuHBlr8NH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Juja3//w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=defu1nJc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Juja3//w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="defu1nJc"
Date: Wed, 24 Jun 2026 08:26:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782282404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UEwSwydbqyddg0x4WGqgKE9dtk0yX5ie6tfL0VulhhQ=;
	b=Juja3//wAMtoqQ9BPBv8GnGjLzUs4cHvNu+MiAp1raa+aOuYzcgHGnpnK0PR9UoxnIaWSm
	KnHqjI/GItmuSvC8UqLaCmju8Aj3LAvJCC1uLHQLNpaqA6HHgBYrjD+g7LcNMmj1xTQDj9
	exkKkwFTfd4lWXYfSWABZsWnvLIuY9pf7p7pFcgowI0vulYbvuC4+FGWJEJAOr7udUXfci
	yS+boDlanrogfe4D4dKtZckjjZ5/Bv89Aeb5nYBVaQyGPJYbCSqsQb+Az5fVkECc1s8wCH
	bf/LZNLZtMjxU8xFx5yJ/rXVqcRlk3n1r108pLgeq3ZECooAQorWHiuKUxeTgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782282404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UEwSwydbqyddg0x4WGqgKE9dtk0yX5ie6tfL0VulhhQ=;
	b=defu1nJc+8utxGZI3K+aqFY0T0pIpJuycUiiStzL1lpqAw4pWEq86wVndS4WRZgCg/nDlw
	lqWbWAicArExUlAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Andrea Righi <arighi@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Ben Segall <bsegall@google.com>,
	Breno Leitao <leitao@debian.org>,
	Changwoo Min <changwoo@igalia.com>,
	David Vernet <void@manifault.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Eric Dumazet <edumazet@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Simon Horman <horms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vlad Poenaru <vlad.wing@gmail.com>
Subject: Re: [PATCH 1/2] bug: Provide WARN_ON.*DEFERRED() macros for console
 deferred output
Message-ID: <20260624062642.5DER6vrP@linutronix.de>
References: <20260623142650.265721-1-bigeasy@linutronix.de>
 <20260623142650.265721-2-bigeasy@linutronix.de>
 <038a11a7-4ced-49ae-b605-2058733e841a@amd.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <038a11a7-4ced-49ae-b605-2058733e841a@amd.com>

On 2026-06-23 20:24:02 [+0530], K Prateek Nayak wrote:
> Hello Sebastian,
Hi Prateek,

> nit.
>=20
> Instead of replicating these bits, can we replace that return with a
> "goto out" ...

sure

=E2=80=A6
> ... and replace this return with a:
>=20
>     return (warning) ? BUG_TRAP_TYPE_WARN : BUG_TRAP_TYPE_BUG;
>=20
> Looks a tab bit cleaner to my eyes. Thoughts?

It sure does.
I wait for PeterZ' executive order to either do this and sprinkle sched/
_or_ make legacy consoles deferred as it is done on RT.

Petr, was there a big push back doing it unconditionally?

> >  }
> > =20

Sebastian
