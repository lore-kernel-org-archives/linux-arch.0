Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793313053;
	b=234YiRbZBsUQu7GxuVBKmHGkss5Ufa/BgohpFRLcGtIN7qRWWPh+TIBYVhY0ICfTyyKN
	 5dSzPVDsK7W0dxY3A+FlwU13GnKqaOLfIki8gP17ecuFwjf82+nAJR8HFM1GAjthTa9Yr
	 BQTxUoX9i/j4HiPduFEFhEbsi/S0mwoeEXC0r83nNcmD7ukUysaazoQnnRnppD+o6E2lX
	 UHmuLnT0ESFnezyj99G6S6Y8vb0erFl7+6nt4ZT68+l/LBNl80SOWX8J+MC3l+lBXRM9J
	 HsH54epZ8+Rmurs8NWNa3lmcezxfHsNiJLzpfA6Y1mPEfTOl2WyU2JdZeOidhvzXIiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793313053;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=UPY3X5uvq0LQlVSKfRxAerWA4F2Yg0A//1vEESl9I+c=;
	b=gEvKW9XvO7dUfWp8uAgibj/hERlgiF3E3SqRqgLbgPVnNUxW6AGHfCsmIaRMiXvUaNwL
	 tr/V9axRzCXZOIfzAUVBbBfcmcErcV6ICKqa87EFcOQ+uT0Er1PLUjHGemC0HFnN/vz4B
	 4QeaPfJPKu/kLW3r2r4yYeo1CGPndUWoCgkHDD79N9aF0hIxlbpn3F8HuKV4QpNXJAEyy
	 vVWfzgcJ18tqRVni2kPvx/5lsfJpPKST6AWcX/shYfB+E0aRFX1ZaXeYIgVdbU6hq9Fdx
	 ewGFbb70gLoXVyc7PxeWuVS4RV4bREaY9rr3taqH5Ucx5UJOg5eBjJDfKtR29PAjjew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=VSHotii2;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B35606A31C
	for <linux-arch@vger.kernel.org>; Thu, 29 Oct 2026 22:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2B35606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=VSHotii2
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91c63449320so1295926d6.1
        for <linux-arch@vger.kernel.org>; Thu, 29 Oct 2026 15:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793313051; x=1793917851; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UPY3X5uvq0LQlVSKfRxAerWA4F2Yg0A//1vEESl9I+c=;
        b=VSHotii2iA/Qci+re5k9+hkvQxKjnotN/2zPP0cTQVX8b2J8BjE60+OcYufQKoVKvx
         a+j3LCBHF1DpLlIDKR7gb6PpKNODYEXP5niM7fAnH7XdFH7GFuaFd3xcGQIGPOzeeZ36
         dX2hldmlIJ3DR5XmGdNwQLj7XhdPI1h4ZuM7QOuzWnRVpoDso9hh2meI0Lui5uI/IuOk
         506s3mKiMnXlDNPtgHXynDbZfoZM5erpE048exc19KkqyliRV6xYwunu5BjsxA79iI4j
         XwHJNuL76Wix5UlGfgAKC8Pr4DZ0OiWTffDcTDfMEgS1ueH/XIz4VWe0mCZo0xJKxe0s
         aGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793313051; x=1793917851;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UPY3X5uvq0LQlVSKfRxAerWA4F2Yg0A//1vEESl9I+c=;
        b=va13lUiKPoP7vzERwp70j0vMk6rI+nnRZpFph80VgMOFMBcuTrwTYfOndreDW0c6W9
         RwoqOgJysHRY962QjOFxKt/MkP0M0BCCEK7EhoRpX+x+4loWkKwcXUUEWAPsTiywJ8oY
         AB9uEEi6hUKf4Mz2MjtZKftoV9jZLcSCFnY1GQVFxVFV0jTMokVmfReLwkm0K9xcm3nP
         VyS/3u4h558LiRJPPl/hAjg5csCXBC7FiHAqENEsp8szRDLozvzDw7vaLbh7yQcla+AH
         //SX1OvVQlWA8HCMd+cvx0VLHvsTEsYtQbHVhKKVm/XHWLiZv+P+okMxz3Y3oDvAt8AD
         inoQ==
X-Forwarded-Encrypted: i=1; AKwUvBxME14jAkKI7uwc+fgaGIdGZZQOTaP4aZmrBbhpTmB+8WHrfMplbNHJSS0eQlt4BMK5OHpZ8Sclaj9/@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0/h1QJJIiJq/0hNPEB+hwpNpDaqpmLWst9zXwLFYTpGP3+Dkh
	NMSYb6X+Zw78syLFC9cG0z/yn50VWd5Ut9O5PTAfIWF2HHFL84wjHKEa7+7vZcW4dD0=
X-Gm-Gg: AYBFou1Ww82eMn8jTtxPWWQVkvlLcaCnuY5zJkVJuqmSSvJ95zQBCyPannQchAdfXpW
	LsRkrcnV+DUeAx73TdtVuVSZLrAiMyyAeKfP0XYLMucoGSgR0Iivz+aHp+NClhMGWQ0uqUqRfkx
	dNkBbm9ADG8ggHNMxRJ8o55jipCPM/xOnHZ7HnXKMYZHgg4Ij+QPYL7VqStveR5k0LUZbyIvqZO
	TJNodU6esscyUaP86nRVttJJQnaM9+v41CUqZZKYKne6xpXaO3SHPmX0cR/C0pM93J03nUwJy6u
	LatN28s4S1K4JDK7NAHbpnA+bWZ6Jx5r3pbWOjiwpiIZbU2pkZ6oevvsA7jBgmvplO0cJwja22c
	/umkh9dv7tShaFDsGamCFY3Rz3w6KC/n28i0ICYUFD47icVm34YNmAafXZOIoerAzhgrLwVnCKK
	OZNhPy8v4wdoMK7SocElvHwOOQ0m/UUFWsytyz/0+96WO0s99vd6eMv+400nna7nA0EKYJhOYio
	ZHlhfbsx5MIme9aipRxuGf0Lw+8oYAC+CgtlsxHnXpTncEw4UEKQM5gAEiPC38FZh9p7rwx86dm
	xkyFXD3dlAXJ4fwq2/lqjFWUAjZu+Lg/O+7VhPON/6c8G5OgSXRRu3Nivg+y76sjrdL2eaeI21d
	C
X-Received: by 2002:a05:6214:5f10:b0:91b:8296:3b88 with SMTP id 6a1803df08f44-91ca4ae90b0mr5824286d6.15.1793313051262;
        Thu, 29 Oct 2026 15:30:51 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca68e5f47sm398016d6.42.2026.10.29.15.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:30:50 -0700 (PDT)
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
Subject: Re: [PATCH v2 14/47] mm/huge_memory: fix zapping migration entries
 for device-private THPs
From: "Gregory Price (Meta)" <gourry@gourry.net>
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
 linux-cxl@vger.kernel.org, Chris Mason <mason@kernel.org>, 
 stable@vger.kernel.org
In-Reply-To: <20261029-fixes_core-v2-14-a64ce7f83abb@kernel.org>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
 <20261029-fixes_core-v2-14-a64ce7f83abb@kernel.org>
Date: Thu, 29 Oct 2026 18:30:48 -0400
Message-Id: <179331304801.2127828.6570375349219520262.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-29 21:33 +0100, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> A PMD migration entry can refer to a device-private folio.
> zap_huge_pmd_folio() checks the folio type instead of the entry type,
> so it treats such a migration entry as a device-private entry.
> 
> Installing the migration entry already removed the reverse mapping and
> dropped the mapping reference. Zapping it must not repeat those
> operations. Concurrent MADV_DONTNEED during migration back to system
> memory can trigger this.
> 
> Check the PMD entry type using pmd_is_device_private_entry().
> 
> Fix generated by an LLM and sent by Chris Mason in private.
> 
> Fixes: 368076f52ebe ("mm/huge_memory: add device-private THP support to PMD operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: simplify description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

One note below, but it's not a holdup.

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

> +	const bool is_device_private = !is_present && pmd_is_device_private_entry(pmdval);

pmd_is_device_private_entry() already returns false for a present
pmdval - so !is_present is redundant.  If there was a reason to open
code this, then keep it, but otherwise you could drop it.

-- 
~Gregory

