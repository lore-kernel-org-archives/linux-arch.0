Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415013A1BA;
	Tue, 20 Aug 2024 01:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724118411; cv=none; b=GcVRFakRT9dkOA2MYsoLX6TMGEKUfXXHZUzF/XbOw2ISHE69GOTJM65wmkjTXkN3WKWtYrtM7q1gM4efNtIPb66Q/uDzzY/VBEsISkxgNWbpuOWIqoZAEn++Y544sbL3UUW1entapshDCKdRYudgl9RwGLiKzvrFYCtY7j30uNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724118411; c=relaxed/simple;
	bh=rA2KKwezxMOw6UPaznb0hf7DP0Mow7wiG3m7yVXGBTk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tOECHzSKw4qVcL9HQMeWEWpHNGceouxNb2krax47WLRnfVXwqbokouX8pHOaPQxSXpj/nGoX/EVcStA0w29/QGTCmVOiEC3IDwboSdXVq3y3P8hVGzujnwfHr9wHUaskLE/0JY5CRU0ke/X/LmKtVz7Le3VXQ4UznQfHW8ktV+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=jix3qp/N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="jix3qp/N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77A6C32782;
	Tue, 20 Aug 2024 01:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1724118410;
	bh=rA2KKwezxMOw6UPaznb0hf7DP0Mow7wiG3m7yVXGBTk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jix3qp/NdvOwD3MXE1iLaiyPurkDmKXMgyvVN5f6craLLKdZ4RrJQ9PJhZcGbVwjj
	 S71p0O32+TVGOhmo1o2Wh2YKmM1YEvC7gHbpUlnNNC+Xont7T1qFz9csoVPDFZhkv6
	 C5TYeg7PHhn+Ys+rvHXw6L0TOosywYTW7NVJQ1Vk=
Date: Mon, 19 Aug 2024 18:46:49 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>, kent.overstreet@linux.dev,
 corbet@lwn.net, arnd@arndb.de, mcgrof@kernel.org, rppt@kernel.org,
 paulmck@kernel.org, thuth@redhat.com, tglx@linutronix.de, bp@alien8.de,
 xiongwei.song@windriver.com, ardb@kernel.org, david@redhat.com,
 vbabka@suse.cz, mhocko@suse.com, hannes@cmpxchg.org,
 roman.gushchin@linux.dev, dave@stgolabs.net, liam.howlett@oracle.com,
 pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org,
 dennis@kernel.org, jhubbard@nvidia.com, yuzhao@google.com,
 vvvvvv@google.com, rostedt@goodmis.org, iamjoonsoo.kim@lge.com,
 rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 5/5] alloc_tag: config to store page allocation tag refs
 in page flags
Message-Id: <20240819184649.8fc7da59f89290f716ae0553@linux-foundation.org>
In-Reply-To: <ZsOtwhWC_JpgWe_J@casper.infradead.org>
References: <20240819151512.2363698-1-surenb@google.com>
	<20240819151512.2363698-6-surenb@google.com>
	<ZsOeVSlToyhsyDGD@casper.infradead.org>
	<CAJuCfpH4yFw6RNKVDK0hqXQQhAhMsyGNp5A50E+c2PZd+_vOgw@mail.gmail.com>
	<ZsOtwhWC_JpgWe_J@casper.infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 19 Aug 2024 21:40:34 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Mon, Aug 19, 2024 at 01:39:16PM -0700, Suren Baghdasaryan wrote:
> > On Mon, Aug 19, 2024 at 12:34 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > So if ALLOC_TAG_REF_WIDTH is big enough, it's going to force last_cpupid
> > > into struct page.
> > 
> > Thanks for taking a look!
> > Yes, but how is this field different from say KASAN_TAG_WIDTH which
> > can also force last_cpupid out of page flags?
> 
> Because KASAN isn't for production use?
> 
> > >  That will misalign struct page and disable HVO -- with no warning!
> > 
> > mminit_verify_pageflags_layout already has a mminit_dprintk() to
> > indicate this condition. Is that not enough?
> 
> Fair.

Is a BUILD_BUG_ON() feasible here?
