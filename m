Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534342F361E;
	Wed, 27 May 2026 01:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779846260; cv=none; b=AN9rIEswdWSPBU2PHYJg+JBxczJcWod1WQbXiBCCNmZay+D3+dBNYqZ/T8XHEE7AhIzkiBp/N1JCFw8U/V4OH231dQ92O7Lz08JMOCNZaYDeonS+Za435VYXm2EfRuA6kxmub3eay5fgIQnAl9NkPBFf7aSChnqhuhygiG+mWH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779846260; c=relaxed/simple;
	bh=YkqhpB2yRiNrR5OCmysL5NkRfbjm9+DobitoJx5LLaQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=geb7aZUKTErWKqdX6VtVDz0aRi8pRDNV2XZ/UPmRkDcOLoPvTPBc5tsd4IBMUeu0UsIacGEthr0EwGLDfEW4AqaYdhnYpjb+lJaleiF20nUU76ThVS9IWFazlc7rT6gPIVBCX2ZpsqQethjhaa9VV7OFb2Sf1D29JzCQAc04FZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BhuCFQ9i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BhuCFQ9i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E12211F000E9;
	Wed, 27 May 2026 01:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1779846259;
	bh=YwMQK/K0YC5t/5LwYD8hgycOymIzyP/pOWdnzfaJDUY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BhuCFQ9i5RmTYcvz3+9UJKwbl9rmgW/uXmrXQKonSFXDpwnt78VzYXfK6sXWMQDvA
	 Y4Mxf+SGcRH09Jga7eYF96NTKSYVqxrVeRxmfCwFmAiDpC99kAbXharxaDWpAxgYEX
	 pflJ2eqx3w8XlmqyQ0o6jOYOwM++hWYQkWBnET4w=
Date: Tue, 26 May 2026 18:44:17 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Lance Yang
 <lance.yang@linux.dev>, david@kernel.org, dave.hansen@linux.intel.com,
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
 linux-kernel@vger.kernel.org, ioworker0@gmail.com
Subject: Re: [PATCH 7.2 v10 1/2] mm/mmu_gather: prepare to skip redundant
 sync IPIs
Message-Id: <20260526184417.a4de7beb76bce85d7597b676@linux-foundation.org>
In-Reply-To: <f437455d-1598-483d-9dcf-1932d265ef3f@intel.com>
References: <20260424062528.71951-1-lance.yang@linux.dev>
	<20260424062528.71951-2-lance.yang@linux.dev>
	<20260424150454.GF3126523@noisy.programming.kicks-ass.net>
	<f437455d-1598-483d-9dcf-1932d265ef3f@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Apr 2026 08:52:16 -0700 Dave Hansen <dave.hansen@intel.com> wrote:

> On 4/24/26 08:04, Peter Zijlstra wrote:
> > So I don't like this at all.... The comment says there is a preceding
> > TLB flush, but there is nothing that guarantees there is. One would have
> > to go audit all users and ensure this is always true.
> > 
> > This thing is incredibly fragile.
> 
> Yeah, this seems like an attempt to apply a code solution to a data
> structure problem.
> 
> I think I talked about this in earlier iterations. But, ideally, what
> happens here is that the things doing the table freeing or collapsing or
> whatever would note in a data structure what they did.
> 
> Then the actual flushing code can look at the data structure and figure
> out what kind of flush it needs. Things like "do I need to flush on lazy
> CPUs?" Or, "have I done an IPI since the last page table free?"
> 
> But, if I remember from earlier in this thread, some of the callers of
> this stuff didn't have a nice data structure (like an mmu_gather) passed
> in to the places where it would be needed to exfiltrate the information.
> 
> I think Lance gave up on that because it looked too invasive to him.
> 
> But, I think this boils down to the code being too fragile as-is to
> support what Lance is trying to do. It actually needs some refactoring
> love before it can support the desired optimization. I'm not sure
> there's an easy way out here.

Well this is a bummer.  Looky:

> On a 64-core Intel x86 server, the CAL interrupt count in
> /proc/interrupts dropped from 646,316 to 785 when collapsing a 20 GiB
> range with this series applied.

It would have been nice.

Oh well, it's been a month with no progress so this patchset appears to
be before its time.  Thanks all, I'll drop this from the 7.1 queue.

(otoh, "a month with no progress" == "decently tested")!

