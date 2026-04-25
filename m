Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA828632B;
	Sat, 25 Apr 2026 22:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777155161; cv=none; b=sef71+B4ZbTbUEPDmz6hgbaa81BKPFZJbE63uMlfGI0gxYmtW5fYElO491iB7yM8oaUr/K8G7Wlh73kXSceLncleN24/J/PmMlah+5D3TafLnvZ000dDc6SSkZ6bnrNXMXOi62iaVRPqZjdFUsPNWkNUKZpv7OxlY9jdy0CtAJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777155161; c=relaxed/simple;
	bh=DouxsJA2y6RwNgRRZj6nWQu9vyqCaCSBWNXyaOgcrzs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GXMevE1fava0zezyzNIzPHIYcrdm44XalySWf18edYxOUBGd9czyFQKOdJpUevcd9YSSNwAE1UXiNyfw7o1/ai+kmH35ioS5WnzDJp1SscRDCUGgt9fpXeKQzLkLIu7x2pwdof/nCVyWUIYW1NS5vtVtWL13wN3kqIuZQXXj1fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IJJFpjCl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IJJFpjCl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829BAC2BCB0;
	Sat, 25 Apr 2026 22:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777155160;
	bh=DouxsJA2y6RwNgRRZj6nWQu9vyqCaCSBWNXyaOgcrzs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IJJFpjCl4eQKxccsjicKylgLII0fEbujJJLoGlMcUbh++REVkge3jUBio7NJOB25y
	 Q1rvQRGFBzzsNyVLxUSefm9uQJjU9riV+8tZl4FoPYO3tH7sgTzJ77+8qTBZOn5X4l
	 zHT0HxmOLs5Oy6bFKG1FQoVRZ1ajV4ZRO6jDKJfY=
Date: Sat, 25 Apr 2026 15:12:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Min-Hsun Chang <chmh0624@gmail.com>, arnd@arndb.de, msalter@redhat.com,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-generic: replace ________addr with
 __UNIQUE_ID(addr)
Message-Id: <20260425151240.2a46e3a8640fde3902461d41@linux-foundation.org>
In-Reply-To: <20260425230134.5449498a@pumpkin>
References: <20260307092119.20733-1-chmh0624@gmail.com>
	<20260322144032.7353997c@pumpkin>
	<20260425135737.e79c4b546d22b5ebfd96c0b5@linux-foundation.org>
	<20260425230134.5449498a@pumpkin>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Apr 2026 23:01:34 +0100 David Laight <david.laight.linux@gmail.com> wrote:

> > > The real problem with this define is that both idx and phys are
> > > expanded twice.  
> > 
> > The real problem with this define is that it's a define.  Why oh why do
> > we keep doing this to ourselves?
> 
> Sometimes #defines generate better code because they are expanded earlier,
> and sometimes you want type-agnostic 'functions'.
> But neither is true here.
> 
> But I think I'd go for 'always_inline'.
> Sometimes the compilers make silly decisions.

Gee, if `static inline' misbehaves then we have big problems!

What's special about the fixmap code anyway?  It's not exactly
fastpath.  Perhaps this stuff can simply be uninlined.

Pet peeves:

We use too many macros.

We inline too much stuff.
