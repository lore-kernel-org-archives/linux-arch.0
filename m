Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3382236655A
	for <linux-arch@vger.kernel.org>; Wed, 25 Feb 2026 22:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772060044; cv=pass; b=ZMvBJp5qhnnVGNSDIgnK1Jgex7KkxnH9jgFmkGXpHPQX1vBqkcYgZqc+qoXcI1p/sksinQ/lzXCSn+4wREFqcO+MQqoeYFZzYuGW488adhUB3wxKbGLwSHEr/MoXqTIeyZIERkoUpKBSMftca3zeZq1bW7UisztnD7ATDA4Jekw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772060044; c=relaxed/simple;
	bh=AA8Dha/bfnPZLgD3DchzKVXjebkJkUtPW4e/jFBhSi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lji0K6q1CM/JGypynhPeopC8R1yj1RemYRRWY66anfRhQp/44063ZYR8xSSQ+RIfRc/gKOPqqGweKSprOIALAXo3UgDSthMovWwPzOaIimgNHF4pCzfsy2/fLddKK79JXTJaq9cFc+666ztXe93DAVWP4iYyGfIppK8D1a2u9BI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n0lPkRCn; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n0lPkRCn"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2adb1c1f9d4so35155ad.0
        for <linux-arch@vger.kernel.org>; Wed, 25 Feb 2026 14:54:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772060043; cv=none;
        d=google.com; s=arc-20240605;
        b=HHbp9fhBzOj3zqfmeDqtGy3OPlTmxNlCaNgcndSPikoVi/Tm1MxV/dHxUXwI3AfMtB
         SUB8tAmh3HoeiC6645820vj4h0bxW85Qo1S4X1u8j4WrrMALQPJQWR2PQiQs3qid0LPM
         oRKBmr5yeFwDhvT6bN6BfIo9H9Hv9BTHD+XDrWyW62nHi2znHlWxomOlcadeMwVJp1iU
         gHEyujGP0Ss1eNtcqI977SIEHl4ZZ5tTiFW0E6aje+uJShxZWy8QXMEd8HaKiSj3upyI
         Way1gpzXxRhEJVSVZjCr3ZA3O0it1u6znOGCV9FITMspxjo844jjckoTcGc2AMwh3cza
         iIKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4HuRDvA6p5zItbneJew7P4gaYb7aavWFbfaGOQjNc2g=;
        fh=SnE0XUKwREL6UigigMgxF1ZkxqYf8K4MqfPZr6BaYIg=;
        b=YKtEHSHgFXG0Te7zsfNWEMflJYtOChUe6qPDosPiYq3ygMyACAc1itZ2wQhQbmnMiC
         SoY3OapIWYh5LczVCRLzd/a9rkNYztptNnAjiNqEQH0ySiq/eMRtpPuhYB3ZxMZmhRFp
         lV7an6pRyWL5X0DrsAbXDy42MiUPC/n9ftkzPZKYQq8XvRK7NXpAHXzWNVNLM9+89Mfj
         Yk0rd2MGS7fV4Ctq8tK0CgB/TshC7Lx2kKXelRFpSkTENDE5j9B3DpaampK3O7ntoG87
         QlNfkjXGrMs9zFekQ80rutpDJXvpAIjV9c7mTnKWuIAiHE0eErKDfYVPA89CCxm5V9nF
         Swxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772060043; x=1772664843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HuRDvA6p5zItbneJew7P4gaYb7aavWFbfaGOQjNc2g=;
        b=n0lPkRCnlaKPc31W+Ixe9a5yrxUPeK30kELXwBMMBSlsBGacPr38z18oyIJHAvLju7
         UpvZl4VEMou7fB9uCdA2oRI9F2OcwqwhSn83G/ECf/9d1Iu9gGVVy1iXfvK4WsMYRemG
         R+0QprEZbE/i4+aBOa3jRjwW6+/Hbq79BLV8eVrs8SxKhUL4+6p3aLcAiWktBbOJmvU6
         AChCGJ/M2XvJliLlEFfO2OzJ9+msQzDr6PIeLvKtNqS4+C4R+2bzKm9RbwZnKwQi3w5K
         6zObqdYNGjpMA/9TVMBT31x2MuEL3xksxZ0UGOcwCvL8lbo+hzpWpznit0s+6O9dq/rX
         Jt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772060043; x=1772664843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4HuRDvA6p5zItbneJew7P4gaYb7aavWFbfaGOQjNc2g=;
        b=KnCcHi7I7qWn37R2F/acFosQnQnJvmm5SzY+HjA8xVfvSi62gkzPIPfHK+2Xg1uWfx
         RKyW8je5ZTWnJb/tXGhnzUJYppNNlVrZG5FGFRBC5HSTlWDmRK9h+kUvz2bZwKsJFnMh
         Hn457CunaU7KPPwXkhLfgeEihreYYBrmnfBOsv9tZJI7lH2Q11v9yt32b3foDNvmPuYi
         qvOJV8Cdj9E4kHC2VJKd609pRcFhaLiru+QjZ2rc90UkHSuGddrOzQiDVTokBMqGk2ky
         jWyjyav6a84nd/ipH0pIcTjO4t/EI5hNbIQhB6bsvSzzntlco93eCVoV6kftu0hZu6cF
         oj7g==
X-Forwarded-Encrypted: i=1; AJvYcCXRlngxTR9AFzYlmNQat561jqTHLAlAUWnU3EdORIpHmSZVsjcvgJ8rtY+vHJ16X9e2ilzCW09oH6WH@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp4Uwi3htowzbpJExYhCdifDRkQtsBR0w+nhNhXK29LuSw7Y7C
	MEljggu1bosJ/pLpMw5oY0OOHb5a0Mh/mX/aRYTBO1OpuaJg8bw+f+LEYZ84eBHgTJYpt5XTPQi
	5Mf1QDfsrlNQFsneLg6zHMHZWt/MZmy2SyJPjoS5y
X-Gm-Gg: ATEYQzzkXJgfjWucAkdlBUKjw7RuGr0TRoEMSgxr29DfxfkkVvZKdUQXaIyC+qKU+bg
	4g+IFB2xYUB8n0rhxtbNs3b/dUFmONEZ0CAOTLI+/WZzgSkuByZUGaE0spmayVtENt6fLZdFsia
	Slpkk7+xgB9jic94QLDpPWm3T4NT3c4xsA9f/xo65/uHy0lVjmfIwGkUqU+EpBBDXOzAKFWBgyq
	ZA/3FfFhxBmsON136aq3j0Ovyh+5b3lwgDAs4j7SG2/G4e6Iph7HmnjNBLM3x7jvm/n/pdU6jq6
	8RRXXH2DcwJ2sg6hmkj/vSPbrx1Whqhrjh4YwQ==
X-Received: by 2002:a17:903:8c4:b0:2a8:ffed:4663 with SMTP id
 d9443c01a7336-2adf7738436mr799085ad.12.1772060041893; Wed, 25 Feb 2026
 14:54:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820010415.699353-1-anthony.yznaga@oracle.com>
 <CAC_TJvcaJdEzK8n9BK0qgEXdzjzXtbA_Zk-ybfmG8kjNExVCzw@mail.gmail.com>
 <fqabaahjjlmoc2xh4cwh4ykbqyu3rnzvjw5epxi5wwpmgqth7f@d3mqpjozwmo4>
 <CAC_TJvdRsfzYohiKW=82N8Ofi5V26rX1GS0M8HeaX6CEsgc+PA@mail.gmail.com> <7302e25b-dfcb-4117-85f9-870632999dc3@oracle.com>
In-Reply-To: <7302e25b-dfcb-4117-85f9-870632999dc3@oracle.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Wed, 25 Feb 2026 14:53:49 -0800
X-Gm-Features: AaiRm5115WEriTEwyOL6pAVEQGUSdPho0h6nJ0kCy4aKIpi-RiI2rNOQ4qeMtvg
Message-ID: <CAC_TJvc+Ld19MrqQbTLkLXbLe3D8nYNP2DkD0knv+u7mjRC++A@mail.gmail.com>
Subject: Re: [PATCH v3 00/22] Add support for shared PTEs across processes
To: anthony.yznaga@oracle.com, 
	"David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, akpm@linux-foundation.org, 
	andreyknvl@gmail.com, arnd@arndb.de, bp@alien8.de, brauner@kernel.org, 
	bsegall@google.com, corbet@lwn.net, dave.hansen@linux.intel.com, 
	david@redhat.com, dietmar.eggemann@arm.com, ebiederm@xmission.com, 
	hpa@zytor.com, jakub.wartak@mailbox.org, jannh@google.com, 
	juri.lelli@redhat.com, khalid@kernel.org, liam.howlett@oracle.com, 
	linyongting@bytedance.com, lorenzo.stoakes@oracle.com, luto@kernel.org, 
	markhemm@googlemail.com, maz@kernel.org, mhiramat@kernel.org, mgorman@suse.de, 
	mhocko@suse.com, mingo@redhat.com, muchun.song@linux.dev, neilb@suse.de, 
	osalvador@suse.de, pcc@google.com, peterz@infradead.org, rostedt@goodmis.org, 
	rppt@kernel.org, shakeel.butt@linux.dev, surenb@google.com, 
	tglx@linutronix.de, vasily.averin@linux.dev, vbabka@suse.cz, 
	vincent.guittot@linaro.org, viro@zeniv.linux.org.uk, vschneid@redhat.com, 
	willy@infradead.org, x86@kernel.org, xhao@linux.alibaba.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, android-mm <android-mm@google.com>, 
	"T.J. Mercier" <tjmercier@google.com>, Isaac Manjarres <isaacmanjarres@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 11:59=E2=80=AFAM <anthony.yznaga@oracle.com> wrote:
>
>
> On 2/23/26 9:43 AM, Kalesh Singh wrote:
> > On Sat, Feb 21, 2026 at 4:40=E2=80=AFAM Pedro Falcato <pfalcato@suse.de=
> wrote:
> >> On Fri, Feb 20, 2026 at 01:35:58PM -0800, Kalesh Singh wrote:
> >>> On Tue, Aug 19, 2025 at 6:57=E2=80=AFPM Anthony Yznaga
> >>> <anthony.yznaga@oracle.com> wrote:
> >>>> Memory pages shared between processes require page table entries
> >>>> (PTEs) for each process. Each of these PTEs consume some of
> >>>> the memory and as long as the number of mappings being maintained
> >>>> is small enough, this space consumed by page tables is not
> >>>> objectionable. When very few memory pages are shared between
> >>>> processes, the number of PTEs to maintain is mostly constrained by
> >>>> the number of pages of memory on the system. As the number of shared
> >>>> pages and the number of times pages are shared goes up, amount of
> >>>> memory consumed by page tables starts to become significant. This
> >>>> issue does not apply to threads. Any number of threads can share the
> >>>> same pages inside a process while sharing the same PTEs. Extending
> >>>> this same model to sharing pages across processes can eliminate this
> >>>> issue for sharing across processes as well.
> >>>>
> >>>> <snip>
> >>> Hi Anthony,
> >>>
> >>> Thanks for continuing to push this forward, and apologies for joining
> >>> this discussion late. I am likely missing some context from the
> >>> various previous iterations of this feature, but I'd like to throw
> >>> another use case into the mix to be considered around the design of
> >>> the sharing API.
> >>>
> >>> We are exploring a similar optimization for Android to reduce page
> >>> table overhead. In Android, we preload many ELF mappings in the Zygot=
e
> >>> process to help application launch times. Since the Zygote model is
> >>> fork-but-no-exec, all applications inherit these mappings, which can
> >>> result in upwards of 200 MB of redundant page table overhead per
> >>> device.
> >> This can be solved by simply not using the Zygote model :p Or perhaps
> >> MADV_DONTNEED/straight up unmapping libraries you don't need in the ch=
ild's
> >> side.
> > I think that's a separate topic, but that model is used on billions of
> > client devices :) The common runtime for apps and other core system
> > code is preloaded to significantly reduce app startup latencies.
> >
> >>> I believe that managing a pseudo-filesystem (msharefs) and mapping vi=
a
> >>> ioctl during process creation could introduce overhead that impacts
> >>> app startup latency. Ideally, child apps shouldn't be aware of this
> >>> sharing or need to manage the pseudo-filesystem on their end. To
> >>> achieve this "transparent" sharing, I would prefer Khalid's previous
> >>> API from his 2022 RFC [1]. By attaching the shared mm directly to the
> >>> file's address_space and exposing a MAP_SHARED_PT flag, child apps
> >>> could transparently inherit the shared page tables during fork().
> >> So, we've discussed this before. I initially liked this idea a lot mor=
e.
> >> However, there are a couple of problems here:
> >>
> >> 1) mshare (as in the mshare feature) isn't really aiming for transpare=
nt here.
> >> There is e.g a specific need to setup an mshare region, with a few fil=
es/anon
> >> there, and then later mprotect/munmap parts of the region - and have i=
t apply
> >> on every process that has it mapped. This is why we're aiming for diff=
erent
> >> system calls (not ioctls anymore), doing munmap(mshare_reg, 4096) is a=
mbiguous
> >> as to whether you want to unmap the mshare VMA, or a VMA inside the ms=
hare mm.
> > Since we are interested in sharing text here, how does this play with
> > stuff like symbolization for call stacks? I believe this is another
> > reason where we might want to avoid mapping the pseudo mshare file
> > wrapper?
>
> I haven't explored shared text, yet. There may be dragons there.
>
>
> >
> >> 2) Sharing the page table at all (even worse so, Transparently(tm)) is=
 a huge
> >> pain. TLB shootdown becomes much harder, and rmap as-is isn't suited t=
o deal
> >> with this case. The way things are going with mshare, the container mm=
 will
> >> have one single entry in rmap, and then actually doing the shootdown i=
s a
> >> huuuuge pain (which, fwiw, will probably need a per-mshare TLB workaro=
und),
> >> because you need to find out and shoot down _every_ mm that has these =
tables
> > I agree the TLB shootdowns would be a pain. Perhaps, if there was a
> > concept of a shared ASID/PCID in the hardware, that would make things
> > less so ...
>
> That would certainly help. sparc64 has a secondary context, but that
> doesn't do us any good here. :-)
>
>
> >
> >> mapped. And then, naturally, since you're sharing page tables, doing A=
/D bit
> >> collection on these becomes extremely useless - and that will naturall=
y pose
> >> problems to the reclaim process if you abuse it.
> > I think in the use case I described, it would mostly be sharing
> > MAP_PRIVATE stuff, and the access bit should still apply for global
> > reclaim. However, I agree it becomes difficult to reason especially if
> > you throw memcgs into the mix.
>
> mshare won't support mapping objects in it with MAP_PRIVATE. Sharing
> PTEs to memory that can be COW'd is problematic. If it's something that
> can be adapted to use MAP_SHARED then maybe things can work.

I can see how mapping .text and .rodata as MAP_SHARED could
technically work, assuming the sharing process strictly mseals them to
guarantee they remain immutable. However, RELRO (.data.rel.ro) is a
different story. It must initially be mapped MAP_PRIVATE and writable
so that the dynamic linker can resolve relocations. Because these
modified pages cannot be written back to the backing file, they become
private anonymous pages.

If there was a way to allow an initially RW MAP_PRIVATE mapping to
resolve its relocations, be write-protected, mseal'd, and then have
its page tables shared, that would solve the RELRO issue. In the
Android Zygote model, this works perfectly because relocations resolve
before forking, meaning the resolutions are identical for all
children.

But how would we express this in the msharefs model? Transitioning a
post-CoW MAP_PRIVATE VMA into a shared page table structure seems
fundamentally at odds with a strictly MAP_SHARED file-backed
pseudo-filesystem approach.

>
> As for memcgs, the current idea is to have an owner associated with an
> mshare region. Currently this is the process that creates the region.
> Mappings in an mshare region will be evaluated against the mem cgroup
> the owner is a part of.

I'd also like to think a bit about what happens to other standard
memory metrics. Should accounting that actively walks the page tables
(like /proc/pid/smaps) still work correctly and see the mappings?

What happens with the counter-based metrics tied directly to the
mm_struct rss stats?

Since msharefs manages its own detached mm_struct, should we include
those RSS counts across all sharing processes when reporting in
/proc/*/status? Or will we need to introduce a new UAPI to
independently expose and understand the RSS of each msharefs
mm_struct?

Thanks,
Kalesh

>
> Thanks,
> Anthony
>
>
> >
> > Thanks,
> > Kalesh
> >
> >> 3) other misc problems that make it hard to work transparently (VMA al=
ignment,
> >> levels which you may or may not want to share, you need to revisit mos=
t page
> >> table walkers in the kernel to get a completely transparent feature, e=
tc)
> >>
> >>> Regarding David's and Matthew's discussion on VMA-modifying functions=
,
> >>> I would lean towards the standard VMA manipulating APIs should be
> >>> preferred over custom ioctls to preserve transparency for user-space.
> >>> Perhaps whether or not these modifications persist across all sharing
> >>> processes needs to be configurable? It seems that for database
> >>> workloads, having the updates reflected everywhere would be the
> >>> desired behavior. In the use case described for Android, we don't wan=
t
> >>> apps to be able to modify these shared ELF mappings. To handle this,
> >>> it's likely we would do something like mseal() the VMAs in the dynami=
c
> >>> loader before forking.
> >> mshare_mseal!
> >>
> >>> Perhaps we could decouple the core sharing logic from the sharing API
> >>> itself? Since the sharing interface seems one of  the main areas wher=
e
> >>> we don't have a good consensus yet, perhaps we could land the core
> >>> sharing logic first. Keeping the core infrastructure generic would
> >> I think the core infrastructure is relatively generic (at least the
> >> small core mm modifications to get this to even work) already, but
> >> perhaps Anthony can comment on that.
> >>
> >> --
> >> Pedro
