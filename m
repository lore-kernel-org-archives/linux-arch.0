Received: from outbound.ms.icloud.com (p-west3-cluster5-host5-snip4-5.eps.apple.com [57.103.72.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA13B263F5E
	for <linux-arch@vger.kernel.org>; Sat,  2 May 2026 05:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.72.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777698389; cv=none; b=tYA6T90GReb9bmDGR2UEYgPm6K6MoQv7z6YoaJJelY6I29SjEUjZrSCyS7Fj9Lklt/rjA3OvCxawRBtB3wnllUzrGZquTyDZi6wmwAMyOOiOR/URHEbFnHKcpdW7nHcXI63dk99yAx9ngSI5TT3JIjg2F0SzIH0antCFnQ/Zu4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777698389; c=relaxed/simple;
	bh=zFoEHfPR8cJmzJa7YGWhhXovDcPeM30LuVZl3ibSp08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0yBcIhKuoy/GH9QAfEzYWnTVPmdgPRktXpuidK+8LVeojlq2//w+MbBVwU32pHnBDK4sXA9h7kUqz0pzJY9XHapP2FfcWiZ3IDTS7OnzL40bOp1eoC+fspJ9/Y96N5p1V32INzxV74HzjlSsAm4LerIisija6w37UwHp2nTMlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=o5CVhdBY; arc=none smtp.client-ip=57.103.72.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="o5CVhdBY"
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-100-percent-11 (Postfix) with ESMTPS id 679B7180010F;
	Sat, 02 May 2026 05:06:24 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhAA0MFWgFeAUEdXwFLVxQEFEYGVg1dE0wLcwRUB10FXVZQAlpLVBQEFEYGVg1dE0wLcwRUB10FXVZQAlpLQBMESgZNXw5eHwQXRhlVBEceXVZeHhkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4EVAddBV1WUAJaS18ZXUUPDFE8dSNKS0RaYTtRHWkUeC17Pnkxezl6QHooA04ZDEodUlZbE1UXRgk=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1777698387; x=1780290387; bh=eXyCcuhff3Muw13ytVc8r3c1ETz4ajbUvk27BTvdfbU=; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=o5CVhdBYLnOmy4aGCa4HLeA6lPv3dpIsNnDXKhNwSvPNZSCo6FkqvYGG3kA4gUN/JYjtDR1kfqDaZ5o5TmRlnBjhKGQ7AsGSNNdeRudqS+gTU0CCHfLK6xirdrjSeoB8FBkOxPP2v19wbFHKFP9yo8Q8To63Iq6z3YrqaTfbn7P8cE0pn5vzRbdl+rTyKZ5J1H63+AVLS7PL+j8OxNfPgnB2sfKdzMh+if0tAZawGeZe9rASfMiClnv6hmoyK1HSuaM95VvVlRqUOx+rV4oX7hhLmEZjlKQR/7s+vH3ryo8bQJJh2IagAaOqtQhkffh2cycx49gi8PBlGb3b0KOrFQ==
Received: from localhost (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-100-percent-11 (Postfix) with ESMTPSA id 425EC18000BA;
	Sat, 02 May 2026 05:06:23 +0000 (UTC)
Date: Sat, 2 May 2026 13:06:18 +0800
From: Luka Bai <lukafocus@icloud.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	Arnd Bergmann <arnd@arndb.de>, Kairui Song <kasong@tencent.com>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, Luka Bai <lukabai@tencent.com>
Subject: Re: [PATCH 0/5] mm: Support selecting doing direct COW for anonymous
 pmd entry
Message-ID: <afWGSs3w7VPcmPlK@LUKABAI-MC1>
References: <20260501-thp_cow-v1-0-005377483738@tencent.com>
 <b5379cd3-f7bf-47f9-8a60-c7300b4415a2@kernel.org>
 <afTR48WxGnIpxK8a@LUKABAI-MC1>
 <785b6164-aa71-4fc4-a4f3-f4977b7db30e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <785b6164-aa71-4fc4-a4f3-f4977b7db30e@kernel.org>
X-Proofpoint-GUID: aLriYDqX6Wfr6DEL-NnEpDvapidL7Ddn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAyMDA0NyBTYWx0ZWRfX7BA131RWYzYc
 lDIO3AIKEMBEDgkNbAgRbghgsMbxyPHzklMuZLvG+sY1KHn8ZFIJnRB26zEdG889m8NhzJGdPFj
 HUTJ8qaRBcIL6U1nnhD6XPDOZBHWGZwGsDl+MaZg2V5YSo2GhxehTM/SuHzlNB1A42IOdSj0mAJ
 HtX2eGwlO7NYK0sqI+fRbI/n70GpZFtzYrqirwqvGDZGZj3VuR2M0De2XMhDNPIaRjfqOw+77Wj
 w7U2Room2z2IljLjFJ2ln/PXo7PhrssWdf70pNKQc5C5W+/Kzs5hseJGNDKhamPjiYQqj+vmDJQ
 SiB+L0ieg1uFhLL73ivk87vg6gyxQ0YRZ4tKbvvb3yvS2p6NcJMwequwCSpqaQ=
X-Authority-Info-Out: v=2.4 cv=FN0WBuos c=1 sm=1 tr=0 ts=69f58652
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10 a=UaoJkeuwEpQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=Ikd4Dj_1AAAA:8
 a=1XWaLZrsAAAA:8 a=Ycdc37sN3yXXCXtWWT0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: aLriYDqX6Wfr6DEL-NnEpDvapidL7Ddn

在 Fri, May 01, 2026 at 08:30:39PM +0200，David Hildenbrand (Arm) 写道：

Hi David,

Thanks for replying again :). I've read your advices, and I agreed with your opinion,
THP COW is premature now for the upstream, we can reconsider other approaches. :)

> >>
> >> Note that there was a recent related discussion for executable, which was rejected:
> >>
> >> https://lore.kernel.org/r/20251226100337.4171191-1-zhangqilong3@huawei.com
> >>
> > 
> > Yes, I know this history, and I know that it will cost some memory or latency,
> > That’s why I was wondering maybe I can add a switch to it to make it
> > configurable :).
> 
> Switches for something like that is just not a good fit.
> 
> For example, for a short-lived child (e.g., fork+exec) it usually makes no sense
> to cow a larger chunk of address space, when you know that it will exit
> immediately either way and free up the memory.
> 

Yeah, for most workloads, fork will be used with a exec call soon, which makes the
COW for THP not so useful for these workloads.

> >>>
> >>> In addition to the problem above, this logic can also generate some
> >>> deficiency for THP itself. Currently THP is just a "best-effort" choice
> >>> with no "certainty". THP is easily splitted into multiple small pages
> >>> on common calling path like reclaiming, COW. A transparent splitting
> >>> can cause throughput fluctuation for some workloads. For these workloads,
> >>> we may want to give THP some "certainty" just like hugetlbfs,
> >>
> >> There are no such guarantees, though. And We wouldn't want to commit to any such
> >> guarantees today. For example, simple page migration can split the folio.
> >> Allocation failures will fallback to small pages etc.
> >>
> >> If you need guarantees, use hugetlb for now.
> >>
> > 
> > The reason why I want to use THP over hugetlb is that I need reclamation for my
> > workload :). There are many processes in my workload that need 2M
> > aligned folios for better performance, and we want to reclaim them back automatically
> > when the process doesn’t need the folios. 
> 
> Can you share some details how exactly that is supposed to work?
> 

Sorry for that, it's basically just a bunch of processes in the environment with 2M sized
folio as their backend, but we want the OS to reclaim them when it's possible. And we want to
balance performance and memory saving, and don't split so often since it may cause fraction
and may influence the future 2M folio allocation. :)

> > But hugetlbfs cannot do passive reclamation
> > from what I know (except doing active madvise by the processes themselves). And using
> 
> Right, you can only return hugetlb folios by doing MADV_DONTNEED or munmap().
> 
> > THP can easily split the hugepages. So that’s why I would like to add certainty for THP,
> 
> Repeat after me: there are no guarantees. There is no certainty :)
> 
> > and use THP for these processes as backend, because THP is very well integrated with
> > the swap system and other filesystems. And from what I checked,
> > it seems the most common case for splitting a THP is COW and swapping so I am trying
> > to handle these two scenarios (But coincidentally, PMD swapping is committed in
> > https://lore.kernel.org/all/D3F08F85-76E0-4C5A-ABA1-537C68E038B8@nvidia.com/
> > a few days before, which is a great implementation :) ).
> 
> Right, but that really only changes how we map large folios, not how we allocate
> them. There are no guarantees.
> 
> > 
> >>> The effect
> >>> we want is: after some customized setup, if only the system has usable
> >>> folio, and the virtual memory alignment permits (or we setup to), we can
> >>> make sure we always use THP for it, the system will never split it except
> >>> the user wants to do so.
> >>>
> >>> This patchset is about both two things above, firstly we add pmd level
> >>> THP COW support by revising the code in do_huge_pmd_wp_page, we added
> >>> switch for it because different workloads may need different resources,
> >>
> >> The switch is bad, and we won't accept any toggle like that. A system-wide
> >> setting does not make sense for such behavior.
> >>
> > 
> > Oh, the reason why I added a switch globally is also because the scenario I mentioned
> > above, I want those processes to always use PMD sized folios as backend to make sure
> > performance. 
> 
> "Always" is wishful thinking in many scenarios I'm afraid.

Yeah, I agree, so we also think that maybe we can do some other things to increase the
possibility of allocating pmd sized folios. :) 

> 
> > COW is truly not that common like swap out/swap in, it just can happen
> > sometimes, which I guess the reason may be about image duplication. Setting the system
> > globally is more convenient for my situation :). I can go without this global switch
> > if it's more reasonable.
> > 
> >> A per-VMA flag? Maybe, but I expect pushback as well, as it is way too specific.
> >> So we'd have to find some concept that abstracts these semantics. But I expect
> >> pushback as well.
> >>
> >> We messed up enough with toggles in THP space, unfortunately.
> >>
> >> Also, anything that only works for PMD-sized THPs is a warning sign in 2026 :)
> >>
> > 
> > And for PMD-sized THPs, actually, I’m also considering adding more support for
> > COW to mTHP if the upstream consider it useful. And also for pud sized THPs
> > also. But I guess I have to firstly handle stage 1: PMD level COW now :).
> > And also, since PMD sized folio is commonly used in my workload, I'm also wondering
> > digging into pmd sized KSM in the future, in which I think pmd sized COW may
> > be more useful then :).
> 
> I'm afraid I have to stop you right there: there has to be a pretty convincing
> story to add any of that. In particular KSM with large folios (/me shivering).
> 
> But I already don't buy the COW story. Just configure khugepaged in a better way
> or use MADV_COLLAPSE and you don't really need to modify the kernel at all in
> 99.99% of the case. (khugepaged needs a lot of tuning work, it's currently not
> the smartest implementation)
> 
> Maybe, we might give khugepaged better direction of what to try scanning next
> (e.g., where we just COW'ed a THP). Not sure, there are plenty of things to explore.
> 

I see, actually all the things here is about saving memory and keeping the 2M tlb
benifit at the same time, including my KSM thought and THP COW. Giving khugepaged
a better direction is also what we are considering in the next step :).

> > 
> >> You don't really raise any concrete use cases or performance numbers for these
> >> use cases. Some details about applications that use fork() and rely on such
> >> behavior would be helpful.
> >>
> > 
> > Sorry for that, the concrete workload itself hasn't been finished yet. 
> 
> Okay, what I thought after seeing no workloads an no performance numbers :)
> 
> If you don't know the workload, how can you claim that the additional latency
> and/or memory consumption is not a problem?
> 

Oh, our point here is that we don't want these 2M folios to be split, since that
may cause some fraction and increases the difficulty a little for allocating a
2M folio later as the time goes on. It may cause some additional latency and memory
consumption, that's true, but the workload we are trying to do wants to make sure
the 2M folios in the system first. And though the workload hasn't been finished, we
analyzed what it will do, and we think for the most time, COWed 2M folio will be
written in a range much bigger than 4K. So it will will cause more page faults if
the fault size is 4K :). As we see, the time consuming of only one 2M sized page
fault should be able to beat the multiple 4K sized page fault, since the copy
can be merged together and there are not so many times of handling other than
copy. We can see a performance improvement in the end to end copying test which
includes many possible COW on 2M pages, though. The performance improvement is
about 2 times. The improvement is not big as we imagine it should be. We'll dig
into more details then. :)

> Also: there is no guarantee that you will actually succeed in allocating a PMD
> THP during a COW fault.
> 

Yes, so we are actually also considering some solutions to increase the success rate
of allocating PMD sized THP like reserving, the idea comes from TAO of Yu Zhao in
https://lore.kernel.org/all/20240229183436.4110845-1-yuzhao@google.com/. But we may
do the reserving using another approach like migratetype though since that may make
it easier to dynamically change the reserving size. We also want to discuss it with
the upstream about this if anyone has time :).

> 
> > Now it just
> > can happen sometimes in my multi-2M-sized-processes workload test. But the user
> > of our 2M sized folio schema is actually not necessarily myself but also can be the
> > userspace developers. I cannot guarantee that fork will not be used in the
> > performance test of their workload since that is a normal posix call. Maybe a little
> > overthinking? :)
> 
> If your application cares about performance, you either shouldn't be using
> fork(), or you should be using it very, very wisely (e.g., interaction with
> multi-threading, MADV_DONTFORK, avoid touching memory in parent until child
> completed).
> 

Agreed, we'll try that, thank you. :)

> > I just think swap and COW are two main scenarios that may transparently split pmd sized
> > folios, so maybe we can solve it and make THP both reclaimable and stable.
> 
> There is page migration, MADV_DONTNEED, munmap/mremap/madvise/mprotect in sub-2M
> blocks, memory failure handling and probably a lot more. THP allocation might
> fail. THP swapout+swapin might fail to allocate THPs.
> 

Yes, in my former consideration I just thought munmap/mremap/madvise/mprotect are actively
called, so it should be easier to restrict them, like directly fail them when the user calls
them in sub-2M blocks. Page migration is truly another scenorio we need to handle. But
it's not that likely to happen if we configure it so since we have our
CONFIG_ARCH_ENABLE_THP_MIGRATION setup, things like numa balancing, live migration, compaction
can all be disabled though. Maybe there is something I missed here? :)

> Tackling COW handling when you don't even know that it's a real problem seems
> premature.
> 

Yeah, I guess THP COW can be replaced by other approaches. We just think maybe we can
firstly add the THP COW, then the COW that may happen in fork, pmd swap in, and maybe other
places can all benifit from it. But maybe it's still not the only way to solve the
problem we meet right now.

> > Maybe
> > that can make THP more widely used in real deployed environment since the resource
> > can become more controllable for the users :). That's why I was thinking maybe
> > implementing it with setup switches is a reasonable solution?
> 
> No magical toggles.
> 
> > 
> >> Note that an application that does fork() could use MADV_COLLAPSE after fork()
> >> to make sure that it immediately gets THPs back.
> >>
> >> There is also the option to just use MADV_DONTFORK to not even share ranges with
> >> a child process in the first place, avoiding page copies entirely.
> >>
> > 
> > MADV_DONTFORK and MADV_COLLAPSE are nice and great options :), but the former one seems
> > to be a little wasteful :). 
> 
> It's actually the right thing to do (tm) if you care about fork() performance
> and know that your child will not actually need certain memory areas.
> 
> For example, in QEMU we use it to exclude all guest memory from fork(), heavily
> improving fork() performance. [there are not a lot of fork() use cases left in
> QEMU today, fortunately]
> 

Yeah, these two are nice in many situations, we'll consider using MADV_DONTFORK and
MADV_COLLAPSE and other tools for our workload, thanks!

> -- 
> Cheers,
> 
> David

Best regards,
Luka
