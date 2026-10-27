Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793096590;
	b=ndgSL5lAdYTyL7ymrQMlYR8UdGh4HQm9QyilYXcjeqG7KR2jzoT9aFQhZLY/T2w43oQM
	 X3yZ6f6RBuYDaDsWdGIZZP1pDmSv70OEGzF9ylfnkJFJ6aAotE67Gh1Xb14hOuu9lZErx
	 khsrqpBBhUTbpAprAKVu2pObAElXHzcIp5Z84VZf717JEevaXERuL1JA9YnZI6xHDzhZx
	 BaqmO4h3c1p3d+fD+/Zy7WWSlKUcS7SxA8Gn/YxdYyAl8mi37rLtmhaAVo8cPnNIITy37
	 /4PDGgrO1Uhjpi6bHAH2MTVHwbFW0DsyEPGh+s42YkSoU6R7GX5rtrpxed25Gjs3rGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793096590;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=HuWBfUhRw2eXbrJVRrdIsgOVF/qwEOWqwz0sZ/JDeUA=;
	b=QYgyJZOdWbWb8DNI6a8oxzgNAcv6cawDQRDB33hPXee78CcBjZgWkBA20BxPGhAZVX0M
	 WH7vQY25quzXpyFUJvmBiT225pB9a5uGg6SplbrAhAoZAOxai4fj+mocJLy/4dfhftPU9
	 iWWjc7LdZhIKmy2MLrbKl/jiw4LSLquoWiOoF6CHN/jTsJZZSmrW/6ITlpCS0Elx7rTsG
	 0ih8l7xXyJXfULicAhJ15dPyfxwgkC/V/YgsSQarNJoDuvyI9qP2AYF9yGlKAEOWUglgo
	 O3dgiYxGmwZv6wgF/2SqTg/sM+xTHJnmAhEYURYKt2F/aRU57OOXjjBMREBvvwzW/PA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rlxPCoS9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C72606A31B
	for <linux-arch@vger.kernel.org>; Tue, 27 Oct 2026 10:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7C72606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rlxPCoS9
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c49b431f022so28319766b.1
        for <linux-arch@vger.kernel.org>; Tue, 27 Oct 2026 03:23:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793096588; cv=none;
        d=google.com; s=arc-20260327;
        b=lqppP/0bOFwUDw7F2vY5bi8PrqrDTeWccde4gcLOns6oITcigwE8+Lrf/j+tTIBHWc
         HJVSbGfifOxT98hYKnbi9GAgspFsO+cEjWdDFcIb0cxJgC9fRphVsPT0DNUt+JeYHuq7
         bOAZXP9L71AhSWCPRNjXLX/SvVS8YEuhJWvZeb3YVjA5ySA/MsxwHlhdvDULLKv2GiVI
         Kjqr+XU3GxPoFhhWpQ5r2xLNgVPxbvAF77CTe9nwCbkwxb0o5pb4UFk93IqITD+/ojvQ
         oQyjZMnYveMntOIMSfU/ZOHRLeyb2VMfB2QI/VPWj9vjVj8LtQN+m6s0q9IneD38Vf2V
         KQkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HuWBfUhRw2eXbrJVRrdIsgOVF/qwEOWqwz0sZ/JDeUA=;
        fh=p4VViEP8VUOZTY07SuSoMDI6q9yj7GeR+dzC1Bob5No=;
        b=i8NE1l2pOInbbHj7jI0DKIsJLtXnOlk7f6GwI19kSN4Y4fKBkGwv3o1hb690vjdQs8
         okitNEYRnFNDvgxTVZKZDFN8F2AR0VghfBQDFqMaKhf2GKstdlc5ZHY8oR1PAXfZ4hGd
         W0BhttQLKwSoDZ1kmTZyqyF4Mg+eVPCkX1Ju2T5rQdG8y36wCd+djnn2O79UDk8XJ/uw
         6RXY0HI5aVQJ9wYmyLSQMpba59TIm0qm3XWRSeBCqdv2yh8V28V2/XRqm8ZCCmDE0fHO
         CEHg6fodKL90kkcrWhqRNG9rojy5LsjANDLwmKC77rfKhouD1LeqHoJCtZz66FmFMXQB
         8FBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793096588; x=1793701388; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HuWBfUhRw2eXbrJVRrdIsgOVF/qwEOWqwz0sZ/JDeUA=;
        b=rlxPCoS9TacJB5sbR4/DuCvg1gHofa48v4RHRIbBlyZQUhw6r7bL6zg7MUtgoZBxKQ
         lt+YYPbrvQtc79S9rfvuPcGOb7C0BZY3qgF3U0I/tVnJgBGJx6xt/DMQpY30uai4QsoX
         P5Z/pcj6R7IGmpyEZjIkQ8RE3etZC17RDFgvcM6Y+9bhDyYYZoMMp/cQ3dx0FSoFEG3E
         yCnpC60BmhPOCYYuljKb2FIw3gC9JotwIBxNU1pFqurxlv0c49doWeUpfGKBEj/1fv6d
         Iu3zIa2GIe2Vu2FDkwEINlHF1PCgOTqXmfejtN27WWbwQvMYwFzZDiaJKRXsAeQtFbxn
         7XPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793096588; x=1793701388;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HuWBfUhRw2eXbrJVRrdIsgOVF/qwEOWqwz0sZ/JDeUA=;
        b=CZDnSwZsRsMtb7euRh8iFVFuMHNeCw3HXaYky7s7S06VqhPzp5OV7lXNyYRkP5dZRF
         6uqSaylwedt+J4+aerxwgCYN1/nmlXJcNixBVmwT1byOCicFe++0BwQU6CIw5cKaPHE5
         1BlnmDGp/NIRzHcIEGCkz2ZwQPxz+QqC0ILmADp89MkvXAYq12mrrE4Retfwl8QvSE06
         DWNUQHDWv8dCGcvTqiQMM99jy0SCWcF8VwFhlz1pZ/sxSOgg5Z2YnIBRirDUWlJqXf/4
         fpxN91O/3m9cFdp1pdL8OcrT3n/+1hZ+eJ9ciV6Ktm/AevMMx9v1haNx1hXbu3OHij+z
         SVrw==
X-Forwarded-Encrypted: i=1; AKwUvBzDON4vNqGYcOBh9AulLLoRYa6+XX3NXYDUG3ovl3lLCxa9k/FvXws8Cd1ghKS4my0cSVMSTj6PneJr@vger.kernel.org
X-Gm-Message-State: AFq9FYIV7K97LbpCCUem9UE7UezSpyDFz6kcqOvfZ4rMXKNyI82vmb67
	b23cGLfJvmqLbDJXWxg/BHZYPyBCFB5DLqAnITu7eVlat/iLKZmDhUUSG7om4I3Ly7LswcvVmDf
	z5uWnD89dat/PGFaAZ0zIYATkuy07bVQ=
X-Gm-Gg: AYBFou0rmBBKMWgdj/W1vuYPkaK2L/hmtKUPHCOB6KzLBKW4CX/+d1MsUU/GoiYI3eq
	y1yJFg+9HNBsIqUXLuqZbeI2kSUZY80HocPuQC1jwA9eWGuWzs/ilMyhrCBHS7imWh6TR/hk3l+
	sxGBUb+Jn8hf/f5bcmi/rV0Oq7RrKEA4mijdRkKnq77f6FbOOWyr8CMeHe25oHVZ9Zwrihs4SKu
	DeaY5eGFFdd33tsca9vKPeLPlhMYB+2u7fs7ZFAWvrSj0g9s+KGDohUYvfdSrIZtTGGKEaqMvQl
	xXQIs9TvUCM/FG3+fy29GFI5NRppK9U1F3xgz1maDYTB7doFcF3V3Fx8L7qctRh32N8NjJl5NQy
	9cF/IYLiVwjWwz30GWL3g7i3YR2S5LBR4eNcK7ELosdnPvwdaOkGLoNTkMVRCZ9wSTCQbhg==
X-Received: by 2002:a17:907:86a3:b0:c31:5bb8:4b3b with SMTP id
 a640c23a62f3a-c46bdaf85e3mr1028439166b.2.1793096587718; Tue, 27 Oct 2026
 03:23:07 -0700 (PDT)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org> <20261027-fixes_core-v1-1-6f74bec9a5bb@kernel.org>
In-Reply-To: <20261027-fixes_core-v1-1-6f74bec9a5bb@kernel.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 27 Oct 2026 18:22:29 +0800
X-Gm-Features: AclHuK-sc-Sst_xgCP0rWexz2ICrmdMlmxE50eDjh8zWXXtcyxqz8s5Avp5yS-o
Message-ID: <CAMgjq7CgeA5OYUuXAQF-PQ_LkmsLw2V3VzRwPUdMYTcGCmYCbA@mail.gmail.com>
Subject: Re: [PATCH 01/46] mm/mglru: don't use stack pointers when walking PUD
 and PMD tables
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Lance Yang <lance.yang@linux.dev>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 7:18=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> From: Josef Bacik <josef@toxicpanda.com>
>
> MGLRU passes stack copies of page-table entries in walk_pud_range() and
> walk_pmd_range() when walking to the next level. These copies can become
> stale when khugepaged or MADV_DONTNEED (CONFIG_PT_RECLAIM) removes a PTE
> table concurrently.
>
> This pattern dates back to commit bd74fdaea146 ("mm: multi-gen LRU:
> support page table walks"). Likely, earlier locking masked the latent
> bug. Later changes exposed it: commit 1d65b771bc08 ("mm/khugepaged:
> retract_page_tables() without mmap or vma lock") allowed concurrent
> retraction, and commit cf4a65539c13 ("memcg-v1: no need for memcg locking
> for MGLRU") dropped the walker's outer RCU protection.
>
> The fix is simple, so just fix the original commit so we don't have to
> speculate. To fix it, pass the actual PMD/PUD pointers. This restores the
> RCU-protected lookup and validation against the live PMD. Note that the P=
UD
> handling is required as well to handle folded page tables correctly in al=
l
> cases.
>
> Fix generated by an LLM and sent by Josef Bacik in private.
>
> Fixes: bd74fdaea146 ("mm: multi-gen LRU: support page table walks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: handle walk_pud_range() as well, clarify+simplify description,
>          adjust Fixes: ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/vmscan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Kairui Song <kasong@tencent.com>
