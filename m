Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4781D165F16;
	Sun, 26 Apr 2026 11:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777201767; cv=none; b=GxWRva/DJVPMQzNfDisIldC7nN+AsSW9OFM0x7SlC6yr9awRTwehTsKLrQ8l3D0qOgUYasL0tCWGg8o+klcpkzr9noL5PAVfrDEf/h7g9EWkPDWuMUSre7/5ItMaU61BtGu/kJSZkuej9KkJi+ZFqIqnUgDycCzLMOIx77SAFxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777201767; c=relaxed/simple;
	bh=pbIEORir0Ac/K2INhsvTrLmqOd8GXcfOwlVr+xdk80c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mx1oEBDpnYg/0d1ftxX+yNfgP6xYzQEA/v90OzmWRJl01cKaVAXwMoX1SgE7liVw2XE6i5HrdyRSs/pPHd5BaiQoaDSl3JUQ+OqmhlgM/VBMhXRnAN8/zF00bjKB+nbe44rHzUOkVOEkNEGvqRALzwcNXplbO5e/Yd1V3SZPc7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LBhlIXrl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LBhlIXrl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4F2C2BCAF;
	Sun, 26 Apr 2026 11:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777201766;
	bh=pbIEORir0Ac/K2INhsvTrLmqOd8GXcfOwlVr+xdk80c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LBhlIXrlz7FDITo83KiESVr8Z6pZkiZQQn1pWmi8jVCmJwkpwXlYYhaje6yhNNl7N
	 HM1B4KVo/xcTuEyTdoPQYDa6hTU4m5djY4XkWF8j+0dgHedNIlm7FUEEEVO25q40Gt
	 N8GjHLYgmEK0ujoWeJLH4e5KZmGAu9U1ZkQTcmCw=
Date: Sun, 26 Apr 2026 04:09:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Min-Hsun Chang <chmh0624@gmail.com>, arnd@arndb.de, msalter@redhat.com,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-generic: replace ________addr with
 __UNIQUE_ID(addr)
Message-Id: <20260426040925.b25cb2a32680bfe884431abf@linux-foundation.org>
In-Reply-To: <20260426114938.4dff28c8@pumpkin>
References: <20260307092119.20733-1-chmh0624@gmail.com>
	<20260322144032.7353997c@pumpkin>
	<20260425135737.e79c4b546d22b5ebfd96c0b5@linux-foundation.org>
	<20260425230134.5449498a@pumpkin>
	<20260425151240.2a46e3a8640fde3902461d41@linux-foundation.org>
	<20260426114938.4dff28c8@pumpkin>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Apr 2026 11:49:38 +0100 David Laight <david.laight.linux@gmail.com> wrote:

> On Sat, 25 Apr 2026 15:12:40 -0700
> Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > On Sat, 25 Apr 2026 23:01:34 +0100 David Laight <david.laight.linux@gmail.com> wrote:
> > 
> > > > > The real problem with this define is that both idx and phys are
> > > > > expanded twice.    
> > > > 
> > > > The real problem with this define is that it's a define.  Why oh why do
> > > > we keep doing this to ourselves?  
> > > 
> > > Sometimes #defines generate better code because they are expanded earlier,
> > > and sometimes you want type-agnostic 'functions'.
> > > But neither is true here.
> > > 
> > > But I think I'd go for 'always_inline'.
> > > Sometimes the compilers make silly decisions.  
> > 
> > Gee, if `static inline' misbehaves then we have big problems!
> > 
> > What's special about the fixmap code anyway?  It's not exactly
> > fastpath.  Perhaps this stuff can simply be uninlined.
> 
> Some of the inlines are trivial - just adding an extra parameter.
> But this set would be simpler if the last function
> (__native_set_fixmap() for x86) returned (address & ~PAGE_MASK)

I don't understand this?

> > 
> > Pet peeves:
> > 
> > We use too many macros.
> 
> Indeed, I get fed up of looking things up to find they are trivial.
> Some of the 'helpers' do nothing for core readability.
> Even things like BIT() can have unexpected consequences.

Sure.

> Not to say I haven't got the pre-processor to do odd things in the past.
> But it is usually trying to avoid having to keep multiple definitions
> aligned with each other.
> 
> > We inline too much stuff.
> 
> True - don't look at what strlcpy() can generate.
> The inline code should just get the constants from the compiler and
> then call the appropriate function.

I can't actually find an in-kernel strlcpy()?

> As does the compiler.
> pixpaper_panel_hw_init() repeatedly calls two static functions that
> contain sleeps. They all get inlined bloating the code size and
> exploding the stack when clang separately allocates all the buffers
> in the called functions.

Poor thing.  I guess compiler developers are more focused on userspace
code and aren't especially concerned about kernel's particular
requirements.  And that's understandable - it's down to us to persuade
them to add options to permit us to tune the compiler behavior.

