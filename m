Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904FA331218;
	Fri, 17 Apr 2026 08:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776414681; cv=none; b=AoNFns/plaCijm+1AY9jAX1BampaHIOumvz32sQUT2SzGFiY4/vinqxeR4ZTMNlq9ul27O6LF7GvPmHNPa5hfGV8K7FIzzB+xWimQp3ILmM/wEePMsrBXi586lgVfbFccJqbZrMReNOPPCgxDdDOcgGTL293kxylAOP+AE58nF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776414681; c=relaxed/simple;
	bh=Xf8oSVlSyjbs13J2X0kdO8ZpK0071NFBikk2L1e0ZT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTy0VXiqU0Ih8AGccxO0G6Ac32ISAZO+bDbkTVuzC/HespO48MzFTzXFICYc2Lum97RhXOi8sOmwcy/IK/YebEcDOooHLbyw5VYKPePJld1L/UQsuxKfcgBFXzzVs02+YyFAFKXbJ+y7HlM19mSJYzqKS/eyM5h3eyZ217XVtdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=tZgojb2e; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="tZgojb2e"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2FF51E7D;
	Fri, 17 Apr 2026 01:31:12 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 235843F641;
	Fri, 17 Apr 2026 01:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776414678; bh=Xf8oSVlSyjbs13J2X0kdO8ZpK0071NFBikk2L1e0ZT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tZgojb2evQ6/7+DClcXpyLa99zzRDpUS7S0mVhSbZhXIt0RPhE/BPySCWlI6E2NHK
	 KPE8JCU3bOeXhjZ/k47vt0jDLgArIHpRRZNbU2Ju8E0bWimOItBpxk5rNzeDT8az5m
	 g7QTTyHdiLu7/ZHOEJT2o8LaOxRwWwqLBwRqKEgY=
Date: Fri, 17 Apr 2026 09:31:10 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@arm.com>,
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
	Ryan.Roberts@arm.com, david.hildenbrand@arm.com
Subject: Re: [PATCH v2 2/3] kasan: skip HW tagging for all kernel thread
 stacks
Message-ID: <aeHvzh3A0eC-tds9@arm.com>
References: <20260324132631.482520-1-usama.anjum@arm.com>
 <20260324132631.482520-3-usama.anjum@arm.com>
 <adlCN9sUcQdWbf_i@arm.com>
 <adlDSiuBeSduK0mj@arm.com>
 <aa7c5a29-c8f7-48aa-b0a0-ed147d29fde4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa7c5a29-c8f7-48aa-b0a0-ed147d29fde4@kernel.org>

On Thu, Apr 16, 2026 at 11:03:46AM +0200, David Hildenbrand wrote:
> On 4/10/26 20:36, Catalin Marinas wrote:
> > On Fri, Apr 10, 2026 at 07:32:23PM +0100, Catalin Marinas wrote:
> >> What the original approach might help with is use-after-realloc in case
> >> we had a tagged pointer in a past life of a page and it still works now.
> >> Oh well, that's I guess for other types of hardening to address like
> >> delayed reallocation.
> > 
> > Another thought (for a separate series) - we could try to map the stack
> > as Untagged (unless stack tagging is enabled; needs compiler
> > instrumentation) and enable canonical tag checking (newer addition to
> > MTE). This way, any stray tagged pointer won't work on the stack since
> > it needs a 0xf tag (canonical).
> 
> Do you mean mapping it as Untagged in the vmap for CONFIG_VMAP_STACK or
> also as Untagged in the directmap?
> 
> The latter brings in the set of problems with direct map fragmentation.

Just the vmap, there are a lot more problems with the direct map. Not
sure how much it does in terms of security, maybe marginally. A
match-all tag (0xf) would still be able to access the canonically tagged
memory.

-- 
Catalin
