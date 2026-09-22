Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFC2478859;
	Tue, 22 Sep 2026 09:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070185; cv=none; b=rcIFIljZaW+UcI/MTHRxSaxqhtWdrAqIHugFedLj90bM3NZPxQdRzxgC5zSH1EzpxbfUuYNO0aVhl61nrgJsn7R/eHuIBEpYF9fWMP0Ruq2ry8Ua07jgGUa51IJJWwKLZLuWEUYxmRE+U5B9ANmAU06X/GhEvHlWsEth9jvv2z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070185; c=relaxed/simple;
	bh=+ZdcKu3/+uyhfFbgt58db6XcHXJpIEbKDkl9pefBftg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHp28LhJxcDhTAYSFjaml7cYNl6olW54Suyp6RGw/+key10/M00sLrjvXbXccne7PDzbb0YkzmTGsHVnA5MCsRzgTV/p4EcL/I1ufXqSMYWnokxsCPQtZ3+0Amp5D0ZTf7MoBZ/NfIRuhUfJf626xJS0jWhcO4qaRCqDfRjao0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEDT5Pjb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEDT5Pjb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9988D1F00893;
	Tue, 22 Sep 2026 09:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790070184;
	bh=V+eCBMsdRHZZ8+99AV4x2YGu7/eXm49oGH7gIIrlNWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HEDT5PjbUbEQaAwBztSRssxASmJHaBqVwPwKnbEQzsJZHM+j+y5CasBQn12wmlSJn
	 CuHqNQhabvHNIE5dxrC6QQ3nX2kIuww0JvVP2OXFnTkjcYV2qnP/mRlpxd612CoRVl
	 MH+PLj+Bg+NihW+ZUZmiXEO9xnC/xz51ZS0tCCAxu/FIyVQJvDIn94lfBrZZ9/h3d4
	 LPbb4NTCgzcZzrmK3Y0xPjiBDCuUMpAv7GbvkYoaxBVrDHqpolf8pst6EaxjvSDPB6
	 m7OzrlzeotaCljEpaYVl448V2ES93RVHyOaaA5G/RAHfF1BBOI+NYgUORG28y/Ik/h
	 13rAqbmckKezQ==
Date: Tue, 22 Sep 2026 12:42:55 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2] docs/mm: describe set_memory() and set_direct_map()
 APIs
Message-ID: <arJNn2QD_pY6e14R@kernel.org>
References: <20260919-set-memory-docs-v2-1-a2a4b3657690@kernel.org>
 <433d32a4-f59a-4d6c-915d-2c1b4c22b840@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <433d32a4-f59a-4d6c-915d-2c1b4c22b840@arm.com>

On Mon, Sep 21, 2026 at 03:03:32PM +0200, Kevin Brodsky wrote:
> On 19/09/2026 12:43, Mike Rapoport (Microsoft) wrote:
> > [...]
> >
> > +Modifying the kernel page tables
> > +================================
> > +
> > +Except for the vmalloc area, the kernel page tables are mostly static. Still,
> > +there are cases when the permissions of existing kernel mappings have to be
> > +updated, for instance when a module is loaded and its text becomes read-only
> > +and executable, or when a page is temporarily removed from the direct map to
> > +reduce its exposure.
> > +
> > +There are two families of functions for this, both declared in
> > +`include/linux/set_memory.h`:
> > +
> > +* `set_memory_*()` change permissions of an arbitrary kernel mapping. They
> > +  take a kernel virtual address and the number of pages.
> > +
> > +* `set_direct_map_*()` change permissions of the direct mapping of the page
> > +  frame represented by a `struct page`. They take a `struct page` pointer and
> 
> The new phrasing is a mouthful but at least should be accurate :) It
> should probably say "range of page frames" or something like that though.

It gets even more mouthful, but you are right, "range" should be there.

Andrew, can you please fold this in:

diff --git a/Documentation/mm/kernel-page-tables.rst b/Documentation/mm/kernel-page-tables.rst
index b3148df07fc8b..c16de34b4f79d 100644
--- a/Documentation/mm/kernel-page-tables.rst
+++ b/Documentation/mm/kernel-page-tables.rst
@@ -103,9 +103,9 @@ There are two families of functions for this, both declared in
 * `set_memory_*()` change permissions of an arbitrary kernel mapping. They
   take a kernel virtual address and the number of pages.
 
-* `set_direct_map_*()` change permissions of the direct mapping of the page
-  frame represented by a `struct page`. They take a `struct page` pointer and
-  the number of pages.
+* `set_direct_map_*()` change permissions of the direct mapping for the range
+  of page frames starting at the page represented by a `struct page`. They take
+  a `struct page` pointer and the number of pages.
 
 Architectures that implement `set_memory()` select `CONFIG_ARCH_HAS_SET_MEMORY`
 
> Looks good otherwise!
> 
> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
> 

-- 
Sincerely yours,
Mike.
