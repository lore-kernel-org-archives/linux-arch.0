Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE6C2F1FEF
	for <linux-arch@vger.kernel.org>; Tue, 27 Jan 2026 03:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769483214; cv=none; b=sBehC52BMdj2xLUa5Xkp33qRNap0wZ01zjIRhgI19T4pNZ0+EgiUJ7LZpssKK0mtKx6TUHonGmveppQIRt6uNsLChtPttGs2F+RTG7tiPJDdLkUcaIeDWuah5bXDDA9wZSxrqsqpRVHEfFamj4lhUGP+9u4VG0UXt74pdoUb+lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769483214; c=relaxed/simple;
	bh=wYEcUgNuD+lPf2tV7/btjfFjqrI60S+N7nj/8yNW7Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=scSwG4kbKoaOn0VqDsbBWLlp6kj7CCmf5i+3Qcku/Ie0k46XeKtEjt+woa4LHIrX3nLwqcLAF4PLJaBvc0+q9bmqc5BtVe6C61Ilf+xd5llCH5Al6WVYWHNysD2pHZ9TApvbagDwsIc6yUBesWygRCy9B7gKYnOnxtkZ0p3F58Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IU47TRk1; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IU47TRk1"
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-78fc3572431so51184837b3.0
        for <linux-arch@vger.kernel.org>; Mon, 26 Jan 2026 19:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769483211; x=1770088011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XtcTamun/anyrF+4xJBkkNRqAbEPEhjvU9VCmmVXBeM=;
        b=IU47TRk1K97pPGLqScYNmy4ieeG4lxxAnlN6s9T5ZO8WFpCbaJanHJru4scZJ/CbVl
         SmKDr9/06OWQzItbsOcZI+uuqTGVB015Uq996Jb2kNYlwbiOMYACKf7wpL7on99kakp8
         H415wOaurydKRZ4sP9l2enHfr+aDhBIQLMuW4lazcPnGyJSzVcerSo7WtZbSYgxzA2Oa
         QO4OHhOH+mGDtYKpF+GBlnJl7CLwjkiQn5iSJ+HXjjPExlu8ajNLuurTzkaoirbPsbtK
         DlHwskRWVw1SXw5/65rCtlEOiLMAt1gKOqNEs+NzjdM4s9c5TnNXAnoeWZKbrmDCYpXH
         NxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769483211; x=1770088011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XtcTamun/anyrF+4xJBkkNRqAbEPEhjvU9VCmmVXBeM=;
        b=m+PEgkUa37xP6ntKb9tTVWHqAzNrKz4cVDpv8oPyt8TbyGF1JopMejKUeFB87BCxD8
         pHhhQHvVjlejSpgy6LLFZRwiQsChpZVHbV7RJBt8Xi9MHQiLrdjFEOc9eilsO46LHq2d
         v7DONGQAiTBgl6aHCivO6d9tBDG/va+5QJO+dwV3fN4rZw4FAgw/jhIITQJXCvhtcnWI
         kr1eLDHZ7Bcomb5ifzl6oT0ReimWFKhL1lEipos6nA2FF/Gssdu3H0WCE7bwyHU3MLFb
         UIy3D5N/gB/p0u2nctPh3wQP6PIquuqEB6+NMnDHU7/bulwRTXA8/VkWPqJHwr11VxoX
         YQWg==
X-Forwarded-Encrypted: i=1; AJvYcCUkpIZnZm/i7ejHbga1zyiF64oR39CPz7NFuCBZcTRUE4IsVbtJZvBHVekDYgMmW4t49wENJObB7lZI@vger.kernel.org
X-Gm-Message-State: AOJu0YwuXHVpL0GjIKoXB7I4X061mcgNIzV4n32jtCICLIIBmirEXfRj
	t/0rbtZNFsR4yabREvhhKWUuAwxuIdMCzPMlyAf3/BmsRVUCftgg+1QB
X-Gm-Gg: AZuq6aI4TW259lwNjfaTlpu8biXAMfvjZWahXr3rOSJuCB1ACwKBAMvGPhGkS3md9hi
	iOQdwV6I3G6jGjxKvBB55u5kpSdseYB7TVac+aZ7njdM6ilD6oDBKPlL1dypOLUlQePWcmV6GNv
	ZOZvQeZZ7+YoA3CaVvHcA7yBmHONMKcTTscSRLc+MsVEQcyfFxNHDSFlNTv8Hy6mRLmQHpwFdsj
	0xaZsQERDYl8AkuxDztZeWKw+Mb6elCiJm8MoaS6P7ftdF/ckJlhxGj0OqBIIpRm3sIr2qVsDTy
	7ZrJ7snS3CR0jNa5D+jD6pdKrKj8DHye05+hOwZVn4HMJgPNyfsEp2xQ96maziv12eKuBYUppg1
	OMsk7681w+I9IO6n3JhQQZ9ZoZv1YDqCuvx+htLQCoAvF2Yf/BaIZS0901zXjl6B8DwsKRHpks/
	i0QcbEWRurOQEg+mFqEh9Q0OdlY3P5/LOlIg==
X-Received: by 2002:a05:690c:f02:b0:786:7a54:4635 with SMTP id 00721157ae682-7947ab3c172mr1656687b3.21.1769483211400;
        Mon, 26 Jan 2026 19:06:51 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:5::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79475c0212asm5994517b3.2.2026.01.26.19.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 19:06:51 -0800 (PST)
Date: Mon, 26 Jan 2026 19:06:49 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <stfomichev@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	asml.silence@gmail.com, matttbe@kernel.org, skhawaja@google.com,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v10 4/5] net: devmem: document
 NETDEV_A_DMABUF_AUTORELEASE netlink attribute
Message-ID: <aXgryaSx9CzFR7kv@devvm11784.nha0.facebook.com>
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
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126184440.755a55b2@kernel.org>

On Mon, Jan 26, 2026 at 06:44:40PM -0800, Jakub Kicinski wrote:
> On Mon, 26 Jan 2026 18:30:45 -0800 Bobby Eshleman wrote:
> > > > I'm not a fan of the existing cmsg scheme, but we already have userspace
> > > > using it, so getting more performance out of it seems like an easy win?  
> > > 
> > > I don't like:
> > >  - the fact that we have to add the binding to a socket (extra field)
> > >    - single socket can only serve single binding, there's no technical
> > >      reason for this really, AFAICT, just the fact that we have a single
> > >      pointer in the sock struct  
> > 
> > The core reason is that sockets lose the ability to map a given token to
> > a given binding by no longer storing the niov ptr.
> > 
> > One proposal I had was to encode some number of bits in the token that
> > can be used to lookup the binding in an array, I could reboot that
> > approach.
> > 
> > With 32 bits, we can represent:
> > 
> > dmabuf max size = 512 GB, max dmabuf count = 8
> > dmabuf max size = 256 GB, max dmabuf count = 16
> > dmabuf max size = 128 GB, max dmabuf count = 32
> > 
> > etc...
> > 
> > Then, if the dmabuf count encoding space is exhausted, the socket would
> > have to wait until the user returns all of the tokens from one of the
> > dmabufs and frees the ID (or err out is another option).
> > 
> > This wouldn't change adding a field to the socket, we'd have to add one
> > or two more for allocating the dmabuf ID and fetching the dmabuf with
> > it. But it does fix the single binding thing.
> 
> I think the bigger problem (than space exhaustion) is that we'd also
> have some understanding of permissions. If an application guesses 
> the binding ID of another app it can mess up its buffers. ENOBUENO..

I was thinking it would be per-socket, effectively:

sk->sk_devmem_info.bindings[binding_id_from_token(token)]

So sockets could only access those that they have already recv'd on.
