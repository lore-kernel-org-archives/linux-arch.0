Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0FC1F16B;
	Sat, 25 Apr 2026 01:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777079554; cv=none; b=Y7hyr1YUxOvEv7ZxZopnuMMko/sbop5Ejl+ygF/e8se7N+zpQwPvDEKRHTDa5hgnYKxmJGYkwAcXuP2qr1+XxfluAibUNaCJmgi+ShIMcVljc8hsCoFQOAR9n8WIzvVVoHAb74UB2fHO5goiDQk0KlLqb8vqtL0t3h39JtsaXiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777079554; c=relaxed/simple;
	bh=kLGofZVDjG/mCzrm1LRRVMOEwwqZ3rDNeHAHTirfbaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ATC/4v93D4Rj6bqs7ZAzVqD3Fsw3T18rWWNFahs2S55dO0IvYDNAIop5xJiDf0QuxaUp86HF0IaS1n0jk3FVn1XBlbNOHyY4Y6eCe+YLpX+x0svUbP/Oo4ZEqdpGu2s6ryMYxFgEYG4Oqt/yTmJbvq1+cfAYtzUOLbe2bVDaHSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrRUtSPb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrRUtSPb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D479C2BCB2;
	Sat, 25 Apr 2026 01:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777079554;
	bh=kLGofZVDjG/mCzrm1LRRVMOEwwqZ3rDNeHAHTirfbaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DrRUtSPbpCYF9NFEliEIjHHeYQcZ66l1VWvOXUU8wfQAq5VLZuRqmfsSGZbBfEVhr
	 ElLh2ilGqlOTwJ2VXwXW4hqCPW3axHoWKImRIWkIApx0GIqQUbK3iuAoOvXKr4hurG
	 LkxowpnzN/tZFyA0UmYmFy6Gym+yJC0tOuZHMJls2H+E95YRt3OS5O6b/wXgjkM+OV
	 jY6rXzHRtx8T4iTgkd7MgWE3AmzuAqW034nBcXgAGsXq53YbpqtwXofjq0oM7/4FiO
	 563qADLY2NVkI1knPbVwA1zM45NLL50cqB7IZeuZWN/uo1JdJaR3Pny7SZW9J2LXlo
	 QKU/bwYk0cYag==
From: SeongJae Park <sj@kernel.org>
To: Yosry Ahmed <yosry@kernel.org>
Cc: SeongJae Park <sj@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Lance Yang <lance.yang@linux.dev>,
	peterz@infradead.org,
	dave.hansen@intel.com,
	dave.hansen@linux.intel.com,
	ypodemsk@redhat.com,
	hughd@google.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de,
	ljs@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	shy828301@gmail.com,
	riel@surriel.com,
	jannh@google.com,
	jgross@suse.com,
	seanjc@google.com,
	pbonzini@redhat.com,
	boris.ostrovsky@oracle.com,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ioworker0@gmail.com,
	roman.gushchin@linux.dev
Subject: Re: [PATCH 7.2 v10 0/2] skip redundant sync IPIs when TLB flush sent them
Date: Fri, 24 Apr 2026 18:12:22 -0700
Message-ID: <20260425011223.85854-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAO9r8zO4eSiAK9U-ijzWJMK80XsK+LmFxGAG+nTo+tmK6aLfYA@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 24 Apr 2026 12:18:49 -0700 Yosry Ahmed <yosry@kernel.org> wrote:

> On Fri, Apr 24, 2026 at 12:09 PM David Hildenbrand (Arm)
> <david@kernel.org> wrote:
> >
> > On 4/24/26 20:50, Yosry Ahmed wrote:
> > > On Fri, Apr 24, 2026 at 11:36 AM David Hildenbrand (Arm)
> > > <david@kernel.org> wrote:
> > >>
> > >> On 4/24/26 16:31, Andrew Morton wrote:
> > >>>
> > >>>
> > >>> Why do you think so?
> > >>
> > >> The most important part for me is that authors are aware of the reports.
> > >>
> > >> Sending them as a mail forces people to publicly reply to the feedback, and at
> > >> this point in time, I am not convinced that that is the right approach.
> > >
> > > But I imagine it's useful for reviewers to see Sashiko's feedback as
> > > well (without having to go look on the website).
> >
> > I read a lot of them, yes. Maintainers know how to find it.
> >
> > I even think maintainers should  briefly go over it before applying to spot if
> > anything in there is still left unanswered. But that doesn't need a mailing list
> > posting.
> >
> > I enjoy if contributors are aware of the reports and use that input in a
> > reasonable, like Zi just did [1]. And if they are unsure, they usually ask to
> > double-check.
> >
> > [1] https://lore.kernel.org/r/15191F7F-0D10-4907-B963-DA4EA0E36EB6@nvidia.com
> >
> > > It's possible that
> > > Sashiko is right but the author isn't convinced, so getting more eyes
> > > on the feedback would help.
> >
> > Forcing contributors to reply to everything. I don't like that, in particular
> > not as long as there is no way for contributors to run it early in private.
> >
> > In most cases, contributors just do the reasonable thing: incorporate the
> > feedback in a new version.
> 
> The usefulness of the mailing list posting is that it makes it easier
> to respond and discuss the review. Yes, what Zi did is great, but it
> would be nice if contributors/reviewers didn't need to manually quote
> Sashiko.

I agree.  I had to implement hkml-Sashiko integration [1] to avoid the manual
works.  People could use such existign tools or develop their own.  But I can
say Sashiko's direct mailing service has improved my dasy much more than the
hkml feature.

> 
> That being said, I understand the concerns and the pressure to respond
> to everything as you mention below. Maybe at some point this will
> become an easier decision to make as reviews become more refined.

I agree here, too.  Apparently [2] my tooling-motivated Sashiko reply
forwarding didn't convince all.  My honest feeling was that it is not only
unconvincing but might making someone slightly annoyed.

I personally feel no problem at Sashiko review is publicly replied to my
patches, but I understand my personality is not necessarily same to others.  If
some change can make someone happy while also making someone sad, I'm up to
reducing sadness.

[1] https://github.com/sjp38/hackermail/blob/master/USAGE.md#forwarding-sashikodev-statuscomments-to-mailing-list
[2] https://lore.kernel.org/20260331045245.67438-1-sj@kernel.org/


Thanks,
SJ
