Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFB730EF85;
	Tue, 27 Jan 2026 03:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769485441; cv=none; b=oKMlXP74HgP/1Q5Y5vl1mWKqdDprpAHXF//h9JhatUklPRDipCpFKFxlUwq2cSyinzCKMxgEB+3kyu9Zs6yejq+kSKTYntzv8vQIktLK1kohIpPm6KrVfW3WPlXH79fyGFlgmgFc/MjlJOnqEGqkZUYEIIQIkF0XI+EHt/9ZphA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769485441; c=relaxed/simple;
	bh=psMAziqlxDZVzb5Uk+I3z12K0GYTEbRIPCJLgCvJfyk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rRQPzzhWzU8VyMrqkUytrImeM8ltJmIapdq421bJEsEobcsRyDQllwP26nOqSgvC0ZhYnCrEJ78+JG2DHRIwqQwBrEEAGUSSsf0VDi1+NJlxP6CRyeeYiNmQN1/cjdPhNTjayQKkygtAGmhly46qXrySth2q5Uot9+xKffwUGRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GO34MJc3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GO34MJc3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8D9C116C6;
	Tue, 27 Jan 2026 03:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769485441;
	bh=psMAziqlxDZVzb5Uk+I3z12K0GYTEbRIPCJLgCvJfyk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GO34MJc3QrTM9RTmQLg60gwEOa2nf9DAetvsmTUhy7DCAmTc9syqWiXzDJ0RxqAeR
	 bDo1V/IabA3/zj10YoPSlQ/u7/cZgxbgwkfSrFmhRKsA02m41IMGw7j97a1pqN+C8x
	 M+9Mcv/K/9I72omasTgSxqRYAcOybpaPBhxcitoLYR8sTA+hL2gIyAhtUBXNt+NHaf
	 5ddW7tTNjehwk4A6llU8APiqS5MMBg4gFJQkV0VbkAGeeaH2Jnnoh7ibfrcByCFk+O
	 cxTSvFNp4HH+lB2DtyZtmj5n9yeVh3SPLJgjCDNbSvFX3FdX+C94CWDWHNf6PP2+Xh
	 jlYDnuO4UP5Nw==
Date: Mon, 26 Jan 2026 19:43:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, "David S. Miller"
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
Message-ID: <20260126194359.461f908b@kernel.org>
In-Reply-To: <aXgryaSx9CzFR7kv@devvm11784.nha0.facebook.com>
References: <aXBnqYQdomzH9bT/@devvm11784.nha0.facebook.com>
	<20260121173512.748e2155@kernel.org>
	<aXGNhEKOhkTHbJvw@devvm11784.nha0.facebook.com>
	<20260121185021.446b00e8@kernel.org>
	<CAKB00G2xNvfiV6J3RzKDs=GHMGZ7L16+VKUYLGjpZdOrLnSYKA@mail.gmail.com>
	<20260121194615.33dc0812@kernel.org>
	<aXGib0OcNdHTLyZN@mini-arch>
	<20260126172646.2e5af2d4@kernel.org>
	<aXgjVb5PVqdPM10J@devvm11784.nha0.facebook.com>
	<20260126184440.755a55b2@kernel.org>
	<aXgryaSx9CzFR7kv@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Jan 2026 19:06:49 -0800 Bobby Eshleman wrote:
> > > Then, if the dmabuf count encoding space is exhausted, the socket would
> > > have to wait until the user returns all of the tokens from one of the
> > > dmabufs and frees the ID (or err out is another option).
> > > 
> > > This wouldn't change adding a field to the socket, we'd have to add one
> > > or two more for allocating the dmabuf ID and fetching the dmabuf with
> > > it. But it does fix the single binding thing.  
> > 
> > I think the bigger problem (than space exhaustion) is that we'd also
> > have some understanding of permissions. If an application guesses 
> > the binding ID of another app it can mess up its buffers. ENOBUENO..  
> 
> I was thinking it would be per-socket, effectively:
> 
> sk->sk_devmem_info.bindings[binding_id_from_token(token)]
> 
> So sockets could only access those that they have already recv'd on.

Ah, missed that the array would be per socket. I guess it'd have to be
reusing the token xarray otherwise we're taking up even more space in
the socket struct? Dunno.
