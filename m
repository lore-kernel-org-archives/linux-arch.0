Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206565;
	b=B2mQmnOH7oSLuOBxnePyG6Ram20l/j8zJBypFmi6EK9v5DDfetbwWA+AKLdYGmgFbov5
	 Kf5f1grdL0WtnG/Mgd4hl3L3ql3r6wq8biDyQVnERpcrWpreM8PaawDcm2W9fF1nAh8gM
	 e7X7f1amdhar/6q120cV2NrKdSPEBmvmS1XVTy49I6UbIGPuh6GE33WVusX860hAXvCc1
	 lC4ETXpIRXPr0A4WcX67+9j0TP5CK3lKQzwDNltP5TDHV5TLo6/mDwI7kwv07ZaG9Ogyk
	 zr9jhqvWtXdqdN7tHWkiewu+yGunCZU1hwjFnZfzNgz6L+3WKAMcizoQutUT5t4WtAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206565;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=r3C0d19m+/iHxVzVsZqZF5QMTPBWCH1ibPkdNy3hhyQ=;
	b=GmnNFyUf+9TpeCJEVa8UICgqvO+0tXe1sePfBk2Wo8NOs3lPubCep+pd34W2jIidCzWy
	 TLFV9dSodqXvW6zjClJ3gtsTE186SnBbSvuKeMIlE2jUJ0YYikSqo1Dql/5RNY7IPExna
	 yyXP+e6hytlUHXFt4TTtl0cpZndaPPgtd1rI/KrjSkzZ8RwAnZm+NTi0W47irXU7X+CbX
	 tyt3PpBrEymNGZx2epp/CbODV4KLI1v9OhUnLOQ88A4BwRPEjHuJx8YDmKE8e94GgPo2R
	 swvnPjBiU0ADEeq+oyoivCq91L4sJvYYk1DsCMxkT/kQ/Kc0ITl6IZI364gcW8vacKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=RLxEwpL1;
	arc=none smtp.remote-ip=209.85.222.46
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7D8606A320
	for <linux-arch@vger.kernel.org>; Wed, 28 Oct 2026 16:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C7D8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=RLxEwpL1
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-990835cec4bso746199241.1
        for <linux-arch@vger.kernel.org>; Wed, 28 Oct 2026 09:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793206564; x=1793811364; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r3C0d19m+/iHxVzVsZqZF5QMTPBWCH1ibPkdNy3hhyQ=;
        b=RLxEwpL1hIyB/8de987ZDlpeLtVUV1o6ZwdAJJ5mPDG/A2ay9kTAD4XqeALAUEZc7T
         E+rNOMrhz40DYs3ycXgV4yPyi2Usq+ABEvzGTdQ6EpE08oZlMGrXBuZn0oksHESP214x
         HOhO5Bk+S9aZF/Fy2QjBdly76Bg3QJbA3fHIMsPq+C8FaEknA6C+IUV0EwW0bTP9/zWQ
         OOiQwebdi3deLoTwUunNlh8mr6V4B5Us/zvAKXtM1PltIwFDSzlYp0tYCGFgZb7w9dqp
         BlbKIJP2xgxwiBLxFNlTcmwU0vPots5dguJS0n27G0NkKxZIVloQxL0s3OxtMGYRXIkB
         K+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206564; x=1793811364;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r3C0d19m+/iHxVzVsZqZF5QMTPBWCH1ibPkdNy3hhyQ=;
        b=Y2Tky5vo6uNOS9NJkdaA70KacvlRjGxv4F4Le4qkweJZCAnTAiu3/pWnsfKcXJqXPP
         JK5j65TACx5sEeGOThFG/cDm8+9ICz/i2q0kr43OEty8mMl8hBdAnKjUX8MS/l4L55Qi
         rI4s8sJk0RgOXNc7YQ9gBvZg28pbeQWgrHgh7TocOqLiWujWvXQAXQ+SiPXLiiJo7911
         s1nT22OoYSZFAlLo+S0Kw9SMN5zWOeazi2Jd+QX08oY8zDIMkVQPz/OSikXSIEmgresn
         Occq2j3kulsiVMVRaKpNPDK5sIsdkvYNrp2uyG0DGsSUFUN7bdzFSKi1XtkJe6NpDg0J
         EBtQ==
X-Forwarded-Encrypted: i=1; AKwUvBztbR8GUMvfMe0j1e0czHvGdvyGcOYGvjqsiZAQg4pE8/aq7j3TFFUzkh0IanyOFiHBUpzy17YT0CQf@vger.kernel.org
X-Gm-Message-State: AFq9FYJZB7J+rIuaTNPyX7HLWlfLO3PFAk+UXJ+RpxLBfx4zT16DvQtp
	rq89i7M7Cp6FTrJWzUKUX+UglEsGd8voByTKCWqE6xWoLlAM7Z4U3s3an4aIWejyorc=
X-Gm-Gg: AYBFou2tILetMgHZDJgjDqfBpC4hN7Vk0FbAb36VsU6RJQwg/JimKErAmglq2Ooc+XN
	I7QR09j1uyqL8WyZBuHcmyAli7ZPJFwG+hVOaRQ5uyhc2uvNnFyozmO8EyoC3eHKgMJ94g4dFNo
	HQ9HumBUxVNbWi7FYWfv6JlK3ar8BtpShXx4csY8LoeY80An+qrIRXhkBpo8ja9eqicDV/zVkFb
	sv9HiWCOxu4ivRAP84WLvNfN0M9zxDpCfLpbhkFdrSjQMlmkx1FmfICUT6PG0VcX+TtzwqkLLxT
	ka85OtwLbDh/2hOWaTkqTdrZ0HarI05wjY781wQXqNlTiCVrG8Q/Ogw0L/BpC5JiWPyTJIp9IjZ
	BIFxbNzqaJgqpaaI8ieFhDPt7pezHqY5Evs9jSzJjwv02hh/ESstdLo5yCS7Ztv/fUCDqpFtDza
	ROd4gvOE3dJsJuwn7qJn0sNZGKBmYiIQME5aRsCATDYEvfPB+y7ibwg/Xou1KuBgL0Dsrm85yac
	b0JnJdqGOvdlZ70cmuB9MX9zs+YWdzFyLs7iyPDAzd7S/eV/Z9C0QNAE7ZIBVA9Aieil/jgoq+F
	sCnYkR6oC2JE2XWSKleir30E3azLAxabEBNXWO3i6KBUvzdMlYDeFFuJQ9qbPPrwN+yfiGZHcf5
	xCmdJ8TRLcWzT7PxMiJYHnBRohR2jpuU4M6z9t9sb+q/Rl0JJp4v2
X-Received: by 2002:a05:6102:370e:b0:7ce:a79e:75a9 with SMTP id ada2fe7eead31-7d03a59dbf7mr1528233137.36.1793206564343;
        Wed, 28 Oct 2026 09:56:04 -0700 (PDT)
Received: from google.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-991259fbcbfsm6525438241.10.2026.10.28.09.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:56:02 -0700 (PDT)
Date: Wed, 28 Oct 2026 12:56:01 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Hugh Dickins <hughd@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, stable@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 38/46] mm/ksm: reset the unstable trees of all nodes
Message-ID: <auIpGR1VG7lOxJ8P@google.com>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-38-6f74bec9a5bb@kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027-fixes_core-v1-38-6f74bec9a5bb@kernel.org>

On 10-27 00:17, David Hildenbrand (Arm) wrote:
> Each full scan resets ksm_nr_node_ids unstable tree roots. Enabling
> merge_across_nodes resets this count to 1, even if per-node roots were
> previously allocated.
> 
> So when toggling "merge_across_nodes" 0 -> 1 -> 0, a scan that starts
> while the setting is 1 and continues after switching back to 0 can
> encounter stale unstable tree roots, resulting in UAF.
> 
> Only root is allowed to change "merge_across_nodes", and the documented
> sequence is: "merge_across_nodes setting can be changed only when there
> are no ksm shared pages in the system: set run 2 to unmerge pages first,
> then to 1 after changing merge_across_nodes, to remerge according to the
> new setting."
> 
> Let's fix it by tracking in ksm_nr_node_ids the actual number of
> allocated tree roots.
> 
> remove_all_stable_nodes() and ksm_check_stable_tree() will now scan
> more tree roots (skipping the empty ones), which is harmless.
> 
> Fixes: ef53d16cded7 ("ksm: allocate roots when needed")
> Cc: stable@vger.kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/ksm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index dbfb8f98b1892..9c51925825cbf 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -475,6 +475,7 @@ static void advisor_stop_scan(void)
>  #ifdef CONFIG_NUMA
>  /* Zeroed when merging across nodes is not allowed */
>  static unsigned int ksm_merge_across_nodes = 1;
> +/* Number of allocated stable and unstable tree roots. */
>  static int ksm_nr_node_ids = 1;
>  #else
>  #define ksm_merge_across_nodes	1U
> @@ -3636,14 +3637,13 @@ static ssize_t merge_across_nodes_store(struct kobject *kobj,
>  			else {
>  				root_stable_tree = buf;
>  				root_unstable_tree = buf + nr_node_ids;
> +				ksm_nr_node_ids = nr_node_ids;
>  				/* Stable tree is empty but not the unstable */
>  				root_unstable_tree[0] = one_unstable_tree[0];
>  			}
>  		}
> -		if (!err) {
> +		if (!err)
>  			ksm_merge_across_nodes = knob;
> -			ksm_nr_node_ids = knob ? 1 : nr_node_ids;
> -		}

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com> 

>  	}
>  	mutex_unlock(&ksm_thread_mutex);
>  
> 
> -- 
> 2.43.0
> 
