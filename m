Received: from outbound.qs.icloud.com (qs-2001a-snip4-2.eps.apple.com [57.103.87.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A311B3EFD39
	for <linux-arch@vger.kernel.org>; Fri,  1 May 2026 16:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.87.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777652226; cv=none; b=tBVqz45fs95Wpu55Z3+oSM9dlIvKAtBlEMZkxc3HaDiHwch/TvqF0Y3D/yqtfG5f859LTzhOzRv5CT+/V/qPoRX6o/jnQdvjaQECfaVDgym4557X5pM9Wh2A4cLLjHAkEMl8dd6OqdfvobJmZDehFw6owB3uv5Aof/Lg4sIUizU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777652226; c=relaxed/simple;
	bh=0kbe/PDYbS8nMLyo6EBbJuKhNh/p/WEZQ3ZEQK0DSoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Brb07hGUGSuTgvfga40itrqoiJJCD55usr+njyaKYYzomQAuDkXNFThSwhOrvNz/nA8fDrnVNRWWAKtoZIyWGKkDUZuLVwhvTu/KrPz5Ayq4zrolD94CyerZGqUJVvon55Fcj26uTzeVBD6chl4AqPYdFJ36BXTI1L1J9LedRO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=q25XdUV6; arc=none smtp.client-ip=57.103.87.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="q25XdUV6"
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPS id 19B19180024D;
	Fri, 01 May 2026 16:16:45 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhAA0MFWgFeAUEdXwFLVxQEFEYGVg1dE0wLcwRUB10FXVZQAlpLVBQEFEYGVg1dE0wLcwRUB10FXVZQAlpLQBMESgZNXw5eHwQXRhlVBEceXVZCHhkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4EVAddBV1WUAJaS18ZXUUPDFE/YEQBL0sqWSJCCHJAUi17Pnkxezl6QHooA04ZDEodUlZbE1UXRgk=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1777652210; x=1780244210; bh=UgGxl8M14pUS6KDhLcMRY7wJXbhdvbGGNTkbFAyofIo=; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=q25XdUV6HHEJiVM5xR4bEA+wlvdJ2WgHrnPEJ9Xzxh57hdT1BT4pHkh3zay9tJcl5JKTYJzWHpNAUIciTBcF5h5VFtR/H28RJSiJ3bOoRfxqyjOsrm5m1i2/faJphio2xZ2KQS0lzeVTBGFYPFYNIeo1BlL3y2z2BktvtjaYiu4odoPPoAm+z5pnEb9rA8G6qjQVYdQZax/ytQfm/9aHgUbo7iVcUNlDvBOv+eoKVcS9VoF927+3oaWb316ZkaSWP7aOT1v4ldTIQGSnZ1Z/etqn0GNyYfrXkRlsfnSWGLJXHbL50a1ntFtc/+8lzTgNHCTatP/pkZ7VvoydsBIDZw==
Received: from localhost (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPSA id BA86E180014B;
	Fri, 01 May 2026 16:16:39 +0000 (UTC)
Date: Sat, 2 May 2026 00:16:35 +0800
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
Message-ID: <afTR48WxGnIpxK8a@LUKABAI-MC1>
References: <20260501-thp_cow-v1-0-005377483738@tencent.com>
 <b5379cd3-f7bf-47f9-8a60-c7300b4415a2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b5379cd3-f7bf-47f9-8a60-c7300b4415a2@kernel.org>
X-Authority-Info-Out: v=2.4 cv=AfC83nXG c=1 sm=1 tr=0 ts=69f4d1f0
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=x7bEGLp0ZPQA:10 a=UaoJkeuwEpQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=v3ZZPjhaAAAA:8 a=i0EeH86SAAAA:8 a=Ikd4Dj_1AAAA:8
 a=tr256uPD42VStoVvj3sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDE1OSBTYWx0ZWRfX2BK81TZ7hv7f
 6ZYItCAV/kwwQFqAPl2gXT63PFHdPifaGDNaNMYEEDLdvh9nYb3TyeJPUqP2ZXZWA4jBvQZDV3j
 q8aoq7oQsqfODso2mba4dMWPP3FNenojRlM1TdahB05RiwdNgWmH6EKpnkw0LheKHvMX3qTjYDo
 AKfKt4/xEGZTzkL1FMV7H0DHfSJ9ZbUB/oaN+Gmn/M/ycqLkAO38aCMrgLQzOWpiNrn3czdkmql
 4MljY1FEOeyeT4HAT+y+h9W5dPq/3NQZN1ZMJv6iRpoej6xsJNbqvqUQ41boBcIeFVRxGkrP9cC
 hd5IOP/VNZU0TUsrzK8EWkfFTb5eoa2PBTk+UbCDeFMRyfPPh+n9p5cxoojAQo=
X-Proofpoint-ORIG-GUID: BoNt6ECAJfAKmyJrQNW1V_En691lj7za
X-Proofpoint-GUID: BoNt6ECAJfAKmyJrQNW1V_En691lj7za

在 Fri, May 01, 2026 at 09:07:49AM +0200，David Hildenbrand (Arm) 写道：

Hi David,

Thanks for your review and opinion :) I really appreciate it!
I'm sorry that I'm not that familiar with the mail sending in lore, so my
earlier reply in
https://lore.kernel.org/all/8F6F0691-91A1-4645-A218-2219DE6047AD@icloud.com/ 
may be in a wrong format, if you haven't read it, just ignore it, and read
this mail instead, I also revised the reply a little in this mail. thanks. :)

> On 5/1/26 07:55, Luka Bai wrote:
> 
> Hi,
> 
> > Copy on write support for anonymous pmd level THP is simple right now:
> > firstly we'll check whether the folio can be exclusively used by the
> > faulting process, if we can (when the ref of the folio is only 1 after
> > trying to free swapcache or the page flag AnonExclusive is setup) we'll
> > directly use it with few further handling. If we cannot, then we'll
> > split the pmd into 512 4K ptes, and do copy on write only for the
> > specific 4K page that we faulted on.
> > 
> > This logic is truly memory efficient since for most workloads we don't
> > want to allocate 2M new memory simply on a small write. However, it also
> > makes the original 2M page for the process suddenly splitted on a
> > write which will generate some performance thrashing. For example, if
> > process A and process B share an anonymous 2M pmd, if process B chooses
> > to do a writing, then its page table mapping will be changed from 1
> > pmd entry into 512 4K pte entries at once, so the tlb benifit will
> > suddenly just "vanish" for process B, which sometimes may cause a
> > observable performance degeneration. After that, we can only wait for
> > khugepaged to do the collapse for this area and merge the pmd back, which
> > is not easy to happen.
> 
> You probably know that, historically, we did exactly what you describe in this
> patch set. It was rather bad regarding memory waste and COW latency, so we
> switched to the current model.
> 
> Note that there was a recent related discussion for executable, which was rejected:
> 
> https://lore.kernel.org/r/20251226100337.4171191-1-zhangqilong3@huawei.com
>

Yes, I know this history, and I know that it will cost some memory or latency,
That’s why I was wondering maybe I can add a switch to it to make it
configurable :). But I don’t know the existence of the discussion in 
https://lore.kernel.org/r/20251226100337.4171191-1-zhangqilong3@huawei.com,
I’ll check it out, thanks for informing me that :).
 
> > 
> > In addition to the problem above, this logic can also generate some
> > deficiency for THP itself. Currently THP is just a "best-effort" choice
> > with no "certainty". THP is easily splitted into multiple small pages
> > on common calling path like reclaiming, COW. A transparent splitting
> > can cause throughput fluctuation for some workloads. For these workloads,
> > we may want to give THP some "certainty" just like hugetlbfs,
> 
> There are no such guarantees, though. And We wouldn't want to commit to any such
> guarantees today. For example, simple page migration can split the folio.
> Allocation failures will fallback to small pages etc.
> 
> If you need guarantees, use hugetlb for now.
> 

The reason why I want to use THP over hugetlb is that I need reclamation for my
workload :). There are many processes in my workload that need 2M
aligned folios for better performance, and we want to reclaim them back automatically
when the process doesn’t need the folios. But hugetlbfs cannot do passive reclamation
from what I know (except doing active madvise by the processes themselves). And using
THP can easily split the hugepages. So that’s why I would like to add certainty for THP,
and use THP for these processes as backend, because THP is very well integrated with
the swap system and other filesystems. And from what I checked,
it seems the most common case for splitting a THP is COW and swapping so I am trying
to handle these two scenarios (But coincidentally, PMD swapping is committed in
https://lore.kernel.org/all/D3F08F85-76E0-4C5A-ABA1-537C68E038B8@nvidia.com/
a few days before, which is a great implementation :) ).

> > The effect
> > we want is: after some customized setup, if only the system has usable
> > folio, and the virtual memory alignment permits (or we setup to), we can
> > make sure we always use THP for it, the system will never split it except
> > the user wants to do so.
> > 
> > This patchset is about both two things above, firstly we add pmd level
> > THP COW support by revising the code in do_huge_pmd_wp_page, we added
> > switch for it because different workloads may need different resources,
> 
> The switch is bad, and we won't accept any toggle like that. A system-wide
> setting does not make sense for such behavior.
>

Oh, the reason why I added a switch globally is also because the scenario I mentioned
above, I want those processes to always use PMD sized folios as backend to make sure
performance. COW is truly not that common like swap out/swap in, it just can happen
sometimes, which I guess the reason may be about image duplication. Setting the system
globally is more convenient for my situation :). I can go without this global switch
if it's more reasonable.

> A per-VMA flag? Maybe, but I expect pushback as well, as it is way too specific.
> So we'd have to find some concept that abstracts these semantics. But I expect
> pushback as well.
> 
> We messed up enough with toggles in THP space, unfortunately.
> 
> Also, anything that only works for PMD-sized THPs is a warning sign in 2026 :)
>

And for PMD-sized THPs, actually, I’m also considering adding more support for
COW to mTHP if the upstream consider it useful. And also for pud sized THPs
also. But I guess I have to firstly handle stage 1: PMD level COW now :).
And also, since PMD sized folio is commonly used in my workload, I'm also wondering
digging into pmd sized KSM in the future, in which I think pmd sized COW may
be more useful then :).

> You don't really raise any concrete use cases or performance numbers for these
> use cases. Some details about applications that use fork() and rely on such
> behavior would be helpful.
> 

Sorry for that, the concrete workload itself hasn't been finished yet. Now it just
can happen sometimes in my multi-2M-sized-processes workload test. But the user
of our 2M sized folio schema is actually not necessarily myself but also can be the
userspace developers. I cannot guarantee that fork will not be used in the
performance test of their workload since that is a normal posix call. Maybe a little
overthinking? :)
I just think swap and COW are two main scenarios that may transparently split pmd sized
folios, so maybe we can solve it and make THP both reclaimable and stable. Maybe
that can make THP more widely used in real deployed environment since the resource
can become more controllable for the users :). That's why I was thinking maybe
implementing it with setup switches is a reasonable solution?

> Note that an application that does fork() could use MADV_COLLAPSE after fork()
> to make sure that it immediately gets THPs back.
> 
> There is also the option to just use MADV_DONTFORK to not even share ranges with
> a child process in the first place, avoiding page copies entirely.
> 

MADV_DONTFORK and MADV_COLLAPSE are nice and great options :), but the former one seems
to be a little wasteful :). And the latter one can greatly solve fork situation, but
we have to recognize all the possible regions that may be accessed in performance
test and collapse them. And it's also not easy to solve the situation like pmd swap in
for pmd pages mapped by more than two processes. :)

> -- 
> Cheers,
> 
> David

Look forward to your further opionion, thanks!

Best,
Luka

