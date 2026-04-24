Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E7B3EFD05;
	Fri, 24 Apr 2026 19:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777057716; cv=none; b=D2Z6Is+W5A3At2ngvF2yEVSc7ntgWkPrrd+lFY6nfaFJzfc0sk8s3FAPOAMlPpZCz0jz9nbUEzffqOmrlo6fkm/dNt4HyPJhCLFvfAQjdOMp2C6zpwBcisIP6pDVhGV/quKZTGdSxS0x5dI4ZjdPdFY3a6kmg5NOuHAE+4V48Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777057716; c=relaxed/simple;
	bh=NIslsik2bfMFifVngfMjs60MjOCxmWpxVeRk5iyfLnI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SoFzG96x6g5HFnH0CZ2SaXOm6g0nYniy6HOiXADcmRxVyY9C6OAEHoBpHCRZfZE7m5EmTLCbPSH3byHYU9jzkxsiUrm3SCiqxLO592UUSJI0A8S3gk4/FrXMWC7XB9ouYiF2iqod/1wn/Vly+5alN99DyFB+f7XNvvzrwYvaGFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=o+YeHDZt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="o+YeHDZt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87502C19425;
	Fri, 24 Apr 2026 19:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777057715;
	bh=NIslsik2bfMFifVngfMjs60MjOCxmWpxVeRk5iyfLnI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o+YeHDZtlw2/jrwRhrBGxNaIXgAE2Oyte35CJEGmKkM0xU8Lj7cjnshAiz4uj4LaQ
	 b6Im1fEwd/7w5TXPO9uSQ4oqSCNMSqnhw6xcDqjbDUCVbxyoecZUxOprgzPAq5Cstm
	 v6ODDyYliLGfiHysiDbE44Ndo58RVlZJ6NXIBY3c=
Date: Fri, 24 Apr 2026 12:08:33 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yosry Ahmed <yosry@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Pasha Tatashin
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
Message-Id: <20260424120833.130df9049a1533396f608c8e@linux-foundation.org>
In-Reply-To: <CAO9r8zN1pRfyC0Rh+UdW-Lsret=z3oveT3=gnZftX-Sr_ubyyQ@mail.gmail.com>
References: <20260424062528.71951-1-lance.yang@linux.dev>
	<20260424063024.ce42ee6a5546e4d9337dd007@linux-foundation.org>
	<aetw4aoABYj3keMh@plex>
	<20260424071533.d28ce90126f05e1c6fc1b740@linux-foundation.org>
	<80ab39c2-efb9-4a23-bd56-46d9bb4e41bb@kernel.org>
	<20260424073145.b990fe9b925da304508aad71@linux-foundation.org>
	<644e65dc-3d39-4137-b51f-51d953b67d50@kernel.org>
	<CAO9r8zN1pRfyC0Rh+UdW-Lsret=z3oveT3=gnZftX-Sr_ubyyQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Apr 2026 11:50:03 -0700 Yosry Ahmed <yosry@kernel.org> wrote:

> > >>> Preferences?
> > >>
> > >> Reply-to-author would likely be better as a first step.
> > >
> > > Why do you think so?
> >
> > The most important part for me is that authors are aware of the reports.
> >
> > Sending them as a mail forces people to publicly reply to the feedback, and at
> > this point in time, I am not convinced that that is the right approach.
> 
> But I imagine it's useful for reviewers to see Sashiko's feedback as
> well (without having to go look on the website). It's possible that
> Sashiko is right but the author isn't convinced, so getting more eyes
> on the feedback would help. If Sashiko is wrong, it's still useful for
> more people to see it and point it out, instead of Sashiko privately
> misguiding the author, especially that reviewers are probably more
> likely to tell if Sashiko is right or wrong.

Also, Sashiko does like to find unrelated bugs in surrounding code.  I
saw two of these today.

But whatever, one step at a time.  My main interest at present is to
stop having to send lame emails linking to the Sashiko reports!
