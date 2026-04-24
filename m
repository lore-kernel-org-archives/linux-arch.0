Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2CD3E5EDC
	for <linux-arch@vger.kernel.org>; Fri, 24 Apr 2026 18:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777056616; cv=none; b=Ya/vGRc0GSvDtlyHgHww3EwcSyOjRicpkz4UayLcEmIo+MqhmBf+wXXRUkzFz0P8njE6JRuKZ4EaA40TMBsPBrdPXKB8tAgk97fP1oU6c3iwl3MlSmdenxAI8IDl66wmxxICbXOkT97fWtsFmrgL87AfzaD/7t/KS9EN+NxP/sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777056616; c=relaxed/simple;
	bh=w5kUoCAdRW22OY51cZNgSK5N7Gpb3BDGbpsiHoe6xEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PFK028LMdnYG71KUygfhUrcVjqx8j82mUMd10H1rSdx3VjGaEJWvBWVeRF+yjpxRBNxLnZhcvdNLQHka7tTRq5ruG5+esuJ+wl0i4lyqsY/wvyu8ECnLBTxmpLKSaarZdD98LO5r8CDP6A/ULxZyKEb4fqHbzk767caKIKBlJEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pftDalM3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pftDalM3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A22C19425
	for <linux-arch@vger.kernel.org>; Fri, 24 Apr 2026 18:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777056616;
	bh=w5kUoCAdRW22OY51cZNgSK5N7Gpb3BDGbpsiHoe6xEA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pftDalM3kJ9DPPvgqPonQ8Vuac/lSzURnxnvhHdDJpTgHP0CDrIvO8ljHgA/fBiH6
	 12m42BYH8ANEfIcVa+brAYwt+ei5bXS84bXwbuc/W+GfHRNCHqqQdHtVJ2gH7VqiqY
	 izqXhaLsSXtSq5Tx50f+kHKWJ3HhvIVdUh+IUxp9TpZG2WLyZ8aL4P/629m+/Q+ErU
	 ZglR5Y9QZOOWcmcHa+C0vr7X8x1aH6uNqjNmdHhayQcuQM68oXiN6BGhm4WJSczF2Y
	 DRugXmwBSroybC7MpT+/CqOhNAY3G3BQ39fm9SOKNxB6PPd7TK94BwTN1DEcqA6LTb
	 ymVgyyrngrjug==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b9c603ec2dfso1076365566b.1
        for <linux-arch@vger.kernel.org>; Fri, 24 Apr 2026 11:50:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+GwbE1nAq60be1Ob8X4jMVGW3i47XIY3q4EaIv+pmOXKuzQCUBobByjb+ZVdxvh6NUHSf2CxLRb2rM@vger.kernel.org
X-Gm-Message-State: AOJu0YytymKULtxhLnRs5ihkMxTrUtiDg+6xq3VXQaVTOIszLDBS5aRw
	OuM8SDplIX31vnF7t86z9w2l29vHiXoJo6xRfiY/i5f8wVMBX9LsURWyrdlW0hdLUGOMRUcywVl
	C8ntaVbsMCdYbtYFQmiOmeMP42lTAsxI=
X-Received: by 2002:a17:907:2d9e:b0:ba7:ade5:8605 with SMTP id
 a640c23a62f3a-ba7ade5873cmr1292114966b.6.1777056615011; Fri, 24 Apr 2026
 11:50:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424062528.71951-1-lance.yang@linux.dev> <20260424063024.ce42ee6a5546e4d9337dd007@linux-foundation.org>
 <aetw4aoABYj3keMh@plex> <20260424071533.d28ce90126f05e1c6fc1b740@linux-foundation.org>
 <80ab39c2-efb9-4a23-bd56-46d9bb4e41bb@kernel.org> <20260424073145.b990fe9b925da304508aad71@linux-foundation.org>
 <644e65dc-3d39-4137-b51f-51d953b67d50@kernel.org>
In-Reply-To: <644e65dc-3d39-4137-b51f-51d953b67d50@kernel.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 24 Apr 2026 11:50:03 -0700
X-Gmail-Original-Message-ID: <CAO9r8zN1pRfyC0Rh+UdW-Lsret=z3oveT3=gnZftX-Sr_ubyyQ@mail.gmail.com>
X-Gm-Features: AQROBzAzgmye5h2hgq6OujP1bhxfaF6hprGZxVf_6cZmOYHaxIkk2WQtzQUABGE
Message-ID: <CAO9r8zN1pRfyC0Rh+UdW-Lsret=z3oveT3=gnZftX-Sr_ubyyQ@mail.gmail.com>
Subject: Re: [PATCH 7.2 v10 0/2] skip redundant sync IPIs when TLB flush sent them
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Lance Yang <lance.yang@linux.dev>, peterz@infradead.org, dave.hansen@intel.com, 
	dave.hansen@linux.intel.com, ypodemsk@redhat.com, hughd@google.com, 
	will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, 
	hpa@zytor.com, arnd@arndb.de, ljs@kernel.org, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	shy828301@gmail.com, riel@surriel.com, jannh@google.com, jgross@suse.com, 
	seanjc@google.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	ioworker0@gmail.com, roman.gushchin@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 11:36=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 4/24/26 16:31, Andrew Morton wrote:
> > On Fri, 24 Apr 2026 16:20:55 +0200 "David Hildenbrand (Arm)" <david@ker=
nel.org> wrote:
> >
> >> On 4/24/26 16:15, Andrew Morton wrote:
> >>>
> >>>
> >>> Yep.  I'd be OK with an automatic reply-to-all.  Maybe some won't lik=
e
> >>> that.
> >>>
> >>> An alternative I've discussed with Roman is an automated
> >>> reply-to-author with a cc to a dedicated list (we could use mm-commit=
s
> >>> for now).
> >>>
> >>> Preferences?
> >>
> >> Reply-to-author would likely be better as a first step.
> >
> > Why do you think so?
>
> The most important part for me is that authors are aware of the reports.
>
> Sending them as a mail forces people to publicly reply to the feedback, a=
nd at
> this point in time, I am not convinced that that is the right approach.

But I imagine it's useful for reviewers to see Sashiko's feedback as
well (without having to go look on the website). It's possible that
Sashiko is right but the author isn't convinced, so getting more eyes
on the feedback would help. If Sashiko is wrong, it's still useful for
more people to see it and point it out, instead of Sashiko privately
misguiding the author, especially that reviewers are probably more
likely to tell if Sashiko is right or wrong.

I understand the fear of too much noise, but I think it's easy to
ignore Sashiko if we want to. It's also a good exercise to spell out
why Sashiko is wrong (e.g. improve changelogs/comments to document
assumptions more obviously). We can always tune it down later if we
think it's too much, right?
