Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793273883;
	b=BxRsvpEhmt0zPNKO3SKfSM1h7vQM/E+qx2C5hJSFETgS8EtFR4hhctb1War/Yu/KqHRS
	 j8l39NchlF3bmYbuAJGX125CjkRr6EPE6pfXlN0LARM4iqE0d4Vwm98pd+adukPQgIHKL
	 cA22PgfnAqlLYJzxh+eVmovDV6QjI9+OG/xvh1yW4a23eK7yt8Jg6eQr3xT6QFC0nHv/y
	 VOywRXXQBVjFE0kt7gLgmVaS8HTqz35h6vCLChc6fMWxP8wlXmQDAHWTZUdaeaCuIoEHc
	 vJ/Y41Jui64M7ARHvnqZkGcPAJfoaNgOsYOcgSTHi3AphgtsZME6dESTS8hX2tizjqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793273883;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=hNCQwk1kVwwDQd6YdP9bn0F2tzwSBJGnMYrpsz+xroI=;
	b=bvKSEV9qs7m1l5rTHxxvvLL8tnQHpaXL4lt1C+azbKh+jm5AEnjizytIb0F5v2kfhooo
	 Fjcs9Jgq4XuZN5Z7luco1XgEPz6AV7aD979T3BBRj/T6fuZANrmKrLvTiHKfZsqMj2y7v
	 wvxieIPvnoqLMRbaAA5iI/laTzhJjv+Cs10NJkLKMzl047I24Vg0qmR6uPZvXIYRX7jsN
	 xa1zeQzTA4gKZ+soAh69X3PXxonviOUf3tPjVSynWs0lftIXd2pDKhj+dqVHRUtDNe4Y3
	 JPjcV3HzkviMh7fjJMEeuLAsjHtbhc+SEtvkJm8FkGl/grhYT7Rdpp4FuoQHzvkBm3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ail9VJBd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098BB606A31C
	for <linux-arch@vger.kernel.org>; Thu, 29 Oct 2026 11:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ail9VJBd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E101F01829;
	Thu, 29 Oct 2026 11:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793273882;
	bh=hNCQwk1kVwwDQd6YdP9bn0F2tzwSBJGnMYrpsz+xroI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ail9VJBdWbIaFY6FctxLtUgYRHgBXtvqpup5RxHjX8Kun5bgSmdWKaIGvUbl/H67D
	 EtchMfmh++7c58rAzzIcOZJlh7lU068ve+224x/vgneSfQv01jqM2Wo4b1vgV5PkQV
	 p1wGA6vLiXNJvxW4IlD096ZyNX3LzYYrCECa15A67f/Y3MyckPpiJSZQCM9WofsF1h
	 dNLVrxG6X+4vXWm3hjvcfoKWjvFUJFbtcZd9TwphSLT6L7gTvVao+jRJGI2iJ7TQ6k
	 Iqx3OJ8IZ43B5gnVKp4CY6HGbSbA7r7q2m7qWPekZSqeQFYt6ZRDde2QXdTZrHksaG
	 hRFiEsxBGnmWw==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.ams.internal (Postfix) with ESMTP id 61199198003A;
	Thu, 29 Oct 2026 07:37:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 29 Oct 2026 07:37:57 -0400
X-ME-Sender: <xms:CjDjajshZPeHtuir7v6mreGhAT4TgwhDFbd67W8lqX6eL1H1h2Hveg>
    <xme:CjDjapxTdjr1qMNJTi5jiBAbPeUL8WNi-rLAE_SEgVpbUTGclmUKEQ760n5h0fqeV
    hy4NTYi59RMULuyZS8aZ2YEk4SsTRY2j-0YZqzoSiY2c-6zrTJ_WiZa>
X-ME-Received: <xmr:CjDjah4JZaAhw-Fk9PScSG2a10e8jvqhDX8C23W0UBFCIs08u9qC86Fq1ss>
X-ME-Proxy-Cause: dmFkZTEJDAstCk+7zNgejakM4nNk+p9JZpQkZ6Wp/ORPY45DYJ9sLHFzb2OSqjFNCrREyO
    88yfN6Bm2PU/BZ+n9uLJeM8IQCx6gh4dmoBjtrR/gRMQnW1vav0T4U3R0wWLGH7ILSJz0U
    jdMa6OkiVebfbkVm5JCCWeL4Bgmn1pDydwYsJOPck3Qdns4HPrCASx59vSMT+/j+yF0qvX
    G2BRvU5cIsoY70+iA26gBsYSOUUpx4hNQp6J+87EVccCZ9Ae0yLIol7hi0rblFUAevpiPd
    uHrIkD9QzQyn3BgarrdLD501N6XdbeMUSrCRkW1q1L/F8zcqlxf0OSCgggqIu+bFPdnmVK
    NcNYxpSkwWOCwZcLOuaYHRTsxYx6D85JDsOHrpKL1vEhmUAKDtUhCnUAlLFqot1DM9q/eV
    ZTIcjPJqq14fF0zy0HGkF60Z4NFN+bSz/WNKQw6f5WcVzsXmI0zvI1J66w/XqmME697OXQ
    zERHpQf1f2P1KpVc8eIXbHuzD/SOd6B+KE+lUnfFtKDQN9VNcFcye2oj8ZEx6A7qEAQffs
    IUWqlyPo0fg/2eaM6xeJ2DOITKhJqU9srQCSgILo9WyD2HhperaR62DEVqvtfMq6CL02UO
    uYQhCBNO5b6ROgC+/K/MpQZdw9fNc5YCZUTnJbGBtnaHKfxJROTOsVpYwzvA
X-ME-Proxy: <xmx:CjDjanSS7Mx8TZPiU7heer_Q9SPTwHVFNB-SMCwAJ9aut0b1vRFrUw>
    <xmx:CjDjag-PYdm5Aer_OhpqtOoZx_SwLxAY07eLDmtLNEeq-uTx5hq8eg>
    <xmx:CjDjauzsU80bWiXzCsXzA_QbCjiGNW-gGh7_khHqQIP9Mv30v0qhhg>
    <xmx:CjDjaqzuB5gcDCgx7-WAvZUa70Eg8YXQlUPcy8ONATKcSf71OQuvVg>
    <xmx:CjDjah0f_57xCcmxZRGSyxLW9vwtr4aZedU-FEl-YETeEd7d6gRBRj2j>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 07:37:45 -0400 (EDT)
Date: Thu, 29 Oct 2026 11:37:44 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Hugh Dickins <hughd@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Usama Arif <usama.arif@linux.dev>, 
	Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
	Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, stable@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 05/46] mm/truncate: look again if a folio left the mapping
Message-ID: <auMvYdTd_e9O9kDj@thinkstation>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-5-6f74bec9a5bb@kernel.org>
 <auIniV8YSpA4_oxg@thinkstation>
 <2f2ef336-2186-4f20-b7f5-565e60471bda@kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f2ef336-2186-4f20-b7f5-565e60471bda@kernel.org>

On Wed, Oct 28, 2026 at 10:45:34PM +0100, David Hildenbrand (Arm) wrote:
> My brain hurts, does the above make sense?

Yes, I missed that the loop only goes back to start when a lookup
comes back empty below end. When the last batch reaches end, it exits
without another look. It doesn't need the split either: any punch hole
whose last page is in the page cache gets there.

That exit looks unintended to me. b9a8a4195c7d ("truncate,shmem: Handle
truncates that split large folios") turned the "if (start >= end) goto
out" early exit into the loop condition. Before it, the loop went back
to start until a lookup from start found nothing; Hugh kept that on
purpose for hole punch in 792ceaefe621 ("mm/fs: fix pessimization in
hole-punching pagecache").

Restoring it is enough, and makes the "restart to make sure all gone"
comment true again:

+       if (start >= end)
+               return;
+
        index = start;
-       while (index < end) {
+       for (;;) {

Then a replaced folio is found on the next round, and truncate needs no
special case for it.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
