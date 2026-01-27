Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6CC2FDC20;
	Tue, 27 Jan 2026 02:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769481882; cv=none; b=k5x3pqBfJoVbZu6AhE0BxHAtDNliSd+Pw77EAPn8ggLMqVC/lmx34QmdPM0KIYBBhvBSn7sCKSq5MJwHsAdw505uA98A7Yjno0GHcXHIpalqgNIu7DMCcy9+8eptymOxDWkkfJlUN6tMgDwWfs0dHyahCa4rNhebgUzg0Ck3yis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769481882; c=relaxed/simple;
	bh=S3Iqv2UJ//ANnGVhqJ9ttWirfCzi27qFI76ZSe0b+FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GK9tY2CrATqMch05/87Zjf+LmTpxXB3jkJNdPFb59EWYPduOrTZ0AOHQHnj0FKCrgNHbYKe+AOIEXPm/0dhtITmIc5/zWbPL23lvf3kMDtUeiH5zypQRtC3jWc2eTMPtN36Q4z67NzbvJkAhMd2DU3rb/+EZ0+bo7nVdpAZOSbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3OpRkkl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3OpRkkl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F14C19421;
	Tue, 27 Jan 2026 02:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769481882;
	bh=S3Iqv2UJ//ANnGVhqJ9ttWirfCzi27qFI76ZSe0b+FQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h3OpRkkl4n9357WKdBrgLX7LAe+6aaa1OucIzp4sF4ML4DVrO7USZJIreSRrw0xij
	 VpjEEqoi4J8mPAaT4Ss1ksoaq70V1KCI2946aQztwcqT6So9Zng4ruOLy7SFsr7OKD
	 r5Y3nd3juyFxNBUBSk+ddPDwQDgElPSC8hC1XPCTJ5m/gX6OWjNlW+jpN0vGdB6eFh
	 b6NSQ4eKMknjTb7LOIb6ipTDracDgXWPy1oaoU/776uzL22osQaLYEvPwXyWkOjpUJ
	 xlJeKuVQuVWGBqWF7pF3YSlANL/u/lB0T5qsMFw6lW9f1tfrGdZRit3e2vh3lLQRQT
	 pPZJWw0eSgM0A==
Date: Mon, 26 Jan 2026 18:44:40 -0800
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
Message-ID: <20260126184440.755a55b2@kernel.org>
In-Reply-To: <aXgjVb5PVqdPM10J@devvm11784.nha0.facebook.com>
References: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-4-686d0af71978@meta.com>
	<20260120163650.5a962648@kernel.org>
	<aXBnqYQdomzH9bT/@devvm11784.nha0.facebook.com>
	<20260121173512.748e2155@kernel.org>
	<aXGNhEKOhkTHbJvw@devvm11784.nha0.facebook.com>
	<20260121185021.446b00e8@kernel.org>
	<CAKB00G2xNvfiV6J3RzKDs=GHMGZ7L16+VKUYLGjpZdOrLnSYKA@mail.gmail.com>
	<20260121194615.33dc0812@kernel.org>
	<aXGib0OcNdHTLyZN@mini-arch>
	<20260126172646.2e5af2d4@kernel.org>
	<aXgjVb5PVqdPM10J@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Jan 2026 18:30:45 -0800 Bobby Eshleman wrote:
> > > I'm not a fan of the existing cmsg scheme, but we already have userspace
> > > using it, so getting more performance out of it seems like an easy win?  
> > 
> > I don't like:
> >  - the fact that we have to add the binding to a socket (extra field)
> >    - single socket can only serve single binding, there's no technical
> >      reason for this really, AFAICT, just the fact that we have a single
> >      pointer in the sock struct  
> 
> The core reason is that sockets lose the ability to map a given token to
> a given binding by no longer storing the niov ptr.
> 
> One proposal I had was to encode some number of bits in the token that
> can be used to lookup the binding in an array, I could reboot that
> approach.
> 
> With 32 bits, we can represent:
> 
> dmabuf max size = 512 GB, max dmabuf count = 8
> dmabuf max size = 256 GB, max dmabuf count = 16
> dmabuf max size = 128 GB, max dmabuf count = 32
> 
> etc...
> 
> Then, if the dmabuf count encoding space is exhausted, the socket would
> have to wait until the user returns all of the tokens from one of the
> dmabufs and frees the ID (or err out is another option).
> 
> This wouldn't change adding a field to the socket, we'd have to add one
> or two more for allocating the dmabuf ID and fetching the dmabuf with
> it. But it does fix the single binding thing.

I think the bigger problem (than space exhaustion) is that we'd also
have some understanding of permissions. If an application guesses 
the binding ID of another app it can mess up its buffers. ENOBUENO..
