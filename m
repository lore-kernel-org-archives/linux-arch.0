Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31052E7370;
	Mon, 28 Sep 2026 12:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790597795; cv=none; b=VuEDutNp2OhoMqemJGqPdno+wx8396K/U091Izco0LtQyfA4Wh0rdJi1DjmzChrOVHg/uxMgnxFM2zbjgHLvLnVajGflv3Viz6zZoOKtbzmAhcdloj/IVUDpZ8XfrcuGTSud4URBQbp2MD2TlxQsLJE7OhZpiFDIlnGRWRInM4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790597795; c=relaxed/simple;
	bh=KuHZqfekh5ZPAEucEpKCSKNpmdMHELyD0CXhACD4lAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qtix/dXJWzn+qdinYo6YZSK/DJWfpx61JVnrxUSuMR8FpLGixHwV5zrmaEFvPgqLaR54VLnbffHS7Z/whEGfjlQsZTTxY/SxZa8HKoQxym9WoO/ErD6O9i5CQZCWkfhqKRjQx/q0QgULD5PjhneqjBEghZzyvTVflEpSwbbunfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpiW+7rN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpiW+7rN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536221F000FF;
	Mon, 28 Sep 2026 12:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790597793;
	bh=KuHZqfekh5ZPAEucEpKCSKNpmdMHELyD0CXhACD4lAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HpiW+7rNQQuhtN0LsjGTaRjsKM87FLoi2vaHHamzjDYtGSW+EZIpa93MpItmkZgEF
	 RraauKwc3Rvefoza+wpqTTFUYyaIsOzT4DPMlMX91z2NwmtcB7xZWetsTcG4oaGnZD
	 ty9qT6d8gNWGxz13JV4xb5YPgIMLE6A/nGwv+A4VYh1m8XusBkNpEi/w9KOqf28Y+Q
	 GHiqMYIZ9XQCIr4Plj4VoC1aHbIJSsZThn8H4OINo+GHHfNmOifmMPwRsMEi15LR6s
	 49+KQhLg7vKbeFstUQMDJEKQ5ucbPX71OrH5wK7OFREE23D6c7qrjFVqK68ZeYAut0
	 WArzzbNt+5mfg==
Date: Mon, 28 Sep 2026 13:16:27 +0100
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
Message-ID: <arpXd4ZEYnP6qR4j@gremlin>
References: <20260927161227.1179863-1-sashal@kernel.org>
 <arpLoeLVATRCXm5E@gremlin>
 <20260928115628.GA964114@ax162>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928115628.GA964114@ax162>

On Mon, Sep 28, 2026 at 01:56:28PM +0200, Nathan Chancellor wrote:
> On Mon, Sep 28, 2026 at 12:15:46PM +0100, Lorenzo Stoakes (ARM) wrote:
> > Nathan - do you want me to fold this into the 1st patch of my series on respin
> > or fine to treat separately?
>
> Let's keep it separate since it is an existing issue and might want
> to be backported in its own right.
>
> I applied a subset of your series to kbuild-next-speedups to begin
> exposing the "ready to go" (IMO at least) bits to -next (good thing
> since it found this). You should be able to rebase on that for
> subsequent versions, although maybe we still want to include those
> changes for
> others to continue to review but *shrug*. If there are follow up review
> comments, just send delta patches and I will decide if I want to keep
> them separate or squash them.

Ack, will rebase on that and send deltas from here on out on those.

Easiest to keep things straight on my side would be to stop sending those
patches, I can list them in the cover letter with links to the originals
for any further review?

As for what remains, is there anything else I need to do?

I think timing this week is less than ideal with LPC next week so people
have less time to go through it but it does feel like things are
stabilising (despite the large changelog for v4 ;)

Thanks for all your help with this! Is much appreciated.

>
> --
> Cheers,
> Nathan

--
Cheers, Lorenzo
