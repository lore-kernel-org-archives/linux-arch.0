Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B84624DD09;
	Wed, 21 Jan 2026 01:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768957671; cv=none; b=isn+tbBW4Vau9KheXXzUoDdN1wAsN5E6uz74fJtnty7ZuNfv/yrYI1dgYoMxQBTPsVxtW9Y3SUiG42zW+DdVd4/paW7bqYOGXT39DORze+1EP3l8X8whjF37tfdWHZBYSZpVmj1adjmVvb0RWbgR8cNy3muCWPFLtey74XhAATs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768957671; c=relaxed/simple;
	bh=oOpcGukiPPewh4Q7E0yytjx4AC+fAjQGqYtWozM5MOs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T+7O164Z8HtjJRUqqZygvQXhBRpJjiICmeMXNpUxiojc8la1PH5iYlwAF4OohbHrjCY91PEFc6v/zMdlgLGlJfdqOfMtUTv3mYUllRRtL1NnE3It8g+L5NCBtaPpvDoj/gV9kuEnTypuE5SpTbhSD06wX47WViV0wjAM+j3ew6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvATIDtL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvATIDtL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620F6C19423;
	Wed, 21 Jan 2026 01:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768957671;
	bh=oOpcGukiPPewh4Q7E0yytjx4AC+fAjQGqYtWozM5MOs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GvATIDtL+LoiOGpWcaGgXeYAugG3mjd2IkpG38tw2Pawrvi8V2BQk9xpAzHIRhx47
	 L+x+WQOGofrRe1jKb0EqVyrCVbWF47Dh4S/d17wkz+8gkvBOUEM7N2i0yauTedTK78
	 GHxc+f0WhICLFZaM6AZcvXiQFPlh/sdwpr592pgpZbUdIEjAC4UpP9v3whLnyO3hbx
	 l6zPzy6hkKi0ahjhWtI6WVqjbJNLgCfiAfY4Qnaw9uklCuxkJo0EApoJVaXLUlB2DM
	 pWUKDXub7krn93x33HdxtVPVp5cVxoS5YUVbZ1wRag3smlajhahJ+yJUG5dtC4aThU
	 b1zA8eg2PL9RA==
Date: Tue, 20 Jan 2026 17:07:49 -0800
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
Message-ID: <20260120170749.101e8bcc@kernel.org>
In-Reply-To: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
References: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Jan 2026 21:02:11 -0800 Bobby Eshleman wrote:
> This series improves the CPU cost of RX token management by adding an
> attribute to NETDEV_CMD_BIND_RX that configures sockets using the
> binding to avoid the xarray allocator and instead use a per-binding niov
> array and a uref field in niov.
> 
> Improvement is ~13% cpu util per RX user thread.
> 
> Using kperf, the following results were observed:
> 
> Before:
> 	Average RX worker idle %: 13.13, flows 4, test runs 11
> After:
> 	Average RX worker idle %: 26.32, flows 4, test runs 11
> 
> Two other approaches were tested, but with no improvement. Namely, 1)
> using a hashmap for tokens and 2) keeping an xarray of atomic counters
> but using RCU so that the hotpath could be mostly lockless. Neither of
> these approaches proved better than the simple array in terms of CPU.
> 
> The attribute NETDEV_A_DMABUF_AUTORELEASE is added to toggle the
> optimization. It is an optional attribute and defaults to 0 (i.e.,
> optimization on).

IDK if the cmsg approach is still right for this flow TBH.
IIRC when Stan talked about this a while back we were considering doing
this via Netlink. Anything that proves that the user owns the binding
would work. IIUC the TCP socket in this design just proves that socket
has received a token from a given binding right?
