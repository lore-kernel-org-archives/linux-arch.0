Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBCA4B7A38;
	Mon, 28 Sep 2026 11:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790596595; cv=none; b=QzzDq38UTOvspuCZ80TDEafikdKNLDmP/tgWZwafURKRa2LVzjZZCW9aglwOcbz3hm1PpD7MwLQgI1qO1cWrOYsKCLR86RiJRBzGnPzqUz8cOQ+OvXXMcZGAYP5b2UjIsvaq9OLfX11Eh8J9j/ceBneXdoKXlcLMsAteYzHSdWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790596595; c=relaxed/simple;
	bh=GvWYWpCCeFvIak39RmgGJI45zZfVnXWHBGVhiM1YW/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZh75QO+TeNNQEoQeZ2eRKlzRA9GcCovKUX2ENKQhM6ImY95EHmgaKQPziI9QHeQ1Lo8bqNJQCeZ0eVRR9KRqLTVH9woG+ShaufF9lsZT09qoW9eby7EW27pG8sqNdbJR001QB+tsVqVw/mRt7zUR/DVVNVaobA1G97inv9JS1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIYWDQih; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIYWDQih"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CCF1F000FF;
	Mon, 28 Sep 2026 11:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790596594;
	bh=KLJDpGd1SnpOinp5Or+qY1V3tuorX8/dmLV5l0L135k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lIYWDQihtpb00kxulAGFmbwu/emGV2/zoaibT5CHsSNqEgy2MX3XwKDXsr+k2tLhB
	 5Wv/YH56JrT+0a74/krsK50nF1uZFD2Lc8rpGMB8Ag5mb90tiU6zLv31mwgg2vfQxj
	 fbMbcgHE5MjVB13fV6Xg+LsA3JsnSL77Tw0mZriVt+CNyc+NuqUfULORY1NBxo7Z/W
	 CKEbgzoHyxYdDsLfytGEvkGGRKh3NlyZ6tje0/NEasZxjqaSDd1qwGOUtTg6Esh31b
	 KPahOKyKeDUNG4N7CWTEtToSuPCTa9i2vqX4TbptPvaL4ol7w09LiZniFWBq67Q/F0
	 wkUX5BRrWL/oQ==
Date: Mon, 28 Sep 2026 13:56:28 +0200
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
Message-ID: <20260928115628.GA964114@ax162>
References: <20260927161227.1179863-1-sashal@kernel.org>
 <arpLoeLVATRCXm5E@gremlin>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arpLoeLVATRCXm5E@gremlin>

On Mon, Sep 28, 2026 at 12:15:46PM +0100, Lorenzo Stoakes (ARM) wrote:
> Nathan - do you want me to fold this into the 1st patch of my series on respin
> or fine to treat separately?

Let's keep it separate since it is an existing issue and might want
to be backported in its own right.

I applied a subset of your series to kbuild-next-speedups to begin
exposing the "ready to go" (IMO at least) bits to -next (good thing
since it found this). You should be able to rebase on that for
subsequent versions, although maybe we still want to include those
changes for
others to continue to review but *shrug*. If there are follow up review
comments, just send delta patches and I will decide if I want to keep
them separate or squash them.

-- 
Cheers,
Nathan
