Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A74A36D9E0
	for <linux-arch@vger.kernel.org>; Tue, 14 Jul 2026 10:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784024796; cv=none; b=JyK4XjyMDXEFfcWR+0aFFd/PiC7EFtLvfcf4A7JEtBug+TD7o9mX4pBkKnRnSr0vYI6zlVlkpUEJS78i8VChTBNRJuUHlGcSpCYWdTCH5XKQ6IpoO/SygWFONVb02uZPwXsB1CCMW9sZrc4qzaNWsZ74f5hx9Y5Nf4JO0Sos4R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784024796; c=relaxed/simple;
	bh=wRvxYrU0Db74kgKIg4MAkH8AJ48uHcgqYHktBr4Iftk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRJn2KP9fUYP/vr+uGjWpSU5z6P2dzHq7WPwcaNSdvyC6vQ/hYevfEuwXaEDyAHPSvq7g1gjDKVUi0CQ/wqb16+CExiHS+0K6b5ZiVkMM5+GLiOOluS05kJ0Jfh071ZoHlgTCIYjlSCFsYv9dH4FMUmYEHoWw60zYYuYS1iKpNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X1UcKjUP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DPgDPUNa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X1UcKjUP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DPgDPUNa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X1UcKjUP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DPgDPUNa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X1UcKjUP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DPgDPUNa"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 134CB75D55;
	Tue, 14 Jul 2026 10:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784024793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=khB/to3aOpUTgGTf59zKb1ob5wdV92G9QJtQXjDAoS4=;
	b=X1UcKjUPwFCkcvM34/QaEi0GeBdnyXah3hmHi1D8Poz47UB712qXIXRaJG6edsNfbG2ZA+
	z5cB65T9O/OYv5qY43ugJDHwVaTgllfBIZ9UaWwkNvt07EqCc4MfDsXlOrzcTa1ljoJsh8
	ZREca7S8uqp/stNOGwDBdmvskz1XeX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784024793;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=khB/to3aOpUTgGTf59zKb1ob5wdV92G9QJtQXjDAoS4=;
	b=DPgDPUNaL/Uj8oEf2qMTyo3J81KosNcpxLKOMxymAIDnO1BMA1vluTZ6/clWzrYO9GdgP4
	w321jUwSCwkNL+AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784024793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=khB/to3aOpUTgGTf59zKb1ob5wdV92G9QJtQXjDAoS4=;
	b=X1UcKjUPwFCkcvM34/QaEi0GeBdnyXah3hmHi1D8Poz47UB712qXIXRaJG6edsNfbG2ZA+
	z5cB65T9O/OYv5qY43ugJDHwVaTgllfBIZ9UaWwkNvt07EqCc4MfDsXlOrzcTa1ljoJsh8
	ZREca7S8uqp/stNOGwDBdmvskz1XeX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784024793;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=khB/to3aOpUTgGTf59zKb1ob5wdV92G9QJtQXjDAoS4=;
	b=DPgDPUNaL/Uj8oEf2qMTyo3J81KosNcpxLKOMxymAIDnO1BMA1vluTZ6/clWzrYO9GdgP4
	w321jUwSCwkNL+AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B7FB779AE;
	Tue, 14 Jul 2026 10:26:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PH4iO9IOVmoNJQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 14 Jul 2026 10:26:26 +0000
Date: Tue, 14 Jul 2026 11:26:20 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, linux-arch@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, x86@kernel.org, 
	linux-mm@kvack.org, kasan-dev@googlegroups.com, linux-csky@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org, david@kernel.org, 
	linux@armlinux.org.uk, akpm@linux-foundation.org, ankur.a.arora@oracle.com, 
	rppt@kernel.org, linmag7@gmail.com, chleroy@kernel.org, klarasmodin@gmail.com, 
	chenhuacai@kernel.org, kernel@xen0n.name, kas@kernel.org, zhangtianyang@loongson.cn, 
	wangyuli@aosc.io, tsbogend@alpha.franken.de, ljs@kernel.org, jgg@ziepe.ca, 
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, ryan.roberts@arm.com, 
	pasha.tatashin@soleen.com, rmclure@linux.ibm.com, baolin.wang@linux.alibaba.com, 
	tj@kernel.org, kevin.brodsky@arm.com, anup@brainfault.org, 
	atish.patra@linux.dev, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, dave.hansen@linux.intel.com, luto@kernel.org, 
	peterz@infradead.org, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, 
	hannes@cmpxchg.org, mhocko@kernel.org, qi.zheng@linux.dev, shakeel.butt@linux.dev, 
	kasong@tencent.com, baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, anshuman.khandual@arm.com, 
	yang@os.amperecomputing.com, chaitanyas.prakash@arm.com, ardb@kernel.org, guoren@kernel.org, 
	yang.li85200@gmail.com, viro@zeniv.linux.org.uk, dinguyen@kernel.org, 
	schuster.simon@siemens-energy.com, wangruikang@iscas.ac.cn, junhui.liu@pigmoral.tech, 
	muchun.song@linux.dev, vishal.moola@gmail.com, namcao@linutronix.de, pavel@kernel.org, 
	djbw@kernel.org, yu-cheng.yu@intel.com, baolu.lu@linux.intel.com, 
	Jonathan.Cameron@huawei.com, coxu@redhat.com, andreas@gaisler.com, liam@infradead.org, 
	vbabka@kernel.org, surenb@google.com, mhocko@suse.com, geert@linux-m68k.org, 
	shorne@gmail.com, jonas@southpole.se, stefan.kristiansson@saunalahti.fi
Subject: Re: [RFC PATCH 02/34] ARM: mm: make 2-level pgd_t a scalar
Message-ID: <alYL7B0HAvmLVHGU@pedro-suse>
References: <20260713135614.1618183-1-yeoreum.yun@arm.com>
 <20260713135614.1618183-3-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713135614.1618183-3-yeoreum.yun@arm.com>
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,lists.linux.dev,kernel.org,kvack.org,googlegroups.com,lists.linux-m68k.org,armlinux.org.uk,linux-foundation.org,oracle.com,gmail.com,xen0n.name,loongson.cn,aosc.io,alpha.franken.de,ziepe.ca,arm.com,arndb.de,soleen.com,linux.ibm.com,linux.alibaba.com,brainfault.org,linux.dev,dabbelt.com,eecs.berkeley.edu,ghiti.fr,linux.intel.com,infradead.org,redhat.com,alien8.de,zytor.com,cmpxchg.org,tencent.com,google.com,os.amperecomputing.com,zeniv.linux.org.uk,siemens-energy.com,iscas.ac.cn,pigmoral.tech,linutronix.de,intel.com,huawei.com,gaisler.com,suse.com,linux-m68k.org,southpole.se,saunalahti.fi];
	R_RATELIMIT(0.00)[to_ip_from(RLdozb9qxkmspn1ke6sq1inr93)];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[95];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Score: -2.30

On Mon, Jul 13, 2026 at 02:55:41PM +0100, Yeoreum Yun wrote:
> From: "David Hildenbrand (Arm)" <david@kernel.org>
> 
> We don't want pgd_t to be an array, as it prohibits returning it from a
> function, like pgdp_get().
> 
> So let's just use an u64, and extract the right 32bit value in
> pgd_val().
> 
> Leave the STRICT_MM_TYPECHECKS case alone for now.

I have to ask: is there a good reason for the STRICT_MM_TYPECHECKS ifdef?

I see the compiler has an awkward time returning a u64 struct (see
https://godbolt.org/z/qejbv6j9a), but if this doesn't work maybe we should
get rid of the STRICT_MM_TYPECHECKS stuff? I seriously doubt anyone is
purposefully toggling it on for testing from time to time.

If STRICT_MM_TYPEDEFS's worse codegen doesn't matter then maybe we should
permanently toggle it on.
> 
> As an alternative, we could use the STRICT_MM_TYPECHECKS approach here
> as well, but using an u64 looks conceptually cleaner, even though
> pgd_val() gets a bit more involved.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  arch/arm/include/asm/pgtable-2level-types.h | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/include/asm/pgtable-2level-types.h b/arch/arm/include/asm/pgtable-2level-types.h
> index 650e793f41429..02052cef9437a 100644
> --- a/arch/arm/include/asm/pgtable-2level-types.h
> +++ b/arch/arm/include/asm/pgtable-2level-types.h
> @@ -25,7 +25,7 @@ typedef struct { pteval_t pgprot; } pgprot_t;
>  
>  #define pte_val(x)      ((x).pte)
>  #define pmd_val(x)      ((x).pmd)
> -#define pgd_val(x)	((x).pgd[0])
> +#define pgd_val(x)      ((x).pgd[0])
>  #define pgprot_val(x)   ((x).pgprot)
>  
>  #define __pte(x)        ((pte_t) { (x) } )
> @@ -36,14 +36,21 @@ typedef struct { pteval_t pgprot; } pgprot_t;
>  /*
>   * .. while these make it easier on the compiler
>   */
> +typedef u64 pgdval_t;
> +
>  typedef pteval_t pte_t;
>  typedef pmdval_t pmd_t;
> -typedef pmdval_t pgd_t[2];
> +typedef pgdval_t pgd_t;
>  typedef pteval_t pgprot_t;
>  
>  #define pte_val(x)      (x)
>  #define pmd_val(x)      (x)
> -#define pgd_val(x)	((x)[0])
> +
> +static inline pmdval_t pgd_val(pgd_t pgd)
> +{
> +	return (*(pmdval_t (*)[2])&pgd)[0];

Ugh. This isn't correct C code. It only works because the kernel passes
-fno-strict-aliasing. I would recommend either forcing a struct here, or
using a u64 with bitmasks/shifts.

-- 
Pedro
