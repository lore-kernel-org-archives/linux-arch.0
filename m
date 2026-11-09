Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794213331;
	b=vOnDcpPyl5uozkgMe6HasWi8YwEcvUpSGQZFicVUhBNfF8Utv11fouMOSlvOuqg1TII9
	 oAR4izA38ytCruZLH7r5NL8NL0KveSqWPxPzEuRQlY7VFGzROsdYJ+8tJygH25Cyzjk6v
	 o6qsEP+6Bexmwlxpa0yM+LgxKIwp/c+KwZE4PH2D2MY3SVjPYG+njr/LXWdn/h7DwB8OW
	 9qqDcZQb50DKQjfusDklblFCPHFNAG7gabPJWWKoMPzO22zH30sEGItmrEbLapvuQg/3j
	 49AR/AWOloKSqoHDmAc3GY2p4zW7BDN0e9dEmTri+MW/PtsfC3BPaYAC5Nkr+SCED3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794213331;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=6v/EUAzIuUZtunuZ0TzsEXeSSrt8us4QeYlPDnXiIyE=;
	b=qVsNYO1aNrc2x+6O3JP6b+HHKkESvKTyR3+NV/JAk/zNhEFC5M0/vQ7FZIDNV1GGX7wh
	 4GylhjfLRp25y9ieNsLGUgoFXz4QXIedZO/tyz8nF3x7goUWkmbufW+inC/Y26rOX0e+z
	 Bny3X6n2iTMQNdr8q4vvEyDFu5NOgGDCdrnFLaGP2ff+nJ5+3fq7ugn9PRlrdafeyWHg9
	 wYBUEAcajUdMJYqpIJAV+nMMBMux/FjFDK84Pb+GTeQOZt+XOjZxijGS8S2+BVWoDxhOQ
	 QIG6Ys5yFGyjhMVedf4/rbtsplUW7Dz7xpKiEf6PO7fpoeB6NE42wHEF048ZkEAfd9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kmd1vfA7;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B49A606A322
	for <linux-arch@vger.kernel.org>; Mon,  9 Nov 2026 08:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B49A606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kmd1vfA7
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4b7252a32c8so5469815e9.0
        for <linux-arch@vger.kernel.org>; Mon, 09 Nov 2026 00:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794213328; x=1794818128; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6v/EUAzIuUZtunuZ0TzsEXeSSrt8us4QeYlPDnXiIyE=;
        b=kmd1vfA7HwVdKlIlNMcEdgSvfMccQHxtsBaQ5wrlPJ2pETJCu/dB5avuxdOeVXJbBi
         KOyzf4oZ3H5dRwTfXxv5zF2iW+FgAxXtoL6vUAonyK9hiz4/gOsvk3QAg1rxIyH4OaDU
         5lVlTkXusCDeJ+5UZeQ0nSIlh7ca0tSHggdztmbjQYOlZ3cyydUW29Af4wLsYFNoSj7l
         Uxe49m7b5cT9hGql+cIpNRaBHqcFlYVq5WdXa1NK+FbgspW6vo3pbYAJRtHgpDx8Tp0K
         4xviTwp0YHAbFBBwYfvbPfMiKK5Pj8dPPA6arIrC4UUfVfMyjMGyOJiMz6TDbfz4O4pa
         AqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794213328; x=1794818128;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6v/EUAzIuUZtunuZ0TzsEXeSSrt8us4QeYlPDnXiIyE=;
        b=E8i39bZ3nMhGw9wJQs1hEKUIvCO7uUYLQsGQ/t15I/njuLiDgsU5GP6URW1olypAum
         ZzQFPz0yOAZSRheZ4u0OGpHcI/Aug0XMMjaIuhQBZ1PGlpindELrdl2hjgrmLy8GWdsa
         6Dq6G+upiS5r+IylwQpkil0bR4UVq/H3Y4/DWQcwOvUNost+P0U2UTRqbVoVQ+oYIIaS
         UaWN+LnpP1K4Ts+5cRW0oDTvSPiBHbNHzedluetSEruoXtL6JZhHBtb61GnTDo/VfXG5
         cyE1rw2TX4zvywD+WvTuoqdlW0ss2QskLecQN+x5rNuB2Nr+N2w7EJ6tHsKj0U9HJfni
         hkdA==
X-Forwarded-Encrypted: i=1; AL+hErGtMJIM8mzQFWHuiZw2MxUFcENGGEleyoh7m7vre55z5kqDsXqdcW0KRNGTOZ9YALJAsVj46Dk/n9lZ@vger.kernel.org
X-Gm-Message-State: APuU4Z+8+LqNkRK6ClyBseA/17YhLAkQ++5nxbaFWOSF4M+IuRhK3IPQ
	lJODqDPQceXxpwYsQEeET0bGll/SB5qM2UAguLzKM5LyhezNieaDKVSG
X-Gm-Gg: AYBFou2c/ZhBBdA5UeJjD2+e3YA5HXBmoY2bjToL+Np+wYwNMmNqE0bET7Vi/gUvukZ
	19Nxa+I9gPIV/eOAH7b4adaKuxYKKeVPK78q8g8eMlOGEuu3jDhetjlyXbpm++nhqF5dXM/VU8D
	U5GO6iot63gLs7+TfIHII3+VTRbfID/JA4TCJd9ETB5RimG8ML+7OUFrXLBhFVd6zDu1E1dEwgM
	ORFeeXiCmJxP/ObLvfPWn1Wxi1Zfzc0bkKnRb8nUegM9GVbeC7xO51FD7/G8iY4H1VeTJGVf3Y8
	j5yJDB9xfZ55Oh7ErB4ot4WWdBm3oEjqvNhwsRjfzhAk9yDlXq1F1Kgy+uS0udIYLGzEHOOv8Hp
	zDYaIidIzQG6/KhxNLXj914xot+rBgAWVLF5ShY4/xUWo3JhqVKqTrdvWtW1fm23gKO1lAdaACK
	Ii1cCQ+zW1/Txkg7wW72cyO9dTUFMQex8PHsMJZDbDv60CaF3j5JCrygjPbiyui1ZY91zHbf0M6
	YuMD2Q/u7wF38c1RcCW+ocoLIEnqREWOSzsDuH7FQ5HxAl+hlxyPIAcu6blt/G1/oEiUrWv+EdK
	sc45ipNOZg1VlGHGmMI6wDxLOyxShcvi7WCV62h4jNAV
X-Received: by 2002:a05:600c:37c3:b0:4a3:5991:718 with SMTP id 5b1f17b1804b1-4b963c87b5cmr58185485e9.16.1794213328165;
        Mon, 09 Nov 2026 00:35:28 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b90ee1ddc7sm170118285e9.4.2026.11.09.00.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 00:35:27 -0800 (PST)
Message-ID: <4bae9936-02ca-480f-b754-c7048702c667@gmail.com>
Date: Mon, 9 Nov 2026 09:35:24 +0100
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] mm: limit pagecache folio refcount when mapping
 pages
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Song Liu <songliubraving@fb.com>, Rik van Riel <riel@surriel.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Steve Sistare <steven.sistare@oracle.com>, John Hubbard
 <jhubbard@nvidia.com>, Josef Bacik <josef@toxicpanda.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev,
 linux-arch@vger.kernel.org, iommu@lists.linux.dev,
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org
References: <20261107-refcount_overflow_stable-v2-0-c38f6809b106@kernel.org>
 <20261107-refcount_overflow_stable-v2-1-c38f6809b106@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261107-refcount_overflow_stable-v2-1-c38f6809b106@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/26 11:23 PM, David Hildenbrand (Arm) wrote:
> With large file folios, overflowing the folio mapcount and refcount
> became possible. For anon folios it is currently not really an issue:
> each large anon folio can only be mapped once into a process; on 4k
> kernels it would be more processes than usually allowed on a system, and
> on 16k or 64k kernels the processes alone would consume hundreds of GiB.
> Something to be sorted out at some point, but it's not as urgent.
> 
> Being able to overflow the refcount is not really big news, but it's about
> time that we do something about it because some modern technology might
> find ways to abuse it :)
> 
> One of the enablers for that was commit ddc58f27f9ee ("mm: drop tail page
> refcounting"), however, file thp support was added later.
> 
> File folios can be mapped multiple times into the same process, allowing
> for processes to hold many references to the same folio.
> 
> As a short-term solution, let's introduce two folio refcount limits:
> one for ordinary consumers and one for admins. Leave some headroom
> before the refcount goes negative, which we really don't want (having
> the mapcount go negative is also not expected).
> 
> Start reporting SIGBUS if we run into limits. When restoring mappings
> from migration entries, instead zap the pte/pmd entry. We allow for
> slightly exceeding the limit to keep things simpler.
> 
> During fork(), prefer not copying page table entries over failing fork.
> Export __folio_ref_count_over_limit() right away as that will be needed
> from fuse code next. Use has_capability_noaudit(current, CAP_SYS_RESOURCE),
> so filesystem credential overrides do not affect access to the admin
> reserve, and to not generate auditing messages simply because we access
> optional reserves.
> 
> This is far from ideal, but better than all easy alternatives we can
> backport comfortably. For now it fixes the big problem: letting
> the refcount (+mapcount) go negative and cause trouble.
> 
> This is only a temporary fix, we'll follow up with something better.
> 
> Check order 0 folios as well for consistency: each
> folio_add_file_rmap*() and folio_dup_file_rmap*() needs a prior check.
> 
> Also, just document -EHWPOISON for copy_present_ptes() while at it.
> 
> Note: When zapping file migration entries, uffd-wp is preserved using PTE
> markers, but uffd-rwp protection is lost because there is no corresponding
> marker. try_to_unmap() already has the same problem when unmapping file
> folios, so we'll happily ignore it.
> 
> Note2: For now we don't let migration or PTE table collapse exceed any
> limits. Admins can always refault, and if we are already operating in
> admin reserves, something is already off.
> 
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

LGTM.

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
