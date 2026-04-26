Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EE42F2619
	for <linux-arch@vger.kernel.org>; Sun, 26 Apr 2026 21:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777239818; cv=none; b=M/8YtjEDVNBeAL7958spqaw9sUthFxua1wKHfQFMeFUc5KUobCs89RsqUnv0RFOlSH8T7no2NwmEsIYQXD2p3/yT+eNlBvKj4bdoPpu1GH3VNuCSc1qK8YethTKHkICZCRK9wTa5GZSqrwgD0/1be4e6/hMccZQTrW7qePJPWvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777239818; c=relaxed/simple;
	bh=LPWavIZ/gOJwBHcgiOClWB2JoXZPTl0uqt1pe5AXjT0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=umDscvb8xgEhPOh3ODjCHmgcwkQanC4PffCDpmomk4JGHCyPKDhcsH7il8QHEQEAJqjmYHJIXLX6zbTkB348NPRPlifeaiKB4ksZ7COo18+D6QdbNATa4+oZfHm4cbbN91aErIEYesk2qkUMvG9q8Xx4YYtalhTSSFsVVn4zOIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZiMGVpT; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZiMGVpT"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso79491665e9.3
        for <linux-arch@vger.kernel.org>; Sun, 26 Apr 2026 14:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777239815; x=1777844615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUdLgQOCVlyixTrdH7a4UDIcauv75NFTtaENVvxSOB0=;
        b=LZiMGVpTTndH/DySeXr4HBvh2OA8adnCl8GxEEeTMFge29737Hvs0QkmVbgcySUgMJ
         pni9QOW3dAgO/UZ7ZdlwXKpzFLaEdV8OVNIcSGysrnIBg009ivqykzihNZRqyLCSsJ+7
         1t84g1+UeElc/FShffngKzDXeJY43pYbMN0DaxyfoKUyH80LQtqbvosp6q8pmfcssKmx
         OTBcgZzxWBfn21q2Vte++KY6EegGmni97sjs0pQp+HyQu+L83IHp0iUPBhUNhFobAGjI
         WRQeCp7TJU0pUR+bufv9CPU4fOtwkaZTgg5S1ffsEAtsMxgD/1BOQbnGnuPHynpekxvB
         1NCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777239815; x=1777844615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FUdLgQOCVlyixTrdH7a4UDIcauv75NFTtaENVvxSOB0=;
        b=abbcNMJ0w3gE7ulj6HS118x01F0UxaV/PIOLbJLq0/cAQ3/MWbhAUvp45H+iEjWr4a
         /aKQePI93sJJb2lBO7TK2MmnwSaSQZJeA/jPJlEpbbHxQDcww+sVWWkqjFgoZA5DUAQx
         kAlxYgvQ0KVUNWc7QEPo7ziw8fq6re0M9iWLPKCiE045mnUcnb153I5OFQDCwh6ifPvx
         /VGJM6md53m1L3hQsAZJwPD5kLCPx6CtMkIhg5tw2N+ZFOZjJ51o15NCJukTxzp7lK33
         HaqcdmlgIF3Er0Zbn0N31Uj96BfbcNbpJUdOjnRu8c3vnfUwywrHLALP74LsbZ1klGYu
         eJVg==
X-Forwarded-Encrypted: i=1; AFNElJ+IYYjyG4s1TBwSKQ8RQQe29++cmH9Sm24f+jQpfYOvk8H/ytRma414MyOq4RG0xZlUbu/zvIKw7pUv@vger.kernel.org
X-Gm-Message-State: AOJu0YwWxHjr4ll0Myd3Mgck4pTKGZQ0KqK56OFINHUgLPLXjcewEfg9
	kAtR4SLBXVRMADiFTzqQPB0OZQYNb9W5HOw0UlHe6xw2nGHIj7q8+D8c
X-Gm-Gg: AeBDievvgHu40+IrNkdE/1ZxT3p1REnIZ6bZ8DfBao6NJhF+fPpb8v54z395cQtD28R
	HXVKlOd134AaNXDd58ML+pS98QNfiF9OKTA1jldcW6A7ZcWmMXHbnsPs0+6j07XhdOt/37m+vWO
	3ucPHYBxzZE8duAIogUA1UoCxDRJlwoigFlYpZ9mzaKlziqeNNUcU6exNw+LTXf2yYM+GfqkQ0g
	YxFoZw+m9FD5zVWsdLpGHg5AMALqBmauOL8HrtbTL1aMTWMFZ3XsCcN0T0QfWTyXKldA2Stmn9f
	yANunoB+jgwWkLJ0I9I5KB4mAKq2ZFCqcsIezDhpeePM98CSNqAFRNPgXXFzd+zddFgwzJA6G/t
	3UQy4Z2MMvLQNqeUsN5YNjkeaCd8Uncm77ZmshxAxIEY6iFC+sRNHaz2/6p2CkCI7yVHfBXkajM
	mLCGlJ4iJoFUc4UntmMNt1Ko1JPd4Voo6+oQdDiyh6KXwVi5NBROEm1AgCvXtIkKwmvGa8CtoOt
	J0=
X-Received: by 2002:a05:600c:c085:b0:488:c530:48a0 with SMTP id 5b1f17b1804b1-488fb784843mr454167245e9.24.1777239815396;
        Sun, 26 Apr 2026 14:43:35 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a52583fe7sm423356605e9.13.2026.04.26.14.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 14:43:35 -0700 (PDT)
Date: Sun, 26 Apr 2026 22:43:33 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Min-Hsun Chang <chmh0624@gmail.com>, arnd@arndb.de, msalter@redhat.com,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-generic: replace ________addr with
 __UNIQUE_ID(addr)
Message-ID: <20260426224333.5916c960@pumpkin>
In-Reply-To: <20260426110932.786047b4338843e0a91abaa9@linux-foundation.org>
References: <20260307092119.20733-1-chmh0624@gmail.com>
	<20260322144032.7353997c@pumpkin>
	<20260425135737.e79c4b546d22b5ebfd96c0b5@linux-foundation.org>
	<20260425230134.5449498a@pumpkin>
	<20260425151240.2a46e3a8640fde3902461d41@linux-foundation.org>
	<20260426114938.4dff28c8@pumpkin>
	<20260426040925.b25cb2a32680bfe884431abf@linux-foundation.org>
	<20260426183420.2216d187@pumpkin>
	<20260426110932.786047b4338843e0a91abaa9@linux-foundation.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Apr 2026 11:09:32 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Sun, 26 Apr 2026 18:34:20 +0100 David Laight <david.laight.linux@gmail.com> wrote:
> 
> > > > True - don't look at what strlcpy() can generate.
> > > > The inline code should just get the constants from the compiler and
> > > > then call the appropriate function.    
> > > 
> > > I can't actually find an in-kernel strlcpy()?  
> > 
> > That is because I meant strscpy() :-)
> > 
> > In particular https://elixir.bootlin.com/linux/v7.0/source/include/linux/fortify-string.h#L275
> > Particularly once it gets as far as calling strnlen().  
> 
> Oh geeze, why did we do that.  This is the kernel - string functions
> aren't fastpath!  Someone please move all that gunk into lib/string.c!

It might be worth selecting memcpy() for fixed length copies that fit.
Especially since that can get inlined to something smaller than the call.

> We'll still need some macro if we are to retain the (imo silly)
> omit-arg3-if-its-an-array trick.  

Try: strscpy(tgt, src, len, spare_argument)
I'm pretty sure it compiles fine.

	David
