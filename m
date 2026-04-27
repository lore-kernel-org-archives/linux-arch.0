Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219273A6F12;
	Mon, 27 Apr 2026 08:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777280044; cv=none; b=BaLNcAg79PAqRvEfXABccMQSF2WDCl1mwe0SS29LoNMmuv0y/rNy1BJ2X54U/2FcrTLsQrGOc0gIJXGjhar0VIWj+XHcD1VbgPZzFoRTxV5OoR1WVaDUsfkWo3c/6TDzwiA9R1isPegYR0MBQiaIgq786ERFFDnpQv1bvFsiT0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777280044; c=relaxed/simple;
	bh=PtRJvasZkHp+/95b/vL94bJzCcFOTEky3Sgd0xF9RXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DvHZh7r/H2jbxeVhVyQOKruJ5rc+vPkkjzjCQSNaTPvEtAdx/5d3stnkIjRbw0Q5XwKYIV6Vl6+ywBNa2RIJKDR7u39Wnlci30zokNfzVSuRP1z+DensFDkJyGpQxgP2W27MgEVlJwcn0oPbftY0s5PWQGfCS4kjODCWrS5dJ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGvBru2d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGvBru2d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2484C2BCB4;
	Mon, 27 Apr 2026 08:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777280043;
	bh=PtRJvasZkHp+/95b/vL94bJzCcFOTEky3Sgd0xF9RXI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eGvBru2du1vkxSlCwhoF5+RD25f8/jipUj6nJW3i8PK5u+iKtE7HMW4CEIMfpJtrF
	 t4vlM7yBSyANHHK9oRs+WpteFmnxx/pY4CiWv2DvIRdTy7NH8l6iqSU8uulGfHZpnu
	 jHoCRsWLXcqMqU4MduvgenOdiT/Cz29l0WB7QwvIYnmuwerweo6WsOX1D/t6HScKtB
	 xDrzEAavdqmEUyIYWUdKfkt4CbM+X/LhV88K1eNzOciCn6RzLjtRBAvgvz42689kfS
	 bXHpum7jsoE+AHM0nJhJ6FT/Xi+ixk3KV8+2mqOOQcsIOlVaZm5DUUZjKYPPLK82t1
	 TphzYQf1VbVDA==
Message-ID: <9b02dc87-15e3-4f6b-af53-aeb1b3ef01e1@kernel.org>
Date: Mon, 27 Apr 2026 10:53:49 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.2 v10 0/2] skip redundant sync IPIs when TLB flush sent
 them
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry@kernel.org>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Lance Yang <lance.yang@linux.dev>,
 peterz@infradead.org, dave.hansen@intel.com, dave.hansen@linux.intel.com,
 ypodemsk@redhat.com, hughd@google.com, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
 arnd@arndb.de, ljs@kernel.org, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 shy828301@gmail.com, riel@surriel.com, jannh@google.com, jgross@suse.com,
 seanjc@google.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, ioworker0@gmail.com, roman.gushchin@linux.dev
References: <20260424062528.71951-1-lance.yang@linux.dev>
 <20260424063024.ce42ee6a5546e4d9337dd007@linux-foundation.org>
 <aetw4aoABYj3keMh@plex>
 <20260424071533.d28ce90126f05e1c6fc1b740@linux-foundation.org>
 <80ab39c2-efb9-4a23-bd56-46d9bb4e41bb@kernel.org>
 <20260424073145.b990fe9b925da304508aad71@linux-foundation.org>
 <644e65dc-3d39-4137-b51f-51d953b67d50@kernel.org>
 <CAO9r8zN1pRfyC0Rh+UdW-Lsret=z3oveT3=gnZftX-Sr_ubyyQ@mail.gmail.com>
 <4e7699eb-e101-4a25-b585-79a777eb7cc2@kernel.org>
 <CAO9r8zO4eSiAK9U-ijzWJMK80XsK+LmFxGAG+nTo+tmK6aLfYA@mail.gmail.com>
 <872e752d-c7fa-4a75-a963-4e2f42ce468b@kernel.org>
 <20260425043605.a3a1819fb219c649eab0f3a1@linux-foundation.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260425043605.a3a1819fb219c649eab0f3a1@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/25/26 13:36, Andrew Morton wrote:
> On Sat, 25 Apr 2026 07:17:18 +0200 "David Hildenbrand (Arm)" <david@kernel.org> wrote:
> 
>>> The usefulness of the mailing list posting is that it makes it easier
>>> to respond and discuss the review. Yes, what Zi did is great, but it
>>> would be nice if contributors/reviewers didn't need to manually quote
>>> Sashiko.
>>
>> I think the most important part is the contributor side. A private posting is
>> sufficient for that.
> 
> Thinking through how is this going to work out.
> 
> - contributor sends patchset
> 
> - akpm looks at the Sashiko scan and thinks "huh, we might be seeing
>   a new version soon".
> 
> - Now what?  Maybe contributor doesn't like AI, maybe contributor
>   thinks it was all nonsense.  But I don't know this!

Right. In the common case, people will just read the output and process it in a
reasonable way, like some people do today even without any notification.

But there will be cases where people ignore it, I am sure.

> 
>   So I send the email "I see that Sashiko said stuff - can we expect
>   a new version?".  Which is no improvement over what's happening now.

That only happens in the scenarios where there is no further feedback from other
reviewers and there won't be a new revision.

That's why I am saying that the AI review on the last upstream posting before
merging is the most important one from a maintainer perspective.

I agree that when we are about to merge something and AI review was not
addressed (no feedback from contributor), that it's a problem.

> 
> What I would like to have is some reasonably reliable and prompt means
> by which we all learn contributor's views on the Sashiko scan. 

Right. At the same time I don't want full AI review posted to the mailing list
immediately to each and every revision of a patch set.


As  first step, I would be fine with having AI review send a review status in
case it went into a problem to everyone as reply to each patch set, just stating
whether it failed to apply, or if something was found etc. Paired with a link
like you would send.

> 
> One way to bring this about might be to set suitable reply-to headers
> in the Sashiko->contributor email, along with a few words asking
> contributor to let everyone know the status.

Yes, that's an alternative if we were to send the full AI review to
contributors. Which might make sense in addition to the AI review status (above).

> 
> But whatever - let's not overthink this.  To start somewhere, let's
> send that private email, spend a few weeks evaluating then perhaps make
> adjustments.

Right, let's do this step by step.

-- 
Cheers,

David
