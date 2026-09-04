Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05DF20DD51;
	Fri,  4 Sep 2026 23:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788566364; cv=none; b=Z8N6FRV2fw8NNE+TKnPHW3N22DhQA6oprs0C13h93wZk2SVQxFuSgBW4qmpIArHmeDbsYtNS9UHbr+/gnnsMta8Wg2xtRx9vYrvbWavPtNSZVZ8h0oI+eou759QvsrzuozMzqhW3j3y9LC0YO6hdtpetYTzc2sE0y4OYmhy/q70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788566364; c=relaxed/simple;
	bh=WHzdFsrJQSCCVC6yMxL1HpWyzM2KSkS2Xmm5/Nf1p+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwkgeetmGSUX+i/g9Zz8+JC3UvfdfhBu2WFYh//PFWIt0Oo4/VmkM1nRTswRM120Dz3lzDLdlgcyBaC82yc7kyIpSIfyCgGe74GeMCnD2wpa4vXWz0kagXBwc5esq0RAQ0ohsi5t8Mj2M6XKkTAddQEODc6DISf5s7dpFuew9WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TO2wh+yi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TO2wh+yi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFEB1F00A3D;
	Fri,  4 Sep 2026 23:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788566363;
	bh=q6CYCkPfdGnTvONd8HyYxDOWKWY6Ru41NtJnnGeiMOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TO2wh+yiKuCY1xzOsag6p5uyZOXkGCKAu9zZFjNh15nMGEvsNeP3JUEKP/3W6gy4g
	 WbwV4TwI9PmwEOMxdK1pUyUclBKMjDYdCkbwfZPK+g7Mjk/SPZCKrCzozGJzrPSp0n
	 5bv8HIAON+IMF62uJcQs+DduMLKa6eaNblScfGB/m50OIaNQGqCJ6XrKD9sUPZ9/3Y
	 Mh2J/WDXU7wQzlDDTU8ydWzWZ/3yb1jHO2u+4ILT+G4ObOjIq0e/Iq83JxXY5o39KW
	 r9afyp+V+wiGXbaD0D3k1ylmzO1hUcXV5jqLlW0/m5JA1OXOzbSXrS7qOJQT17lHju
	 uv+gfGJJnXxmA==
From: SJ Park <sj@kernel.org>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/5] asm-generic: fix typo "explicity" in comment
Date: Fri,  4 Sep 2026 16:59:15 -0700
Message-ID: <20260904235916.67459-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904104854.25272-2-hemanth.selam@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri,  4 Sep 2026 16:18:46 +0530 Hemanth Selam <hemanth.selam@gmail.com> wrote:

> Correct "explicity" to "Explicitly", reported by scripts/checkpatch.pl

Too trivial, but 's/explicity/Explicity/'

> using the misspelling list in scripts/spelling.txt.

Again, too trivial, but I think mentioning spelling.txt is not necessary.  LLMs
might disagree.

> Only touches comments,
> no code changes.

Anyway good catch, and looks correct to me.  Thank you for fixing this.

> 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
