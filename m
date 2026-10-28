Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206505;
	b=XpHOCLspnhC33r0xs0nIUufXWIiZDAEvd4PS5SyjMvQvFWG9ryfN3sKjuQlKQE2dsQh5
	 9jfpDoaLDgv5qy7uiXnV8VR9+mcy8bvmnyTcFFInmSUIXNgr4CSfHomgGJx+hoRGE85nL
	 QF69rfpKGC5VofmIE3mjd4IbSBWLiMnjSBvNqFM7HOFr/hCagFDftt1u7dzlwTGdIA/xV
	 /bCUNtiEiVeh1rheQVvQbfYVF7rxW8EgPd1xrqark5/hI16ED6FnlnJf8tBdiVWWuQnmc
	 ROx11ByiXccTQJEnHXfAB8r7E3GJYvSYavJRBkBCRpXI8tMM6543k8/Lejv6dZ5Xh8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206505;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=PRHEIBcRVtOU9mxXH6oSTTLdGiFLeS2r2uPk2vm17iM=;
	b=L5WpXutNeqMCEqs2vc9ZeXcQz6ZHViVJqVtvlzlg4Ml7bwrhM967X66lavWNPByaHasf
	 17otSNcyxc42Z4fu6F8lnoeGgbm+ursqrA0Olnq0YMNDgWDQWPXqXq8MBbByHlzjmoaRH
	 oDI22EtLhl0bIErwplYMM2Cz9SXlEdy+h0GtejvQGYBxiNM8Hyx6IUW87mBgPXJ0Uu0ks
	 2USdx/NtDzb1XDaRTrZrHGhfOcsPSLDtsp4BN+GNGeoYWvZg856nSFqULfcNjPcGatV6k
	 g+p44i4rzyqbniO5rW9fe+ZlaQYZDxHQzgMqWaZMBlxc0uKpsXi1tbiIkV/ZGMZQaag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=YZTcsWCI;
	arc=none smtp.remote-ip=209.85.221.170
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD84606A336
	for <linux-arch@vger.kernel.org>; Wed, 28 Oct 2026 16:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CD84606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=YZTcsWCI
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5ead4026fe6so483488e0c.2
        for <linux-arch@vger.kernel.org>; Wed, 28 Oct 2026 09:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793206504; x=1793811304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PRHEIBcRVtOU9mxXH6oSTTLdGiFLeS2r2uPk2vm17iM=;
        b=YZTcsWCIUypnB5n4D/hsVZ4sYhEwp0OAWBZMIpgCIgC9VKYTguiLg2qUrAb1YtwQXm
         fBX2qjbMohrDsF8FpU3xT0wg+Z/De85xmZkcivTaFPK/xC2rSJQKjq22NWOhc1lGVidr
         hM8JGH+eSNGpRlvJh4EuWmmvnFfWam7TOV3FYkuqC4/2+sI4BlGechXv6xOQOVgypb6q
         zWTc1Wh0ex2ijemeCLiISE7AQnNSqdbH3U9hHcLHJdV8/WdwHyqp0xajG5zARiSHdoqr
         pOVMKySmKrvxR+H5Dzu0wqmwb1u32hxlg1K0CKnzvk4A8gUXWUD4WI0PaDrMBKpYlNaK
         M9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206504; x=1793811304;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PRHEIBcRVtOU9mxXH6oSTTLdGiFLeS2r2uPk2vm17iM=;
        b=glKNFbMF7TRySdSWaTTWEl/ps0nn9XlVruk67QzCgQRkbtzKg8RCSxPS7SyVq5zTUR
         TCyZTNKNBdhK6OklUaAawJrICKbsjoWgkTmwDS3aO9HugnwrD5K1HPQ/MdR8Wj2apCY8
         BxJiv02151AsglHuMFdNhHFH0aXKhNH09jyCsZv+j16e3mpBFD4OWdyrzZvQTCdcmBGy
         FPENwqadbiv+LM40sgJzzY05Tj2MYKpDnzQCQEr9x/ZSBStR9V+dQD/TQKTtH/6ed9YA
         1XoJ0A0wJiMTmHxefMHWjNlCkGiGIjzegLxdZMJVA+MLnqUg1OQUY03N5NUZ9A5EvSMA
         rdHw==
X-Forwarded-Encrypted: i=1; AKwUvByPO8J5C4OG26rAyzu8C/h2ZHbUfV00/Bw9nTfhDf46+YDE+4fyoZQAWMbXir92RMhzEmCkc4MLxae5@vger.kernel.org
X-Gm-Message-State: AFq9FYIzSwjaL+9FbjsrnHBkymaSOsjCZVT232k0+408ZxUZtkhIb2sm
	ZbfPba4V+9jcGiWWcQXa4oFcuRfQIpLXlrN+CaeN3HxEggN1Q2wkgin3z2pugTwPwaQ=
X-Gm-Gg: AYBFou2yT+T/mi+TAXJfFvanFl4xK7Wwc2hvulkF1hmPa7BjXxZcsgXtnqNMuj0u/JA
	RUW5oScmSe1TOKEY6kdA/qOS635fYnCs9c187TNjTmnUY6My60W+y5OGHy8WqpcmTFajRVfMkTY
	zNUJrNIIy6ztM3XMThcF4GGPnbPTKV7thj5falS9gdewPImQb8om/NRkWAdY9tRVGrrfJiHmtL9
	mxwmXfG+n3reqynPNzLp9JdGCsV4uVi5tH5uRzNlfwlikBkayec04bOXpyIqahhad823/Wk6IYv
	j/KWGHghFpE8TAv8WvMg5OmmmylS5YtKTD9LwKa/V+d/i9MRBhKksOGCnjwzlG3v0YIDtigI9JI
	7Nw+8TmnVSBlIJriBGOBdkQPJ6b0i946gvyKVZpw0lGtl7BHlgl98KXdY9H4wCOv+Zx8ZlHZe/E
	pbW7Q7r8qm+SVLfvWo0O5c4aSVcOxlrmHjVS1/7yzmQZyJVtSayJiD4w7tDpjSnfHHFaEMKwOaP
	4hO88gxH23zgTKL7LxZfRrPA13AwSfnMzJdc5ZfNhhnIHQgxTFssQn7LtmwJ/O+4K/dYKFfeInI
	Y+GSo6fmB+5VrnQcUX+OPp31xkbUsbJLpwgu+Cw5gRhmUxrGysVco6807InEGekjySzR/y/mHIw
	s4R0VuI6CSrcIz5kR/W+kjjVIu9QX4Q==
X-Received: by 2002:a05:6102:a54:b0:7b1:6028:5475 with SMTP id ada2fe7eead31-7d03a505a71mr1235376137.12.1793206503993;
        Wed, 28 Oct 2026 09:55:03 -0700 (PDT)
Received: from google.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cea3d32a48sm6300543137.9.2026.10.28.09.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:55:03 -0700 (PDT)
Date: Wed, 28 Oct 2026 12:55:01 -0400
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
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 04/46] mm/memfd: make f_pos accesses atomic
Message-ID: <auIoupm228FQTNGi@google.com>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-4-6f74bec9a5bb@kernel.org>
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
In-Reply-To: <20261027-fixes_core-v1-4-6f74bec9a5bb@kernel.org>

On 10-27 00:17, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> Commit 9c225f2655e3 ("vfs: atomic f_pos accesses as per POSIX") made
> read(), write() and lseek() on a shared open file description of a regular
> file serialize on ->f_pos_lock.  The flag that asks for it,
> FMODE_ATOMIC_POS, is set in do_dentry_open().  A memfd is a regular file
> too, but its struct file comes from alloc_file_pseudo() and never passes
> through do_dentry_open(), so it does not get the flag:
> 
>   CPU0                                CPU1
>   write(memfd, "a", 1)                write(memfd, "b", 1)
>     pos = file->f_pos  (= 0)
>                                         pos = file->f_pos  (= 0)
>     vfs_write(..., &pos)
>                                         vfs_write(..., &pos)
>     file->f_pos = pos  (= 1)
>                                         file->f_pos = pos  (= 1)
> 
> One of the two bytes is overwritten.  Two threads writing 100000 bytes
> each, one at a time, to a memfd end up with a file that is far shorter than
> 200000 bytes, while the same program on a tmpfs file never loses a byte.
> 
> Set the flag when the memfd is created.  As for any other regular file the
> lock is only taken if the file is reachable in more than one way, and
> nothing a memfd does in read or write waits for another operation on the
> same file.  This cannot be done for all alloc_file_pseudo() files: anon
> inode files such as eventfd are S_IFREG as well, and a blocked read holding
> ->f_pos_lock would lock out the write that is supposed to wake it.
> 
> Fix generated by an LLM and sent by Josef Bacik in private.
> 
> Fixes: 9183df25fe7b ("shm: add memfd_create() syscall")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: minor description tweaks ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com> 

> ---
>  mm/memfd.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/memfd.c b/mm/memfd.c
> index 7d2da23157003..6f5fbce74f21e 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -484,6 +484,8 @@ struct file *memfd_alloc_file(const char *name, unsigned int flags)
>  	}
>  
>  	file->f_mode |= FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE;
> +	/* a regular file like any other: POSIX.1-2008/SUSv4 Section XSI 2.9.7 */
> +	file->f_mode |= FMODE_ATOMIC_POS;
>  	file->f_flags |= O_LARGEFILE;
>  
>  	if (flags & MFD_NOEXEC_SEAL) {
> 
> -- 
> 2.43.0
> 
