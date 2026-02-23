Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04272314D14
	for <linux-arch@vger.kernel.org>; Mon, 23 Feb 2026 17:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771868599; cv=pass; b=hnspuOb2onKj0gtu+ZacaUHvDeGye99QZz4ReHnVUvCIgL9N9wf8DAURJaSqcRgGLwWuF2Grs07PonXLlMbtqDI3r/Y58JK8/WOEbTOTT6KBS/L9qHh2CYq+VuMetOU7mkULRjP9VaZVsiAkYxIuHXcX85HYiqsxn1ap4dRNApQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771868599; c=relaxed/simple;
	bh=UpLPt/oB8+XkGfOx/1ojVQnuH+pIsA+hVmjvI/oayfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Na5ceKi6jip5eWXorqfnTXSqMfRpFa1shVQuXowdYucNEZeIxFJ7k7qzZKH/uU/diRb9+/EM8Uo9jS4ztBT0rNCZwgzEp7hkJDjeAiS5b5oR/jC+3RHqy0JuwvmtYPs9qK68KnVWa2esAXNtdOgz/0s7tDr0v0wS0W/ctRwP07I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oU7sspAc; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oU7sspAc"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a964077671so3045ad.0
        for <linux-arch@vger.kernel.org>; Mon, 23 Feb 2026 09:43:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771868597; cv=none;
        d=google.com; s=arc-20240605;
        b=YSfM9ZadnynBnCl/0BS/FM8wf0fyUTQSH2Ra/uidiWDOBqRfIc9DR5pFDbmenCs3Hy
         Z3tUp1VPIpM7A/1wLKS/G1LpamQSX5X87AOuLTyaNXlbb1GipOWBmDpFqosn1iID/Ewr
         SnpqTRYMjHWMa67oGXJv2BRwWdrwIrlx171SR8iQcBVRWRga88t/Bx28iDr9CueSRVal
         m8048sqiTRo1LFBW/CQbmcL2MHY9vff8OANrNNN38kqGbPf2Iq6MqWym0xn9+ZKziniA
         gIUHj+IfBvEymm4GA7F+nlR/quscat7PfTE7cQw5gos7dLVYwszTJFPZJ9FE9vtOM9Hm
         ktog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nchrh37I6wEN3HEejFjQWq3au44qPr6w+TKeLWlYsk4=;
        fh=G8xhl5OfVyBQYNJTG1qEpd1ZiEc21IiB46ELSxAmWwY=;
        b=f3VhHYgbVV5Zhdc7ZGcxbJHZ4gO2SvbFd483VE1Fjjj8Rz9WOxG0jQGM+daatDJ0iS
         uQowjqdx6W+q+PvS8zP5htBRDXs43MA0HB8PAjI670D2d8qggYedKQnv4GOUjV2eUMuc
         E3i37L17AHcIkIwLCRy7ibuQ9i/zb4NOZIAliIw4L+zbtR2VGzXTOijjk6RKLr419O4Q
         KQYRo6PLFMduSRFhFbwF4SP7aSJ6RoRoqqtUTrl6I2BFB7HSMu3XBHDswm/5b2XCofSM
         OAjjv9k9/huuPWB39GJIoGMcci0G0LbZKmcfHzt9J01A7FJyr9iC/ffuHY6D+tnBPP/U
         QriA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771868597; x=1772473397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nchrh37I6wEN3HEejFjQWq3au44qPr6w+TKeLWlYsk4=;
        b=oU7sspAck7q1pvjMGUrZdRlERrBobRxNJZi7LJnBFhNdpx9agMPji5/xUBYW4d2l3G
         y8ChJcUXkTNRJ05LIgpEu6cfBV8JR+97GPv13w9qGcGRqOZRAFYyev9KjgJuTr6wZyU6
         R3dyG+01wu5S7a8El8Oe7Qne4SgBYkouMVQBHAbrhE+YN2awOrs+ddt++ETLt2GQPfCS
         Ejzab//HHSv4+qWbpoBvRqQt4Aw3Jz46JGjWRuaS+2RFUBKWtvJEU3kPsn/Lwz0kxDsb
         SchTAE7RrRB13iT/f4ZDiHE/N+97RVPggzCERjexkBQGZqaDephNN7lf92jHxMSi3PZd
         5RDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771868597; x=1772473397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nchrh37I6wEN3HEejFjQWq3au44qPr6w+TKeLWlYsk4=;
        b=w/EqGY48PLG8E6aVgTKYK4Eaj03anNMC7ovYT5zCz2hEk0dWKsyUvAw2jz093vw35j
         E3JO0POyiHUCIQcXeUXmcgokZrk8p3UobDfPoIdNOVBqKt7gPNN1qeuB1oeb6Oa/5BI4
         QIMvqYn7xEBm3RuCCYxonadvz7XedmmjRFGdFPRa5mKgkAcJQjOrJnZRUu/FtdumcqvF
         4KUko7bBeC1petvztaLf+6QTBB+boMBgpohOackay7O30WbsTIj0HgccGFNSaFtI9BhX
         Wv5DjAMze65qRmOsLxagfuSiEDXYeRD8u9DkxxsT5bDT+t5XGmUgKCEFi8Medj7TpeXj
         /rmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJJunISTJODzzTwQBQ2ou330QN3QR1Tf2xkkeH/3+EjVOQVp9HiFmkquidGoGhUjoQbZs2NroUN9ep@vger.kernel.org
X-Gm-Message-State: AOJu0YxJGZbH8sd5fAGvrf5taw8/7pNccaKfHDjUbUB9ZAWYDtgC2NUO
	RM92BZKaPx5V+lECkP4dZ4A8vnNnvMfNS7vEcgcmv3fe5npv0tz6at3iH3JfSvR0MHHZdC7LJyN
	vI7NIbApc6RQMW5TATVcmQm+GPz5URF2VwgpXGgFM
X-Gm-Gg: ATEYQzyCWVlCUXTMznMJN6ei/0UCvFp+vgG74E1Ah2ew+ByB6XxzpCGK2jIUpK7Fy7i
	bbPdOuiU1XFYwCJC7NuDgKaVzPRM619mccfj6L16PkmV1Zcp1nvJ2aBlL2e2WRCfxUvwethSvIq
	wwStNwwJe9iFUn131Us8OA5f6Hcbt4hRyMpZsc1eKPzrNTfCHLVjITvhE/XvnBY4QXWEweFi/kt
	B1VlKrusUimGctmic3yfvly+Xc6TzNjwf1Wy00bjq5Bgik4QIhHmIULZ7/RrcoEBQtKr1vT3b9O
	TC4xQTTQB+jusENL3h7juNJzMEiBrvNEvs0=
X-Received: by 2002:a17:903:1746:b0:2a3:cd98:f07 with SMTP id
 d9443c01a7336-2ad75ce8893mr2648175ad.3.1771868596848; Mon, 23 Feb 2026
 09:43:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820010415.699353-1-anthony.yznaga@oracle.com>
 <CAC_TJvcaJdEzK8n9BK0qgEXdzjzXtbA_Zk-ybfmG8kjNExVCzw@mail.gmail.com> <fqabaahjjlmoc2xh4cwh4ykbqyu3rnzvjw5epxi5wwpmgqth7f@d3mqpjozwmo4>
In-Reply-To: <fqabaahjjlmoc2xh4cwh4ykbqyu3rnzvjw5epxi5wwpmgqth7f@d3mqpjozwmo4>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Mon, 23 Feb 2026 09:43:03 -0800
X-Gm-Features: AaiRm50m9UYvsRrMNZGeDJldRqqXCjwlRuVa1vgsK31xKBtD7H4yIH2DN8vqIDQ
Message-ID: <CAC_TJvdRsfzYohiKW=82N8Ofi5V26rX1GS0M8HeaX6CEsgc+PA@mail.gmail.com>
Subject: Re: [PATCH v3 00/22] Add support for shared PTEs across processes
To: Pedro Falcato <pfalcato@suse.de>
Cc: Anthony Yznaga <anthony.yznaga@oracle.com>, linux-mm@kvack.org, 
	akpm@linux-foundation.org, andreyknvl@gmail.com, arnd@arndb.de, bp@alien8.de, 
	brauner@kernel.org, bsegall@google.com, corbet@lwn.net, 
	dave.hansen@linux.intel.com, david@redhat.com, dietmar.eggemann@arm.com, 
	ebiederm@xmission.com, hpa@zytor.com, jakub.wartak@mailbox.org, 
	jannh@google.com, juri.lelli@redhat.com, khalid@kernel.org, 
	liam.howlett@oracle.com, linyongting@bytedance.com, 
	lorenzo.stoakes@oracle.com, luto@kernel.org, markhemm@googlemail.com, 
	maz@kernel.org, mhiramat@kernel.org, mgorman@suse.de, mhocko@suse.com, 
	mingo@redhat.com, muchun.song@linux.dev, neilb@suse.de, osalvador@suse.de, 
	pcc@google.com, peterz@infradead.org, rostedt@goodmis.org, rppt@kernel.org, 
	shakeel.butt@linux.dev, surenb@google.com, tglx@linutronix.de, 
	vasily.averin@linux.dev, vbabka@suse.cz, vincent.guittot@linaro.org, 
	viro@zeniv.linux.org.uk, vschneid@redhat.com, willy@infradead.org, 
	x86@kernel.org, xhao@linux.alibaba.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 21, 2026 at 4:40=E2=80=AFAM Pedro Falcato <pfalcato@suse.de> wr=
ote:
>
> On Fri, Feb 20, 2026 at 01:35:58PM -0800, Kalesh Singh wrote:
> > On Tue, Aug 19, 2025 at 6:57=E2=80=AFPM Anthony Yznaga
> > <anthony.yznaga@oracle.com> wrote:
> > >
> > > Memory pages shared between processes require page table entries
> > > (PTEs) for each process. Each of these PTEs consume some of
> > > the memory and as long as the number of mappings being maintained
> > > is small enough, this space consumed by page tables is not
> > > objectionable. When very few memory pages are shared between
> > > processes, the number of PTEs to maintain is mostly constrained by
> > > the number of pages of memory on the system. As the number of shared
> > > pages and the number of times pages are shared goes up, amount of
> > > memory consumed by page tables starts to become significant. This
> > > issue does not apply to threads. Any number of threads can share the
> > > same pages inside a process while sharing the same PTEs. Extending
> > > this same model to sharing pages across processes can eliminate this
> > > issue for sharing across processes as well.
> > >
> > > <snip>
> > Hi Anthony,
> >
> > Thanks for continuing to push this forward, and apologies for joining
> > this discussion late. I am likely missing some context from the
> > various previous iterations of this feature, but I'd like to throw
> > another use case into the mix to be considered around the design of
> > the sharing API.
> >
> > We are exploring a similar optimization for Android to reduce page
> > table overhead. In Android, we preload many ELF mappings in the Zygote
> > process to help application launch times. Since the Zygote model is
> > fork-but-no-exec, all applications inherit these mappings, which can
> > result in upwards of 200 MB of redundant page table overhead per
> > device.
>
> This can be solved by simply not using the Zygote model :p Or perhaps
> MADV_DONTNEED/straight up unmapping libraries you don't need in the child=
's
> side.

I think that's a separate topic, but that model is used on billions of
client devices :) The common runtime for apps and other core system
code is preloaded to significantly reduce app startup latencies.

>
> >
> > I believe that managing a pseudo-filesystem (msharefs) and mapping via
> > ioctl during process creation could introduce overhead that impacts
> > app startup latency. Ideally, child apps shouldn't be aware of this
> > sharing or need to manage the pseudo-filesystem on their end. To
> > achieve this "transparent" sharing, I would prefer Khalid's previous
> > API from his 2022 RFC [1]. By attaching the shared mm directly to the
> > file's address_space and exposing a MAP_SHARED_PT flag, child apps
> > could transparently inherit the shared page tables during fork().
>
> So, we've discussed this before. I initially liked this idea a lot more.
> However, there are a couple of problems here:
>
> 1) mshare (as in the mshare feature) isn't really aiming for transparent =
here.
> There is e.g a specific need to setup an mshare region, with a few files/=
anon
> there, and then later mprotect/munmap parts of the region - and have it a=
pply
> on every process that has it mapped. This is why we're aiming for differe=
nt
> system calls (not ioctls anymore), doing munmap(mshare_reg, 4096) is ambi=
guous
> as to whether you want to unmap the mshare VMA, or a VMA inside the mshar=
e mm.

Since we are interested in sharing text here, how does this play with
stuff like symbolization for call stacks? I believe this is another
reason where we might want to avoid mapping the pseudo mshare file
wrapper?

>
> 2) Sharing the page table at all (even worse so, Transparently(tm)) is a =
huge
> pain. TLB shootdown becomes much harder, and rmap as-is isn't suited to d=
eal
> with this case. The way things are going with mshare, the container mm wi=
ll
> have one single entry in rmap, and then actually doing the shootdown is a
> huuuuge pain (which, fwiw, will probably need a per-mshare TLB workaround=
),
> because you need to find out and shoot down _every_ mm that has these tab=
les

I agree the TLB shootdowns would be a pain. Perhaps, if there was a
concept of a shared ASID/PCID in the hardware, that would make things
less so ...

> mapped. And then, naturally, since you're sharing page tables, doing A/D =
bit
> collection on these becomes extremely useless - and that will naturally p=
ose
> problems to the reclaim process if you abuse it.

I think in the use case I described, it would mostly be sharing
MAP_PRIVATE stuff, and the access bit should still apply for global
reclaim. However, I agree it becomes difficult to reason especially if
you throw memcgs into the mix.

Thanks,
Kalesh

>
> 3) other misc problems that make it hard to work transparently (VMA align=
ment,
> levels which you may or may not want to share, you need to revisit most p=
age
> table walkers in the kernel to get a completely transparent feature, etc)
>
> >
> > Regarding David's and Matthew's discussion on VMA-modifying functions,
> > I would lean towards the standard VMA manipulating APIs should be
> > preferred over custom ioctls to preserve transparency for user-space.
> > Perhaps whether or not these modifications persist across all sharing
> > processes needs to be configurable? It seems that for database
> > workloads, having the updates reflected everywhere would be the
> > desired behavior. In the use case described for Android, we don't want
> > apps to be able to modify these shared ELF mappings. To handle this,
> > it's likely we would do something like mseal() the VMAs in the dynamic
> > loader before forking.
>
> mshare_mseal!
>
> >
> > Perhaps we could decouple the core sharing logic from the sharing API
> > itself? Since the sharing interface seems one of  the main areas where
> > we don't have a good consensus yet, perhaps we could land the core
> > sharing logic first. Keeping the core infrastructure generic would
>
> I think the core infrastructure is relatively generic (at least the
> small core mm modifications to get this to even work) already, but
> perhaps Anthony can comment on that.
>
> --
> Pedro
