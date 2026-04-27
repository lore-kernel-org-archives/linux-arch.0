Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C476739183C;
	Mon, 27 Apr 2026 03:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777261847; cv=none; b=YxMuYvAvX/9eM81VaP9Q1u+ysv818XE4Dg8hUTVeuXeDmOc1Kn+dnuOmHbDWFp4hFO/wCaMIDt4cB3OwbbZCCTsOHQBCZUHMVUN47AIBjaJQ6omlR7DXRkkkuFGsIQcBNLP1K8zYxS8Ul/0dXu5PlnMR34Ex6FUx68968IsogDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777261847; c=relaxed/simple;
	bh=zkxFhlZxuv8BWG3mAtIzF1LABWxJnsl71a2G+oo7Zxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fGlosxOrGi9ikb9ghreXEUPQ3DR4rYrToLwYLsq4OCuGfKXvy+XtGl+dfVhjfmIDfm7IvUKyXJsOIu7dYg98c2Pnorw2QdqfbefuOGzLyR4bCrg2j6pJXreMz9pf2bBhO/Db3QMeSw8PoUuZJbd5V+PdxLcs5vKbsqgunw5ws6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=aAOLkdyl; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="aAOLkdyl"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95D8D1684;
	Sun, 26 Apr 2026 20:50:38 -0700 (PDT)
Received: from [10.164.148.37] (MacBook-Pro.blr.arm.com [10.164.148.37])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C438E3F763;
	Sun, 26 Apr 2026 20:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777261844; bh=zkxFhlZxuv8BWG3mAtIzF1LABWxJnsl71a2G+oo7Zxc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aAOLkdylAOs7Gx/pumsYaXDaFDsWQDPbx2TdX4oJAkjfwD+s/6Jpa+fLZYDcw68uR
	 3JuZJqe3PM8qoQ4triJ0mxt0kW+Vjh0p8LlkdSIMhJ3Ey2SqNlW4725ckmevNH3Ifb
	 XKXQ8oCjBmkldnOry7jn9ShllEB7nnhRoGiwKgCc=
Message-ID: <e9e3f1f1-44bf-457a-ab1c-37a772ab8444@arm.com>
Date: Mon, 27 Apr 2026 09:20:32 +0530
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] mm: skip KASAN tagging for page-allocated page
 tables
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: arnd@arndb.de, kees@kernel.org, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 akpm@linux-foundation.org, david@kernel.org, urezki@gmail.com,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, ljs@kernel.org,
 Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, tglx@kernel.org, usama.anjum@arm.com,
 mathieu.desnoyers@efficios.com, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Ryan Roberts <ryan.roberts@arm.com>
References: <20260424130157.3163009-1-dev.jain@arm.com>
 <20260424130157.3163009-4-dev.jain@arm.com> <aeurLGC4ohFU9Xtn@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <aeurLGC4ohFU9Xtn@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 24/04/26 11:11 pm, Catalin Marinas wrote:
> On Fri, Apr 24, 2026 at 06:31:57PM +0530, Dev Jain wrote:
>> From: Muhammad Usama Anjum <usama.anjum@arm.com>
>>
>> Page tables are always accessed via the linear mapping with a match-all
>> tag, so HW-tag KASAN never checks them. For page-allocated tables (PTEs
>> and PGDs etc), avoid the tag setup and poisoning overhead by using
>> __GFP_SKIP_KASAN. SLUB-backed page tables are unchanged for now. (They
>> aren't widely used and require more SLUB related skip logic. Leave it
>> later.)
>>
>> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
>> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> Your signed-off-by is missing. You must add it if you are reposting
> someone else's patches.

Okay I read submitting-patches properly and didn't know we should
add SOB even if we are sending it as it is ...

"Any further SoBs (Signed-off-by:'s) following the author's SoB are from
people handling and transporting the patch, but were not involved in its
development. SoB chains should reflect the **real** route a patch took
as it was propagated to the maintainers and ultimately to Linus, with
the first SoB entry signalling primary authorship of a single author."

So I'll re-order the tags as

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Signed-off-by: Dev Jain <dev.jain@arm.com>

> 
> Also I only got cc'ed on patch 3. You should normally cc all people on
> all patches. Maybe you could skip this if the patches are some
> independent cleanups but even so, I'd still cc all the others at least
> on the cover letter.

Oops didn't realize my script was not taking a union of the result of
get_maintainer on each patch. I'll fix that.
> 

