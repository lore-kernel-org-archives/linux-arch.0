Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794678305;
	b=eAszDllMJ1UH/cnoAcOqJ/qp3MPEdOQlm45uQWjrUE6oujnsccP3vlXPh/K5QuVgaPzQ
	 qAvBPUFjI3LbsOYVkUBolGxnKY8aZkfZtRjN6cXehwSCTZP3mff3gycQ9aiE5I0t0a2qW
	 ckPxts2Bxsjx4U5+Dh6dy8gUFQ73pRAVTcW5TzSPT7g/LiBgYJDYWqsX5DI7ahVOGhbvy
	 xjnHTgI8DE3/XZHiL+OQe9FqBPz7aYa2QuJHVN0LZynrmhJ7W6PnOLZ7d/UkPsbxGIRl0
	 Y7COdCgD8veBUzorRrtdoKh4EiPbHbcCazwJq+g4WOo8hTnffrAa3S2HauIGxDJmSBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794678305;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=ZNcZMolhjI9akx8wnIcso6bAnFZ7LtMgZRZy+seyfFc=;
	b=GVu2XVwhbZTQNT1L+C+Hs7bNj+orVsb3pNR0SLZ0xcEPG6b7LnfBVV5d2hK094bNG8yd
	 8a8wfpmkl0DFQ2D1XnmILCNq5j6nmhBKbNSzAablpdyY9U6s0RgA7h/IxUOZ0fE+2U482
	 ADa5b5a/CuyWxZD3rVDQBZJkgm1+WxGzNHXDt+TFlb0NwPu9FpPFpZA065dxyY2HDr9n/
	 DC57pyUljlmS5dNpZZlHIdn0xPrEhPa9pCYgqFkZmLO0xPKQm7jKoI1CRRKDBjpUm56TZ
	 8QKeUe5DeRrfL30ZjmsxJO/YVrHEEb2sIFcmJMCsjKkMJvxHy/oJAMWPYZYG34W2ENg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b="MmWE3/tW";
	arc=none smtp.remote-ip=209.85.219.54
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F235B606A327
	for <linux-arch@vger.kernel.org>; Sat, 14 Nov 2026 17:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F235B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=MmWE3/tW
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91ecdaf14beso31462086d6.3
        for <linux-arch@vger.kernel.org>; Sat, 14 Nov 2026 09:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794678304; x=1795283104; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZNcZMolhjI9akx8wnIcso6bAnFZ7LtMgZRZy+seyfFc=;
        b=MmWE3/tWVbBtF8EcqqHy+PVeL5SSlcJKpP6VzS0tSTNZ2fAANN/mjeb2XKUMnYOGnt
         fS7SPnLre/soNOeedBOj6usNp+QZWktQVRGGddD5xas5spd/gD61hYWBXaHU1f7LSdPo
         bK8uKTvij0ptR88ShH5mhzY9iqEzp+SHQCjXzVtKMzPH8bnKh3tKLARb3tJTj5Xk84j+
         57zNzCJH2LXVTRHwrBigzqWgZ2tlkMTHXah/csAHOyHHZ2Qpn/t9n7Prea0qhwuAyV70
         tipj7gdjHgvDatjTm9WXPyj2RnA2biRVYdIFA6vArHMeWI3Lk1QNJoRZo1702R+InuiG
         Pc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794678304; x=1795283104;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZNcZMolhjI9akx8wnIcso6bAnFZ7LtMgZRZy+seyfFc=;
        b=FFyGwQ463wnsXb8V1clM0HToahbEpHf1vOXvfzwW62gxlZokYWbbN5SeZFdY83iMih
         JdwTzHbbgT4w2nW2vK2AUtnKlXRTlErx+poityy6Gd3h4nwPstOP8XfCAmbs+mE/A8kf
         XhkTXJTBDLwMeH7PAPfSHP20+7Nir1/HHb0h9srfFKbDsXGATIE/IOXsZapXYDU61kkM
         +1RZ8rYwTL9q3IjTm1SDNFo/9HLiDQoIlgNUNT50YqtAqTPaCwWeAnGnmt9C3YOQWAFY
         UFIuZQpRtMWnOAusCDIcovnULmE7KVbAS9qKzDKXDReh7WngLSprU9rNm4z1vQXR6M3L
         aYLg==
X-Forwarded-Encrypted: i=1; AL+hErHI6qHJspgNPzqk4BwBXiiz+IGX/YTUhs4XANnOAgdyo0fnsqO8Df8XYo6oZ6JjabIA/pXZm2qkwa2K@vger.kernel.org
X-Gm-Message-State: APuU4Z9xfL369Kt6iEkq/A/jkwmgf0spN9ZH2qqoN16N/wZJmm7+unc4
	3/SNGLLsFLh32OzBLSKoX5ED+1hTDYcf7sTPa2sZ2YWR9vSHnxjtTMBEeWbSZXro5x8=
X-Gm-Gg: AYBFou3gDJd4szpPyLaB7lYfzC72gQF/fTWtDyVchMARBjNGqR4CLPpszP0jrJIxwEt
	WB1kS3DC18QGMHk5CwMdK6YLP85rBdukJbqSyqkXz6Z2qV3Awez7JdFEnGj4dz1kLc84HpBMaGO
	HmLlcJAcog5qFSzJWGzr3XYsvMgcbsghQU1YCxhDluOh/MELLbR7KGoL6TYBkGetpxZi2EXd7CS
	rgX/E6IGU+pgTZW7JDoBB0BAGFalqbnlY7se5r1Si8DuVMe/Bhb79e79VLFIiRk17NrnPlFy9RS
	QWr/9ClYDl92aNBvoVlbGpVNo0xzcPOIBs398gqIH0IhlIgrib9cCBgNKl7qsoPnkvDiiQPJd8a
	XkZ2Cgi875hoBSvZ6JYkeRzZCWM98nASWTX4zZ95+9JNvD4pshCRxXckVhw/WlyHAkr/kJ26iYu
	eLEP3o3Mjzec+oS6gs8FImOYIsryCaTTJRRv4HYFxYtNvIv1F6DHSTRt3/V1UmcAX6pEa7WzYy2
	fObl1a4jvKLb6gukKtZAbvLNRlIHT8h2b1VuGdk5/6skLoIGaPIht/IWQ6YY0GRoz95PSUZFhEB
	ctYaVSdR2GjQkzrPnCvgT9yPC8dNjd2zT4gt74PTfijSiWZm02xN2QYjUnAj+Cc5beeU8MwsAkf
	9M95KRh0=
X-Received: by 2002:a0c:f409:0:b0:91e:747c:f833 with SMTP id 6a1803df08f44-91f2424b367mr92045736d6.46.1794678303872;
        Sat, 14 Nov 2026 09:45:03 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d73258sm47539586d6.24.2026.11.14.09.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 09:45:03 -0800 (PST)
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
Subject: Re: [PATCH 12/15] mm/hugetlb: keep surplus folios that are
 reserved
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
 Chris Mason <mason@kernel.org>, stable@kernel.org
In-Reply-To: <20261028-fixes_hugetlb-v1-12-a0a033db180f@kernel.org>
References: <20261028-fixes_hugetlb-v1-0-a0a033db180f@kernel.org>
 <20261028-fixes_hugetlb-v1-12-a0a033db180f@kernel.org>
Date: Sat, 14 Nov 2026 12:45:02 -0500
Message-Id: <179467830214.482102.2328406932805572650.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-28 21:13 +0100, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> free_huge_folio() may restore a reservation, but still returns the folio
> to the page allocator if its node has surplus huge pages.
> 
> For example, start with no hugetlb folios and allow one surplus 2 MiB
> folio:
> 
>   1. Mount hugetlbfs with pagesize=2M,min_size=2M. This allocates and
>      reserves one surplus folio: free=1, reserved=1.
>   2. Create a 2 MiB file and write to a shared mapping of it. The fault
>      consumes the folio and its reservation: free=0, reserved=0.
>   3. Unmap the file and truncate it to zero. The mount's reservation is
>      restored, but the surplus folio is freed: free=0, reserved=1.
> 
> Besides losing a hugetlb folio that is required for a reservation, this
> can also make available_huge_pages() underflow and cause other issues.
> 
> Keep the folio in the pool if it is needed to cover reservations,
> including any reservation we just restored.
> 
> Fix generated by an LLM and sent by Chris Mason in private.
> 
> Fixes: 07443a85ad90 ("mm, hugetlb: return a reserved page to a reserved pool if failed")
> Cc: stable@kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: simplify comment and description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Was able to reproduce the issue and demonstrate the patch resolves it.

LGTM

Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

