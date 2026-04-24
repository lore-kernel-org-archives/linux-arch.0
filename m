Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFC8364023;
	Fri, 24 Apr 2026 19:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777057321; cv=none; b=Lsqb8ob/obuXTZqAOipbXD1f2ZDTg+xV+HuGB14ckr/XB8x1VPOvoYC37iISqUe7i8+4o7HtF38V5/Q8vyi8hfiQZibq6gsbss3SFoRZ9w3WhSA1nYQzVW0NG8U3TxP9W7bydba9ECvb5ljZWnB5HH0LiEfW+1s4gcYe25PbMBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777057321; c=relaxed/simple;
	bh=qXXPhIB0sL9TCVVBti/PLOD4VulXmM4RrN7ox2Cw8JM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNHn03PFwM8caPLopoaAr1fYbDoMkhiYkNFVTIvgFKCJOFxRAT6Ko5xApcsSejvz/lDeslEdQhOGRaOdmH4Ncj1uuHrzY5gokC7bTTVo/bRr6RBxQf2L4fMhvdwU6WdsLf8lKT2XhKY0JsTor/G4Bk0N1QDSenY90p20ksSfu2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iBXOAcq5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iBXOAcq5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qXXPhIB0sL9TCVVBti/PLOD4VulXmM4RrN7ox2Cw8JM=; b=iBXOAcq54PklkFMQVTXPK7sgiS
	h+ozXVaSzR3kNof5rtS70uCRPVLWxdrU91OeILCZjWSikajxROUfVFhAt4h4Fk8xev1J3hJkoDq0R
	bBjGkp/fQSpDHNocIILF0xWu7gO7Bi3zJ1o2cr0lKkwxwO3hbPspsz4H0Vr7shRGdUpk6/TEhm3G3
	HG/zaOaBUgiTHVjKONV37n+RkB+KSmPliyu6RRYec7HGGWjUxmpQO4o7m2vFwHDzXy000LFvV2Xbu
	+dcyqBKtgSU0PetS5UvBj0k9yRGY4G8ULhSIJxJiPV2Pq7ZwXMFsrbRDGq0Drb0wAM0hyGKX6SwiK
	/1xg61yA==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGLmZ-0000000FfiV-2WUs;
	Fri, 24 Apr 2026 19:01:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0D4E7301142; Fri, 24 Apr 2026 21:01:42 +0200 (CEST)
Date: Fri, 24 Apr 2026 21:01:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Yosry Ahmed <yosry@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Lance Yang <lance.yang@linux.dev>, dave.hansen@intel.com,
	dave.hansen@linux.intel.com, ypodemsk@redhat.com, hughd@google.com,
	will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
	hpa@zytor.com, arnd@arndb.de, ljs@kernel.org, ziy@nvidia.com,
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
	baohua@kernel.org, shy828301@gmail.com, riel@surriel.com,
	jannh@google.com, jgross@suse.com, seanjc@google.com,
	pbonzini@redhat.com, boris.ostrovsky@oracle.com,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, ioworker0@gmail.com,
	roman.gushchin@linux.dev
Subject: Re: [PATCH 7.2 v10 0/2] skip redundant sync IPIs when TLB flush sent
 them
Message-ID: <20260424190141.GA3783056@noisy.programming.kicks-ass.net>
References: <20260424062528.71951-1-lance.yang@linux.dev>
 <20260424063024.ce42ee6a5546e4d9337dd007@linux-foundation.org>
 <aetw4aoABYj3keMh@plex>
 <20260424071533.d28ce90126f05e1c6fc1b740@linux-foundation.org>
 <80ab39c2-efb9-4a23-bd56-46d9bb4e41bb@kernel.org>
 <20260424073145.b990fe9b925da304508aad71@linux-foundation.org>
 <644e65dc-3d39-4137-b51f-51d953b67d50@kernel.org>
 <CAO9r8zN1pRfyC0Rh+UdW-Lsret=z3oveT3=gnZftX-Sr_ubyyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9r8zN1pRfyC0Rh+UdW-Lsret=z3oveT3=gnZftX-Sr_ubyyQ@mail.gmail.com>

On Fri, Apr 24, 2026 at 11:50:03AM -0700, Yosry Ahmed wrote:

> But I imagine it's useful for reviewers to see Sashiko's feedback as
> well (without having to go look on the website).

That's why I have a script; if I press 'S' in mutt on an 0/n email, said
script goes and does webrequest to sashiko and inserts the review
comments into my local maildir as properly threaded replies to the
series at hand.

No looking at website needed.
