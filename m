Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ABB35839C
	for <linux-arch@vger.kernel.org>; Fri, 24 Apr 2026 19:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777058342; cv=none; b=CbtO9GFH6cJdOg1+vfJRooatPPAvzXsdOAfa7yEb/I0nCU6TknGpmtEgxPNVeHmRP7bFXY08TnzX0bNenHCPtSAHvo/0NMD33fD8LEOQwo7IPtqLdL8UzIAxQnoGWVZMXSEjTcLtvfyTPItI58kA/w/4B23/2UMxksisypBkNWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777058342; c=relaxed/simple;
	bh=TjoObAyADCrST/Y7w112PE3u3cZVRxOGJDu7cAPas0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sNi4RxdSfL/kGKbTdkn0SVzlDON6MOGEiMwf5MVKIfAGUuJ+QZa36D3SvSpA7HaUlQah33qFRL7QidLeona65gwVpr90QjL8vAAssfPxzVymFjruU7J5zjcrxp2bbZMe7hkrSe/hOFe3LR/wgYZjM2Juz3FBGeuFNPnLC9yCm+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+YNOXLP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+YNOXLP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF41C2BCC6
	for <linux-arch@vger.kernel.org>; Fri, 24 Apr 2026 19:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777058342;
	bh=TjoObAyADCrST/Y7w112PE3u3cZVRxOGJDu7cAPas0s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=h+YNOXLPMp39PBG3Gr9uLo0BRKTr7R0w8PsGZ8sjtp/4fqSauRop3zzrKFWK9EwYv
	 Qx3MMCrtXEVro0XeS18cFL9iDWpyPvH3WFFA2bAE/7aRdmSoZhqArZ0Cqk/RKeHCfq
	 Pb2i2ATkGohu8TGQ7a7S2jHfz0emIp8QlT/AwKCyFZo9871F4KTzJACgRFN/l7+quh
	 /0b6RoBFxip1Hb/l/lU3HNZQI7AkIrzNLd+rURTItHfGF17ouHDpidvhUySxE9Htbb
	 8/Ve0ItcVl3MNbqZnVaBx1M1eBGI85wZ8jjXL4oiSZz8xChk1WVTkfeiwYsDDHiuT/
	 jM9dWyJwBqKWg==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b8d7f22d405so1379813066b.0
        for <linux-arch@vger.kernel.org>; Fri, 24 Apr 2026 12:19:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+dGDMd2XAvHGwXIEUYQB9O/Bile/0IokO2u0ycwgDaJlvBdCnfWJaOXMBNoHMhBRCZX8CVFSOczEYA@vger.kernel.org
X-Gm-Message-State: AOJu0YzMHNBqvmm/KL0qw0npyLoyxx4W5RHPMDisduniKE9lfzBA0tuj
	O8tr7XxZ6IpKtM96wWG940pbBk/eZdwwT/J+Pk5cnd9GOhhgRyjImdOXCN/EbZTwDOO02df/hfM
	g2oolNxHchkEXmCOXrYttyvBSAa7zlo4=
X-Received: by 2002:a17:907:c10:b0:ba6:8f34:b419 with SMTP id
 a640c23a62f3a-ba68f34b5c5mr1407089666b.13.1777058340906; Fri, 24 Apr 2026
 12:19:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424062528.71951-1-lance.yang@linux.dev> <20260424063024.ce42ee6a5546e4d9337dd007@linux-foundation.org>
 <aetw4aoABYj3keMh@plex> <20260424071533.d28ce90126f05e1c6fc1b740@linux-foundation.org>
 <80ab39c2-efb9-4a23-bd56-46d9bb4e41bb@kernel.org> <20260424073145.b990fe9b925da304508aad71@linux-foundation.org>
 <644e65dc-3d39-4137-b51f-51d953b67d50@kernel.org> <CAO9r8zN1pRfyC0Rh+UdW-Lsret=z3oveT3=gnZftX-Sr_ubyyQ@mail.gmail.com>
 <4e7699eb-e101-4a25-b585-79a777eb7cc2@kernel.org>
In-Reply-To: <4e7699eb-e101-4a25-b585-79a777eb7cc2@kernel.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 24 Apr 2026 12:18:49 -0700
X-Gmail-Original-Message-ID: <CAO9r8zO4eSiAK9U-ijzWJMK80XsK+LmFxGAG+nTo+tmK6aLfYA@mail.gmail.com>
X-Gm-Features: AQROBzDBfOuUErZMfxDCkdpEwLja5wXxHZ0y9sOKUJXXYUWA3b3LIrTjfVdzPRU
Message-ID: <CAO9r8zO4eSiAK9U-ijzWJMK80XsK+LmFxGAG+nTo+tmK6aLfYA@mail.gmail.com>
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

On Fri, Apr 24, 2026 at 12:09=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 4/24/26 20:50, Yosry Ahmed wrote:
> > On Fri, Apr 24, 2026 at 11:36=E2=80=AFAM David Hildenbrand (Arm)
> > <david@kernel.org> wrote:
> >>
> >> On 4/24/26 16:31, Andrew Morton wrote:
> >>>
> >>>
> >>> Why do you think so?
> >>
> >> The most important part for me is that authors are aware of the report=
s.
> >>
> >> Sending them as a mail forces people to publicly reply to the feedback=
, and at
> >> this point in time, I am not convinced that that is the right approach=
.
> >
> > But I imagine it's useful for reviewers to see Sashiko's feedback as
> > well (without having to go look on the website).
>
> I read a lot of them, yes. Maintainers know how to find it.
>
> I even think maintainers should  briefly go over it before applying to sp=
ot if
> anything in there is still left unanswered. But that doesn't need a maili=
ng list
> posting.
>
> I enjoy if contributors are aware of the reports and use that input in a
> reasonable, like Zi just did [1]. And if they are unsure, they usually as=
k to
> double-check.
>
> [1] https://lore.kernel.org/r/15191F7F-0D10-4907-B963-DA4EA0E36EB6@nvidia=
.com
>
> > It's possible that
> > Sashiko is right but the author isn't convinced, so getting more eyes
> > on the feedback would help.
>
> Forcing contributors to reply to everything. I don't like that, in partic=
ular
> not as long as there is no way for contributors to run it early in privat=
e.
>
> In most cases, contributors just do the reasonable thing: incorporate the
> feedback in a new version.

The usefulness of the mailing list posting is that it makes it easier
to respond and discuss the review. Yes, what Zi did is great, but it
would be nice if contributors/reviewers didn't need to manually quote
Sashiko.

That being said, I understand the concerns and the pressure to respond
to everything as you mention below. Maybe at some point this will
become an easier decision to make as reviews become more refined.
