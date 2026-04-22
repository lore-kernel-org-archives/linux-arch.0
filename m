Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307ED3A5E62;
	Wed, 22 Apr 2026 18:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776880850; cv=none; b=Fe4g6J4efsmYRq/pda6CZX5UJlYRJjFocbNVodSOEJzCzZAJ+OL73jUdEPloV7olrl1B+11EE2Ey1me2e+evHti6EAzp9liuNhd0KF3iBYI7dxfjDAsGOSGVGQe9hAmJDQydcGq5tIh9qIJ30FRaVAE+m52WfMTWj7Re/FAyXds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776880850; c=relaxed/simple;
	bh=ZRWId2cyQPbIGqtv5LXo706QXNfX8RgsC2E99iractY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IC5Gwsi/htT8S8Y7RXwG/zlqMoWa92Zf9RjTYfStBZnIlPrlpKkxreyYDGSJ7RThgXjfEaNne8WT4MDct9LaAtIgdnhP4iyMPdVwgwQJgWZPTEEYaXbIe/YFcLtM+CHMnqlQtAvsiTQkX2Zo22TtH5sx4CM6F+Uowshtu8eAsFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=eZ6G8Y+a; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="eZ6G8Y+a"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C50A41E5E;
	Wed, 22 Apr 2026 11:00:41 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD2A33F641;
	Wed, 22 Apr 2026 11:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776880847; bh=ZRWId2cyQPbIGqtv5LXo706QXNfX8RgsC2E99iractY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eZ6G8Y+a+3ieHINeGVnaUq5ovTQIwOFu/Ti2cVg0P+gf9INs3drkr0QbohRQSj5FD
	 lGj8LN2o45FDPFxHGNXgkMZLuZ338Y+rgujmkz1WXMe0I+fEUbnyt1EE0N/C2AtBHH
	 AfSAw1hbSSnOmvNJImz4LtWg462/igj5ij3rHBBo=
Date: Wed, 22 Apr 2026 19:00:30 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
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
	david.hildenbrand@arm.com
Subject: Re: [PATCH v2 2/3] kasan: skip HW tagging for all kernel thread
 stacks
Message-ID: <aekMvrcBCUTf3yT4@arm.com>
References: <20260324132631.482520-1-usama.anjum@arm.com>
 <20260324132631.482520-3-usama.anjum@arm.com>
 <adlCN9sUcQdWbf_i@arm.com>
 <adlDSiuBeSduK0mj@arm.com>
 <aa7c5a29-c8f7-48aa-b0a0-ed147d29fde4@kernel.org>
 <aeHvzh3A0eC-tds9@arm.com>
 <e881c79a-fe7c-46b1-a518-febf7a278cc9@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e881c79a-fe7c-46b1-a518-febf7a278cc9@arm.com>

On Wed, Apr 22, 2026 at 02:31:14PM +0100, Ryan Roberts wrote:
> On 17/04/2026 09:31, Catalin Marinas wrote:
> > On Thu, Apr 16, 2026 at 11:03:46AM +0200, David Hildenbrand wrote:
> >> On 4/10/26 20:36, Catalin Marinas wrote:
> >>> On Fri, Apr 10, 2026 at 07:32:23PM +0100, Catalin Marinas wrote:
> >>>> What the original approach might help with is use-after-realloc in case
> >>>> we had a tagged pointer in a past life of a page and it still works now.
> >>>> Oh well, that's I guess for other types of hardening to address like
> >>>> delayed reallocation.
> >>>
> >>> Another thought (for a separate series) - we could try to map the stack
> >>> as Untagged (unless stack tagging is enabled; needs compiler
> >>> instrumentation) and enable canonical tag checking (newer addition to
> >>> MTE). This way, any stray tagged pointer won't work on the stack since
> >>> it needs a 0xf tag (canonical).
> >>
> >> Do you mean mapping it as Untagged in the vmap for CONFIG_VMAP_STACK or
> >> also as Untagged in the directmap?
> >>
> >> The latter brings in the set of problems with direct map fragmentation.
> > 
> > Just the vmap, there are a lot more problems with the direct map. Not
> > sure how much it does in terms of security, maybe marginally. A
> > match-all tag (0xf) would still be able to access the canonically tagged
> > memory.
> 
> I think with the first patch in this series, we are alredy vmapping the stack
> memory as untagged, right? vmalloc only calls arch_vmap_pgprot_tagged() if we
> are not skipping kasan. So I think we already have this protection? (perhaps we
> need to explicitly enable the canonical tag checks?)

Ah, yes, good point. So, we could just enable canonical tag checking so
that untagged memory only uses the 0xf tag while in the kernel (not sure
what might break but in theory these would only happen if we have use
after free bugs etc.)

I think it's just a matter of setting TCR_EL1.MTX1 but it has some
implications on the PAC bits. This setting would affect the kernel
image mapping, modules. Anyway, something to investigate separately.

-- 
Catalin
