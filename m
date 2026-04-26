Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E341022A4E1
	for <linux-arch@vger.kernel.org>; Sun, 26 Apr 2026 17:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777224865; cv=none; b=sFwqHWb46u46aVpP6T2lhNewfXzd/yCBeE5YadA5uC3zchK7gpI9rQMdY+kb/byLzbVYcVlJBW15AcgvBmiwiyUaG7FhrKeX7rFSpK1kLBz7B6sfjLxtoixkT/EmbpDtJQNVc6O4HSqNJ/wiYvZNJuVK3+BIWEijyjQqgfrk668=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777224865; c=relaxed/simple;
	bh=N0LKPEi7WB8bR3HgkSU/ioxwPoQBdIh0x2OI04p1Av4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JXcGlCUt5Kbm4mKtlkNLqb5OM0oo7ApAi+hHqr8HAOxYoheTr5ockdVTTmi3K+Oveo9MwO+R+jC5lXgf91vbmhfbrnevLnrDyW9MED6ocMAyluiei7VLdFiGYd8xUHKWFnK9AWMtA0qrCNe2VoLZE6AcVfxxvA9CIBeT/IV5gEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S69Hq9vR; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S69Hq9vR"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43d7e23defbso5576276f8f.0
        for <linux-arch@vger.kernel.org>; Sun, 26 Apr 2026 10:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777224862; x=1777829662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QyGD/jXsZR2JkMBX6t9t85Fm770UU4EyuOCFTF+xktc=;
        b=S69Hq9vRzF+t8LAKuHe1KdrUpTiQyt7IQ8pfVDiLzkIEnUeLfsbFMPLCWFAf2G5NJs
         B71uwkbWt1gBQD9O68pzKDnRHwnwG6Cv5FAWLfhEXDQaQnRWX01/ZQrg9bJubzmIu01S
         5udC5g5keozveHqB31rTE09JITLH+mImR57riomLJd9UM5+MZw0ZgiKlfLrOE0O9L2f9
         wmVrNLIFd1jWtoHz6CLTaCT2v/7Zs+nYGaFyYtiF3oSivR0PPA2YKmXX1CLpOoMT92HN
         b4M9d5wh73fupyG7gJdbF+Iqx89KUai3g6s4MfES2SOJTAjf5L82Oj3Ps2wLzuCIp9tb
         ZBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777224862; x=1777829662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QyGD/jXsZR2JkMBX6t9t85Fm770UU4EyuOCFTF+xktc=;
        b=qhIV95b8KtVkCft4wiBJCxzDWHaRNjVFg2kHoHOwNPL47rOf0MknSyOp5Vj345ouob
         GCcBFJs2sa/gbIyUDZNFCdKpxn5jXVmXrH0IDFVFXWCFaxO6WoeDE3vIoK/rBG8vuHf+
         /RGueRzvE87JqyYAjQqS1hpJIHLoezIokm/yUZW6E+Osz4PcVhP944PWoa6VGPYNt4sY
         /bgw+xaaAMAzS/bkBJ6WITAasAZX7oHlp/7RSTvEjozQVuVScf8KzyyTpSWsnd4FFbM8
         mvTd3oWl50/a4jvikhNakSD1B99Vymo647hECDz037Yh8Y3plZTylkaVVg6+tr24RBng
         iSNA==
X-Forwarded-Encrypted: i=1; AFNElJ9wXByZI2uRjP8J1wI8q+XBy/MnTNaaq9sJIA0huU4+R43+nCr9Te5jp353aFHeVKRDGENQibeSxShf@vger.kernel.org
X-Gm-Message-State: AOJu0YwWoWCoG6+kSTw5CDdaic2skC9qN2rjy1ROzFNvruAdHTSj8oXY
	Z71Z9MYXDYBTXc5noFa5A8hv+L7Jd1Dk/ERKS0kgQB1uttzevbzU4/CV
X-Gm-Gg: AeBDieu5YU0GqLHy/hicK80PfCrmLjoXn0WJ2GbxlOLsWUvUK1/2a118pLdd0V8Y/m8
	rOd9KOo191ifUmYNXfiDoRrQ6SwyXKAV5uzWOeLdVsvFei0qutIXAEEvqmuEXYPzQA+jWb5Dx7d
	7xRldL484H7SGc6NX3iFETRM57qPe0EjT7yz/t6al6Kuup/xWpbpl2G3DjIaCMtXP5kP3O/vr3L
	pP9GuY7hSbSJL8oR8hovbpGaDY2LvnuianRBi3ZeOou96b7iyDOjLt2l6oKmcSr97BkZPsAMrlK
	pj61Zdvxz3+CKl35eCVU3HFmtngXazPkkzhQtK2fLYRc3+LSpMT5uR3MLQHnhJ+K+J/hwqz+uo8
	RjxJjqMvbqALRqRL5jS92ClArRpTXVIE+GUMGH7FrAa6PiFkQ5Dn5+E2496DpkgbjEJQUULCN4V
	pY3pniix7++l+YbtZbRrkR9gIMp3qABB+MvqjIVHe+pV++vhtxE7AlZtb0SFO8Tjs1FURfS17UM
	y4=
X-Received: by 2002:a05:6000:186c:b0:43d:7946:badd with SMTP id ffacd0b85a97d-43fe3e0be7bmr61587116f8f.35.1777224862017;
        Sun, 26 Apr 2026 10:34:22 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4411c9f4f03sm44639379f8f.1.2026.04.26.10.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 10:34:21 -0700 (PDT)
Date: Sun, 26 Apr 2026 18:34:20 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Min-Hsun Chang <chmh0624@gmail.com>, arnd@arndb.de, msalter@redhat.com,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-generic: replace ________addr with
 __UNIQUE_ID(addr)
Message-ID: <20260426183420.2216d187@pumpkin>
In-Reply-To: <20260426040925.b25cb2a32680bfe884431abf@linux-foundation.org>
References: <20260307092119.20733-1-chmh0624@gmail.com>
	<20260322144032.7353997c@pumpkin>
	<20260425135737.e79c4b546d22b5ebfd96c0b5@linux-foundation.org>
	<20260425230134.5449498a@pumpkin>
	<20260425151240.2a46e3a8640fde3902461d41@linux-foundation.org>
	<20260426114938.4dff28c8@pumpkin>
	<20260426040925.b25cb2a32680bfe884431abf@linux-foundation.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Apr 2026 04:09:25 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Sun, 26 Apr 2026 11:49:38 +0100 David Laight <david.laight.linux@gmail.com> wrote:
> 
> > On Sat, 25 Apr 2026 15:12:40 -0700
> > Andrew Morton <akpm@linux-foundation.org> wrote:
> >   
> > > On Sat, 25 Apr 2026 23:01:34 +0100 David Laight <david.laight.linux@gmail.com> wrote:
> > >   
> > > > > > The real problem with this define is that both idx and phys are
> > > > > > expanded twice.      
> > > > > 
> > > > > The real problem with this define is that it's a define.  Why oh why do
> > > > > we keep doing this to ourselves?    
> > > > 
> > > > Sometimes #defines generate better code because they are expanded earlier,
> > > > and sometimes you want type-agnostic 'functions'.
> > > > But neither is true here.
> > > > 
> > > > But I think I'd go for 'always_inline'.
> > > > Sometimes the compilers make silly decisions.    
> > > 
> > > Gee, if `static inline' misbehaves then we have big problems!
> > > 
> > > What's special about the fixmap code anyway?  It's not exactly
> > > fastpath.  Perhaps this stuff can simply be uninlined.  
> > 
> > Some of the inlines are trivial - just adding an extra parameter.
> > But this set would be simpler if the last function
> > (__native_set_fixmap() for x86) returned (address & ~PAGE_MASK)  
> 
> I don't understand this?

I found the following:

#define set_fixmap_offset(idx, phys) \
	__set_fixmap_offset(idx, phys, FIXMAP_PAGE_NORMAL)

#define __set_fixmap_offset(idx, phys, flags)				\
({									\
	unsigned long ________addr;					\
	__set_fixmap(idx, phys, flags);					\
	________addr = fix_to_virt(idx) + ((phys) & (PAGE_SIZE - 1));	\
	________addr;							\
})

static inline void __set_fixmap(enum fixed_addresses idx,
				phys_addr_t phys, pgprot_t flags)
{
	native_set_fixmap(idx, phys, flags);
}

void native_set_fixmap(unsigned /* enum fixed_addresses */ idx,
		       phys_addr_t phys, pgprot_t flags)
{
	/* Sanitize 'prot' against any unsupported bits: */
	pgprot_val(flags) &= __default_kernel_pte_mask;

	__native_set_fixmap(idx, pfn_pte(phys >> PAGE_SHIFT, flags));
}

void __native_set_fixmap(enum fixed_addresses idx, pte_t pte)
{
	unsigned long address = __fix_to_virt(idx);

#ifdef CONFIG_X86_64
       /*
	* Ensure that the static initial page tables are covering the
	* fixmap completely.
	*/
	BUILD_BUG_ON(__end_of_permanent_fixed_addresses >
		     (FIXMAP_PMD_NUM * PTRS_PER_PTE));
#endif

	if (idx >= __end_of_fixed_addresses) {
		BUG();
		return;
	}
	set_pte_vaddr(address, pte);
	fixmaps_set++;
}

Doesn't seem to hard to arrange to return 'address + (phys & ~PAGE_SHIFT)'
from __set_fixmap().
(Other architectures will vary, but I suspect they are similar.)


...  
> > > We inline too much stuff.  
> > 
> > True - don't look at what strlcpy() can generate.
> > The inline code should just get the constants from the compiler and
> > then call the appropriate function.  
> 
> I can't actually find an in-kernel strlcpy()?

That is because I meant strscpy() :-)

In particular https://elixir.bootlin.com/linux/v7.0/source/include/linux/fortify-string.h#L275
Particularly once it gets as far as calling strnlen().

> 
> > As does the compiler.
> > pixpaper_panel_hw_init() repeatedly calls two static functions that
> > contain sleeps. They all get inlined bloating the code size and
> > exploding the stack when clang separately allocates all the buffers
> > in the called functions.  
> 
> Poor thing.  I guess compiler developers are more focused on userspace
> code and aren't especially concerned about kernel's particular
> requirements.  And that's understandable - it's down to us to persuade
> them to add options to permit us to tune the compiler behavior.

That would be wrong for for userspace as well.
Inlining and loop unrolling decisions don't seem to allow
for the cost of reading code from memory into the I-cache.
(Loop unrolling is so 1980s)

My suspicion is that very few writes of user code ever look at
the generated code.
So the compiler developers go their own way optimising things
that improve some benchmarks but make more normal programs
run a bit slower.
Of course, modern cpu are fast enough that it doesn't matter
what is generated for most code.
(end rant)

	David


