Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793307227;
	b=YH8UpDcc7sqZXNaxiwn2miItDGnY0MdwO8W4ENi4BRqIObLXAZwMlURoYKxbWGaFz1nW
	 VTBpWMwKdu2eWARW9stywKKmSygGsIBP+aHsQeVX22SJTixPYV5w1mOvqFqNJBFxedx0s
	 zaSUmu55xaKgIn47zAH/I8hhsZFEcgnFD3BUvnC0bEtaQmimIiOcUFlzfOKr93TrftgUx
	 wbBEzyaXscQnDkoNHc/cqHTg506did83Ez315Jx4AiubD+ub2mgsa98nyCpf38O2SG2UC
	 Gi2fjmDXoxjP1QjubwjwVIForGXEsx5BMnE0FY8h7lDM134EOMGryK+UoP/Kbe30r9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793307227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=+9X2/iX/Lqo173Vwu0EOcoEv3bNJRFgizimBaD4S5Pk=;
	b=JsL4q2ydfrIL+CC/7JBYwXlYHBjHKuJUVmPa185SRaOe4aoLY1qhhhdo4j8CBoUh8JIn
	 txxuOfTPfYitwTJFaUi9b6ciruYuQrfTuXlZKBycNb9BhbIxFoiZWlLkw9gKFeDJJPK3D
	 U6zCduJ+Q4+T6ytPpywsWmSWIasKp19evTOxEE6eGoX2mWd37K/wWNvaf17o44lqVrkga
	 Dlc8xWoFpqq4X2oMAZvXqoD4FfEaSf5GPuIMWU3+Aepa1Ra0axlZYb1l4ntqDZU01SbK2
	 7Za6RXt+wDBfV5BuyoHSUDpfI1FG12SfvtrAdkKcaDoiosDzsK0ve/KQZR9mGCiwAyg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=X4ncqWDH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2004E606A339
	for <linux-arch@vger.kernel.org>; Thu, 29 Oct 2026 20:53:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2004E606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=X4ncqWDH
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso23927eec.0
        for <linux-arch@vger.kernel.org>; Thu, 29 Oct 2026 13:53:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793307226; cv=none;
        d=google.com; s=arc-20260327;
        b=p1BFVKthfm/C6UCt9kw6nkJ3M7zo5iY290HR5jdDuxZba2ihmviRL8XTgPsx2Ml2cr
         ojLqAw2/4JEmg3seKWX0NmSc/4wQO2GgnKDLzKOPtcLXxEcuvKOH5YDWmNkVSX6mNTau
         yhzrGkNbPLgORn24od+dAFo2Bw58NqgYRAzSIa5QSX/gg0AdZ1r+f6ykZG/BZov3Jk2n
         MY/XJY67Nggi9wjiT2Ei7riA/DYy0wDekK94JJ6123EcFfWHy8FdEtzem7A9WW/Z0cWL
         ZL02gonKJK1H4UOGRK8gosfsqUydJf6xcSFInv2keoqihGzohWB8onkrBZf5FUK7T/sT
         7BBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=+9X2/iX/Lqo173Vwu0EOcoEv3bNJRFgizimBaD4S5Pk=;
        fh=iLB8bCZqsIQ9SxuWi+S+ntXUzuD303r7yr6KMQsJrIU=;
        b=hRaNora3qitVk6L2jrwT2nb7vluddLUP9duyGx2LCetJ/Ic/slcjxA0/lEkfoMpMUJ
         OCGGM72X7fDr8fVCwGNK12RdMuW93yigTyHTxb2/I1xS3SUW9DsGoSZmJLKeAEK1xji/
         Hepf+D8WLhH//T75dZhgybU11lh0MyWTc0trqkMsNBd+1Vusk3pjWXse4ajk2xMx4IXz
         UEF7DY9lSDgIZ0SXPC3LF6JtnvHjvzDiubGCQT7JdxmvYrf5pRD4PoeocncZYMY1yAbJ
         G4LSMz16yj25nDd5+EEyviUZLmstkC7dxzTpY1gidzuO2P72o7iRCuVDCmREZowJRzpO
         GkyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793307226; x=1793912026; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+9X2/iX/Lqo173Vwu0EOcoEv3bNJRFgizimBaD4S5Pk=;
        b=X4ncqWDHObARExJNzFicTAgGNShnnQyxHKRK/cw0fjeWbrVpO9dqNdFUtJLaHpfPe3
         3pQCYs5wPDyyeDRmHh6ZqxApAZowXImXkA1IiV80Wa+vN63OrMv6zHZ38w2Artqhj0kC
         TU5uAZwV8krucDNHMSBMsftqEv1zyLHEc4T7kkfonRf1QyhSc0K9tIEDxDosPnvHYJtU
         xrApcK1DGEJ0jC9G46yDslykO/UkCOdwNhIENzzsS6m5+HzjfiU4CekIHstdVmcDr6+w
         qoB3o1FiEmAOoeBr6eS4J+v8S4/RWAMAqqL+riJw8IsTfV7R0fo/ywFH88iTB5PhjqF0
         soEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793307226; x=1793912026;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+9X2/iX/Lqo173Vwu0EOcoEv3bNJRFgizimBaD4S5Pk=;
        b=n01cmiX6E5lQa8Q41CGUI4Gj3PjqMoLnUkuyvdc7Flp3TW5/slpbquHU6YTKhpVeKB
         4a/IlQeYk/n0kfxu2IEAqojWQ8Nt+575F1K53XVtyR28A9pBg4hr6eTcz1na4eJKx1tY
         isnWaggck5EBhNRxYz1rYAgiloDOBayvYJ1Q5R6E3JP4nJp7CbHGKW+XiKsQN0Q6vMaY
         GlfsZAFr24nO2ap2azIU0ASmDLGbZjEP9SUAjqK+mo2s2eTWB44bNnP+74+x22K2/D2+
         oCaM9vFtl/B9Me46/xX5/Rbgf3bdyjg5+w2m2KchIynARG2C+EVFYYUGHy6upFrUaC1N
         +LAQ==
X-Forwarded-Encrypted: i=1; AKwUvByjjux0V+xzPpd8xPAcTXX/sPqspOvUgU8Qnhk2aqUF9T9qZm5eDt7RYsPlm+fU172CgBGLjRswq6Ej@vger.kernel.org
X-Gm-Message-State: AFq9FYKXLb7dP0e9TvCf1ZaNYB9jdsPZ4ttZNfRs/zjCtOBTAcsZKjkK
	znnY0PsqPH4ssYog7PxUWqP+ToxiXw2qnqs6DVO/LwuhpVdGhmas8o6odyKYiv9dn92UzGFc0Kf
	Q8/2GjAntzUFZwt3r+6Z+DJ8FYQ+fRJoz7XHg+D/w
X-Gm-Gg: AYBFou2rTDTM0FZ+PbDCEOPv2OlgB30vkWizaHgix362/ueGcG+M6NrEqsg5Sv/h9k2
	KwV6tLS/lv02DzUKiHESddGvbWCcalttFA5DUQPrr50BTdPWrPTc5dKFvGhGFBjEUlV6zwUh3Jo
	aK41K4RUYINy9BLucw8bn1szmhT7MSIi2+Z2XwZoa6H/ngOr3rNXSgyJh1KW37rv9d/YPpVVzp9
	F7D9mWEwF5Hkp9dl9dISZVLODy02OyJake5F4yqXvrNPgqB6n+c6gcbiAh7HhJ4HjFzRJDzfPWT
	KKL6lLrUIPaf9IR8sT0k8JpkfmHAPnZKCCosXyuvwAGUnkxEVl+orErFLC75cAUXUz68l3YhO9j
	Zofpj7BnXG/Felm5uplOhh09yTfJhH8be+/CKSNaRqj88AuiVEh4cmJALKsrU3wwuDOjIbg8kWR
	S6aYuloX19ZNZUbwPIulCyemE=
X-Received: by 2002:a05:7022:2522:b0:1a9:c9fe:12c7 with SMTP id
 a92af1059eb24-1ac5bbb4b85mr358477c88.9.1793307224406; Thu, 29 Oct 2026
 13:53:44 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 Oct 2026 13:53:43 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261028-fixes_hugetlb-v1-1-a0a033db180f@kernel.org>
References: <20261028-fixes_hugetlb-v1-0-a0a033db180f@kernel.org> <20261028-fixes_hugetlb-v1-1-a0a033db180f@kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 29 Oct 2026 13:53:42 -0700
X-Gm-Features: AclHuK_vfygndkmig7dtJT75402KjRWCrBeo-qQvow0jlIneeAJCjzWqgPCqOeQ
Message-ID: <CAEvNRgEY1uNs7F+ZPpcbx4Tgg=9r+f6nYpPsnm7em0+2YMq6cQ@mail.gmail.com>
Subject: Re: [PATCH 01/15] hugetlbfs: fix integer overflow in fallocate()
To: "David Hildenbrand (Arm)" <david@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>, 
	Andy Whitcroft <apw@canonical.com>, Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>, 
	Rik van Riel <riel@surriel.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	Dave Airlie <airlied@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Peter Xu <peterx@redhat.com>, Breno Leitao <leitao@debian.org>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Gerd Hoffmann <kraxel@redhat.com>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-s390@vger.kernel.org, luojiajun <luojiajun3@huawei.com>, 
	Josef Bacik <josef@toxicpanda.com>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"

"David Hildenbrand (Arm)" <david@kernel.org> writes:

> hugetlbfs_fallocate() rounds the range end up by adding hpage_size - 1
> to offset + len. vfs_fallocate()'s existing overflow check only makes
> sure that offset + len does not overflow.
>
> Once we overflow for valid endpoints near LLONG_MAX, we can get a
> negative temporary result that is then converted to a very large
> huge page index.
>
> A one-byte allocation ending at LLONG_MAX can therefore consume all
> available huge pages. Pages added beyond LLONG_MAX are skipped during
> inode eviction, leaking them and triggering the BUG_ON() in clear_inode().
>
> To fix it, calculate the end index in a simpler way that cannot
> overflow. This also fixes the signed overflow reported by luojiajun in
> 2019.
>
> Backporting notes: without commit a08c7193e4f18 ("mm/filemap: remove
> hugetlb special casing in filemap.c"), remove_inode_hugepages() must
> include the final huge page during truncate and eviction.
>
> Reported-by: luojiajun <luojiajun3@huawei.com>
> Closes: https://lore.kernel.org/all/1554775226-67213-1-git-send-email-luojiajun3@huawei.com/
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Fixes: 70c3547e36f5 ("hugetlbfs: add hugetlbfs_fallocate()")
> Cc: stable@kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  fs/hugetlbfs/inode.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 01c4d6f44ebe..5592cfc6cc8b 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -721,11 +721,13 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
>
>  	/*
>  	 * Default preallocate case.
> -	 * For this range, start is rounded down and end is rounded up
> -	 * as well as being converted to page offsets.
> +	 * vfs_fallocate() guarantees that offset + len is positive and does
> +	 * not overflow. Avoid overflows when calculating the end huge page
> +	 * index: set it to one past the index of the huge page containing the
> +	 * last byte.
>  	 */
>  	start = offset >> hpage_shift;
> -	end = (offset + len + hpage_size - 1) >> hpage_shift;
> +	end = ((offset + len - 1) >> hpage_shift) + 1;

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

>
>  	inode_lock(inode);
>
>
> --
> 2.43.0
