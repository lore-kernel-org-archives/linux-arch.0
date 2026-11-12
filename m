Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794499285;
	b=IujhRpWz39G36W0QL6ElczRo0hWcANZhbKKmc4yDqAoVSa1uETP//awU76SGiRkd5gEk
	 9feAy+3Cgj63SeG+P55qpRkOfT+hePfABm5pPwu3laH5gUVEcSL9LklSpJ9uptymKbR4y
	 ZKALRiONMvQCb3d8K1ni4b34O34aXhiQsJ5JlLuuwV5DJfX7U2oEkcvsNkJopMrE3FJk6
	 y4jPrs1f4fzrjxGH99ciV4s1Hv+ucTmhhp/i/rxklxjc51HlNH54SCRGk2uZYnk+2gFy4
	 tWkn7ZJjzFtr7UWcKadUdwVuQ1uKj9qzCF6+h5phRkBhhLYZiMHCHWJ90KFnPSzTqTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794499285;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=K30WU9LcDm9KOHnUzmPG5F9Q3grxCVKpIQuAPTV3Oio=;
	b=BdA40ZZdXwZ0I+pohNryhNhPAj0AqADGODSf9VCM1RqMg1cMrAqWnzNxkwoEPnGK767C
	 acd6bAg78eFf3PxzJ1GajW+26637+JSBcazzCqbLsoZguzMjTeI/0p6RRb+Kxk1mQtJZR
	 g66ijSM62xcyuTEkXv49oJclBXeqNOKsL02gz7Jh6kP+RmntcmwgWVi2ChP7MhBfj21pn
	 V3Off1XTRg0GeNCHqXJNA2W5+OpQ8bN44JpjiElGTeNupwV+fTzju61LK76VfqZpHY/iI
	 Cyx+R0W9owORtJ8DBP0hk4veRKYA0VRRBCbxGoCHPmb5sBQyPIVUFq4dDI7ATs7p1qQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=asQ6Kkgb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30791606A32E
	for <linux-arch@vger.kernel.org>; Thu, 12 Nov 2026 16:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30791606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=asQ6Kkgb
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so47074705e9.2
        for <linux-arch@vger.kernel.org>; Thu, 12 Nov 2026 08:01:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794499283; cv=none;
        d=google.com; s=arc-20260327;
        b=YSiXMpV4dQ4zH04tJ2lCp8FaZR9NzksCsprOxc6/P6QSmH33ybMnYhUsuhIMmYEn7Q
         oBTNU0MVoam81+YP5jomt/scNeilkUbD56nQfiKiIQARJGYFcfAuXSvSdF8ZeFDsdbEz
         7vxnhHVnLhVT3igqQmIEdorKcPvh2+kSr9HP1RPdHmNVKfctZF948aBpr4dAU+Jgjky1
         VFuvrRvgiXvGvaqHQg0pKnO3pfSX8UnuiBWm6qiADRQmEvPb9MovyoNucgnol1kLsnC8
         JuyGMbYRI6FSwKrReo9PilWmRu3S8Ac3pIAnQVEUJfH9laeuS6SaRde+74GeVW3Yi6gq
         tsug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K30WU9LcDm9KOHnUzmPG5F9Q3grxCVKpIQuAPTV3Oio=;
        fh=2d1n101EO/DfxC+Cyxhb18ccP1N/YnQryYMF/OMbbSg=;
        b=si09O3GrbbelnLVRI7AvHbznIKTDpgkcxMyTsE8l9CW3F34p1AzQTlBkljeyHxzeXQ
         dTp+YmeDwsaGPrmRQlyqfutvLWiiNtg0BBnli5/jG84HNhYeY9oR+nv7YacV7Id76gCc
         elqD1Y7X4E4Zh+sG7d3ggsi1SN0zsqTXjyTYFZ38sF29EMC9uJSqQ+98mQ+PII31Z9k6
         GjNyYHxbgtxZBWQs1zffmMxaFiEQUAYJnJCmISpRyZnaPl1RunJBxV/bxzswObwMqq6T
         hWtCI1lLtjKtSMgDw7+sbhqsedbbhnrMeiU87hoGEOQ7qmiDECU1uv/0nVwB8STNNPSH
         q5OA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794499282; x=1795104082; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K30WU9LcDm9KOHnUzmPG5F9Q3grxCVKpIQuAPTV3Oio=;
        b=asQ6KkgboxQr2Mix4uFXV97OZ4yQDaOEh9XXJvisPx2EPGhn5J8mcUoEZGV1Qeagb0
         Ai7PxqX8tEH8mdpe/wwT65dwo+YA6B9kehSmgtkDDpS13Hr62CAOHX7C5QdKM+IGnSfI
         QkCMfS34Um5jNw5/L/5hM0f9cN8RySssd5TviZczWCdI7osE4Z8oZQAb9qD794opBVCq
         gpAzdC2ceN0QkqGe+vB6SzZyXV84S/smCWXulY4TtzR5YGtNMSBL48Is2CzXKFW2QfGf
         6O0jxlFZn87zP3M5OnX6S5Pxeu/cFTk/Et89FxtMSHEkDVN1+uecNnARomY1gctIsF1O
         qqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794499282; x=1795104082;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K30WU9LcDm9KOHnUzmPG5F9Q3grxCVKpIQuAPTV3Oio=;
        b=l+eg0Da1xtVFgJaz282z44PoXS03f7qLUyRqSjxnD+6BqoCHpBNxF1u27X7x6kUDKv
         oEfFNg9Kep4t7/ZbZMCgnmnd4cPvT2t3+w7Y/X+75feNYGLASTK3tGRcoW9oxuxjDa5m
         2E5wtNdBoqyRGvx4lShG/tuq7rgjfDihLp6cDarMwiGBjYc/UTDnJps95LlgH20PpN2M
         R145GeUlS4dZXsrCe5diNEv1y9pWtM3BUf7UvbWFBoJ/IjrESZFL4LcU6j22aY7cHtyc
         x/G8hycfymgDYb2Q5uGaB5JFdQWMEF2Q5q45liNIxb/LfV6Mb8YHtHGtkbYjgZZTXhAI
         L1Qg==
X-Forwarded-Encrypted: i=1; AL+hErFkSrGu0Ijwf51QxASV85z/VgguBe17m8W+4ctF2Cop/nNfk0DYug877fzCLwbK8tX9ITmSlviJFmZn@vger.kernel.org
X-Gm-Message-State: APuU4Z9B3kchxzBEpEpR2N5NvkF5ydt2BNfuzGb73Jpk4R8G+fKtAEw2
	TNVuZGFAZwOmBjU1MO3euM4x3LqbVt/WBFlDutnJc1ZfZgiDrH5I8JODh5oPPyaqk/2OaviyCx2
	pOgqZqlq9FRP0Pq1NJa0Uf/4jWHunWOI=
X-Gm-Gg: AYBFou3dUcb7qLDmIGotoFmv8ZAPvsj3eDo1YDYnoAcsVL5+xLm4kR167QSj0LqQqJy
	RYxzgBqLvm7rOupnNRv8mlvgTM76eSEVMLI68gEL/r1QnREuyyoJ7sUBHap8h4PYuTp1iW9y7Q/
	C8DTH3nm7CbmbNaa8yskM7REQqPUCzQmu8s0Z/xEJ0AevRZPqd8cGfj7liW6DcDOv9ENRL0JmhE
	6aBT6nWhew7uBzy61nH19N1pvJsniBMAIX4fqJgiy+YPtEcC73rYOvsHewTPezm1NEW8B96P1AJ
	TFJVK/3e29L0p7biOzGeB4YZhW+xsQJ0kyCP27hsxSR0EMNsyY7MAyhdmex7aD8DNfw1FuHIrpW
	rw6WdjlxyNWIL7Ozlq7GV1a7JvQHplS2JfOH2Mje4cb21VDSaZDR4DytosTxM5P5G4nQlTw==
X-Received: by 2002:a05:600c:1d29:b0:4a6:42cc:bf65 with SMTP id
 5b1f17b1804b1-4ba0938182bmr115084735e9.17.1794499282029; Thu, 12 Nov 2026
 08:01:22 -0800 (PST)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104165504.2430480-1-kunwu.chan@gmail.com>
 <20261104165504.2430480-10-kunwu.chan@gmail.com> <381033ae-d65e-44de-bbe7-69f707405f40@paulmck-laptop>
In-Reply-To: <381033ae-d65e-44de-bbe7-69f707405f40@paulmck-laptop>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Fri, 13 Nov 2026 00:01:10 +0800
X-Gm-Features: AclHuK_r0z0qzRgTWpnMwVZyYzYAfYE6f8hG1Sg9QutknQhxmorMBRwJwam3dq4
Message-ID: <CAN_Opa9F9prFRqta5KwCHoQHrmsOEB4_m2tst0+0VY+fh5o2cg@mail.gmail.com>
Subject: Re: [PATCH 09/28] hazptrtorture: Add READERS4 and READERS0 torture configs
To: paulmck@kernel.org
Cc: boqun@kernel.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, 
	corbet@lwn.net, mingo@redhat.com, frederic@kernel.org, 
	neeraj.upadhyay@kernel.org, josh@joshtriplett.org, urezki@gmail.com, 
	dave@stgolabs.net, stern@rowland.harvard.edu, parri.andrea@gmail.com, 
	will@kernel.org, dhowells@redhat.com, j.alglave@ucl.ac.uk, 
	luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, 
	joelagnelf@nvidia.com, skhan@linuxfoundation.org, rdunlap@infradead.org, 
	longman@redhat.com, rostedt@goodmis.org, qiang.zhang@linux.dev, 
	brads@mainlining.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, lkmm@lists.linux.dev, linux-doc@vger.kernel.org, 
	rcu@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 5:37=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Thu, Nov 05, 2026 at 12:54:27AM +0800, Kunwu Chan wrote:
> > Add READERS4 and READERS0 configs to cover reader-active and
> > reader-free synchronize paths.
> >
> > Both use the PREEMPT baseline and hazptr-stack torture type,
> > with four readers for READERS4 and no readers for READERS0.
> >
> > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
>
> For these, why not just add '--bootargs "hazptrtorture.nreaders=3D0"'
> to the kvm.sh command line, for example in torture.sh?  Ditto for the
> four-readers case.
>
Hi Paul,

Agreed. I wanted to keep the zero- and four-reader cases as
explicit, repeatable tests. I'll drop the separate configs and
retain them as scripted PREEMPT runs, passing nreaders=3D0 or 4
and torture_type=3Dhazptr-stack through --bootargs.

Thanks,
Kunwu

>                                                         Thanx, Paul
>
> > Acked-by: Bradley Morgan <brads@mainlining.org>
> > ---
> >  .../selftests/rcutorture/configs/hazptr/READERS0 | 16 ++++++++++++++++
> >  .../rcutorture/configs/hazptr/READERS0.boot      |  2 ++
> >  .../selftests/rcutorture/configs/hazptr/READERS4 | 16 ++++++++++++++++
> >  .../rcutorture/configs/hazptr/READERS4.boot      |  2 ++
> >  4 files changed, 36 insertions(+)
> >  create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/R=
EADERS0
> >  create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/R=
EADERS0.boot
> >  create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/R=
EADERS4
> >  create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/R=
EADERS4.boot
> >
> > diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/READERS0=
 b/tools/testing/selftests/rcutorture/configs/hazptr/READERS0
> > new file mode 100644
> > index 000000000000..c5b12f3bef74
> > --- /dev/null
> > +++ b/tools/testing/selftests/rcutorture/configs/hazptr/READERS0
> > @@ -0,0 +1,16 @@
> > +CONFIG_SMP=3Dy
> > +CONFIG_NR_CPUS=3D16
> > +CONFIG_PREEMPT_NONE=3Dn
> > +CONFIG_PREEMPT_VOLUNTARY=3Dn
> > +CONFIG_PREEMPT=3Dy
> > +CONFIG_HZ_PERIODIC=3Dn
> > +CONFIG_NO_HZ_IDLE=3Dy
> > +CONFIG_NO_HZ_FULL=3Dn
> > +CONFIG_HOTPLUG_CPU=3Dy
> > +CONFIG_SUSPEND=3Dn
> > +CONFIG_HIBERNATION=3Dn
> > +CONFIG_DEBUG_LOCK_ALLOC=3Dn
> > +CONFIG_PROVE_LOCKING=3Dn
> > +CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dn
> > +CONFIG_DEBUG_KERNEL=3Dy
> > +CONFIG_HAZPTR_DEBUG=3Dy
> > diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/READERS0=
.boot b/tools/testing/selftests/rcutorture/configs/hazptr/READERS0.boot
> > new file mode 100644
> > index 000000000000..f5564c218902
> > --- /dev/null
> > +++ b/tools/testing/selftests/rcutorture/configs/hazptr/READERS0.boot
> > @@ -0,0 +1,2 @@
> > +hazptrtorture.nreaders=3D0
> > +hazptrtorture.torture_type=3Dhazptr-stack
> > diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/READERS4=
 b/tools/testing/selftests/rcutorture/configs/hazptr/READERS4
> > new file mode 100644
> > index 000000000000..c5b12f3bef74
> > --- /dev/null
> > +++ b/tools/testing/selftests/rcutorture/configs/hazptr/READERS4
> > @@ -0,0 +1,16 @@
> > +CONFIG_SMP=3Dy
> > +CONFIG_NR_CPUS=3D16
> > +CONFIG_PREEMPT_NONE=3Dn
> > +CONFIG_PREEMPT_VOLUNTARY=3Dn
> > +CONFIG_PREEMPT=3Dy
> > +CONFIG_HZ_PERIODIC=3Dn
> > +CONFIG_NO_HZ_IDLE=3Dy
> > +CONFIG_NO_HZ_FULL=3Dn
> > +CONFIG_HOTPLUG_CPU=3Dy
> > +CONFIG_SUSPEND=3Dn
> > +CONFIG_HIBERNATION=3Dn
> > +CONFIG_DEBUG_LOCK_ALLOC=3Dn
> > +CONFIG_PROVE_LOCKING=3Dn
> > +CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dn
> > +CONFIG_DEBUG_KERNEL=3Dy
> > +CONFIG_HAZPTR_DEBUG=3Dy
> > diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/READERS4=
.boot b/tools/testing/selftests/rcutorture/configs/hazptr/READERS4.boot
> > new file mode 100644
> > index 000000000000..0d0df3f7dca4
> > --- /dev/null
> > +++ b/tools/testing/selftests/rcutorture/configs/hazptr/READERS4.boot
> > @@ -0,0 +1,2 @@
> > +hazptrtorture.nreaders=3D4
> > +hazptrtorture.torture_type=3Dhazptr-stack
> > --
> > 2.43.0
> >
