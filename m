Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A15E318B8E;
	Thu, 22 Jan 2026 02:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769050223; cv=none; b=ocOSYrSxnjnUXLJvuFXncWoVSG7eyRNG6Y0AOBQvJdizCL+RBo8/15IM2uY2peQGu1EN35UND1S2ayt+iG83y4pkJK7GL85uZB1s7cvEosLY7HsPr2SEjQ6+FgJnSBQIWPRi19JwCh8Q+FUjCSiY6tWDe2N2W+MUFnhbEJNH4eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769050223; c=relaxed/simple;
	bh=2ZGZ7HwjSQzehUhUbNKlo5C6lCSrbNihlehB5Mznu04=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F5KOX5DlH78XZDW1Flu9BVmAIWGWhFts0FFqSgsfhxnK1QdezDWlr/r2kzeWHVp/x9YpFqjaTIZ1+XQ5KmZzSy7B6M5k+KGA/H5W0oVYj1ItLxkKWKJMPs+p+T9znutnohBkMAzCVZKWASkwfrZaEzNqEQnPkHp3YIqyRZNl37Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8Dl79Mf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8Dl79Mf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C8AC4CEF1;
	Thu, 22 Jan 2026 02:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769050223;
	bh=2ZGZ7HwjSQzehUhUbNKlo5C6lCSrbNihlehB5Mznu04=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V8Dl79MfY/EmKzAmcn+NJnFx4UFhm34bfAY0aHz1L3EnbDbtznByLv0o3Tz1Noc3P
	 QKIIDmb9aY0CKF2atc5WmJ3hG14Bv2t9cMWT3shjuitmLxKk0UsrCYhl61/op8+QlO
	 2gKVe6abrDiDSU5UrfGKjHkMRfdIKsGh8IjFFPCN3Fik4kKhoRIY82W1bYeCJSdMtE
	 NGIc2gjltLI87+JSpAjY1eqlhJKrMEfq4MSk9Za5fzsY6Rpuapl4r+vjkLIeq5hHvF
	 Sdm4f1EPhavF2YFwx04RyXPCc709kcBFXWVf2fZ1ZXmuoPlpA618vm1Nr63KWbSfCy
	 WiBlBVgoSiRBg==
Date: Wed, 21 Jan 2026 18:50:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, David Ahern
 <dsahern@kernel.org>, Mina Almasry <almasrymina@google.com>, Arnd Bergmann
 <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, asml.silence@gmail.com,
 matttbe@kernel.org, skhawaja@google.com, Bobby Eshleman
 <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v10 4/5] net: devmem: document
 NETDEV_A_DMABUF_AUTORELEASE netlink attribute
Message-ID: <20260121185021.446b00e8@kernel.org>
In-Reply-To: <aXGNhEKOhkTHbJvw@devvm11784.nha0.facebook.com>
References: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
	<20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-4-686d0af71978@meta.com>
	<20260120163650.5a962648@kernel.org>
	<aXBnqYQdomzH9bT/@devvm11784.nha0.facebook.com>
	<20260121173512.748e2155@kernel.org>
	<aXGNhEKOhkTHbJvw@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jan 2026 18:37:56 -0800 Bobby Eshleman wrote:
> > > Show an example of the three steps: returning the tokens, unbinding, and closing the
> > > sockets (TCP/NL)?  
> > 
> > TBH I read the doc before reading the code, which I guess may actually
> > be better since we don't expect users to read the code first either..
> > 
> > Now after reading the code I'm not sure the doc explains things
> > properly. AFAIU there's no association of token <> socket within the
> > same binding. User can close socket A and return the tokens via socket
> > B. As written the doc made me think that there will be a leak if socket
> > is closed without releasing tokens, or that there may be a race with
> > data queued but not read. Neither is true, really?  
> 
> That is correct, neither is true. If the two sockets share a binding the
> kernel doesn't care which socket received the token or which one
> returned it. No token <> socket association. There is no
> queued-but-not-read race either. If any tokens are not returned, as long
> as all of the binding references are eventually released and all sockets
> that used the binding are closed, then all references will be accounted
> for and everything cleaned up.

Naming is hard, but I wonder whether the whole feature wouldn't be
better referred to as something to do with global token accounting 
/ management? AUTORELEASE makes sense but seems like focusing on one
particular side effect.
