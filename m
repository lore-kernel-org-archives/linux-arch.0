Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87833CD8CA;
	Wed, 22 Apr 2026 13:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776864098; cv=none; b=MsDYjirRPA4eVeh9VdhQn7VkKD4BZpdTcJsf0UrLLP0346kBwSwx2NdCnxBwId8ZrS02vtgtlS6zkH1iJSvU08iq1O54au1J/9ZcSBR4c1HOEkAhjgpVnicSVI9jgJ59TPqEeAIsyzvb95SPRTo3aueRYb/BphuwL9JDEKY8Yzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776864098; c=relaxed/simple;
	bh=SUhegrWOX2svV6mP7JpNfDMarrvi6LsYsdK7yk17+VU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=QJjX+63I+EAgbh5XwMPGk9mlb9Nq/57hQfX3Gs7hHALR9st/fVJd2AkzGlhCCalQyXQHMWANkgKvLChqqqkfGjnDcjKtzbtTT4KmRR5j435T+F8FILPQAXvHrE1xUiUUc5HWfLKiu0tahmzVAnas+kiOI3PzQoyr8VPuBOp1KkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JYqwc4in; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JYqwc4in"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B5DA22D9;
	Wed, 22 Apr 2026 06:21:30 -0700 (PDT)
Received: from [10.57.89.34] (unknown [10.57.89.34])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E8873FD46;
	Wed, 22 Apr 2026 06:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776864096; bh=SUhegrWOX2svV6mP7JpNfDMarrvi6LsYsdK7yk17+VU=;
	h=Date:From:Subject:To:References:In-Reply-To:From;
	b=JYqwc4inV6mHPq9hN6YI3+EkaNg0zntDPZFli+fquHEtjJdrWF/oJ5zhx8l8amFZt
	 75lBDJU26hCuf55I0FuvZTs90Wt0Z76/DiSrzpQgsEu2PvtFoTrgN5ba58f1cvF76i
	 /OPYInSuiknn1QL1DIDErtNh4sFAgF1KfVoDDCYk=
Message-ID: <727df89e-2069-4a7d-b3c0-88f89cd3dcf8@arm.com>
Date: Wed, 22 Apr 2026 14:21:29 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH v2 1/3] vmalloc: add __GFP_SKIP_KASAN support
To: Muhammad Usama Anjum <usama.anjum@arm.com>, Arnd Bergmann
 <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Uladzislau Rezki <urezki@gmail.com>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrey Konovalov <andreyknvl@gmail.com>, Marco Elver <elver@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Peter Collingbourne <pcc@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 david.hildenbrand@arm.com
References: <20260324132631.482520-1-usama.anjum@arm.com>
 <20260324132631.482520-2-usama.anjum@arm.com>
Content-Language: en-GB
In-Reply-To: <20260324132631.482520-2-usama.anjum@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/03/2026 13:26, Muhammad Usama Anjum wrote:
> For allocations that will be accessed only with match-all pointers
> (e.g., kernel stacks), setting tags is wasted work. If the caller
> already set __GFP_SKIP_KASAN, don’t skip zeroing the pages and
> don’t set KASAN_VMALLOC_PROT_NORMAL so kasan_unpoison_vmalloc()
> returns early without tagging.
> 
> Before this patch, __GFP_SKIP_KASAN wasn't being used with vmalloc
> APIs. So it wasn't being checked. Now its being checked and acted
> upon. Other KASAN modes are unchanged because __GFP_SKIP_KASAN isn't
> defined there.
> 
> This is a preparatory patch for optimizing kernel stack allocations.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> ---
> Changes since v1:
> - Simplify skip conditions based on the fact that __GFP_SKIP_KASAN
>   is zero in non-hw-tags mode.
> - Add __GFP_SKIP_KASAN to GFP_VMALLOC_SUPPORTED list of flags
> ---
>  mm/vmalloc.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index c607307c657a6..69ae205effb46 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3939,7 +3939,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  				__GFP_NOFAIL | __GFP_ZERO |\
>  				__GFP_NORETRY | __GFP_RETRY_MAYFAIL |\
>  				GFP_NOFS | GFP_NOIO | GFP_KERNEL_ACCOUNT |\
> -				GFP_USER | __GFP_NOLOCKDEP)
> +				GFP_USER | __GFP_NOLOCKDEP | __GFP_SKIP_KASAN)
>  
>  static gfp_t vmalloc_fix_flags(gfp_t flags)
>  {
> @@ -3980,6 +3980,8 @@ static gfp_t vmalloc_fix_flags(gfp_t flags)
>   *
>   * %__GFP_NOWARN can be used to suppress failure messages.
>   *
> + * %__GFP_SKIP_KASAN can be used to skip poisoning

You mean skip *un*poisoning, I think? But you would only want this to apply to
the actaul pages mapped by vmalloc. You wouldn't want to skip unpoisoning for
any allocated meta data; I think that is currently possible since the gfp_flags
that are passed into __vmalloc_node_range_noprof() are passed down to
__get_vm_area_node() unmdified. You probably want to explicitly ensure
__GFP_SKIP_KASAN is clear for that internal call?

> + *
>   * Can not be called from interrupt nor NMI contexts.
>   * Return: the address of the area or %NULL on failure
>   */
> @@ -4041,7 +4043,9 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
>  	 * kasan_unpoison_vmalloc().
>  	 */
>  	if (pgprot_val(prot) == pgprot_val(PAGE_KERNEL)) {
> -		if (kasan_hw_tags_enabled()) {
> +		bool skip_kasan = gfp_mask & __GFP_SKIP_KASAN;
> +
> +		if (kasan_hw_tags_enabled() && !skip_kasan) {
>  			/*
>  			 * Modify protection bits to allow tagging.
>  			 * This must be done before mapping.
> @@ -4057,7 +4061,8 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
>  		}
>  
>  		/* Take note that the mapping is PAGE_KERNEL. */
> -		kasan_flags |= KASAN_VMALLOC_PROT_NORMAL;
> +		if (!skip_kasan)
> +			kasan_flags |= KASAN_VMALLOC_PROT_NORMAL;

It's pretty ugly to use the absence of this flag to rely on
kasan_unpoison_vmalloc() not unpoisoning. Perhaps it is preferable to just not
call kasan_unpoison_vmalloc() for the skip_kasan case?

>  	}
>  
>  	/* Allocate physical pages and map them into vmalloc space. */

Perhaps something like this would work:

---8<---
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index c31a8615a8328..c340db141df57 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3979,6 +3979,8 @@ static gfp_t vmalloc_fix_flags(gfp_t flags)
  * under moderate memory pressure.
  *
  * %__GFP_NOWARN can be used to suppress failure messages.
+
+ * %__GFP_SKIP_KASAN skip unpoisoning of mapped pages (when prot=PAGE_KERNEL).
  *
  * Can not be called from interrupt nor NMI contexts.
  * Return: the address of the area or %NULL on failure
@@ -3993,6 +3995,9 @@ void *__vmalloc_node_range_noprof(unsigned long size,
unsigned long align,
 	kasan_vmalloc_flags_t kasan_flags = KASAN_VMALLOC_NONE;
 	unsigned long original_align = align;
 	unsigned int shift = PAGE_SHIFT;
+	bool skip_kasan = gfp_mask & __GFP_SKIP_KASAN;
+
+	gfp_mask &= ~__GFP_SKIP_KASAN;
  	if (WARN_ON_ONCE(!size))
 		return NULL;
@@ -4041,7 +4046,7 @@ void *__vmalloc_node_range_noprof(unsigned long size,
unsigned long align,
 	 * kasan_unpoison_vmalloc().
 	 */
 	if (pgprot_val(prot) == pgprot_val(PAGE_KERNEL)) {
-		if (kasan_hw_tags_enabled()) {
+		if (kasan_hw_tags_enabled() && !skip_kasan) {
 			/*
 			 * Modify protection bits to allow tagging.
 			 * This must be done before mapping.
@@ -4054,6 +4059,12 @@ void *__vmalloc_node_range_noprof(unsigned long size,
unsigned long align,
 			 * poisoned and zeroed by kasan_unpoison_vmalloc().
 			 */
 			gfp_mask |= __GFP_SKIP_KASAN | __GFP_SKIP_ZERO;
+		} else if (skip_kasan) {
+			/*
+			 * Skip page_alloc unpoisoning physical pages backing
+			 * VM_ALLOC mapping, as requested by caller.
+			 */
+			gfp_mask |= __GFP_SKIP_KASAN;
 		}
  		/* Take note that the mapping is PAGE_KERNEL. */
@@ -4078,7 +4089,8 @@ void *__vmalloc_node_range_noprof(unsigned long size,
unsigned long align,
 	    (gfp_mask & __GFP_SKIP_ZERO))
 		kasan_flags |= KASAN_VMALLOC_INIT;
 	/* KASAN_VMALLOC_PROT_NORMAL already set if required. */
-	area->addr = kasan_unpoison_vmalloc(area->addr, size, kasan_flags);
+	if (!skip_kasan)
+		area->addr = kasan_unpoison_vmalloc(area->addr, size, kasan_flags);
  	/*
 	 * In this function, newly allocated vm_struct has VM_UNINITIALIZED

---8<---

Thanks,
Ryan

