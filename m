Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546AB2F25F5;
	Wed, 15 Jul 2026 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784123071; cv=none; b=q5tNW7ASLd1eLMM79dg/D7GvomnPE0mcKoUr2rwsGGdQoKcCb2QeZ1S2YjFhYxTTnsUlEcMqd5PWZK/j+rAKXjZXCthUBTleU6QwU8NxrsUmbvu6Zbuy3kAiyT5eXEnqJyq9BkMLXGHZhU4F4SFrh3pHCj/Pz6EEMgmLMImaFys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784123071; c=relaxed/simple;
	bh=eIgpCTRPgqPTqdx54P+55ycRFoiVAMVPyrH/hSOkxIw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=npQpwoRo+m5C7g0FV9EXk3heRQnSPoy48pTwUy0A2oEEsGyeF4X917kkLX6g0orkrlyrgwYZWIUA9y6TIuE3y3KT8HaK2cRBuQwu12IW2WR/t9TXnd++IUq9disR2JZGCb6oza7zZMzgp9j+TJ2JcztFg6RyVyrmQyluaWRFEoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XUDBCE9u; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XUDBCE9u"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC4D31477;
	Wed, 15 Jul 2026 06:44:18 -0700 (PDT)
Received: from [10.2.198.93] (e142334-100.cambridge.arm.com [10.2.198.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A51C63F915;
	Wed, 15 Jul 2026 06:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784123063; bh=eIgpCTRPgqPTqdx54P+55ycRFoiVAMVPyrH/hSOkxIw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=XUDBCE9uKhapcjpn3hEyydo6n8Z10XJL4DGb4h958hMrkQQ51e4U0TkwAjNzJDzOk
	 eD/LOzYvppL+1IQtFhflB4XCT6Ncvq4/Hh0/F3eNv5PwdHMKH6kHWKs0fpugu38REX
	 eGLtl9O5j7jNXOw9fMgYIdBX0uaZplN8x21Nq5zc=
Message-ID: <1dcd93fa-4922-433b-9f1d-c096c0de3665@arm.com>
Date: Wed, 15 Jul 2026 14:44:11 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@arm.com, david@kernel.org, linux@armlinux.org.uk,
 akpm@linux-foundation.org, ankur.a.arora@oracle.com, rppt@kernel.org,
 linmag7@gmail.com, chleroy@kernel.org, klarasmodin@gmail.com,
 chenhuacai@kernel.org, kernel@xen0n.name, kas@kernel.org,
 zhangtianyang@loongson.cn, wangyuli@aosc.io, tsbogend@alpha.franken.de,
 ljs@kernel.org, jgg@ziepe.ca, catalin.marinas@arm.com, will@kernel.org,
 arnd@arndb.de, ryan.roberts@arm.com, pasha.tatashin@soleen.com,
 rmclure@linux.ibm.com, baolin.wang@linux.alibaba.com, tj@kernel.org,
 kevin.brodsky@arm.com, anup@brainfault.org, atish.patra@linux.dev,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 tglx@kernel.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
 hannes@cmpxchg.org, mhocko@kernel.org, qi.zheng@linux.dev,
 shakeel.butt@linux.dev, kasong@tencent.com, baohua@kernel.org,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
 dvyukov@google.com, vincenzo.frascino@arm.com, anshuman.khandual@arm.com,
 yang@os.amperecomputing.com, chaitanyas.prakash@arm.com, ardb@kernel.org,
 guoren@kernel.org, yang.li85200@gmail.com, viro@zeniv.linux.org.uk,
 dinguyen@kernel.org, schuster.simon@siemens-energy.com,
 wangruikang@iscas.ac.cn, junhui.liu@pigmoral.tech, muchun.song@linux.dev,
 vishal.moola@gmail.com, namcao@linutronix.de, pavel@kernel.org,
 djbw@kernel.org, yu-cheng.yu@intel.com, baolu.lu@linux.intel.com,
 Jonathan.Cameron@huawei.com, coxu@redhat.com, andreas@gaisler.com,
 liam@infradead.org, vbabka@kernel.org, surenb@google.com, mhocko@suse.com,
 geert@linux-m68k.org, shorne@gmail.com, jonas@southpole.se,
 stefan.kristiansson@saunalahti.fi
Subject: Re: [RFC PATCH 11/34] mm: vmscan: remove stack copy address of pud
 pass in wallk_pud_range()
To: Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
 x86@kernel.org, linux-mm@kvack.org, kasan-dev@googlegroups.com,
 linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-openrisc@vger.kernel.org
References: <20260713135614.1618183-1-yeoreum.yun@arm.com>
 <20260713135614.1618183-12-yeoreum.yun@arm.com>
From: Usama Anjum <usama.anjum@arm.com>
Content-Language: en-US
In-Reply-To: <20260713135614.1618183-12-yeoreum.yun@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/07/2026 2:55 pm, Yeoreum Yun wrote:
> We want to change how pXdp_get() works with generic compile-time folded
> page tables. To prepare for that, replace passing the address of a stack
> copy of a pXd to walk_pmd_range() with pud pointer directly so that
> the ignoring the value of folded entries.
> 
> There should be no functional change.
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  mm/vmscan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 986dde8e7429f..61470223d8213 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3725,7 +3725,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long start, unsigned long end,
>  		if (!pud_present(val) || WARN_ON_ONCE(pud_leaf(val)))
>  			continue;
>  
> -		walk_pmd_range(&val, addr, next, args);
> +		walk_pmd_range(pud + i, addr, next, args);
While I was working on converting these page table types to hardware types, I
had this exact patch for this problem.

Reviewed-by: Muhammad Usama Anjum <usama.anjum@arm.com>

>  
>  		if (need_resched() || walk->batched >= MAX_LRU_BATCH) {
>  			end = (addr | ~PUD_MASK) + 1;

