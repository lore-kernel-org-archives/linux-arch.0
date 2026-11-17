Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904455;
	b=jikbAvcVdi3v7vxM6H7c4kVcwVm/tsTaaxGXJFaV5rhcXn6rr9D2ooUCkoynNlbia30s
	 yGWheni35Hlg/u38X86a8dSyMjsf6CB8y1oFbpXBAD5u79LZwtZOOPOqVXMctM28aBKSJ
	 cL1zX5hHl1yEEUN+XpBYEVDZUZ8mFg4v8ak3dL3OJw7o/S+TnEi0IBEyF/B6oo6jJ24bc
	 UXoCcQcLZFkF5vvv+098g2sDgv7Cdp3eL3Xjkchy3g6nuK6/4WM1nUeVkP/ZMuff+Jchh
	 299SJ942eM5ejNGfdakF1oDTOAdNp3zCXBBu3p6/5F2r/OTJtJlBN5T2uSpYhYiKlKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904455;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=GlfPsRE+i3fF5U75sAmCvXCcdyZhOwjsZrTZwssWtpI=;
	b=v4J9Z/ID1X/gLVN9hVFWbrHBCo7zMXIBhOE0bCXc89ntKFEV/AzD1XF+jZ0LnNBcn1Lm
	 hnhIbgxvvDJmKEi829HGiPzlg2OASY5w3EfC9edhZzdaG+QENGAjJrupzF8Rt8yTVat44
	 x38cpfwRhe/Na5Tjaor5I4EV59wj9K1mWIwI1XRK3RSrXENYIquT91myPw19AarTFZHJ4
	 JHUpHVgNm40gzh32ftCqYjIHbq46CoDlCre2N7hvC69p6TdtWWUj5TVJPvyUf3l5R7zqd
	 1OuCsdXY7gDKUWNcZOe732pIXR3MFHqk3o2qMvDKOCDgiwkmnRzPRPOiqoRHPled1mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Ajp9T7xx;
	arc=none smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE949606A880
	for <linux-arch@vger.kernel.org>; Tue, 17 Nov 2026 08:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE949606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Ajp9T7xx
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5363c8de563so55807491cf.0
        for <linux-arch@vger.kernel.org>; Tue, 17 Nov 2026 00:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794904452; x=1795509252; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GlfPsRE+i3fF5U75sAmCvXCcdyZhOwjsZrTZwssWtpI=;
        b=Ajp9T7xxRJnckbguTgRPsP4gP7ggcnMM2Non8C+yfW5N1NAn2O0Q/Op51B10esi8KO
         cT1QYNfljSecakvsb1tR/hbp5ii+N2C1SQRO5eg/t2RsutoaVZEBO63zdqgbyDS5QRZm
         ilg7WysjeJtFO3ioc4r+QSX3DSDXEujufPRNTgaethlsDC0AKr9+o3fWAovz72E0sL8q
         Yx8yRjXW9Qm4H7uIShTpYdjiG8t/jzEAMZsJrxdGZ4Zf3udWcZX/D3Ul54fwpj6boYBy
         Fr7x5iY0EgzeW9DGxrXqMZIa3hxvoh5Ea3aHbyrHezwcgi997p7vTuXIwrmzmze6/thw
         GHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904452; x=1795509252;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GlfPsRE+i3fF5U75sAmCvXCcdyZhOwjsZrTZwssWtpI=;
        b=n5mHF0fjjyBWWxGp3e3QaauLRLIA9dFPClTUEsEbI/qtr7IgRkHO2ZgZXLO+a7g2+5
         bKzzLT0QCPbZV53QErsfkYO7E6SVw2G0Fagxsm8M39oU46x3kZjZiFWj7mOZrLyalLwy
         wF9ue3+xr5F43qMEnEEN+OMJtEDygqvzfWWAJzkj/mFsR8Sn+zGHV++vfgpesaHSAmjL
         5pqhrTSAW7O3bKqWdpqN2YPg2dcAf3cdOWVc9jFSAXvx2/ppTq2HQwqylxhxnkIdh8Hi
         GgjwR/ieYfPiDKTuFFZOa2hJzp7TJ7SuRpFuWJK2lSh72xep2oIq8f2f8BpIBwkCwIyz
         7NDw==
X-Forwarded-Encrypted: i=1; AL+hErElWJzNgRt7qnOQoKVOTJbpg31WmGKXKBGJ4tAPhCz4XHERuBn0JCaBqtQCxkgqtv+m+3GOlj2SlKSf@vger.kernel.org
X-Gm-Message-State: APuU4Z9vxrWtgU/1cxOluNNRB5Od0kBUECUQnRTnuBOIf/x5/K5bDxdr
	jlDJgHH+tTNcdILQgjAx+E2hizgqWl5rAMdIumFTZ3vj6imXOYqPl/Lk23fNNtdUNGw=
X-Gm-Gg: AYBFou2IBgn3ttLZ7G7ufjveF7IPS74utQs6JMyUVrNW0Sef17BKVPYyx51k3PFUSmn
	ASbe4Jlw9CNjaCbF8+y3wY7xQ5AmPnM8Qw9N9ly1TnRPrHyaKDGT0XXEa6Wexi6pmBrsIhy//1x
	BDsLde1XEqDZCLeevfSCbfUhTv3f0q5MDVejtZ2GqLPp0UFRg3l4+I4FI8eIAxVSGauNUGT9qhZ
	gjYMCYbX3u40LeBvuPgJRdEtdYwE+SVmDeI/cRv1qu/a95DAbVmLae8aWYn9ToIkZpUrPDDzzbu
	+AxMY/k/7QnrjVN8pTxeMoAiK9EPlnFbUdbdVJY77acU4t3onvKQakP2wgGBPONkeGN7JkyQXq8
	YrKGiICxvZiVMc6xqWeawQiEAulNDi/oAACKQReCP4thpK5U97bobNsoeT/Y74vNaFYITScNbac
	QSeFzySf+nUBspQ84n505bK+Id4IouaVvHrV5vgnq9+QCQ8wtJPTotzrn77XWOmJyxV2uB00SVs
	Oy1lb7kLvWfy4ve6OBeMcMmMzMoaewIopgiSGhP/S5bLC0qGuqcRnC256lsJ52TUxDYL999a9X6
	5NzxRmnSWHKpEknuL9SGXiDQXGJJTjvjBFpIuWWRqBqB75Xhk1FUcz5aqDXf7RJzuavvQ/1Jw8J
	qPYY7g7w=
X-Received: by 2002:a05:622a:654:b0:55c:b6e8:bb92 with SMTP id d75a77b69052e-55cb6e8c1e8mr144922231cf.61.1794904451796;
        Tue, 17 Nov 2026 00:34:11 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ace15ce7csm100171991cf.1.2026.11.17.00.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:34:11 -0800 (PST)
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
Subject: Re: [PATCH v2 09/15] mm/memfd: recheck the page cache before
 allocating a hugetlb folio
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
 Josef Bacik <josef@toxicpanda.com>
In-Reply-To: <20261116-fixes_hugetlb-v2-9-4dd9e94ea9ac@kernel.org>
References: <20261116-fixes_hugetlb-v2-0-4dd9e94ea9ac@kernel.org>
 <20261116-fixes_hugetlb-v2-9-4dd9e94ea9ac@kernel.org>
Date: Tue, 17 Nov 2026 03:34:09 -0500
Message-Id: <179490444979.482102.6690559604747930966.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-16 19:29 +0100, David Hildenbrand (Arm) wrote:
> A concurrent fault or PIN request can populate the page cache
> after memfd_pin_folios() misses it in the page cache but before
> memfd_alloc_folio() takes the fault mutex. The latter still tries to
> allocate another folio and can return -ENOMEM even though the requested
> folio is already cached.
> 
> In particular, hugetlb_reserve_pages() finds the existing reservation-map
> entry and reserves nothing. If no global reservations remain,
> alloc_hugetlb_folio_reserve() fails even when the pool has free pages,
> effectively failing memfd_pin_folios().
> 
> Recheck the page cache before reserving or allocating. If the folio is
> present, drop the lookup reference and return -EEXIST so
> memfd_pin_folios() retries its lookup.
> 
> This is probably not worth backporting to stable.
> 
> Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning memfd folios")
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Acked-by: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reproduced using udmabuf to race and generated very consistent failures.

Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

