Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9766F423A93
	for <linux-arch@vger.kernel.org>; Wed, 21 Jan 2026 05:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768974259; cv=none; b=lD3frS6U33lYEFUFxsSOmH2LG/QDrlYf2ZuG54wLLC5LsG5daHqBgn/wRP1NDjZb/XK3gTP0VC0c52Q2OXoxvesppNDBZ8I951IGbkLahMN0JEbih95F2dT5L2s5c/9DP7B6YJWfDH3idcKY5OySo3hlV8OMeDDoRaqwbY6EQG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768974259; c=relaxed/simple;
	bh=cCuhNoXS4wqZqsj/4ZE7U7PQyth2hfbCAfjifFmdGbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMAE9zFCyCkY68R9sIoVCZhq2nUmWQfOlhbJnYk9W7N6hQvdGG0tB0y7VJxXnEULBUFUPVYR8q2lm80/Ndw5jevnUMFjcav6NAoDBCrH5weNIGVyyHgsTRwQYyDPy7fdsrXlO6SFAC9kkgpCKBFuBaHVNXWVo2oGJ/nf17NztiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYKYkTXV; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYKYkTXV"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-79405f99b8eso6590517b3.0
        for <linux-arch@vger.kernel.org>; Tue, 20 Jan 2026 21:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768974251; x=1769579051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MoupjKqNDGOAMGhI8qwEY3FdnLYKFkn3HlTzVq0GQs4=;
        b=PYKYkTXVVq1VPftFvETtr5mYeEShg+MMb1rf49mjquldDupu+J0rYNp5AG4YUt/wnC
         iWTvlbLzNVvicwf/bUvzkFOEpdz8CCymPflmTgxZ6kgQfwNfgIPe9X/hPGzHc3CvPaw4
         cAe2yJ2QKNSuWpyXAs+4SjHIZHpDtDzenYvCoNIODYtw+vS1vYOdqIGfwBhYL3VOT2vq
         qUTVyUL1jzEtC0SGwAXu0tMOV9z1h2q/rVHDBYO4YHeJWrEmVUsMoE/C4BHTmWndQTDz
         pwCtBEsAUmG6rORLtaG+tYFuhJ2GsjUOC81nt7n3NWXP12zx63Pw3pGLF8Ccsf3VW/fV
         YWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768974251; x=1769579051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MoupjKqNDGOAMGhI8qwEY3FdnLYKFkn3HlTzVq0GQs4=;
        b=PkBL+3GRH/tnZvUfgkQGgsBBzH27FfqhcBYAKY5KYMcJY2rXYW50GI1Kmabh7fSI6U
         BUB8yDncCOFUiDzwNQTqYx0mTyW+JWDAKsAuZ8ryNBOUZRhAO2ozvLVovrquWp+Z1eXq
         mSpxXx7unwFX3CQHvm4VFSb9xGGdAZY+xQEyg8tQf/+aH5K9d6bxUrgdfmGTUNTSWobZ
         yRBzLmcxiqsRpHPYLQg+tAM98grStv+5WwZjc0V7RTT0fRi2+RHl+YSJyt8qnfXA8aVY
         4DLv9J8OAwycVSIJLZEFL02use1D/LiCs5KuMqoALTdX8xZz888FE0/z8F0tgosglCUK
         ABWg==
X-Forwarded-Encrypted: i=1; AJvYcCXm5ROV+s5FiIzJGmqzM4nA8kwgyP+60uyHINya0B+a/gh1M3Aq1eu+pczXCJ4iofI5fOiphCFYVBQT@vger.kernel.org
X-Gm-Message-State: AOJu0YyeAxQBErdvyakivZivWaSXppHQwK2G80PlCDApPx8v/hMXp2W8
	HEoZx00WBVxSNNwQKBUVmxorEyCTyAWDFm9+SqQabrrb26jip5U1Ab7m
X-Gm-Gg: AZuq6aLVZMTfNrpZy7SXBjKyvPDofXEtTQRYY3d62kaIUk00YK8WkqakxzXwXS8RZt5
	IkXZyDLL1RTLXDblq/53aa13ye6Y9S7ckR9UcWEgm3UAFZcSBq8qXsL9yRZ1PtfwSeFDD5tYTcZ
	acZHdBUGo8/Gl4RpA65xhLddUQfznNk1ZpeZ6CMOgCCUHCbmGVaXwQrv2xsc9rS0lAaY8RB5Y3W
	jHPYL6bYtfV2529zJ9y5dnSA6azNTDLQqBBSsEvZwPqMIuIGStqWlSP9ZR46ikaejJgrhJKyYJD
	Q1D1UiEwexLxUv6O10wdN3YC9DDlGz45HaPmM088aLOhcDx85LKF3eLqczaMshCyIf/0URzlMbn
	Ly9Fjo30UOmnza6mZBxN4Qau083avljbwDK+gKUONYVSDPdw4utLjQNElz6nkiAt+Huzzohzpdw
	ydZUZ++Rq5iixd2rK0U9ZPoKm3nI2H3NRzlRY=
X-Received: by 2002:a05:690e:1907:b0:645:5297:3e5d with SMTP id 956f58d0204a3-6490a6a0761mr15697554d50.46.1768974251183;
        Tue, 20 Jan 2026 21:44:11 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:5d::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6493dcbcce6sm1687077d50.24.2026.01.20.21.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 21:44:10 -0800 (PST)
Date: Tue, 20 Jan 2026 21:44:09 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
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
Message-ID: <aXBnqYQdomzH9bT/@devvm11784.nha0.facebook.com>
References: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
 <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-4-686d0af71978@meta.com>
 <20260120163650.5a962648@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120163650.5a962648@kernel.org>

On Tue, Jan 20, 2026 at 04:36:50PM -0800, Jakub Kicinski wrote:
> On Thu, 15 Jan 2026 21:02:15 -0800 Bobby Eshleman wrote:
> > +- Once a system-wide autorelease mode is selected (via the first binding),
> > +  all subsequent bindings must use the same mode. Attempts to create bindings
> > +  with a different mode will be rejected with -EBUSY.
> 
> Why?
> 

Originally I was using EINVAL, but when writing the tests I noticed this
might be a confusing case for users to interpret EINVAL (i.e., some
binding possibly made by someone else is in a different mode). I thought
EBUSY could capture the semantic "the system is locked up in a different
mode, try again when it isn't".

I'm not married to it though. Happy to go back to EINVAL or another
errno.

> > +- Applications using manual release mode (autorelease=0) must ensure all tokens
> > +  are returned via SO_DEVMEM_DONTNEED before socket close to avoid resource
> > +  leaks during the lifetime of the dmabuf binding. Tokens not released before
> > +  close() will only be freed when all RX queues are unbound AND all sockets
> > +  that called recvmsg() are closed.
> 
> Could you add a short example on how? by calling shutdown()?

Show an example of the three steps: returning the tokens, unbinding, and closing the
sockets (TCP/NL)?

Best,
Bobby
