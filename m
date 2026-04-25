Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0E11E832A;
	Sat, 25 Apr 2026 01:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777080003; cv=none; b=OibmEqC/91MRget9Q24Vht3x92s+ZA+UueDvi8smPfHfBvA3fufoe/9HMGCmZdoupBDlraLTQ34kUtkMRq/R2kzi/2Hdihc5SlAQ896HWm9/0WyAbooD2wKoqHdwF8cCndXpnB8GKytt3F53iJTHfK35JeOi6PUS4lMK/72x80I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777080003; c=relaxed/simple;
	bh=5hX0NBvb8lQVR9PGOGQDik+LqNBSW1MJsV5E+knu75Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OwzEDcp+u625AYlIyA6CtJGGIYPg3Dc7kUI43JC95BtA6k9CFFB8SobMsMICfMpk3ibq+P87DXo48TRMdebnpH28dONr/+qgZ1KNKstDLTwa8KifiCS5reAyj4M4hA1lRbPNNifB2UGTlllTn+blpLv6HK0dUy1yAzMhRBWJ3GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjrkYzfe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjrkYzfe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F15C19425;
	Sat, 25 Apr 2026 01:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777080002;
	bh=5hX0NBvb8lQVR9PGOGQDik+LqNBSW1MJsV5E+knu75Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mjrkYzfe/ynaLya7MElydTQOfByl2dTFw+dWe5Iu9xb94pN65HFo6oyHZS5vZz1aI
	 uXU1dO74AW7WXgb7Seitov67HoeO4ixUGlXSbfr5sak6kb7AU65tTvPVenCqDklOCc
	 6dC3iUeWvi316WYbgzlGInzSHI4tkJMIUyVhjbT4jgcLW34/L7gf2bMV0KvK8g5taR
	 PhoJ0K6G0bpSMwIUo8vQhUDDcTacTOfcweH4MiHYtZWmxqbGbDRlMZygoSswElkdAL
	 NLckoYJizpsMmXw9Ql3RQNqMwZVdaS+gQRAR2Z9JzTLXkPPqs8IiWJ/pXXItPf2vdd
	 nc/VoCQDYYh6Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
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
Date: Fri, 24 Apr 2026 18:19:52 -0700
Message-ID: <20260425011953.85997-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260424073145.b990fe9b925da304508aad71@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 24 Apr 2026 07:31:45 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Fri, 24 Apr 2026 16:20:55 +0200 "David Hildenbrand (Arm)" <david@kernel.org> wrote:
> 
> > On 4/24/26 16:15, Andrew Morton wrote:
> > > On Fri, 24 Apr 2026 13:37:04 +0000 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> > > 
> > >> On 04-24 06:30, Andrew Morton wrote:
> > >>>
> > >>>
> > >>> Sashiko questions:
> > >>> 	https://sashiko.dev/#/patchset/20260424062528.71951-1-lance.yang@linux.dev
> > >>>
> > >>> (I never know if my Sashiko emails are welcome/useful.  Maybe Sashiko
> > >>> said the same stuff about v9 and it's all wrong.  But better safe than
> > >>> sorry!)
> > >>
> > >> These emails are helpful; but, I do not believe you should have to 
> > >> manually follow up with a link to every new patch series.
> > >>
> > >> Perhaps  Sashiko could automatically send a summary email in response to 
> > >> the cover letter, or provide a link once the reviews are complete. For 
> > >> the kexec ML, we opted-in with Roman to receive automated emails from 
> > >> sashiko.
> > > 
> > > Yep.  I'd be OK with an automatic reply-to-all.  Maybe some won't like
> > > that.
> > > 
> > > An alternative I've discussed with Roman is an automated
> > > reply-to-author with a cc to a dedicated list (we could use mm-commits
> > > for now).
> > > 
> > > Preferences?
> > 
> > Reply-to-author would likely be better as a first step.
> 
> Why do you think so?
> 
> Pasha, is it too early to determine how reply-to-all is working out for
> kexec?

DAMON is also opted in to Sashiko's email service.  It is replied to only the
author and damon@lists.linux.dev.  I understand this is the default form of
Sashiko's email service, and can flexibly tuned.

So I cannot say how reply-to-all will work for mm.  But I can say the default
setup email service was a huge improvement for my life.  I made tools for
making my Sashiko handling easier and was quite convinced with that.  But the
Sashiko's email service made my life much better.  Of course, it may differntly
applied to others.  My personality is not necessarily same to others.


Thanks,
SJ
