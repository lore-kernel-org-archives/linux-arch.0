Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF2217BED0;
	Wed, 22 Apr 2026 13:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776864682; cv=none; b=bhW3IBBEUbURPp9i7yhKEsLPj4QCsG9mMvqCS/OOi6eurFFvYZbhQwUujlqE+Stcj/yknF+VKR2X8ZIJ7sVRBr636fS1AkH+/qj1S+p1zCfoVShOIexdkUQj1ZIRWuH5kcy4nrmc4//BnJCSbU1bQCBKFxDMruJNGDGnVSZcljE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776864682; c=relaxed/simple;
	bh=Top9vudgGbwsB9gdK8pkIXSaPiG3wHdOl/KtxsTBaBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZzYAsAVfDM8pJhASxmxK4QSzSUz7rdsIQ01j71Tj94CLoPLQc9cL/Ik8OanogIhT9FiWz9Ahyjjp8uZdP5D9t2FEBX1d/z9+6B3rM0PkOm2CyIy37M4yDucELAlQPhSD01vXZA/2nthT0TXDvV9wsco9HTxI5gooQOqd9Tnu6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZI7EFTOO; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZI7EFTOO"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FCA11E2F;
	Wed, 22 Apr 2026 06:31:14 -0700 (PDT)
Received: from [10.57.89.34] (unknown [10.57.89.34])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D68F73FBD2;
	Wed, 22 Apr 2026 06:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776864679; bh=Top9vudgGbwsB9gdK8pkIXSaPiG3wHdOl/KtxsTBaBk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZI7EFTOOAO8ZKkCeexRr92Fur05p/Z9cynlOaN/iWBeDk8x0fJPzRCDExPChxCMoZ
	 jEycCoKb1uE9rzLTIdc0gQxIUZlTrxOv0LX3BRkzLxWwKLd18J4Q6N1vrnGuFQnmU5
	 Fp+w6T9cD3Ci3CgJZm2gKcUgGBqrSGovqraV9HFE=
Message-ID: <e881c79a-fe7c-46b1-a518-febf7a278cc9@arm.com>
Date: Wed, 22 Apr 2026 14:31:14 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] kasan: skip HW tagging for all kernel thread
 stacks
Content-Language: en-GB
To: Catalin Marinas <catalin.marinas@arm.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@arm.com>, Arnd Bergmann
 <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Uladzislau Rezki <urezki@gmail.com>,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Andrey Konovalov <andreyknvl@gmail.com>,
 Marco Elver <elver@google.com>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, Peter Collingbourne <pcc@google.com>,
 Will Deacon <will@kernel.org>, david.hildenbrand@arm.com
References: <20260324132631.482520-1-usama.anjum@arm.com>
 <20260324132631.482520-3-usama.anjum@arm.com> <adlCN9sUcQdWbf_i@arm.com>
 <adlDSiuBeSduK0mj@arm.com> <aa7c5a29-c8f7-48aa-b0a0-ed147d29fde4@kernel.org>
 <aeHvzh3A0eC-tds9@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <aeHvzh3A0eC-tds9@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/04/2026 09:31, Catalin Marinas wrote:
> On Thu, Apr 16, 2026 at 11:03:46AM +0200, David Hildenbrand wrote:
>> On 4/10/26 20:36, Catalin Marinas wrote:
>>> On Fri, Apr 10, 2026 at 07:32:23PM +0100, Catalin Marinas wrote:
>>>> What the original approach might help with is use-after-realloc in case
>>>> we had a tagged pointer in a past life of a page and it still works now.
>>>> Oh well, that's I guess for other types of hardening to address like
>>>> delayed reallocation.
>>>
>>> Another thought (for a separate series) - we could try to map the stack
>>> as Untagged (unless stack tagging is enabled; needs compiler
>>> instrumentation) and enable canonical tag checking (newer addition to
>>> MTE). This way, any stray tagged pointer won't work on the stack since
>>> it needs a 0xf tag (canonical).
>>
>> Do you mean mapping it as Untagged in the vmap for CONFIG_VMAP_STACK or
>> also as Untagged in the directmap?
>>
>> The latter brings in the set of problems with direct map fragmentation.
> 
> Just the vmap, there are a lot more problems with the direct map. Not
> sure how much it does in terms of security, maybe marginally. A
> match-all tag (0xf) would still be able to access the canonically tagged
> memory.
> 

I think with the first patch in this series, we are alredy vmapping the stack
memory as untagged, right? vmalloc only calls arch_vmap_pgprot_tagged() if we
are not skipping kasan. So I think we already have this protection? (perhaps we
need to explicitly enable the canonical tag checks?)

Thanks,
Ryan

