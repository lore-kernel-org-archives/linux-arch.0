Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2E6471CE4;
	Tue, 29 Sep 2026 20:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790712849; cv=none; b=Ttpr7VlunAguaf0OE7nttR091ztlC0VBUqSmgI9mCfHdWtVafojuW30Y+RdJ/RkPIViQn0JP90txO0cFPB9yx7BP3CHjCoOohhrajpOdaINgNWTfIHjrct0rUqojbArjIAezdxjKgzP1/nOAV89kFHcaXlRcTyjPm23NwC7/3js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790712849; c=relaxed/simple;
	bh=pJgAkGVpb06G4bjjisNl5B/YTyd6nhhXpuwgFTFxoew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LA9KtpnJKnftlFJRT9nbvxsqGdfCBtmczEJBGSR1NMGrvw4FdPje5lvz8poJNPh1o2134Pu0BFKkvYcU3m/uR3JU/J/0xMCYfwvsg7hKS0cj/IE/jPp+mrk3vpB7NvpaE5onjADQkDPpthV4ItOQFRWINvCD1umJcDnFz98zKkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iT1/hmjr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iT1/hmjr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D811F000FF;
	Tue, 29 Sep 2026 20:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790712848;
	bh=2nVgir3haWfJ+c55LCOHSd9HsRw6ZEDkQLl5SSlu5rQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iT1/hmjrU7kNo4Jl1kQnOBzaYjQEEob/LiVTqh+ReAbxTRk+b/MqwVw9XO/UNmVVW
	 SJ7+kizT1dmVwL4Vj8rOgNZs1k+ExawjHUEIL4UTw32UDXrWjzld+a4B5y0+isWO4C
	 v35Wbe8imD+dDNPuQ6sm2lmPKq1vt3/rq36ncO6PET22NhN7J0zsnCbX1WF31Kn06p
	 BBrSeR3Ge24gz8ndMQ2NNTgfSC55IHpjqwkmDwi65xnM6+HYDxswcnt1P0FiabxATN
	 lvNKKJnyE8ECuPOEU30JBbSrJN0wBJeZ2ju4h0MktJ1WtxVpXlhafDKP4zKYKUuC7P
	 KImda8SAApEug==
Date: Tue, 29 Sep 2026 22:14:02 +0200
From: Nathan Chancellor <nathan@kernel.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Nicolas Schier <nsc@kernel.org>, Alexey Gladkov <legion@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] kbuild: keep .modinfo when vmlinux is linked with
 --gc-sections
Message-ID: <20260929201402.GA3237201@ax162>
References: <20260927161227.1179863-1-sashal@kernel.org>
 <arpLoeLVATRCXm5E@gremlin>
 <20260928115628.GA964114@ax162>
 <arpXd4ZEYnP6qR4j@gremlin>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arpXd4ZEYnP6qR4j@gremlin>

On Mon, Sep 28, 2026 at 01:16:27PM +0100, Lorenzo Stoakes (ARM) wrote:
> Ack, will rebase on that and send deltas from here on out on those.
> 
> Easiest to keep things straight on my side would be to stop sending those
> patches, I can list them in the cover letter with links to the originals
> for any further review?

Sure, that sounds totally reasonable to me.

> As for what remains, is there anything else I need to do?
> 
> I think timing this week is less than ideal with LPC next week so people
> have less time to go through it but it does feel like things are
> stabilising (despite the large changelog for v4 ;)

Yeah, I have been spread quite thin between trying to keep the current
ClangBuiltLinux continuous integration setup green, developing a new one
due to changing constraints elsewhere, updating my own personal testing
framework to be quicker for more efficient local testing (especially for
stuff like this), and my Kbuild maintainer duties, in addition to some
personal time off for my wife's birthday before Plumbers.

All that to say, I am not sure how much else I will want to take for 7.4
at this point, as I would like to have the kbuild tree basically
finalized by 7.3-rc7, which is the weekend right after Plumbers if my
calendar is correct. I would like to study these patches to make sure I
understand everything well and I don't think I will have the time to do
that until after the 7.4 merge window opens.

> Thanks for all your help with this! Is much appreciated.

Absolutely, thanks for engaging and trying to make Kbuild better :)

-- 
Cheers,
Nathan
