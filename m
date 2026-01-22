Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942C0210F59;
	Thu, 22 Jan 2026 01:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769045877; cv=none; b=jsqg5xXn5AZ2DmC6N2g3/a//hhdFV+PwkzdZvBP0Ef0AHJ8h59yj8gQFvHTVBsWKkZKqbSgBhajgafC8UOsGhm9qyfrixBOHFsdJDAXNIZFKwH94ltpGtR1KqnZFmH0Gz4dKFL4o8raqZcTXfaS/XMKWjz+X4CYVnmb/t3WlWG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769045877; c=relaxed/simple;
	bh=tQpBBGK/tiBo551bC20Txkb/gPAPjaLfdNVO0nqHTFk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m/5LBQW2v1z+zONeWIz/aUzDEY9ZQ5bU3LCx0T7lqbm45Fw1y1CihAku92cAnZaWmUqWgLoqpQZwQEHqx1IBExbQAPDE/scSIh3C3kYHUjaJf1Ifjz6eBRSnam/okQEzV2F3d8ifuA3x6j0qgGRLFL2T/ICtK2a50FAhMCNDYy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=da7NmC2S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="da7NmC2S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A1DC4CEF1;
	Thu, 22 Jan 2026 01:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769045877;
	bh=tQpBBGK/tiBo551bC20Txkb/gPAPjaLfdNVO0nqHTFk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=da7NmC2SALcJ5sP3HO4Lf2BNs8qmqMtW1cgWNQM7j9kazH1/9r65viSUooCEpquVu
	 YRdrEbJv9XpulFitt6vg9FaFBoney46BLTFKISo3L26sYrL7K0gm4mpI1VomDZPznd
	 VjK7muTAk6zQ+6M9xMlIZsjfbmiROInf5jNQkKtzAg+pEEIUW/ikXrMmgNC6o8f6Ji
	 gbpuISirGrVZUrWx+k4UChBjnNmOnt9JOvwLeutsc6nJfz7HCgmW/tM/5PT/NGxUh4
	 GzJktYX8e5elqFIux8LQz0CINQWhLlkWWU3teWiQ24vXwk4enRZhdp6tfbGUGwyWl6
	 G5jJGCTBgikUQ==
Date: Wed, 21 Jan 2026 17:37:55 -0800
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
Subject: Re: [PATCH net-next v10 0/5] net: devmem: improve cpu cost of RX
 token management
Message-ID: <20260121173755.2ddd0b08@kernel.org>
In-Reply-To: <aXBkQErscGzJwh2i@devvm11784.nha0.facebook.com>
References: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
	<20260120170749.101e8bcc@kernel.org>
	<aXBkQErscGzJwh2i@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Jan 2026 21:29:36 -0800 Bobby Eshleman wrote:
> > IDK if the cmsg approach is still right for this flow TBH.
> > IIRC when Stan talked about this a while back we were considering doing
> > this via Netlink. Anything that proves that the user owns the binding
> > would work. IIUC the TCP socket in this design just proves that socket
> > has received a token from a given binding right?  
> 
> In both designs the owner of the binding starts of as the netlink opener,
> and then ownership spreads out to TCP sockets as packets are steered to
> them. Tokens are received by the user which gives them a share in the
> form of references on the pp and binding. This design follows the same
> approach... but I may be misinterpreting what you mean by ownership?

What I was getting at was the same point about socket A vs socket B as
I made on the doc patch. IOW the kernel only tracks how many tokens it
gave out for a net_iov, there's no socket state beyond the binding
pointer. Right?
