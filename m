Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606153;
	b=zUUz5/LFPDqVvvBg/0qO62hIcg2w8upwRrOWo0w7VUaW8hSZXFfggS4pAH3uTValPOP0
	 YIohpghP3zOGB4KpMvJhPlD/tS8DKjTc+3Hdh3+o4K8CXyh5vATuH1MBHIMDw+t81LPuH
	 C8WhA97cU0JDVcsfUooOd1N0eOIj5B7MCODVef7CGzjYl4Li5EpZ/ZGNkGCymh2gqyJmL
	 JMsNwVACxdpv0fFC/uakby6E8eNvT6X04otY0wdjMicTbCh2RzWt3SD9aPTjyt62CupVo
	 Ec5RIU7F4cazIbkvtUZ1QLfHoUUzlmm1alKz958fcB1qAxcPsVV2TDHFR2pn2sTEvgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606153;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=RwPRyHP2zyVmejGR1uh4JtlvqhjIfEODs3w+QBRfcJQ=;
	b=LgxqJzTy68y47+TFuHVNk/586HTABfgnOrZzriYjU0LEkABVzbzBfuhnGvm6PgzkKTz6
	 G0085g+0sbhAa4P3+U9kLTuN8pdWYhhHWrog3u2tqkcHuYyhIj/4wc9sGKqvh9OTZ6rV9
	 Bwbd0WsD+BbMHVLoV6SYxLD+a3dIZDwnEycYBmeuHnUqRfo1ruVfrYC5uhX3Mi0wJ14wB
	 6AeQfWQs55qs+uc70n3BxqzwuRKRmwEINjPdbeLcHX0A2XeFAYa8XcCpV9wLOBFY0Mqcn
	 sIUA1VwjBwA8tarCemD0oCR3pD9Rn2qfBWxbRyMw49BN5vHmh3gMPSWjoflNqjCyADQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=EKNhbxkk;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B937606A331
	for <linux-arch@vger.kernel.org>; Fri, 13 Nov 2026 21:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B937606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=EKNhbxkk
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-533861a59b8so27900961cf.1
        for <linux-arch@vger.kernel.org>; Fri, 13 Nov 2026 13:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794606152; x=1795210952; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RwPRyHP2zyVmejGR1uh4JtlvqhjIfEODs3w+QBRfcJQ=;
        b=EKNhbxkkQMORETffHCHxv+E20muavs46wHH6TSQgkwOKnkMBWgo3BRqE9adDNYWjJy
         zQvDt0u803Js/yQ/xoqMXeSOKFrPFOOfSJoo4mM3wToNSHCQYLMW01UMv2NrALxHTu5h
         1BKsWm9UIk97Oq6GlYqwEE9cIn2GNrup/GEMawiM0oNLiEcTbAAlcoNRt+Y3u+jnhl7q
         Ff+CjlTIZlIH6YG34N3i7rGeKp+IjYW/FeYl20DzdxfeXsbexBmN7BiSt5uKr6EoNKuM
         /dW15GIGFRQ4M8aVHf6ioFgdIR2GphR1luRLbU/sLdpNwfOidADbdAlqrJzVjjLlQ4ap
         SzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794606152; x=1795210952;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RwPRyHP2zyVmejGR1uh4JtlvqhjIfEODs3w+QBRfcJQ=;
        b=02ecHzdft1xjPPNbn3boTLxTWRrNU1M9a/HfDnjw6eoNYJJZOXPRw8qfYaZgac3Sot
         HFofbbcGmuUupKaAzfE3vMLld3e+eYiByXQRP2Cgeq2DgNnrruipXQhaSHsaTgF6cbna
         OHHHC+jxiP9YIDpE5DlH/DNS+WurZUdTfS76pzCIxXwrqb4EQNDDGcmWLll/yXGJMxTN
         mzAJ94QNRQgv+jGQW9H73ZpFWLE5khOvAD/dutmRy+QvK2kPzaFapV4j1F3q5XS3Atq3
         61o75D73Bs/YBsIqAFjYwRyJ+Mq6PqjGd4gXEh0JjSGrINq9qStKIPVDun+rwzfH/I7B
         DwpA==
X-Forwarded-Encrypted: i=1; AL+hErEXxKvjnzNssXneWBF/Lw3NcM2NU0M8S6M4G0+/jt//XZDmhiCvIwlLwV25giBto3Ci+kbrypKVe/o1@vger.kernel.org
X-Gm-Message-State: APuU4Z9vFbqST2attQn1+8U7dp5M+7u1XEq+1OH/Rj3SdZwIeEpIrITQ
	QIT62mRPpt5bWnL7eGL09lOimajSeEBEMBYmkT2mXla5bB72RdQbW0Ey1p54XdDTtPE=
X-Gm-Gg: AYBFou23EqvKLGb4eq+SXtyUGXAtIudgX7D0Df+46T/m78EQXigVn+yxun2CTgpMuMW
	0QZdOMpPcmqZt8NVK7DztSXveQbC9rjBDFOZMdInuae6btEQDK2Nq4ocC2WHJ+GkNx0g2Va1/Gd
	D7Fg3auLXJDvN44z8mvk4BtDGPrgnw9GCXUf5SjjOvIp+GFzePhuLXa2N+QLiHE/M3CQUbyvl6z
	aL7MvfVRxCWZygd3PzH2lak0y7EcOlKQPgFBLOvPVQOnBmIuIelzUO5VnMAP+FCaYZzbiFD7Ww9
	lxAnUHbdZTUEezIee7OzBrJisepiAJ2LqFrcuoNE7Mvrf8PF47rBc01Scqd32aCw7TOCsd9/zxy
	BTznjLKfZTU2gDOiv4e/gFw9WrwUWsfNKnolqHL12IvfZnGErmWWbCSYohlOssCg4q1SWppqT44
	38eMOizUGhbilDucos+iTPmAetWBYYH5K1Da2PddFInVsJBBSWQdDR9tbOaGqEWHz81xcmmTWtI
	q+4QYXUP6D6H4v/H8VltPOR9vfl32k0ToLbfE//IB9L4RFWxZYDu8vw30AUXZ7uddxjIIqRRP/g
	MU4YpZOdNM1h/2l8+W0XepndHp/XaRWrTxwM63WsFwG0o7MDJmh1pZHnSPpDma+QCE9DhY56dCa
	IdDEQyxA=
X-Received: by 2002:a05:622a:598e:b0:536:566e:6b52 with SMTP id d75a77b69052e-55ac7564a85mr62222541cf.27.1794606152109;
        Fri, 13 Nov 2026 13:42:32 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad0349423sm27363181cf.7.2026.11.13.13.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 13:42:31 -0800 (PST)
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
Subject: Re: [PATCH 01/15] hugetlbfs: fix integer overflow in fallocate()
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
 luojiajun <luojiajun3@huawei.com>, Josef Bacik <josef@toxicpanda.com>, 
 stable@kernel.org
In-Reply-To: <20261028-fixes_hugetlb-v1-1-a0a033db180f@kernel.org>
References: <20261028-fixes_hugetlb-v1-0-a0a033db180f@kernel.org>
 <20261028-fixes_hugetlb-v1-1-a0a033db180f@kernel.org>
Date: Fri, 13 Nov 2026 16:42:30 -0500
Message-Id: <179460615000.482102.14809359037930927808.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-28 21:13 +0100, David Hildenbrand (Arm) wrote:
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

Reproduced the BUG_ON() and validated the fix.  LGTM

Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

