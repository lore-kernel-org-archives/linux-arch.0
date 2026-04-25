Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680F036604F;
	Sat, 25 Apr 2026 11:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777116967; cv=none; b=fEeer+5HPLtD2YAitvLNL3b91Yc2/Ro2K/3YD7tSqDzX58Bf5Yd0bdcMnhnUH8fZerTjqmYS38ORFf075Kp6L4xskwBfXGze1rzqLOpCau+Mkuc1uimjzlhciD3G7t0q/aEeCnVxuD/VNWgOMOrcgSiGZxOWMa9anAMV85b3FPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777116967; c=relaxed/simple;
	bh=+hCqOamL0vTewGf5qbkEKRyELe5agUwAhP+vk48QZYA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QqZ076lsIAhFnT0n38HC1QvQvBdQthjee5c72uhIRfraQUzn1gvHUJ1GZMkVQu5GJvGCNUJz3r9spaGo69nXwZ6AgrGyc/DnINe/jvaYN/9uLlP18L4CBsRIRJ4e7+Kgc1Uk0FfpfeuhZaY71Q0uL/ObTnsznN57rA3iIOvi3Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VnDWnThi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VnDWnThi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F8FC2BCB0;
	Sat, 25 Apr 2026 11:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777116967;
	bh=+hCqOamL0vTewGf5qbkEKRyELe5agUwAhP+vk48QZYA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VnDWnThi7x8C/ChyqkphLKT4CN2qhjn4bgVZRT3thU06/8VKJp4TXxTLKdd3W+/gI
	 lwBurUwV1KTJLClJZCp62a4VPQyRP74hQNi50rzs+q3ioi2wUC6M6N4Cy28yLlKsn/
	 tf044FWTbVqbl6W02n8H+OfPCTeQdT3tULq6Wgbg=
Date: Sat, 25 Apr 2026 04:36:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
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
Subject: Re: [PATCH 7.2 v10 0/2] skip redundant sync IPIs when TLB flush
 sent them
Message-Id: <20260425043605.a3a1819fb219c649eab0f3a1@linux-foundation.org>
In-Reply-To: <872e752d-c7fa-4a75-a963-4e2f42ce468b@kernel.org>
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
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Apr 2026 07:17:18 +0200 "David Hildenbrand (Arm)" <david@kernel.org> wrote:

> > The usefulness of the mailing list posting is that it makes it easier
> > to respond and discuss the review. Yes, what Zi did is great, but it
> > would be nice if contributors/reviewers didn't need to manually quote
> > Sashiko.
> 
> I think the most important part is the contributor side. A private posting is
> sufficient for that.

Thinking through how is this going to work out.

- contributor sends patchset

- akpm looks at the Sashiko scan and thinks "huh, we might be seeing
  a new version soon".

- Now what?  Maybe contributor doesn't like AI, maybe contributor
  thinks it was all nonsense.  But I don't know this!

  So I send the email "I see that Sashiko said stuff - can we expect
  a new version?".  Which is no improvement over what's happening now.


What I would like to have is some reasonably reliable and prompt means
by which we all learn contributor's views on the Sashiko scan. 

One way to bring this about might be to set suitable reply-to headers
in the Sashiko->contributor email, along with a few words asking
contributor to let everyone know the status.

But whatever - let's not overthink this.  To start somewhere, let's
send that private email, spend a few weeks evaluating then perhaps make
adjustments.
