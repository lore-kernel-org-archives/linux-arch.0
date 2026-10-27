Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793077829;
	b=4Imjfa1+lrC/GzF2/eSBh0PtQc7yn3D0NsBj5t+5tDuTCSSVDD8ecdIkcFw54h6Vhg1f
	 AVzm6gYt6EfoIjxuQPno6MDOmqaPcVj1gi6y/lzDmksqZiKfwaaMzEk/B0Drg8/cQ0lHX
	 ZHYRlslJw0udYoWyF3uASBlWvm+8ZVpFyIbcBbLE0Ra/Yj90sVyfKtwiznG25owdRbl8C
	 HXP57Nf2L+UAd1yyw+/xRjHMcBbOaH5vkWZocwTWlnBoM9VaIDo4VSwLo66xOZSTnvEJ8
	 oBiWD6CLI1fiSJw3jKwFJQCw84YuyvjxfZ2slK+xH8NkGPXSSR8ZrlhTEuH6g0ZdaVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793077829;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=U8c13Ig6MUdyuuVgJ6RNI7ksV9FwtObecf4rW8b7B7Y=;
	b=VNLyqP7Fqa7/FXowpvbJeBp0Bn+g7pm2SOP2QezT78p+0tTTwnVutJDONL3cf+UfTB2r
	 sELL8h+xpA6TF3lHlbUQRK0qgKt1QoRZFIAVqAApDVVmH9XpKegbRF++8XUzRJTf57cdx
	 KgX1mE9n0gQn7o3MLKGxGJfLz3xlKRZGaSby0hPbvyq6k3JiHRlg1TkvEYFf6Z2kWD5gg
	 aOd18QCE+lMDv0DWbXqtm5fIG+CWFp22qZkhkjwezxutyCMCBTbty75WEh++534C9uwrg
	 TXmGM9R9Z5UOOmWSnmqKJKH9G9MSmlmfNk/VwzqWrdRvhEFHXDyhhcfB31ZCX7HasZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b="krSh/1sO";
	arc=none smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9638606A320
	for <linux-arch@vger.kernel.org>; Tue, 27 Oct 2026 05:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9638606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=krSh/1sO
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b40fc523faso4047425a12.3
        for <linux-arch@vger.kernel.org>; Mon, 26 Oct 2026 22:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793077827; x=1793682627; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U8c13Ig6MUdyuuVgJ6RNI7ksV9FwtObecf4rW8b7B7Y=;
        b=krSh/1sOaB/EnuxksKvaR29m6EPzqsslcEUDvbWR6jV+oy9fnTCovkxM/rPw1u/v+T
         lxiOLLS87aQMgtIOGwE/Qaa1isZihhaTABaqa/fw900ImJMZPi5PHxp3qJJ3zja9eZN0
         N1PsgwchS8/1NrSdSxpXbjtCt0kPWGt7IGV7ngziZssa8t5rMKdSZi0+x2oTNqoF1xp9
         QfCXP/QbfPSLoXvihdVk58EqWwRUWt/KOB4jO4m0uCstPLPsjAhPIMZUiuouP9bofuae
         Bnw+Gpck4Uy2FyyO7f5GsvYewq849Un6g6AU18RJaXjeNlw7Jif4GLTrZY8PZABYLwKs
         JfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793077827; x=1793682627;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U8c13Ig6MUdyuuVgJ6RNI7ksV9FwtObecf4rW8b7B7Y=;
        b=FZUmfoCjDKIKtIkm+L7Ml6S0+aheJF2XCsvw1OWo1C00Qajt+MLTKHAhjRox+iqFrb
         oeaSOBDn9uuTQxfqV6grMcpY5bmiX63nrWfRfm+pA5+X7PQT5vTaeqN8o3jw0CCxE5d8
         kp6oj4AN7CgercdW/Rew8wgPiPNZpJSvoMDRpIBz2axU4qV0Dgn1RTthcGpuNSnl47Ns
         /NvDqn+5psqTub4ghWuYnay+yPy9I475XMejGVYPspnblHG6nlnjZ+sA97x1rT0GliFq
         nHQfb+gay6yJ1P0b/0d1OeyCZgP7FxewCc/GIw9A+G2brDhxKrDTCmlG5dgnTRgshj8W
         5Qsg==
X-Forwarded-Encrypted: i=1; AKwUvBy5HasX+50otQ509IQHvRdP4/bV7p3QSkZR7e1y3dIX7sd+KxkhuHWxtxqLY0ZqpcuWoAH89vh0l6Uf@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3eNuwasuaqDlqL63gSmg2Vg/BipvVuowZ8/C22I3MvXTNmdz2
	yj8DO8Ee0WBn7GH9TVieOFt7D6V7jFynkwmR1sOJamSxlnBSRM7h108vvXu+5WCgLkw=
X-Gm-Gg: AYBFou253vjTnuEBmK9nIWWaMtOrqhz9LfGUToVPvlV+nzDbjORd0gMgoH0YVKNrxIL
	wUdQKBtPTMAUt9+I3zUldlUmpRAKv85/d0lS3hCSpCPmX9lZTxwvridmYuVOVqHyaOv6AWso1Um
	0tGBTewVARVaxqecetzoRkvC0sWUl7lsCbDbbY1RRPgQoVxOv/JrTHjo6z5HcPE0W5+nVDol1s+
	gfqW91EUl3ReVz+IAtIdBCQLADGD/8qJENtUIj73OY5yVnidEVO+BpNuoD4gc6P8v5CYH85Gquc
	SZ99TIH3H+89la4VZwVLSdatpMGQLk6WehZ7WCSXdBdl3KV/r4syOV4t6Wxu7A0F+oczTBqx9yP
	NtyqAwS9PCl48mMiZMlkNxDxMwAsy1AQnhZAbw2x9HlHAjM7IeVs84bfnOL4GfuomdV6df4+WrL
	/L7r0/IrL+EQZIfLtwAjaLuJje5nvpFWy3eB2FZwuVr8k8ql6Z52kBvUrI9Zxxx3AwPV7P+LlR3
	mF2yr+dbV162h4+gvo/qplUIZYGiV8At61Ae6RMZYI=
X-Received: by 2002:aa7:d642:0:b0:6af:80c4:8981 with SMTP id 4fb4d7f45d1cf-6b443001da4mr6849436a12.26.1793077826967;
        Mon, 26 Oct 2026 22:10:26 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b445984d85sm4571938a12.29.2026.10.26.22.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:10:25 -0700 (PDT)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 25/46] mm/userfaultfd: wake waiters when registration
 modes are removed
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-cxl@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261027-fixes_core-v1-25-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-25-6f74bec9a5bb@kernel.org>
Date: Mon, 26 Oct 2026 22:10:24 -0700
Message-Id: <179307782442.2301705.17273288326330283268.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-27 00:17 +0100, David Hildenbrand (Arm) wrote:
> UFFDIO_REGISTER can replace MISSING or MINOR tracking without waking
> faults that are already queued. For example, switching an anonymous
> range from MISSING to WP leaves a missing-fault waiter asleep until
> userspace explicitly wakes it.
> 
> When a registration change removes a UFFD mode, wake waiters in the
> affected interval after updating the VMA. The VMA is write-locked at
> this point, so no new faults can queue under the old modes and woken
> threads cannot retry until mmap_write_unlock(). Waiters for retained
> modes in the same interval may also wake and refault.
> 
> The hang reproduces for MISSING-to-WP and MINOR-to-MISSING transitions,
> with both read and unread fault events.
> 
> Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>

Two additional automated reviews independently confirmed a similar
pre-existing issue and generated the same patch (below).

Sashiko filed this as a pre-existing:
https://sashiko.dev/#/map/217050

But this seems directly related to your patch here, so it might be worth
squashing this in:

> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 2122676c4220f..710e913c73bfa 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c

[ ... ]

> @@ -2287,6 +2290,8 @@ static int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
> 		prev = vma;
> 
> 	for_each_vma_range(vmi, vma, end) {
> +		const bool any_mode_removed = vma->vm_flags & __VM_UFFD_FLAGS & ~vm_flags;
> +
> 		cond_resched();
> 
> 		VM_WARN_ON_ONCE(!vma_can_userfault(vma, vm_flags, wp_async));

Could the pre-existing no-op check also require an exact mode match?
It currently does this later in userfaultfd_register_range():

        if (vma->vm_userfaultfd_ctx.ctx == ctx &&
            vma_test_all_mask(vma, vma_flags))
                goto skip;

Registering MISSING|WP, then requesting WP alone, takes this branch.
It leaves missing tracking enabled and bypasses the new wake. A writer
started after the replacement ioctl returns still queues a missing fault.
A writer already waiting before replacement also stays asleep.

Both cases time out on the base and on the full series. Replacing the
predicate with

        (vma->vm_flags & __VM_UFFD_FLAGS) == vm_flags

makes both pass with this series. On the base that change fixes only the
fresh-fault case; the already-pending case still needs this patch's wake.
Would a separate fix for the mode comparison make sense alongside this
patch? This is not introduced by the series.

-- >8 --
From: Gregory Price <gourry@gourry.net>
Subject: [PATCH] mm/userfaultfd: compare exact registration modes before skipping

Changing registration from MISSING|WP to WP returns success but leaves
MISSING enabled. The no-op check sees that WP is already set and skips
the update, so later accesses to missing pages still wait for userspace.

Skip the update only when the current and requested UFFD modes match
exactly.

Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/userfaultfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 669f71d485d02..0a28130cebc99 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -2299,7 +2299,7 @@ static int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
 		 * userfaultfd and with the right tracking mode too.
 		 */
 		if (vma->vm_userfaultfd_ctx.ctx == ctx &&
-		    vma_test_all_mask(vma, vma_flags))
+		    (vma->vm_flags & __VM_UFFD_FLAGS) == vm_flags)
 			goto skip;
 
 		/*

-- 
Gregory Price <gourry@gourry.net>
