Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49CE1DD889;
	Sat, 25 Apr 2026 00:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777078713; cv=none; b=S//rGmHIVztn91js6eN031tPjnts81kDWa4e98MnYwtKE8TS+6a3Y4aFtLUQzdTcua3bMehQsy63V6Q27Wf1s8/8nJySgu0qMMDQojehv0iaYE/4vwxd2LgLMmTaK4vID+g125ppJTZP9rejJk9doGm141TCuCLnSF8b76mQAWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777078713; c=relaxed/simple;
	bh=OXNxLHcbXvYstCd0hV40g2fHvy0QoEeo82TGhCpF1qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I0DCQo5xRTgMsLrQ1+GeOuJE5VLe1NHQJL+I6QelrqvulKmCUtNtWYRxHtavOcBlOmDvXyPvCDRIm2bvJ2KZ28zqB4U96DleDhG+SCn8px6UScHzDH8cxsUwXQD5JHzxsAwgUxsOVBAsPZ9jWflNXYjnOnytYi6KlFnOxyb6SW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6lj8ZcI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6lj8ZcI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C2CC19425;
	Sat, 25 Apr 2026 00:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777078713;
	bh=OXNxLHcbXvYstCd0hV40g2fHvy0QoEeo82TGhCpF1qc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r6lj8ZcIssuYUzBmdUm2MTEcxm0OX5yYkORS/Teky3PLp5AKGzuJC2+02+AVURTJe
	 4HC52cDmZgNUic/X2A2ZBPbi5YYFTNtZ+iltBZGhFNyjP99MuV5jbbdJfEtD0eiR1q
	 ZogmJ+phFmniFFp+haYiOe0Kw+dnIWEvt8VvaJD8FaqCI3nHuF/Fm16U8dHeAHFTGc
	 fG5CD/E4KXZT5RGkE1uat0Y7fWE3lNk2TkfpLnNlwIUVz8LRFwdBR3gh0fFBh6pvbx
	 Ci0Zu2cVA1XvRKVCOCdN91qeB1Efixa2bjCPl8tR+qm0e46JOyXaKSMfVGX6DEhFt+
	 eiHpqN7AzWeCg==
From: SeongJae Park <sj@kernel.org>
To: Yosry Ahmed <yosry@kernel.org>
Cc: SeongJae Park <sj@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Lance Yang <lance.yang@linux.dev>,
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
Date: Fri, 24 Apr 2026 17:58:22 -0700
Message-ID: <20260425005824.85689-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAO9r8zOTFUSXc_iZ3i9iL3v9Fw+SOFoROj0vcO_1GwBxO9CVqA@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 24 Apr 2026 12:15:30 -0700 Yosry Ahmed <yosry@kernel.org> wrote:

> On Fri, Apr 24, 2026 at 12:12 PM Zi Yan <ziy@nvidia.com> wrote:
> >
> > On 24 Apr 2026, at 15:01, Peter Zijlstra wrote:
> >
> > > On Fri, Apr 24, 2026 at 11:50:03AM -0700, Yosry Ahmed wrote:
> > >
> > >> But I imagine it's useful for reviewers to see Sashiko's feedback as
> > >> well (without having to go look on the website).
> > >
> > > That's why I have a script; if I press 'S' in mutt on an 0/n email, said
> > > script goes and does webrequest to sashiko and inserts the review
> > > comments into my local maildir as properly threaded replies to the
> > > series at hand.
> > >
> > > No looking at website needed.
> >
> > Do you mind sharing that script? It looks like a great work flow. Thanks.
> 
> Yeah that sounds great :)

FWIW my workflow was also similar to PeterZ [1], except I use hkml's Sashiko
integration.

The hkml integration requires two key strokes to get the Sashiko review, so I
think Peter's script is superior.  It provides a draft [2] for sharing full
Sashiko review that I can further writeup my comment and directly send, though.
It is helpful for asking the author their opinion about Sashiko's review, with
a fine pointer to the question.

So I initially started opening web browser to check Sashiko review.  After that
I used hkml to read the review on terminal and copy-pasted the output to ask
question to authors with quote of Sashiko review.  Finally I was able to just
forward Sashiko review together with my questions to authors.  Each step of the
changes made my life much easier.

DAMON is opted in to the Sashiko's mail reply service from the beginning, and
recently Sashiko started the mail delivery.  Now I don't need to use the hkml
integration, and I feel my life has been even much easier than before.

[1] https://github.com/sjp38/hackermail/blob/master/USAGE.md#sashikodev
[2] https://github.com/sjp38/hackermail/blob/master/USAGE.md#forwarding-sashikodev-statuscomments-to-mailing-list


Thanks,
SJ
