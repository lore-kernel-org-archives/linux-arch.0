Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDA51E0DE8;
	Mon, 13 Jul 2026 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783954131; cv=none; b=dZgNVPaSD00K0Aj20nSkjT61l15QAzHr4GBbKJAbR/Vo/C7JcnaUcYmLR/u3IYIHDDAV1g5A871E2gvny4WBc60GPTbBljErBS/XMNbAkT6aS9qX7zYIAjFOZoFsyjjSUDwW/384n79Qg2I6c4/+6K965Rk4mbv9JSD9QGOfgXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783954131; c=relaxed/simple;
	bh=sDZ088P1ZnGXFHUryOiewAG1Z6y3h/p8Wo8FKkSXATk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tN9/p0M2AeQ0XC8D45AUz1/vPKgTIPbysoCvvErwcv1l4BJ3wwxo4ERxWyZjR5USnz/27qomS7nKn2SAeBAyugKSLznXf1YoDQbvEcNizDycMk6DmpsGwRyg5hPWkqbZoa2NgFYcMESDzWUzF5OaS/fk01coXR+dtVcc3LN4UXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=O/y2Lzj2; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="O/y2Lzj2"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB5FF1576;
	Mon, 13 Jul 2026 07:48:44 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0AFD3F7B4;
	Mon, 13 Jul 2026 07:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783954129; bh=sDZ088P1ZnGXFHUryOiewAG1Z6y3h/p8Wo8FKkSXATk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O/y2Lzj2tpSJ9ie2ChN90dBwkdVcdF6N1YWl/GHJ6Ed6GUsi5HGBqMbedj1YEbc20
	 2d0AjvCqu8dUuUImc6KK72I+VoeCy3EctyWNxpHamAG8FtdxwU0nxUzYtOesBuQc7P
	 5gq+kLEOBALggQXwz5Etf4nWUzIxrBp6483sr6C8=
Date: Mon, 13 Jul 2026 15:48:34 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	x86@kernel.org, linux-mm@kvack.org, kasan-dev@googlegroups.com,
	linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-openrisc@vger.kernel.org, david@kernel.org,
	linux@armlinux.org.uk, akpm@linux-foundation.org,
	ankur.a.arora@oracle.com, rppt@kernel.org, linmag7@gmail.com,
	chleroy@kernel.org, klarasmodin@gmail.com, chenhuacai@kernel.org,
	kernel@xen0n.name, kas@kernel.org, zhangtianyang@loongson.cn,
	wangyuli@aosc.io, tsbogend@alpha.franken.de, ljs@kernel.org,
	jgg@ziepe.ca, catalin.marinas@arm.com, will@kernel.org,
	arnd@arndb.de, ryan.roberts@arm.com, pasha.tatashin@soleen.com,
	rmclure@linux.ibm.com, baolin.wang@linux.alibaba.com, tj@kernel.org,
	kevin.brodsky@arm.com, anup@brainfault.org, atish.patra@linux.dev,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, dave.hansen@linux.intel.com, luto@kernel.org,
	peterz@infradead.org, tglx@kernel.org, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, hannes@cmpxchg.org, mhocko@kernel.org,
	qi.zheng@linux.dev, shakeel.butt@linux.dev, kasong@tencent.com,
	baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
	weixugc@google.com, ryabinin.a.a@gmail.com, glider@google.com,
	andreyknvl@gmail.com, dvyukov@google.com, vincenzo.frascino@arm.com,
	anshuman.khandual@arm.com, yang@os.amperecomputing.com,
	chaitanyas.prakash@arm.com, ardb@kernel.org, guoren@kernel.org,
	yang.li85200@gmail.com, viro@zeniv.linux.org.uk,
	dinguyen@kernel.org, schuster.simon@siemens-energy.com,
	wangruikang@iscas.ac.cn, junhui.liu@pigmoral.tech,
	muchun.song@linux.dev, vishal.moola@gmail.com, namcao@linutronix.de,
	pavel@kernel.org, djbw@kernel.org, yu-cheng.yu@intel.com,
	baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
	coxu@redhat.com, andreas@gaisler.com, liam@infradead.org,
	vbabka@kernel.org, surenb@google.com, mhocko@suse.com,
	geert@linux-m68k.org, shorne@gmail.com, jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi
Subject: Re: [RFC PATCH 10/34] x86: mm: carve out the generic compile-time
 folded pgtable case in effective_prot()
Message-ID: <alT6wmSNDxL9S6rE@e129823.arm.com>
References: <20260713135614.1618183-1-yeoreum.yun@arm.com>
 <20260713135614.1618183-11-yeoreum.yun@arm.com>
 <c3edfb13-08ec-419c-bc05-8f3f64186b24@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3edfb13-08ec-419c-bc05-8f3f64186b24@intel.com>

On Mon, Jul 13, 2026 at 07:19:47AM -0700, Dave Hansen wrote:
> On 7/13/26 06:55, Yeoreum Yun wrote:
> > We want to change how pXdp_get() works with generic compile-time folded
> > page tables. To prepare for that, rework effective_prot() to ignore any
> > folded page tables entries, as it will unconditionally get called by
> > ptdump core with pXd_val(pXdp_get()), and we really should be ignoring
> > that value for folded entries.
> > 
> > For this, identify the first real page-table level and
> > update effective_prot only when the current entry is not folded.
> 
> Nit: could you please clean up the "we's" and move over to imperative
> voice for the series? We're picky about it on the x86 side, but I do
> think it's generally a good preferred practice across the kernel.

Okay... let us reparse in the next version.

> 
> Also I really do think this made the code worse. effective_prot() is a
> pretty tidy function. This change more than doubles the size and is also
> basically the same block copied and pasted twice.
> 
> Further, this does seem like it will stop filling out some of the
> st->prot_levels[] entries. That seems like it might break things. It
> definitely needs to be covered in the changelog.
> 
> So, in the end, I'm not 100% sure what this is doing. Is it "optimizing"
> the ptdump code? Or is it preemptively fixing code that will soon be
> throwing a compile error?

As a part of fixing code for chaning of pXdp_get() which can return
a dummy value for the folded table case since current pXdp_get() mostly
fallback to READ_ONCE(), it generates a meaningless code for it [1].

And this code change doesn't seems to miss anything since it skips
setting of st->prot_levels[] for "folded pagtable" only.
so It doesn't seem to break anything.

In the perspective of effective_prot() change only. this optimization
wouldn't be observed since it would be applied at the upper layer in
ptdump.c But I think this is required to handle a dummy entry properly.


Link: [1] https://lore.kernel.org/all/0019d675-ce3d-4a5c-89ed-f126c45145c9@kernel.org/

-- 
Sincerely,
Yeoreum Yun
