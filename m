Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC2827456
	for <linux-arch@vger.kernel.org>; Sat, 24 Jan 2026 01:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769219158; cv=none; b=vDULuKcnKPAtIJIllO1E+wEMHEivJMPa7PABje1RVCykA0e1nKQqnamK5QU/sE+knQhSHt9tQQMDcthMHeNClpcl5V7u9pkTqXiP2tOWzi7AhiUjRv9BoODUq58ojnVdzDYljo4EeZcUWutsiAEPobTz7StStZolBISQA3WpSDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769219158; c=relaxed/simple;
	bh=9QeaE1bwD3GxKwFMm007vrZkopgiIxQPdZ7Ly6RtqsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsGwa3/9WjxZn6C9owTUUGGAuvzeYy8Bho6ry+w+PkiqjispXbxjnr7e/cw48MuQN/mwQBjzb1QrQLsbTEG20RR16sOFWlyGVnuOYwZhLuHwinkgZumhrQMsvjjkyaxeVMElV1bYnddZVuqiR1hmDp9NeK4B+1kffNvU0vj5yaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsnJhR+M; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsnJhR+M"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b883787268fso405772966b.3
        for <linux-arch@vger.kernel.org>; Fri, 23 Jan 2026 17:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769219154; x=1769823954; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXp0QJyrLLUrmQyXAB/60kXaLRgyX8FN8f699HysLTo=;
        b=WsnJhR+Mi1FQ11mGYA7oMNG+Q18NQF6o4cPFnGITlPkbgKlTg4GYPQqnxtKCCvtkrR
         KRli7UQ2GfZzxCx9E8rwrTndeSyExqFGw7qifPqptU7Svs1rCHtTXRTDrGPAlcsIrzWQ
         j1L6APPS5+ieA738poh4OnPvDMlE2RwIzmjF0k9gMtKWLVMaWhPgkhJwlRxPPRZp7iki
         ZJraeYezYLtb1oY5Cby9kKVAlsrnB1lSXoh3LIhM7eQJEUc1OzkeS3HlE1xD+htLfUzn
         IRAj5cQFEx4eoun1TRg8oM/VIt0mcqGBoeO4nY/HcdDEjB2dMBPbN9oLYgJCrqPqI/aw
         75VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769219154; x=1769823954;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXp0QJyrLLUrmQyXAB/60kXaLRgyX8FN8f699HysLTo=;
        b=pVN4EILmR77jgBXYXgsbVGIdAu0BDkASmIYl3GhxV+Xn76lF80iQcEOFL0zjipR8YA
         ODhanW0IzT1DB2VObfrNTDaWGZziRpuxCqK7mt9O0acqp0r8eSUwMuobzzjY/IzCep7O
         Tfhf6dYrOC0r8Nh7mxxOjbajUph2JFmuSyINr57azRPYeL4tsiJEe1oJ+R5UxJ8Dyapl
         Qe49+x+5kSpsIn7pN971EFoMxmGwudbAe4zQvaGbaI7yWgqJg5xm65g2AbnNn8nqXkgg
         7A+ttTwgv0gu++wiPIx2SVO/MtMSxiQi6gMn3vMU16Z+UPid+Fe7NMHca2GVhv9MVYSc
         Dsdw==
X-Forwarded-Encrypted: i=1; AJvYcCWgX+RpGMWZ5smJXUp8ikq1sIAxOjkuyaHqHQqjZoJZq5Bm8unTTO9dKR5z/Ws1KO6/KCTreriTtycE@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2xCcYPpXKeXqSbPDZOc+wt9OAoCJ2diH1ZxfygTPVRw0Kgxzi
	k3OFqCh2ULMQ/5u3TK89J/Bq5nvreSfs0agj8JyjVWcxPQJy5lQBR2W5
X-Gm-Gg: AZuq6aIjrRzOnX/5L5LkRUj03jETKecxVhL17Eu/C+MHHZTttP7qTSSUxFYZGS5R3JQ
	iRyFTHwHU1e0cDsggOPXkVIG4qkGxDth2cNN2Epm70hGYZi00LvFbNPH5zDuZXIRxad4/DXgW2Y
	mLjQn7apDvfkWIZpQKLQqNiJrYNvctu7zxSuoEBCCP6rYXkRTEAnoLjjv65/k3y8uB3NYQPccCa
	hCy8k9jxIPJODBqYJIzlWm41SV8YAlnFF88gCTymKJodAdYZ8vtOyFJtuxMcE2oOk8AyEdBVh7V
	CxeVn7bKaWEhcnzbtL+TiTxxJpnBgAgxw0BEBrJtUAJz+Oqc1ywiqOfhTTp10UMcKVNUrz6lUi9
	mXOQFObuCyfbVHCawSK7WkQaGeLj4KI6iclfbEOL7/D6QjrqzgwhLr/rRGamBRUYB1OCfpKuphj
	093y/ZD2BYQA==
X-Received: by 2002:a17:907:3f03:b0:b7a:18ba:a63 with SMTP id a640c23a62f3a-b885ac2bd1dmr330014466b.19.1769219153636;
        Fri, 23 Jan 2026 17:45:53 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b886a249e69sm125246466b.6.2026.01.23.17.45.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Jan 2026 17:45:52 -0800 (PST)
Date: Sat, 24 Jan 2026 01:45:52 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: Wei Yang <richard.weiyang@gmail.com>,
	"David Hildenbrand (Red Hat)" <david@kernel.org>, will@kernel.org,
	aneesh.kumar@kernel.org, npiggin@gmail.com, peterz@infradead.org,
	dev.jain@arm.com, akpm@linux-foundation.org, ioworker0@gmail.com,
	linmag7@gmail.com, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-alpha@vger.kernel.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-um@lists.infradead.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v3 7/7] mm: make PT_RECLAIM depends on
 MMU_GATHER_RCU_TABLE_FREE
Message-ID: <20260124014552.um257bwrhwjktdca@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <cover.1765963770.git.zhengqi.arch@bytedance.com>
 <ac2bdb2a66da1edb24f60d1da1099e2a0b734880.1765963770.git.zhengqi.arch@bytedance.com>
 <20251231094243.zmjs7kgflm7q6k73@master>
 <a3a60bbb-70b7-49ed-abc6-937e6c13d681@linux.dev>
 <20260101020715.45wqnjgcklvjcth3@master>
 <d38fcbe5-8b4a-40bc-b8c8-1c49ccaa9964@kernel.org>
 <20260122140034.ymigrfppzwvmcjkr@master>
 <fd90c84b-9829-4699-b7df-c43020519ec9@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd90c84b-9829-4699-b7df-c43020519ec9@linux.dev>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Jan 23, 2026 at 11:21:50AM +0800, Qi Zheng wrote:
>
>
>On 1/22/26 10:00 PM, Wei Yang wrote:
>> On Mon, Jan 19, 2026 at 11:18:52AM +0100, David Hildenbrand (Red Hat) wrote:
>> > On 1/1/26 03:07, Wei Yang wrote:
>> > > On Wed, Dec 31, 2025 at 05:52:57PM +0800, Qi Zheng wrote:
>> > > > 
>> > > > 
>> > > > On 12/31/25 5:42 PM, Wei Yang wrote:
>> > > > > On Wed, Dec 17, 2025 at 05:45:48PM +0800, Qi Zheng wrote:
>> > > > > > From: Qi Zheng <zhengqi.arch@bytedance.com>
>> > > > > > 
>> > > > > > The PT_RECLAIM can work on all architectures that support
>> > > > > > MMU_GATHER_RCU_TABLE_FREE, so make PT_RECLAIM depends on
>> > > > > > MMU_GATHER_RCU_TABLE_FREE.
>> > > > > > 
>> > > > > > BTW, change PT_RECLAIM to be enabled by default, since nobody should want
>> > > > > > to turn it off.
>> > > > > > 
>> > > > > > Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> > > > > > ---
>> > > > > > arch/x86/Kconfig | 1 -
>> > > > > > mm/Kconfig       | 9 ++-------
>> > > > > > 2 files changed, 2 insertions(+), 8 deletions(-)
>> > > > > > 
>> > > > > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> > > > > > index 80527299f859a..0d22da56a71b0 100644
>> > > > > > --- a/arch/x86/Kconfig
>> > > > > > +++ b/arch/x86/Kconfig
>> > > > > > @@ -331,7 +331,6 @@ config X86
>> > > > > > 	select FUNCTION_ALIGNMENT_4B
>> > > > > > 	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
>> > > > > > 	select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
>> > > > > > -	select ARCH_SUPPORTS_PT_RECLAIM		if X86_64
>> > > > > > 	select ARCH_SUPPORTS_SCHED_SMT		if SMP
>> > > > > > 	select SCHED_SMT			if SMP
>> > > > > > 	select ARCH_SUPPORTS_SCHED_CLUSTER	if SMP
>> > > > > > diff --git a/mm/Kconfig b/mm/Kconfig
>> > > > > > index bd0ea5454af82..fc00b429b7129 100644
>> > > > > > --- a/mm/Kconfig
>> > > > > > +++ b/mm/Kconfig
>> > > > > > @@ -1447,14 +1447,9 @@ config ARCH_HAS_USER_SHADOW_STACK
>> > > > > > 	  The architecture has hardware support for userspace shadow call
>> > > > > >              stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
>> > > > > > 
>> > > > > > -config ARCH_SUPPORTS_PT_RECLAIM
>> > > > > > -	def_bool n
>> > > > > > -
>> > > > > > config PT_RECLAIM
>> > > > > > -	bool "reclaim empty user page table pages"
>> > > > > > -	default y
>> > > > > > -	depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
>> > > > > > -	select MMU_GATHER_RCU_TABLE_FREE
>> > > > > > +	def_bool y
>> > > > > > +	depends on MMU_GATHER_RCU_TABLE_FREE
>> > > > > > 	help
>> > > > > > 	  Try to reclaim empty user page table pages in paths other than munmap
>> > > > > > 	  and exit_mmap path.
>> > > > > 
>> > > > > Hi, Qi
>> > > > > 
>> > > > > I am new to PT_RECLAIM, when reading related code I got one question.
>> > > > > 
>> > > > > Before this patch,  we could have this config combination:
>> > > > > 
>> > > > >        CONFIG_MMU_GATHER_RCU_TABLE_FREE & !CONFIG_PT_RECLAIM
>> > > > > 
>> > > > > This means tlb_remove_table_free() is rcu version while tlb_remove_table_one()
>> > > > > is semi rcu version.
>> > > > > 
>> > > > > I am curious could we use rcu version tlb_remove_table_one() for this case?
>> > > > > Use rcu version tlb_remove_table_one() if CONFIG_MMU_GATHER_RCU_TABLE_FREE. Is
>> > > > > there some limitation here?
>> > > > 
>> > > > I think there's no problem. The rcu version can also ensure that the
>> > > > fast GUP works well.
>> > > > 
>> > > 
>> > > Thanks for your quick response :-)
>> > > 
>> > > And Happy New Year
>> > > 
>> > > So my little suggestion is move the definition of __tlb_remove_table_one()
>> > > under CONFIG_MMU_GATHER_RCU_TABLE_FREE. Do you thinks this would be more
>> > > clear?
>> > 
>> > 
>> > Do you mean
>> > 
>> > diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
>> > index 2faa23d7f8d42..6aeba4bae68d2 100644
>> > --- a/mm/mmu_gather.c
>> > +++ b/mm/mmu_gather.c
>> > @@ -319,7 +319,7 @@ static inline void tlb_table_invalidate(struct mmu_gather
>> > *tlb)
>> >         }
>> > }
>> > 
>> > -#ifdef CONFIG_PT_RECLAIM
>> > +#ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
>> > static inline void __tlb_remove_table_one_rcu(struct rcu_head *head)
>> > {
>> >         struct ptdesc *ptdesc;
>> > 
>> > ?
>> 
>> Sorry for the late reply.
>> 
>> Yes, and maybe we can move the definition to the
>> #ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE code block above, then to be next to
>> tlb_remove_table_free().
>> 
>> So that we always have rcu version when CONFIG_MMU_GATHER_RCU_TABLE_FREE.
>
>LGTM, could you help submit an official patch?
>

Sure.

Since this is trivial cleanup, I will post it till next merge window.

>Thanks,
>Qi
>
>> 
>> > 
>> > -- 
>> > Cheers
>> > 
>> > David
>> 

-- 
Wei Yang
Help you, Help me
