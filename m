Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546331;
	b=T5S/pdp4m2eakCBaMd5Rb+qkjx/qtVYIWvF0Supw6RZlgCsXwTuOerA70T6FXiLilVcN
	 jB/s7yG84d5m7G6bW6bZB1+P11Do5uWOTW4Yt3SXy3pZVVbkCwWXFsUQhJDOEz0yvk6cl
	 gTEoVO4Bj3/at2458JeUVGiOySI91IddyEI3Gk6KQw3LSmPIerJeM6KbumyjCzvajZmGD
	 BOTJhlgz95H44ClNkY6TgDIanvJdORAeF9muNUE6d9XHNLiB4V83O/1udFWNZmFzWdSTn
	 lfuYFyvhHRUe5M+TSYQNE0pp5knqdFKcOwwAEr5vFIkCzMoNYwHU+jdI3HdhyraHeXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546331;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=0sNoW/KWYC5fenn6W3ZO2QgTuASrJJ6ujM7Ci83DK9o=;
	b=Ed3D09zOQNrWj3TDzKik5Zre/WpGlfd3VJs2GluUkZg0s9Aw0+AEAg8ncpGS5Cnv2Z1A
	 OCCCDMAKf53sHHjjxcTg/c6gI+QdtWEUY1+5b+VOSE/wDN7a03j9WHj8Yy+kN9UyeFOf1
	 LEBee3LmDPqnM+KUgabSL13aTBRVtvfl2QSYlk/NhbW+C9bpZfDg9YbhgWpJInpy64VWL
	 uC3qcKDpAcAtGdCtw1HT4r+Qs1kd17DdrKgiWl5niipKDd2WuruBcRMWWWt6sc7SkUwID
	 WP0Kp/X4jY/PAzeoTAgNnKqptfakf7S1pneM8JNT6eNmGbo0+bYsm8EB/88AKHSkQ7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=HxpQmHpN;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EA1606A321;
	Tue, 24 Nov 2026 18:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81EA1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=HxpQmHpN
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1019F497;
	Tue, 24 Nov 2026 10:52:08 -0800 (PST)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EAC33F86C;
	Tue, 24 Nov 2026 10:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795546330; bh=cEx0NNr4v9OqxertlfeaIBCZsjK0gqeBlEmSznQ0QE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HxpQmHpNrqXVqUfjE0HPfLK3ewOjjeolAx23daMcxTI88aKM+hL6rA2Fg+4rqd8+R
	 qMFVk/rzRBXFpbU1Dfr/ftkZEjuXw3RMnNovsFD1RM3+rwaFKpdU0NBWTD4cVkNWWE
	 Ki55UEoYDf7IlCgUAL9LE2jIQWyjvIsSNBfWze2I=
Date: Tue, 24 Nov 2026 18:52:00 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, Russell King <linux@armlinux.org.uk>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
	Tianrui Zhao <zhaotianrui@loongson.cn>,
	Bibo Mao <maobibo@loongson.cn>, Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-openrisc@vger.kernel.org
Subject: Re: [PATCH RESEND v2 12/21] mm/pgtable: redefine PGTABLE_LEVEL enum
 with ascend order from PGD
Message-ID: <awXc0MSZl9t9VW8e@e129823.arm.com>
References: <20261102-dummy_ptxp3-v2-0-78840b2ec73c@arm.com>
 <20261102-dummy_ptxp3-v2-12-78840b2ec73c@arm.com>
 <awXD4i47F-VAG1tD@kernel.org>
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
In-Reply-To: <awXD4i47F-VAG1tD@kernel.org>

On Tue, Nov 24, 2026 at 07:05:38PM +0200, Mike Rapoport wrote:
> On Mon, Nov 02, 2026 at 11:21:25AM +0000, Yeoreum Yun wrote:
> > The PGTABLE_LEVEL enum values appear to be ordered in the opposite direction
> > from their intended usage.
> > 
> > Intuitively, higher page table levels should have smaller enum values,
> > but PTE is currently assigned 0.
> 
> That's not what x86 thinks :)
> They even expose it in /proc/vmstat with smaller numbers meaning lower levels
> 
> $ grep direct_map /proc/vmstat 
> direct_map_level2_splits 152
> direct_map_level3_splits 4
> direct_map_level2_collapses 0
> direct_map_level3_collapses 0
> 
> Just an observation, I don't mind either order.

Right. I made this change because a depth-based scheme seems more intuitive.

As you pointed out, though, the x86 specification uses smaller
numbers (0) for lower levels (pte), so I think we can leave the
x86-specific direct_map_* entries as they are.

>  
> > For consistency and cleanup, reverse the enum value ordering.
> > 
> > Since there is no current user relies on these numbers to be ascending from
> > PTE->PGD, so it can be changed to be ascending from PGD->PTE, in the
> > direction of the page table walk.
> > 
> > Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > ---
> >  include/linux/pgtable.h | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index 780fe849ff8b7..a032f95943357 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -2288,11 +2288,11 @@ static inline bool arch_has_pfn_modify_check(void)
> >  typedef unsigned int pgtbl_mod_mask;
> >  
> >  enum pgtable_level {
> > -	PGTABLE_LEVEL_PTE = 0,
> > -	PGTABLE_LEVEL_PMD,
> > -	PGTABLE_LEVEL_PUD,
> > +	PGTABLE_LEVEL_PGD = 0,
> >  	PGTABLE_LEVEL_P4D,
> > -	PGTABLE_LEVEL_PGD,
> > +	PGTABLE_LEVEL_PUD,
> > +	PGTABLE_LEVEL_PMD,
> > +	PGTABLE_LEVEL_PTE,
> >  };
> >  
> >  static inline const char *pgtable_level_to_str(enum pgtable_level level)
> > 
> > -- 
> > 2.43.0
> > 
> 
> -- 
> Sincerely yours,
> Mike.

-- 
Sincerely,
Yeoreum Yun
