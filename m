Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC281A08AF;
	Thu, 30 Apr 2026 19:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777575762; cv=none; b=ZGw9772M+OwcdII3s6s4E+hW92wumFDDezkLZJJelB7eqxDRlVpBNbLbsL0TdxkeIZD4QsLYwM3IfMBYNX0yM+d0Anif5TzzjmwKwSlmOPZicyarWYR6/dsE67grAZ3emDPTEWdmdyY3Q+cxu4mwoE7DJvUilZlJy5fCrwJsnqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777575762; c=relaxed/simple;
	bh=cRC9KLktut1BkXa46+AfHyESKr2HdVz82WI9F/V2NoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chW4NwXMeaJ7SsiSA3HqnVANuUBp63kLJt/awCkrgXH3PHQI4rAlqvfhUXU9dJLmd5yidd5k+AKnX5UA4qWnIwwverciLQi8nu8JAAt+DmA/yGQCADccsCGhUsF0TRKnClrLwabz01LxawCcvnxA5E6dWlqNq0abELGyRQyvY1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDAMgERE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDAMgERE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7879C2BCB3;
	Thu, 30 Apr 2026 19:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777575761;
	bh=cRC9KLktut1BkXa46+AfHyESKr2HdVz82WI9F/V2NoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tDAMgEREKkqVs4jRy1kzycqsSMU4+2ac0/ee9kzHk+1+dZxHx2Ci153SmyDbsVaa8
	 BfEefBumvppLupo4HEZk/+mHUNa597DUgcd9BgrspTgN9aBfobWLUItkq+2StE25lc
	 I1ShObOCRBwzUL4GHF92EBNlKJbG4mwfZB7wc64RoaAqGMXS1Rwa6Tcvgmql0cVMBV
	 o3GLeeNP3ivGFAkPXzs7Ourg+UvcwRPLdl4Eus4b1tLN8MzrSLZuAx9yz9ZYLqrdR9
	 CyCp2TxbC0vu1fl3ptZqKtPq5cYkNpahpp7mHDGmfALYEHGA8/NcDwZpadQJKrbMIO
	 1XouleDbXPi+A==
Date: Thu, 30 Apr 2026 12:02:34 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, yury.norov@gmail.com,
	linux@rasmusvillemoes.dk, arnd@arndb.de, akpm@linux-foundation.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, david.laight.linux@gmail.com,
	cp0613@linux.alibaba.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v5 2/3] bitops: Define generic __bitrev8/16/32 for reuse
Message-ID: <20260430190234.GA438371@ax162>
References: <20260421130752.607500-1-ruanjinjie@huawei.com>
 <20260421130752.607500-3-ruanjinjie@huawei.com>
 <20260429202922.GA3575295@ax162>
 <afK0oL5FS8eLobpV@yury>
 <20260430035943.GA2164248@ax162>
 <afOGKj9SfozoS3x7@yury>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afOGKj9SfozoS3x7@yury>

On Thu, Apr 30, 2026 at 12:41:14PM -0400, Yury Norov wrote:
> Sure. Please let me know if this works for you. If it does, I'll make
> it a regular patch, combine with Jinjie's work and my follow-up and
> resend. Meanwhile, removed all bitreverse material from
> bitmap-for-next.

My builds saw no issues overnight with the CONFIG_CRC32 version, so your
plan seems good to me.

-- 
Cheers,
Nathan
