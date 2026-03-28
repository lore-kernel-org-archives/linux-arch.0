Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84E3330650
	for <linux-arch@vger.kernel.org>; Sat, 28 Mar 2026 15:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774710952; cv=none; b=JkXDqTuHBBnvaVvWid4vgChKHj1p/tR2+Qs3AFUcjyMugE9du9mxrrXLwID1xyEYUf3ptafBYy8fIuP63pkeWeKfAfmiG7ouySX4CUsPGK8LZdWhtwOe/FEa8k4lchLGAhIC3wtWI/4eUVD6syt09UAR7fPpOVDOvmFjtKLHl4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774710952; c=relaxed/simple;
	bh=M5v2YKLGoSwtpfgdVhTIfMqhFC8EhARAr+bEGNbA/tY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UHmEw+EYUKvU7q1i5Jluj/dQiHhlqiZjmlMwdlk0NTl+sRtJpsgy3fmAsreTpkb4HbO5Ud4IKG230oWNX6Qc3wyClz4ARVLu/sm0Df4StvtRSvwGuwe6IZhCMbdK5dObEFw8qpXahUBQuTwG6MxFZsZd+gGzR4KuzTm74nAvLfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+5fzV43; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+5fzV43"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F1DC4CEF7
	for <linux-arch@vger.kernel.org>; Sat, 28 Mar 2026 15:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774710952;
	bh=M5v2YKLGoSwtpfgdVhTIfMqhFC8EhARAr+bEGNbA/tY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A+5fzV43+OEOgaKxRBxncxMnCCE+lKLzJMX5Ma8/7ijDBAxXwonTIitJnmsZ6EpNM
	 WbfkhRGD4YLf1TIGr/4JvVIuKO0ploRDSPH2ebI8QwL4xM9TpCL6p4blVbzKFEPKua
	 uYY0Nr9kRgEZzC+eWVfgurfO4+ifo20ECYo2Gdtq0wPDzs/S9Qx7bqQ8d6CJtj0QPw
	 Oet55WFs3LCZfVXPS7P5Fesi9jWS/Lurq2sLExaoMRxdqLb90OYHt2reX60R5Ul+9G
	 EvQWOPk9UMIqgITGoMrEWzi2kYg3mSVLF4Cwfh4k/CbihXwJiSTk63aWc8PfLPCcoJ
	 LX1zL0cjNgogA==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-661cfb9f3aaso4665698a12.2
        for <linux-arch@vger.kernel.org>; Sat, 28 Mar 2026 08:15:52 -0700 (PDT)
X-Gm-Message-State: AOJu0Yybv46Tvd+d6SZ9iAclwBQqsDFss+XuDeTS8x9PnH2J/PhhqvHa
	8nFH9eaWbOfqsMM2/Na78+3qcIArvsy5jpe/1MHdxFCMfvl+9iLkY6E7cTIWOsA+HrX19yGaMbm
	RovpDGVMx+ZK+E0HgYyo7gy3zOTFtLiA=
X-Received: by 2002:a17:907:8b95:b0:b94:21a8:f7d9 with SMTP id
 a640c23a62f3a-b9b507b5d93mr374153366b.36.1774700208640; Sat, 28 Mar 2026
 05:16:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wgg1QVWNWG-UCFo1hx0zqrPnB3qhPzUTrWNft+MtXQXig@mail.gmail.com>
In-Reply-To: <CAHk-=wgg1QVWNWG-UCFo1hx0zqrPnB3qhPzUTrWNft+MtXQXig@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 28 Mar 2026 20:16:36 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5zCHZeE02RON-4OVb482TirSUNsr+3zTZLmcVpeuNdFg@mail.gmail.com>
X-Gm-Features: AQROBzB2CMxEYm5mnrNBg7Tp1reiR2nFwBWzW2mYXdlo7akKo3YY5W7iJ4MIu4g
Message-ID: <CAAhV-H5zCHZeE02RON-4OVb482TirSUNsr+3zTZLmcVpeuNdFg@mail.gmail.com>
Subject: Re: Attempting to unify some user space copying APIs
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Russell King <rmk@armlinux.org.uk>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Helge Deller <deller@kernel.org>, Huacai Chen <chenhuacai@loongson.cn>, 
	Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 28, 2026 at 8:21=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'm sending this out to the architecture maintainer list (and a random
> collection of arch maintainers that I just took from "recent pull
> requests") in the hope that people can test this on platforms that I'm
> too incompetent to check myself (read: I haven't installed all the
> cross-compiler environments).
>
> The impetus for this was trying to have some shared code in
> lib/iov_iter.c by having a common wrapper function for a couple of
> user copy functions that most architectures don't even have. But when
> doing so I noticed that even the common function that we all *do* have
> doesn't have a consistent calling convention: raw_copy_from_user().
>
> So the compiler ended up being unhappy just because I want to pass a
> function pointer around, and different architectures had different
> types for the functions (and in the case of arm64, used a macro to
> implement it, which really didn't work for this).
>
> So I fixed it all up, and I think the end result looks better, but I'd
> like people to at least build-test this on the platforms that I didn't
> have immediate access to. I've tested this on arm64, x86-64 and i386
> (and then I made changes, and didn't necessarily test all the changes
> on all plaforms, but it LooksGoodToMe(tm), and some earlier version of
> this patch did work on those architectures, so it must be perfect).
>
> The patch was generated on current tip-of-the-day, but I don't think
> any of this has changed in a while, so it should apply and be testable
> pretty much on any half-way modern code base.
>
> I fixed up powerpc blindly (we really had very odd types for
> __copy_from_user_flushcache), and as mentioned the arm64 and x86 side
> should be tested. Everything else lacks the flushcache and nocache
> versions of the user copy functions, and it *looks* like only arm64
> had that odd pattern for raw_copy_from_user().
>
> But maybe my grep missed some case... Considering that three
> architectures needed some header file fixups, let's make sure it's
> _only_ those three, ok?
>
> My initial version tried to use 'size_t', but the type of that is
> typically - but not always - 'unsigned int' on 32-bit architectures.
> And since I didn't want to mess with this low-level architecture
> function more than necessary, the traditional 'unsigned long' it is
> and most architectures should JustWork(tm).
>
> [ Traditional, that is, except for those cache control versions, which
>  just used completely random types with wrong sizes and signs and
> everything.
>
>   Not that we even allow IO that big in the first place, but it was
> still a 'that shouldn't even work' kind of reaction from me ]
>
> Anyway, could I please ask architecture maintainers to check that
> there isn't some odd corner case that I missed? I could put this in
> linux-next, but even before I do that, I'd like to do the basic "it
> won't break anything" smell test.
Successfully compile- and run-tested on LoongArch.

Huacai

>
>              Linus
