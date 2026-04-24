Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CA82153D8;
	Fri, 24 Apr 2026 14:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777041107; cv=none; b=Qprjc0KEus0CUm4/byVd0ponr/e6z5iCR0aJe8krrnLsSm4OcOfX+J9iqIPirl81d67WtxwwEyePoJ0LNSlgBtXYmpJSK23meBPec4zaTQOIiRZcf1mQNnX4+4cV21T09pp1l2hzBrYjZOeGHXe9M1ii1r6XOZOLjMV81RZEzpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777041107; c=relaxed/simple;
	bh=Ibnzz/auXz3+3udo78jueXIEYRqia08WwlRydX0v9S4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=e6stwAlPe5OZKlTV/RPPdHn284xg8C1mlFZLGCUObdXs+LPT2kY2jTx/D1GruHJVyvJHqDGDaWMbt2zcZGl50DiB1D/N3UOHCXv1D3KeRdLuQRJrutw6D+y+U4rWQDRbXZXF+FN2aoyqH9Dk+NKV2+2efE9UqGX4TVllW3ObyLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IQ24m45K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IQ24m45K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB04DC19425;
	Fri, 24 Apr 2026 14:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777041106;
	bh=Ibnzz/auXz3+3udo78jueXIEYRqia08WwlRydX0v9S4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IQ24m45K2Eibx5mWePKXhBUaJIgB7Zc/UcWu4uQMq3XKGP9ldhs3xDFTn0YhGXB7c
	 YSxHUXD162ct8HxKUG9AJgyJLPDB7d/OpWlSS1RR1stCDdFF/KiUarnzrmrDFSkOUp
	 ryowEUP3rFQPzIO3fQX1oM3yNTtsmrc8LZugGWZ8=
Date: Fri, 24 Apr 2026 07:31:45 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Lance Yang
 <lance.yang@linux.dev>, peterz@infradead.org, dave.hansen@intel.com,
 dave.hansen@linux.intel.com, ypodemsk@redhat.com, hughd@google.com,
 will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
 hpa@zytor.com, arnd@arndb.de, ljs@kernel.org, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 shy828301@gmail.com, riel@surriel.com, jannh@google.com, jgross@suse.com,
 seanjc@google.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, ioworker0@gmail.com, roman.gushchin@linux.dev
Subject: Re: [PATCH 7.2 v10 0/2] skip redundant sync IPIs when TLB flush
 sent them
Message-Id: <20260424073145.b990fe9b925da304508aad71@linux-foundation.org>
In-Reply-To: <80ab39c2-efb9-4a23-bd56-46d9bb4e41bb@kernel.org>
References: <20260424062528.71951-1-lance.yang@linux.dev>
	<20260424063024.ce42ee6a5546e4d9337dd007@linux-foundation.org>
	<aetw4aoABYj3keMh@plex>
	<20260424071533.d28ce90126f05e1c6fc1b740@linux-foundation.org>
	<80ab39c2-efb9-4a23-bd56-46d9bb4e41bb@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Apr 2026 16:20:55 +0200 "David Hildenbrand (Arm)" <david@kernel.org> wrote:

> On 4/24/26 16:15, Andrew Morton wrote:
> > On Fri, 24 Apr 2026 13:37:04 +0000 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> > 
> >> On 04-24 06:30, Andrew Morton wrote:
> >>>
> >>>
> >>> Sashiko questions:
> >>> 	https://sashiko.dev/#/patchset/20260424062528.71951-1-lance.yang@linux.dev
> >>>
> >>> (I never know if my Sashiko emails are welcome/useful.  Maybe Sashiko
> >>> said the same stuff about v9 and it's all wrong.  But better safe than
> >>> sorry!)
> >>
> >> These emails are helpful; but, I do not believe you should have to 
> >> manually follow up with a link to every new patch series.
> >>
> >> Perhaps  Sashiko could automatically send a summary email in response to 
> >> the cover letter, or provide a link once the reviews are complete. For 
> >> the kexec ML, we opted-in with Roman to receive automated emails from 
> >> sashiko.
> > 
> > Yep.  I'd be OK with an automatic reply-to-all.  Maybe some won't like
> > that.
> > 
> > An alternative I've discussed with Roman is an automated
> > reply-to-author with a cc to a dedicated list (we could use mm-commits
> > for now).
> > 
> > Preferences?
> 
> Reply-to-author would likely be better as a first step.

Why do you think so?

Pasha, is it too early to determine how reply-to-all is working out for
kexec?
