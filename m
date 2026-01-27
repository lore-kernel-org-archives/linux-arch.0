Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE33168BD
	for <linux-arch@vger.kernel.org>; Tue, 27 Jan 2026 02:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769481049; cv=none; b=bmdWRxlVkyu5UiT/1N3zJF9dEIOdJ4t5rnzaEG/IylCupRIg5EY8uopHQdxBZne73bW8JPSXd65BbNLtXuuMxlOSP/9e0zmuf6qZ7y8zkl/E4BSxsekxt+6OUmRxMjSpKb9MthW67rFVOl2tLvWMDR3cwFN2s9qf2tJwVUhi6x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769481049; c=relaxed/simple;
	bh=KHQTMcbGWv838jeHXPgV8dxHgD873Pl7gf8BNEh3ljU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIQRaSauelbl5pJxrIIhoxuthGshJvNEkRZQOHj7DvT2iOpIksXBeSDKBcPVh7ygRBKlToS0khRfVoVpTbqcB4uhQoheR2tYmJUtBaYi4CaR//ZOb+g5X0c36F+fpuJ+IPE016svsptX9TZdiVk/NUO7WrPhFwt1KNmS5BTqLGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdhCV6el; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdhCV6el"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-79273a294edso49832697b3.3
        for <linux-arch@vger.kernel.org>; Mon, 26 Jan 2026 18:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769481047; x=1770085847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7D31caj3N1Jxdsl7gn2LUCTtkhdOIGiiafmFtbNg3P8=;
        b=hdhCV6elPH6QMYqIGvqzcjebzTt+heU9y99STI21AaP6zDHSTnVZ+hopEFI+L3g/rc
         djUjeUZxPSf6vKPl+iYSXWARYc/t1yPx5qCQDoNi6ev8L3OyQrBM6IP+Ua//WqWfIv1K
         UXoUidhJHbHm2vY4CMHdgx4HOcCUtdhbGCNN6aXdTm2CaMUzYi132Xodjtyld5HG6+J/
         DA+uLybXVsTqpAMkif9tTVH8yJbkPk0XpaWloHbvmMPohXFpk5gmeRAC8ThWZZXm12kp
         tVUBhBzySxggtJxIjc72tNQjbJUtjtnu1cXmmlQRL8z0ZgjOlxWPTvOanGxpIAqTNPAa
         13mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769481047; x=1770085847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7D31caj3N1Jxdsl7gn2LUCTtkhdOIGiiafmFtbNg3P8=;
        b=e+GdON4vw6p1Kt9Cw3dBIixTEjyeJWQIFIXj16O7ZK5JTEl7PKLrVxWi3bnlqL98EB
         nbqrcW97P/QCvtO/9A+Tydy64TqYkq2GMkt4K9SJUgDrZJGpZoB9aYJtPl3Qasr1OZym
         pcWtPC6k+WgevHnVrqeGA/E+Rzsy0YuaRLSST2gByBvcMMtf7bqkziOCX8w7OjkPb3AO
         oa9LuceC0YXAFISh8EpRoPIdlr5M6XJNrBJsafvACcuT0yK/Tj2gxd957kkERijJ8Wgh
         eBr9OyHq6ibC4l+Zn/GWkN7J9lMQ1zRmNorTAFrPoUaIyER0O47arJXdNwXU0jxEcLK+
         IxWQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2ORe/drVyWP/84dbYSLC8x67/GZ5g6UOFz4hxQoiHD4ahkgB7pes/j5E7UrYfSJdYfwE0TI2H2UUo@vger.kernel.org
X-Gm-Message-State: AOJu0YzQb9hsqqvKHvJ4HTPe9aJy3B/0aiSMtnR8E78DBYGsCbQn0uQd
	k5c6Luz7WlRwSqg/F5fvry/C2zFR5T/+ayqjHGqyrkPRd81zfOPQMMrx
X-Gm-Gg: AZuq6aIQuK1hpWKs23j2p1SUrT4CGhxs4Y/Cw01OyeIzeItxeRBOG7eCBe1noorI8vr
	wVxiIzPI2H9sapVgTSXc2+GdDW6y8Zp7ie4I6tFC/PIUmolvHoaEw0Xb87xwjhqf33MP9Shsr3z
	WaE7cjt/ChYDcS1xcp+j2Z2IUNzDIvOX1DOcu7VfqyQnMinopJwyX2GKBXz3QCBs+C8QB2QT3F8
	1O49376VgTCdCpJBu6TwosPCp4QXPDk5bB0EhuhWPPQ9i9t2OYG3CtGDIato6tzR7WgcU7Bj3CW
	gkHGibHe6G7KC34WsGTedKzT3cVSFXOGT39wUbziFBbl3IQtq1/wNo2JAOjxPwbrcrGgFPGHND+
	FNHTeRkQg9cuoORNLxEJ9f0nFAw3cdCHCPHQD9C5Kq0d5hqqMzN/eDca2IuzaAXDjIhNBWvsrHK
	YtOLSUnr4toDBLO8q3uQCIw5opU/AHuQjtBjg=
X-Received: by 2002:a05:690c:6813:b0:786:a0fb:fa8e with SMTP id 00721157ae682-7947ab157c5mr1045097b3.15.1769481047156;
        Mon, 26 Jan 2026 18:30:47 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:44::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7943b2bb70dsm55711407b3.45.2026.01.26.18.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 18:30:46 -0800 (PST)
Date: Mon, 26 Jan 2026 18:30:45 -0800
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
Message-ID: <aXgjVb5PVqdPM10J@devvm11784.nha0.facebook.com>
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
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126172646.2e5af2d4@kernel.org>

On Mon, Jan 26, 2026 at 05:26:46PM -0800, Jakub Kicinski wrote:
> On Wed, 21 Jan 2026 20:07:11 -0800 Stanislav Fomichev wrote:
> > On 01/21, Jakub Kicinski wrote:
> > > On Wed, 21 Jan 2026 19:25:27 -0800 Bobby Eshleman wrote:  
> > > > Good point. The only real use case for autorelease=on is for backwards
> > > > compatibility... so I thought maybe DEVMEM_A_DMABUF_COMPAT_TOKEN
> > > > or DEVMEM_A_DMABUF_COMPAT_DONTNEED would be clearer?  
> > > 
> > > Hm. Maybe let's return to naming once we have consensus on the uAPI.
> > > 
> > > Does everyone think that pushing this via TCP socket opts still makes
> > > sense, even tho in practice the TCP socket is just how we find the
> > > binding?  
> > 
> > I'm not a fan of the existing cmsg scheme, but we already have userspace
> > using it, so getting more performance out of it seems like an easy win?
> 
> I don't like:
>  - the fact that we have to add the binding to a socket (extra field)
>    - single socket can only serve single binding, there's no technical
>      reason for this really, AFAICT, just the fact that we have a single
>      pointer in the sock struct

The core reason is that sockets lose the ability to map a given token to
a given binding by no longer storing the niov ptr.

One proposal I had was to encode some number of bits in the token that
can be used to lookup the binding in an array, I could reboot that
approach.

With 32 bits, we can represent:

dmabuf max size = 512 GB, max dmabuf count = 8
dmabuf max size = 256 GB, max dmabuf count = 16
dmabuf max size = 128 GB, max dmabuf count = 32

etc...

Then, if the dmabuf count encoding space is exhausted, the socket would
have to wait until the user returns all of the tokens from one of the
dmabufs and frees the ID (or err out is another option).

This wouldn't change adding a field to the socket, we'd have to add one
or two more for allocating the dmabuf ID and fetching the dmabuf with
it. But it does fix the single binding thing.

>  - the 7 levels of indentation in tcp_recvmsg_dmabuf()

For sure, it is getting hairy.

> 
> I understand your argument, but as is this series feels closer to a PoC
> than an easy win (the easy part should imply minor changes and no
> detrimental effect on code quality IMHO).

Sure, let's try to find a way to minimize the changes.

Best,
Bobby
