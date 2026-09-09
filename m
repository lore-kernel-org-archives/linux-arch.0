Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2541526AA4;
	Wed,  9 Sep 2026 10:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950669; cv=none; b=jWSLj9QlwTWhAft7nAAx/wFHnmUH3v8/3FGYOR0lEoNu3u0PxnfC9XQnuukHBTnKtgTwfGus2J4Lkmk59JfmjIXhFzqfcHKh/qfqUZfT5NskhOXcy93rMHrmlAiENLyZI39OKOFCdjKn5edd0yyAAklgxqA2LW/CviAZEXRNazs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950669; c=relaxed/simple;
	bh=7R0mQXs3xYdgDBWZb8Aqkt12IMoGAUWjI4NBiQhdrDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovKbv0R3jAtxUJNiPkmMN9P4zMwWg9NpTym6w7O/EgKWonDhCDNVp65dSHN8FniMFsgfykiSTkzWrjFtE5FY9Wa/PIJiSo2ztzZTAFuSvJwOme2JyBHV/S5v2WoR9x0ikW3Y9d3pVBCN7XSLYq9F/o7OBSH26sIpbVWnW6Aq0so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GECD5HUu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GECD5HUu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321E41F00A3A;
	Wed,  9 Sep 2026 10:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788950668;
	bh=ef4yzVRUuSluKii/qI9TSB0cz48W9UzC0JbMj/d/8ig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GECD5HUuvyNPXSw8KxwDdR1M8oKieYZqowA+LyZhHjKs3R0SCxAM5Axsm54iyjjKL
	 5splZb7VgD1a7o/JfmeW8EDWuuKTtfAPBQiLIm74uAt5u5pxHt1HDaOVcjpnqEllrQ
	 WOb7Nv60XAQ3V9Q5Jd+FH1zxH9+uKrBTh3FKl263U7nH1vGc8KKJkrHpAyLtl1FW2Q
	 hKX5hjtnox9BYevBBumPAfo3AEkmqqYnsN2NOiQD+rqELqmFcJbs4+KNoG+WJ6rPAg
	 Ty3e8aYmZc1mn2XypmXtyAdQwm7MQFMT+/WS3sQritV4rG4RwqPP2mYBmsTm/SLVTk
	 ao3vr5oyYMozw==
Date: Wed, 9 Sep 2026 13:44:20 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] docs/mm: describe set_memory() and set_direct_map() APIs
Message-ID: <aqE4hFXS0YHZKLEy@kernel.org>
References: <20260909-set-memory-docs-v1-1-6065d3f208e4@kernel.org>
 <e173c341-eeb0-4361-9729-9b996c3db42e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e173c341-eeb0-4361-9729-9b996c3db42e@kernel.org>

On Wed, Sep 09, 2026 at 12:30:01PM +0200, David Hildenbrand (Arm) wrote:
> On 9/9/26 11:45, Mike Rapoport (Microsoft) wrote:
> > The set_memory() and set_direct_map() APIs change permissions of existing
> > kernel mappings, but their semantics are only described by the code, and
> > that code differs from architecture to architecture.
> > 
> > Add Documentation/mm/kernel-page-tables.rst that briefly describes what the
> > kernel page tables consist of, defines the semantics both APIs have in
> > common, including the parts that are easy to get wrong, and lists the
> > differences between the architecture implementations.
> > 
> > Add kernel-doc comments for the generic set_memory() and set_direct_map()
> > stubs and link them into Documentation/core-api/mm-api.rst.
> > 
> > Assisted-by: copilot:claude-opus
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> > The semantics of set_memory() and set_direct_map() are currently described
> > only by the code, and the code differs from architecture to architecture.
> > 
> > Document what these APIs actually promise, what they merely hint at, and how
> > the architectures disagree.
> > 
> > The discussions that prompted this:
> > 
> > https://lore.kernel.org/all/a98df077-3e97-4eea-8bfe-470bad9ff9e0@kernel.org
> > https://lore.kernel.org/all/5026dbec-0b71-4408-a78a-484a4b8e77dd@intel.com
> > ---
> >  Documentation/core-api/mm-api.rst       |   9 +
> >  Documentation/mm/index.rst              |   1 +
> >  Documentation/mm/kernel-page-tables.rst | 402 ++++++++++++++++++++++++++++++++
> 
> Before I read any of this, how much did you review and edit whatever the LLM
> came up with?

I never send something I don't like :)
 
> -- 
> Cheers,
> 
> David

-- 
Sincerely yours,
Mike.
