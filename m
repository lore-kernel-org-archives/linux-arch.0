Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D310523D7F7;
	Tue, 27 Jan 2026 01:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769477208; cv=none; b=N1ENvMCG0OB+i37br0Lg/haxLd/EAugwmIXesC+jdowgIJSAx1WCLzN/Ppx0q554vdQcyXOhOwxnF5w8XwgjBm79SWZYUu6qwmcmk4KpqHte80+Nvgx0XMaMSsD9oIW/TDnGXqW7EDwqQGu5BuQBwzi8Bga4qDu3COYfpeK5NRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769477208; c=relaxed/simple;
	bh=gmdrVwD9eObEFR00n36pXc50L4GnXjwmmLnzgMT1NlU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uBZnHn/R/W7X7ktpFauMycnsPXgYWu9FqMHvK2TqiFmkasYvwF3TxINP51IZvrLO5NnxHHk0rT+wXdyZtk2WuQ4fdyydgKLPuAMu1fiYcVeQUKyj+0IAtoNGh3XQBnO5zXTz/c5w795L5Vy5E/gQ9ZHtjnEbiWMGPp9QI0Af3U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+QW8vpm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+QW8vpm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E874C116C6;
	Tue, 27 Jan 2026 01:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769477208;
	bh=gmdrVwD9eObEFR00n36pXc50L4GnXjwmmLnzgMT1NlU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e+QW8vpmETOY6ejHARAz2/oNFnfVyXlahzJt93h2H9CUXabli1qsjSy7WoR5FiWJh
	 KvUI037G+x1u4pYJswRTYgbJAiphQy9pGJ/aiE6+qG/Ybp1anuDGIpFhpTwP17iK0R
	 4FVcTTiu2qes330GNIzqi9MiqezgkYYGbu6OPU9o4nbDYogrDjBwfdvHjcAWX28CqZ
	 X13xR5bCq4o1Cwqbp6IIoYAM2J0oPcs8mHjdPiWIuup5e70lZlyLJHEf+jJ8XFwNWe
	 xh4kYAXh5LJ5bV8V32KWLVFUCn3vlfNgTKu5Th7/JWhIespwAW94KW81HVbCNCRubH
	 Ck2AFH/769BYg==
Date: Mon, 26 Jan 2026 17:26:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, Neal Cardwell
 <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, Mina Almasry
 <almasrymina@google.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet
 <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan
 <shuah@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, Stanislav
 Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 asml.silence@gmail.com, matttbe@kernel.org, skhawaja@google.com, Bobby
 Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v10 4/5] net: devmem: document
 NETDEV_A_DMABUF_AUTORELEASE netlink attribute
Message-ID: <20260126172646.2e5af2d4@kernel.org>
In-Reply-To: <aXGib0OcNdHTLyZN@mini-arch>
References: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
	<20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-4-686d0af71978@meta.com>
	<20260120163650.5a962648@kernel.org>
	<aXBnqYQdomzH9bT/@devvm11784.nha0.facebook.com>
	<20260121173512.748e2155@kernel.org>
	<aXGNhEKOhkTHbJvw@devvm11784.nha0.facebook.com>
	<20260121185021.446b00e8@kernel.org>
	<CAKB00G2xNvfiV6J3RzKDs=GHMGZ7L16+VKUYLGjpZdOrLnSYKA@mail.gmail.com>
	<20260121194615.33dc0812@kernel.org>
	<aXGib0OcNdHTLyZN@mini-arch>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jan 2026 20:07:11 -0800 Stanislav Fomichev wrote:
> On 01/21, Jakub Kicinski wrote:
> > On Wed, 21 Jan 2026 19:25:27 -0800 Bobby Eshleman wrote:  
> > > Good point. The only real use case for autorelease=on is for backwards
> > > compatibility... so I thought maybe DEVMEM_A_DMABUF_COMPAT_TOKEN
> > > or DEVMEM_A_DMABUF_COMPAT_DONTNEED would be clearer?  
> > 
> > Hm. Maybe let's return to naming once we have consensus on the uAPI.
> > 
> > Does everyone think that pushing this via TCP socket opts still makes
> > sense, even tho in practice the TCP socket is just how we find the
> > binding?  
> 
> I'm not a fan of the existing cmsg scheme, but we already have userspace
> using it, so getting more performance out of it seems like an easy win?

I don't like:
 - the fact that we have to add the binding to a socket (extra field)
   - single socket can only serve single binding, there's no technical
     reason for this really, AFAICT, just the fact that we have a single
     pointer in the sock struct
 - the 7 levels of indentation in tcp_recvmsg_dmabuf()

I understand your argument, but as is this series feels closer to a PoC
than an easy win (the easy part should imply minor changes and no
detrimental effect on code quality IMHO).
