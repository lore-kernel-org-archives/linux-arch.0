Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833CD26A1CF;
	Tue, 27 Jan 2026 01:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769477486; cv=none; b=jl8WChLo1QV7Ca9r+qWSOZLpFOS65FAHkOS0p/eHydFaxngDQBuDRQ22b1vzcyw1lGfR/ORgfkk2scHMGrnzmGKsAlig/T+kWi+R31hNgsqtJVmUkpobfwIGegji+Mh/IMQXqmu1ZIEeyKU5wXb9cgWpLv68AYgX0SGmYvkayRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769477486; c=relaxed/simple;
	bh=6CGGydCka0qS3s2jXLp1lv9LhM9hYNyCJigg9Eh53z0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kENzdlvSnQbK/lrtxPf018i/Y3bbBQtZJKth65IbqFY6A4Ha/PTOuJupX4QgTbP4wD6YWARtSVLFu45D+balXz4Rak0WSxA+72UQi/B9y3DhhXGf8omlATz3ac6Q/ZIXMCpEmfQlXXU1OJ8JTmS0R1YyqYci8X0rPTke5y+bPn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKNR1oFu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKNR1oFu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDCEBC116C6;
	Tue, 27 Jan 2026 01:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769477486;
	bh=6CGGydCka0qS3s2jXLp1lv9LhM9hYNyCJigg9Eh53z0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bKNR1oFuFrwyurIijVwm3sk6j9TTAkmtj1kBXhGdgVNZkFa5byO66dCNrrm5ahU8f
	 I/eTNZdyGbS/L903Bava2+sxi7k5o7bsWt2695T2opSqORtjdUz4PMfyowmWhLBZhW
	 zdg17SCGg+eWuCokEmKo5p0QZ0YRxu+l73kZHbiuQhVE4Jvvny3Ca2gXjApK59Lb0C
	 5jEPOWcwnc/vTrDnAgCeRAkJ8JRJHqAgY7vsjBMXfmm/mxs2utoJ96H9jNrxyOWLtl
	 Roz0C5YvfJHH2FvmIvIxKQVy6kP/5m9dueWqQ4IMevNfHjICU4zFrwHtJCgpdGb4RA
	 ML4Xm9CIabH8Q==
Date: Mon, 26 Jan 2026 17:31:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, Neal Cardwell
 <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, Arnd Bergmann
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
Message-ID: <20260126173124.1f0bb98e@kernel.org>
In-Reply-To: <aXe2QhzL4DoVbesQ@devvm11784.nha0.facebook.com>
References: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
	<20260120170749.101e8bcc@kernel.org>
	<CAHS8izMZxM6rcF+7Lfw=KFv4dmbHGSUrQBPmxO+sYj=V3TRuwQ@mail.gmail.com>
	<aXe2QhzL4DoVbesQ@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Jan 2026 10:45:22 -0800 Bobby Eshleman wrote:
> I'm onboard with improving what we have since it helps all of us
> currently using this API, though I'm not opposed to discussing a
> redesign in another thread/RFC. I do see the attraction to locating the
> core logic in one place and possibly reducing some complexity around
> socket/binding relationships.
> 
> FWIW regarding nl, I do see it supports rtnl lock-free operations via
> '62256f98f244 rtnetlink: add RTNL_FLAG_DOIT_UNLOCKED' and routing was
> recently made lockless with that. I don't see / know of any fast path
> precedent. I'm aware there are some things I'm not sure about being
> relevant performance-wise, like hitting skb alloc an additional time
> every release batch. I'd want to do some minimal latency comparisons
> between that path and sockopt before diving head-first.

FTR I'm not really pushing Netlink specifically, it may work it 
may not. Perhaps some other ioctl-y thing exists. Just in general
setsockopt() on a specific socket feels increasingly awkward for 
buffer flow. Maybe y'all disagree.

I thought I'd clarify since I may be seen as "Mr Netlink Everywhere" :)
