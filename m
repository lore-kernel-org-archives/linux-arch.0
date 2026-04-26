Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F47326AC3;
	Sun, 26 Apr 2026 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777226974; cv=none; b=XElmFBKjS4xj9Q/R31YOnfRUbpzjmJQeibun0bbmO2PQV2pHiveS9e5pCE+mQW/8ITIeKlYLGasGSaQxoAAaFPRgWLAVOrLLFiFhjjzIWhQJkBzLFBTunEykFmDeakBbmYPjJpT6b3Ts3FoVtV91s6wBHsHtVL7HHOYGMWkq5sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777226974; c=relaxed/simple;
	bh=ZpzvuAjjvIqcno01hmVZJsBQLvD+qtDCobiUZNIrpSQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KtWpm2rv/aKI+PNjiD0qgf0LKnIv0h4D8lUvkrw5+Q1zRggDmrPUAFz2pPBx1z0/2fa5fy+RM9pBeonTTbz0u5FMX5JL866f4uIcNrCoiz01q1Gmug4KZJwb/kblLT1dgpfoABtrWO4IFd4LFQqRL5++cAnvWwf2PB3qHRJyzX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Tn4vwNXp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Tn4vwNXp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B166C2BCAF;
	Sun, 26 Apr 2026 18:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777226973;
	bh=ZpzvuAjjvIqcno01hmVZJsBQLvD+qtDCobiUZNIrpSQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tn4vwNXpXD0czdD18/NTmJwunL37zosOs1UH00Ocy/KcnK6WpNia9rEGNrj6CVJ6W
	 hsgZCqfvMkxKSCsmMvW3VZxR94qfHIq23TChYDruXUMgDp+bYVR/ns5NZRUd9PR51G
	 y+3BTn1ZyXU+EKfrzHOH3BGHeFOHPE3Y4Mp/pBME=
Date: Sun, 26 Apr 2026 11:09:32 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Min-Hsun Chang <chmh0624@gmail.com>, arnd@arndb.de, msalter@redhat.com,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-generic: replace ________addr with
 __UNIQUE_ID(addr)
Message-Id: <20260426110932.786047b4338843e0a91abaa9@linux-foundation.org>
In-Reply-To: <20260426183420.2216d187@pumpkin>
References: <20260307092119.20733-1-chmh0624@gmail.com>
	<20260322144032.7353997c@pumpkin>
	<20260425135737.e79c4b546d22b5ebfd96c0b5@linux-foundation.org>
	<20260425230134.5449498a@pumpkin>
	<20260425151240.2a46e3a8640fde3902461d41@linux-foundation.org>
	<20260426114938.4dff28c8@pumpkin>
	<20260426040925.b25cb2a32680bfe884431abf@linux-foundation.org>
	<20260426183420.2216d187@pumpkin>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Apr 2026 18:34:20 +0100 David Laight <david.laight.linux@gmail.com> wrote:

> > > True - don't look at what strlcpy() can generate.
> > > The inline code should just get the constants from the compiler and
> > > then call the appropriate function.  
> > 
> > I can't actually find an in-kernel strlcpy()?
> 
> That is because I meant strscpy() :-)
> 
> In particular https://elixir.bootlin.com/linux/v7.0/source/include/linux/fortify-string.h#L275
> Particularly once it gets as far as calling strnlen().

Oh geeze, why did we do that.  This is the kernel - string functions
aren't fastpath!  Someone please move all that gunk into lib/string.c!

We'll still need some macro if we are to retain the (imo silly)
omit-arg3-if-its-an-array trick.  

