Received: from outbound.ms.icloud.com (ms-2002f-snip4-11.eps.apple.com [57.103.74.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E40344044
	for <linux-arch@vger.kernel.org>; Fri,  1 May 2026 05:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.74.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777614961; cv=none; b=crFlJtHCcE/YsdMFbN6tYkZypuHnzyg3RJ9DX6IHuIJJn1VfoFv2OFuJXvJh9QKig3NCP2cwQtEka2yQK56xcRlND9U6LiBERMFwEyZqEs5I6FjhDRN2cUhZVMKyKWm7unR8veNH2tjNwUn2Zr93Z5kAw5ZQpRiY3In8TP+PidQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777614961; c=relaxed/simple;
	bh=8F5OWchx6oWjQdaQhYvrUYZ5NQU/mG7ZNaYkB8ZziY0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K97R6yHxNXzCubVojq6rLRsrDg421urEfWo+DKGbD5RYjxCinjrLAhQUm6eYNvce0Q8s0yuCHfZTRGRhyXy+xCgO5ECXL1DEcdAw2EuOBNGWENl3YJzntWcNzbZ9f7oiuP+xj9/zZk0hmmcQD5SFe8snamSN7TSTp3+dAoTCeJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=t5Hy/Ea7; arc=none smtp.client-ip=57.103.74.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="t5Hy/Ea7"
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-60-percent-8 (Postfix) with ESMTPS id 9810B1800137;
	Fri, 01 May 2026 05:55:56 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhAA0MFWgFeAUEdXwFLVxQEFEYGVg1dE0wLcwRUB10FXVZQAlpLVBQEFEYGVg1dE0wLcwRUB10FXVZQAlpLQBMESgZNXw5eHwQXRhlVBEceXVZeHhkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4EVAddBV1WUAJaS18ZXUUPXwdZBEAMSAJAQwNCL1oXREBBWh9AFEgDWARcBUQBSwReDytGFVcbVgNDRVEfVEYTGU4bV01QG18CQg8=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1777614959; x=1780206959; bh=nCs6drGaFkCRJLaExPULFGqJ8DTdS4a2ok3PlUktjtQ=; h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:x-icloud-hme; b=t5Hy/Ea78rL5bj3jYZoSWFw6K619fKXVpfmODAHUgfMAj8AgYKkFYTOVZ9RBgPEbFXzlTJcme7dtZgkTw4M88T0T94vKuOUekoZKa8hTW1nhJWHAbYzTTGpUl0AyN4xTSQIgiPmaNZumwo0fna4ihm0yHAv2NUFA3Uh0KBdAL7Ec2a6mgqZeT8JzK2BIyFym96mLxk65SXvfQuQVcPodwm7GrmID4n9nzqevpz8oZpjIaskx6b3+dAthkaq+1r+lE9ppIVgzJDvt2Ei7fkn+D3Q7meNObR8IvmRHpWZE+xFjB/8W0t3GbjIVi0SYLr8e9njhGCENlQXjUmblooPBtg==
Received: from [127.0.0.1] (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-60-percent-8 (Postfix) with ESMTPSA id A23CF18000AC;
	Fri, 01 May 2026 05:55:50 +0000 (UTC)
From: Luka Bai <lukafocus@icloud.com>
Subject: [PATCH 0/5] mm: Support selecting doing direct COW for anonymous
 pmd entry
Date: Fri, 01 May 2026 13:55:41 +0800
Message-Id: <20260501-thp_cow-v1-0-005377483738@tencent.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUwND3ZKMgvjk/HJdSxMLc+PUFGMDc0tjJaDqgqLUtMwKsEnRsRB+cWl
 SVmpyCUi7Um0tAMn0eRprAAAA
X-Change-ID: 20260501-thp_cow-94873ed30793
To: linux-mm@kvack.org
Cc: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Kairui Song <kasong@tencent.com>, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
 Luka Bai <lukabai@tencent.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777614950; l=4495;
 i=lukabai@tencent.com; s=20260501; h=from:subject:message-id;
 bh=8F5OWchx6oWjQdaQhYvrUYZ5NQU/mG7ZNaYkB8ZziY0=;
 b=Mnq7d1ebKNKd22Mi2Q4QzUgQPN/G4as2TdQObTxVVawo0sRb+In5CDW7lDVCkbmH0A4nKiSy6
 E4oR+nG1e8JAAKnv2gPZd0rLAGI2vUgMg2P4OePKmeODhjd/LA1OxO5
X-Developer-Key: i=lukabai@tencent.com; a=ed25519;
 pk=KeaVteSWd00GIAjFyWZnuFsKAKixjga1ZkLMcI66nPM=
X-Authority-Info-Out: v=2.4 cv=AfC83nXG c=1 sm=1 tr=0 ts=69f4406f
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10 a=UaoJkeuwEpQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=GvQkQWPkAAAA:8 a=_OFjXo-hXSw0Td5hZWcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDA1NCBTYWx0ZWRfX4ZxyaoctKwi/
 n75OHVnLyjNtavyhdX71M2ZUJ7kT/GvlaXbZPJ8/2aFNuBNtEdIi9Y22/8Qc4ZRG7FZZQ2el6i0
 K5rrPW3a5EDXjjXPO4gIO6U0ihiM/6MmO2zZ3fFYj9i6JryTMVx+4k1M1ibrIlLU0SJBaxDM3jq
 YokJCa/LJEc/PoyGFxrCEHwRe0Q8GwVlPDgaMauiWGVuFzbAM56a34BZWPd91OeeXeUx3nSwvCt
 Xd+R/elFBbHpdFQ7DQXZs63iFzkzYtFPeiydEpv9DGKdYeXA1gxx9B1vKKhbbzU3/iwIIChL5oX
 zG+03xnZIreOfNXKt8vJWnIvHwZ3ItDgcYEk0kaAhyj02fna/4nvF1Vbgf9jHM=
X-Proofpoint-ORIG-GUID: 95NSFYUkqOw5GeELm6bq1q4S-sdjRYZv
X-Proofpoint-GUID: 95NSFYUkqOw5GeELm6bq1q4S-sdjRYZv

Copy on write support for anonymous pmd level THP is simple right now:
firstly we'll check whether the folio can be exclusively used by the
faulting process, if we can (when the ref of the folio is only 1 after
trying to free swapcache or the page flag AnonExclusive is setup) we'll
directly use it with few further handling. If we cannot, then we'll
split the pmd into 512 4K ptes, and do copy on write only for the
specific 4K page that we faulted on.

This logic is truly memory efficient since for most workloads we don't
want to allocate 2M new memory simply on a small write. However, it also
makes the original 2M page for the process suddenly splitted on a
write which will generate some performance thrashing. For example, if
process A and process B share an anonymous 2M pmd, if process B chooses
to do a writing, then its page table mapping will be changed from 1
pmd entry into 512 4K pte entries at once, so the tlb benifit will
suddenly just "vanish" for process B, which sometimes may cause a
observable performance degeneration. After that, we can only wait for
khugepaged to do the collapse for this area and merge the pmd back, which
is not easy to happen.

In addition to the problem above, this logic can also generate some
deficiency for THP itself. Currently THP is just a "best-effort" choice
with no "certainty". THP is easily splitted into multiple small pages
on common calling path like reclaiming, COW. A transparent splitting
can cause throughput fluctuation for some workloads. For these workloads,
we may want to give THP some "certainty" just like hugetlbfs, The effect
we want is: after some customized setup, if only the system has usable
folio, and the virtual memory alignment permits (or we setup to), we can
make sure we always use THP for it, the system will never split it except
the user wants to do so.

This patchset is about both two things above, firstly we add pmd level
THP COW support by revising the code in do_huge_pmd_wp_page, we added
switch for it because different workloads may need different resources,
for which memory saving may matter more rather than the 2M tlb gain.
The switch is very similar to the "enable" and "shmem_enable" in sysfs
path of transparent_hugepage. THP COW is only enabled when THP itself
is enabled globally or by madvise. And also, we add basic THP setup
helpers and branch in madvise path and add the THP COW choice to it for a
more fine-grained setup. Now the helpers only supports copy on write
related, but in the future we may be able to add more types of THP
configurations into it like swapping.

Patch Details:
========
* Patch 1 adds the basic THP setup helpers and branch in madvise path.
  Then we add THP COW parameter into it.
* Patch 2 adds the THP COW sysfs interface, the logic is very similar
  to enable and shmem_enable of THP.
* Patch 3 adds the helpers that will be used in the actual COW path
  to decide whether we choose to do pmd level THP COW.
* Patch 4 reconstructs map_anon_folio_pmd_nopf and map_anon_folio_pmd_pf
  to make it capable of doing mapping for copied new folio when the
  fault flag has FLAG_FAULT_UNSHARE.
* Patch 5 adds the actual support for pmd level THP COW, and uses all
  the switches and helpers in the above 4 patches to do the strategy
  control.

Thanks for reading. Comments and suggestions are very welcome!

Signed-off-by: Luka Bai <lukabai@tencent.com>
---
Luka Bai (5):
      mm: add basic madvise helpers and branch for THP setup
      mm: add pmd level THP COW parameter in sysfs
      mm: add pmd level THP COW judgement helpers
      mm: enable map_anon_folio_pmd_nopf to handle unshare
      mm: support choosing to do THP COW for anonymous pmd entry.

 .../testing/sysfs-kernel-mm-transparent-hugepage   |   1 +
 Documentation/admin-guide/mm/transhuge.rst         |  27 +++
 include/linux/huge_mm.h                            |  45 ++++-
 include/linux/mm.h                                 |  19 ++
 include/uapi/asm-generic/mman-common.h             |   9 +
 mm/huge_memory.c                                   | 198 ++++++++++++++++++---
 mm/khugepaged.c                                    |   8 +-
 mm/madvise.c                                       |  25 +++
 8 files changed, 308 insertions(+), 24 deletions(-)
---
base-commit: 41cd9e3d23b8fd9e6c3c0311e9cb0304442c6141
change-id: 20260501-thp_cow-94873ed30793

Best regards,
--  
Luka Bai <lukabai@tencent.com>

