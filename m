Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49116357D0F;
	Wed, 30 Sep 2026 09:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790759099; cv=none; b=ZkVoPmwuOx/vi6nu/aaHkLOM7Vl6Zea+0r+gAAz1pHFHjao7yCA7imlTzXRhtb2Hkwhgg2cvce0GJT8fT3qEHIVS9mrW94Geqy769PBDPPBK2dw6spKXEiyuKnUTyYD99VwPuXufF/TW1w69jNaB3uaNeMf8wONf8oB1oSr/dlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790759099; c=relaxed/simple;
	bh=4b4PoC2MDlGQEqzNFllcavuDzC9ftUjcfDAI5iF/3QY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGNcQZz/D+2C1H20df2Lbtb93hquhHNuLEPH0YecHEsM7bX8uUyoj5kOLOuP3Vnn2ONF/Gv1OI6t1Jr0CB7PyAR/VjZSRzL1HxFvR71cWV7jwpSbX+XZ4Vl/baMVDl877CKvq+2SJkRo1VvFCB/pt1L5H9FYSYmohH+FuVJ5MWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMjCikqi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMjCikqi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB271F000FF;
	Wed, 30 Sep 2026 09:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790759097;
	bh=4b4PoC2MDlGQEqzNFllcavuDzC9ftUjcfDAI5iF/3QY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MMjCikqi1RcCdlBKwU0UEEfQq/X8b/+UxYRVG5M/yhbmi/hMa9RbLwzlYeAiZfPib
	 l7/8mw8FqihaBr+qxqJZniE3Ml6vYo9+jatuWC3Ke5ynehbvNxih7pvHBaVWJEWR98
	 3WfGPZYiefIl1GiTZhYEexmHeChuy8o3eGqiLFDhBGubS64/1PiD6Io/j7cJmYganT
	 y0kFMklv4KC17SyV42WBZrN0bZLGdJgZIwR6Me/TU9RjYJFpAB/g6agnSl6iAui+/f
	 kecY/l5O+22c97eHRAbSFzidfTxBW8b5SyQgQHQnljHKn3fCPYgTXOJC7aNWu0dazU
	 KqEIr9OGdS6VA==
Date: Wed, 30 Sep 2026 10:04:51 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Nicolas Schier <nsc@kernel.org>, Alexey Gladkov <legion@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Subject: Re: [PATCH] kbuild: keep .modinfo when vmlinux is linked with
 --gc-sections
Message-ID: <arzOxTQhvWwcqdDU@gremlin>
References: <20260927161227.1179863-1-sashal@kernel.org>
 <arpLoeLVATRCXm5E@gremlin>
 <20260928115628.GA964114@ax162>
 <arpXd4ZEYnP6qR4j@gremlin>
 <20260929201402.GA3237201@ax162>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929201402.GA3237201@ax162>

On Tue, Sep 29, 2026 at 10:14:02PM +0200, Nathan Chancellor wrote:
> On Mon, Sep 28, 2026 at 01:16:27PM +0100, Lorenzo Stoakes (ARM) wrote:
> > Ack, will rebase on that and send deltas from here on out on those.
> >
> > Easiest to keep things straight on my side would be to stop sending those
> > patches, I can list them in the cover letter with links to the originals
> > for any further review?
>
> Sure, that sounds totally reasonable to me.

Thanks!

>
> > As for what remains, is there anything else I need to do?
> >
> > I think timing this week is less than ideal with LPC next week so people
> > have less time to go through it but it does feel like things are
> > stabilising (despite the large changelog for v4 ;)
>
> Yeah, I have been spread quite thin between trying to keep the current
> ClangBuiltLinux continuous integration setup green, developing a new one
> due to changing constraints elsewhere, updating my own personal testing
> framework to be quicker for more efficient local testing (especially for
> stuff like this), and my Kbuild maintainer duties, in addition to some
> personal time off for my wife's birthday before Plumbers.

Yeah indeed, totally understood. And I hope you enjoy your time off :)

This cycle has been crazy (2x baseline for 2025 and it seems that way
across many subsystems), and the LPC timing is unfortunate, so I can fully
understand why people have had less time for this series.

(I also have a personal interest in clang working for the kernel also as
all my builds are clang-by-default now and have been for a while!)

>
> All that to say, I am not sure how much else I will want to take for 7.4
> at this point, as I would like to have the kbuild tree basically
> finalized by 7.3-rc7, which is the weekend right after Plumbers if my
> calendar is correct. I would like to study these patches to make sure I
> understand everything well and I don't think I will have the time to do
> that until after the 7.4 merge window opens.

Sure, fully understood!

Stripping the stuff you have queued up from the series (+ sending deltas if
needed) will make it easier to send the rest post-merge window anyway.

>
> > Thanks for all your help with this! Is much appreciated.
>
> Absolutely, thanks for engaging and trying to make Kbuild better :)

No worries :)

>
> --
> Cheers,
> Nathan

--
Cheers, Lorenzo
