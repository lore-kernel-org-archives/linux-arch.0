Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC0D3C5558;
	Fri, 10 Apr 2026 18:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775845182; cv=none; b=mmJ723svaM76ZO7WjATPHhCyCEqt22UjUfx1ylTyQouQBa1/RwAxhNwJGxtXD/O4hEjO8CD0sfoGKdl2xBT7gQdyShxOfttFqhCwSH0YLe2Yc9r46KHb56/jmGT3NRCeYQNHpM7jF26+05KXnAS/1/PSPBRffIGVXQRxMDPC5+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775845182; c=relaxed/simple;
	bh=wswWxxzi+b+e63Bx29Kjg7d6BTWx3Z9Nz5swIjtgDRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A51k06YYQCvaRAva8xgmlQhM+vgNVrZM2tZRIIGHtjNJ9lPGaqfwoxQkRzh1PjqbXFFQcJvqBxvnrBFdgnjfXxS3NPB8piPNvFhOsLzSJqCwC2hbW4m9rKrTNQqyapZBQMZA2/X6fGOWz3N1XZ3eok9LCfA8pVBgLvqhVdhJ4v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=vHnKeGLO; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="vHnKeGLO"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 687F847E0;
	Fri, 10 Apr 2026 11:19:34 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 883BA3F632;
	Fri, 10 Apr 2026 11:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775845180; bh=wswWxxzi+b+e63Bx29Kjg7d6BTWx3Z9Nz5swIjtgDRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vHnKeGLObdFUaf8rjfTZjKYDlZJQDObsKUGnOfH7zl8i3+6jMZfRayrZsLLZNgTNi
	 G8xSZJNHssEubmeCoQWD8n/BAHe9gtEZ4r3r1qh6PIPRYd8urfc/JkeCZhZLmm0ioU
	 l1VMeSKcOsZFUhiopVi80bp9UKot3vz5nY0R6UIc=
Date: Fri, 10 Apr 2026 19:19:34 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Uladzislau Rezki <urezki@gmail.com>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Andrey Konovalov <andreyknvl@gmail.com>,
	Marco Elver <elver@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Peter Collingbourne <pcc@google.com>, Will Deacon <will@kernel.org>,
	Ryan.Roberts@arm.com, david.hildenbrand@arm.com
Subject: Re: [PATCH v2 3/3] mm: skip KASAN tagging for page-allocated page
 tables
Message-ID: <adk_NtueSeq8BnOW@arm.com>
References: <20260324132631.482520-1-usama.anjum@arm.com>
 <20260324132631.482520-4-usama.anjum@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324132631.482520-4-usama.anjum@arm.com>

On Tue, Mar 24, 2026 at 01:26:29PM +0000, Muhammad Usama Anjum wrote:
> Page tables are always accessed via the linear mapping with a match-all
> tag, so HW-tag KASAN never checks them. For page-allocated tables (PTEs
> and PGDs etc), avoid the tag setup and poisoning overhead by using
> __GFP_SKIP_KASAN. SLUB-backed page tables are unchanged for now. (They
> aren't widely used and require more SLUB related skip logic. Leave it
> later.)
> 
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
