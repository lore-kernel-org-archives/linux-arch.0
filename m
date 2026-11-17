Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904308;
	b=fvJk5vLUkrELF8AJCa0l8layHnZcnM34fKYqFdJdArEUwhvHplUoFWy7zLSqMAfpGPRA
	 4XAdZPdVLGZIPyi+19s0M3k4D1jddX0moKaWo5IIhdPGOEVoFPnIjfKB5yP1yO4jV05FX
	 njmmfQ2cnTbEuRPW9lQnruIeC8CZ6OWahDQqSF84AiF89N2FBIdzE6xIRqMOXh7E9eic+
	 o9WYAxG02XmiQZzSiUTIFUg2vZ3bQSgf0USi7sJLu44wYhKYCDjGJRYMBeebc8MZjLtZf
	 zB85vtNTmtyQUr5Dp8ByViRqlhqAugPe46P7Tci2H53o65sePUjYQyrEdYzLs21tDBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904308;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=TmH6s81HME+/ARGnJwgL9bVR9VW6JoGP/0HNw1M8o+8=;
	b=cN7kxZljlHg5yMEofNEQASU3oL1Al9deySJ2Y4ugg0iD0yLK6G51XdH1pAKDpa93+2c8
	 keYIUHdg4P2Do4JvpjK0xmDHCMgqoT4f4oILW/TsEF+kbpYBrPbZhO/+DlkkSTQ/qT0b7
	 ZXqwO348QE1hjO24FG1jjjPAlyl8qgSGNfMkD/MZ8LNaEtGsKkGRW4lqNrcGsy4ZY3ZsB
	 FU/fRYXqYUvqghbAPpz4rYg7f74q88fwKxwdQKOIacqc1rc9GMya871rcijM6yDEfiiCO
	 EuAFe/6K6TM61SOW4QHLO+sIgfBHTfA3UVx8ZRSXNU8L0T9a0kAb0XlgqZe0V3maRrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=ourL8s16;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3ED606A893
	for <linux-arch@vger.kernel.org>; Tue, 17 Nov 2026 08:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE3ED606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=ourL8s16
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-55c38cdd5b7so40042821cf.2
        for <linux-arch@vger.kernel.org>; Tue, 17 Nov 2026 00:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794904305; x=1795509105; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TmH6s81HME+/ARGnJwgL9bVR9VW6JoGP/0HNw1M8o+8=;
        b=ourL8s16qvV/ByzrXiQnYSg2kF1A4uqN/AnfqBVQNPBbatZm3DUHQ8Aj5mDYNeanQ5
         MJwxDSueO/GwOBcCYIaM2431ceTkAtIwsRppYKovBOwmv3uilo2gi3HtSlXrxM41UOrR
         nIwd/WnpWNv0lDvrSo4gxjlev3eVFrvzyvPT32/reHLN8c1iROWdTpDcqLiwSDVszKTk
         tI9wm2+3jBJNt+T7vJIMKCVa+vkQ2GH6b803gnwQfkS8l1Bx4WBOwUeysmA7sm5XbKP6
         WiMR5/pZsgjQZYxksMerIC0S6h9yq2gpH5rpRHE1RZmPl0Btw+pchgk0cibqsJOcA4N+
         ka0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904305; x=1795509105;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TmH6s81HME+/ARGnJwgL9bVR9VW6JoGP/0HNw1M8o+8=;
        b=dru1r6FqFV9KqsrydpWX1rSgkYnOFOfs16Xpxq5d2Cnvzd9qolDa5VW7TLZq8VZFOf
         ybM7eZrJvurGHAPf62KS1tflJvtKKAwYXNrXULrnNmIngmwYksHlqpZCwkWG22XTeV7d
         0GGP73NtGmsSswRK276tBgmysUqXj5r9x0Slgpx5V1EhU6BBBmyQv4yIgLmYPj1d/3rr
         h6mkGkjat4vzRYExdSdhY1Q9AEZlfRP+GYSdoOE3t032+ysBnpYuBeTqk2KvySAuZe+X
         ulNeYB8KP8HeCkcU89a2a1J3wqtjIS1VfHRNJKl5MHYuVWchs3k62hgZK5Ord+Fe+6eC
         3vog==
X-Forwarded-Encrypted: i=1; AL+hErFLlgtS+5gnGQjTQy0AzVd58ePnkPLAPL2FDlTE2dq9Rmnu1V6a44lZZRWTVuNN9fK9uJING4afp6FO@vger.kernel.org
X-Gm-Message-State: APuU4Z/yrrmv6UC8ufQETZI3gWcm9Q1poCA8D+3SxdxckbzZpHUSk7Ug
	br1jQeAaCBVWWYkF7ZJXXFdNss9P6FvdVLfqyWoxH+88Tf7CXehjpejBWTcy1Yp1pt0=
X-Gm-Gg: AYBFou0CtEaAXzPx1HYFiRDfvi/y2YNm/mmhS1yL53OlVhCIXICrKEp9E4FweD/XY8F
	5qBhYn+zGgQzV8urdvV0EAALsKYOI7DuB7hsV/CHTGEowoAeKLF31lTImECKp7FO3OwQMes6I8E
	+pgIw6PAAB0ztLDsu78GD6Fe+GJisjiMEN//TUtQK2HiVTyZABvHxyFWq8xLjsUwW7nQim0qgjF
	lsNfFFjcvQVvZvIGEE/kPO6S5IaZhBd4NtoxroylDwQkEQlQEqjuSNMSUtPWvd0Xpqx6q++m3Tb
	xIed7uNvcMSs1hCn1yEuiLGFUSkAiUdgeuKIpI6O913MtfDFfj28feAtWzuBJnX4BNKUKhdu4bP
	tn2HOdzYZvjgBpZo7dWzslQXcje5O5sQXafCT46c984bpkuIt3tz36YbD3pZcFLp2eApFESHyAQ
	UnVTAQIRpokkVvc0+Qbd2UmvAf/Hmm7LepYJvAH1QdN82NnmCnLWV2wdINbmqthYWGvZAK5rzEY
	b7az4V5OZXw8NsOYnhp2c/Q01YcDorzuHITnsDuRgfx1ImtllxAouhZcWNPJnhL1f5JDCeW0ej6
	V2cPGpTflhlQeoZi4y7S4/zdvH9gS1p7Ae4L98ugN0xmUMkbs3iuuqVvIhpZ7CQouK4jxgFaC59
	rem8tFWPf3EveDo40cAb9540et79jBw==
X-Received: by 2002:a05:622a:258a:b0:55d:30e6:8d8f with SMTP id d75a77b69052e-55d30e6a736mr108004181cf.59.1794904304803;
        Tue, 17 Nov 2026 00:31:44 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad0a2006csm99694361cf.10.2026.11.17.00.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:31:44 -0800 (PST)
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
Subject: Re: [PATCH v2 07/15] hugetlbfs: fix unmapping folios from private
 VMAs
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>, 
 Andy Whitcroft <apw@canonical.com>, Miaohe Lin <linmiaohe@huawei.com>, 
 Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Dave Airlie <airlied@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Peter Xu <peterx@redhat.com>, 
 Breno Leitao <leitao@debian.org>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Gerd Hoffmann <kraxel@redhat.com>, linux-doc@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>, stable@kernel.org, 
 Daehyeon Ko <4ncienth@gmail.com>
In-Reply-To: <20261116-fixes_hugetlb-v2-7-4dd9e94ea9ac@kernel.org>
References: <20261116-fixes_hugetlb-v2-0-4dd9e94ea9ac@kernel.org>
 <20261116-fixes_hugetlb-v2-7-4dd9e94ea9ac@kernel.org>
Date: Tue, 17 Nov 2026 03:31:43 -0500
Message-Id: <179490430300.482102.17633361840450824485.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-16 19:29 +0100, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> hugetlb_unmap_file_folio() assumes vm_private_data points to a struct
> hugetlb_vma_lock when hugetlb_vma_trylock_write() fails. Since hugetlb VMA
> locking was extended to private VMAs, this can also happen when
> vm_private_data contains a resv_map pointer; treating it as a
> hugetlb_vma_lock corrupts memory and can cause crashes or hangs.
> 
> Only take the VMA lock when a shareable lock exists, as additional locking
> is only needed for PMD table sharing. The fault mutex and i_mmap_rwsem
> already provide the required protection for private VMAs.
> 
> Fix generated by an LLM and sent by Josef Bacik in private.
> 
> Fixes: bf4916922c60 ("hugetlbfs: extend hugetlb_vma_lock to private VMAs")
> Cc: stable@kernel.org
> Tested-by: Daehyeon Ko <4ncienth@gmail.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: simplify description and comment ]
> Acked-by: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Was able to reproduce a hang / RCU lockup pretty handily and verified
this resolves it.  Have not seen the relevant crash.

Regardless:

Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

