Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E7137188A
	for <linux-arch@vger.kernel.org>; Mon, 14 Sep 2026 23:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427841; cv=pass; b=OYJ5xlvN7c8Ps+y0MWh8HXCI7fZgepn9eaAATCMm+DcLdjDsjO7uem2c7ibaw6sjSC84dk8dF/lcTMyT6cizUg2dr7iL5BLeby1UMgZ09Cz3S0DHyUL0feIsHNRJE1go19kwOzFoAQCLtSU4NFq/e7GP4e4dWopZ597gm8fuHvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427841; c=relaxed/simple;
	bh=RZ7AYDpwif8OjK59BGFRZwWIVN2HIHDHT/0jIXTGwRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g6T0DkVXrk0lzX0kTIHKbDl60qQfodk0UCbmou7jL4b/mWYxi51lwKFP1BIZqZ3mYRjj8vqHph4QDB9jth8c54NlwYmFMecnIy6lN9mryQTyPszlNsSLGzzGhcT8uEUKBsKtpqzdrSvdZuVNA9Ltd6oN8yKfnO0qRxY4xCq83wM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=TDdrvu7I; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="TDdrvu7I"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-66fca0709caso3747883d50.1
        for <linux-arch@vger.kernel.org>; Mon, 14 Sep 2026 16:17:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789427839; cv=none;
        d=google.com; s=arc-20260327;
        b=sundfzb27Q4W1Y+QdfGBElqOVZGcgFFi7POqA/E9kSW9E5MOQakzNMIkTf5R2SNQ+y
         4knS/oVAgyXSJsQizUHDw5tuB9fQCKLWPzYyUlRfKiMEtiUJzoLb6WgwV2I3f1adVlA7
         sW3FuDnZOoF0WsWSZ4sXFoLP7I8e2joYlbH1DIJH6e1nO1nAdnWQaBhKAphLK3LPlKGp
         bBupSLIzrv1KPy9vL5BuuB9Iu+bRi36BMR8lc17zO3v4b1DvMdco1GXTw8T+nTbbmA5U
         TaYh1Epgalm2C+XrB+C8yFU0UOqxuZIS5m7M68HfANj0A8aYaRfA0Rvd79gJZOCuP144
         DocA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rPKM73fBOFsSjy59aqqxc7UWTKxXfj0ZC9NrA+w1XGc=;
        fh=MjmPCjkWarzj3nHROeE4rr9Wr/LQvUtVzeteFpNar+E=;
        b=LTwEUSmrPJSHEAdNmV1n91XziCow6WXDtV+uYI4m1WfMmbFzdg3H0E5zK1QpU8JIcz
         vpgKXjBLdsxlL33P8PH+eWjunN9caVaCAAYCzmIpAauEaB6lJgsFD4Ozz2VQOd8VUNac
         olMNrFaviDLj6QF2HF2wM+032SAnwjYmOtQfRiKBcOWgbns/eYRUT05r5vOVvUn4GApK
         EgJON0xHUi3JOtbTS90rqo5WmVR6eFMhYv1JvOoI87E0EeHlGxaVpABQe535klnR+EqS
         IixnBWOfp1kCEagIFIizE+18K9PfzpMLnX4k2p7S+ORX/HgsqhUTUH0ZFLsvopEY2iVJ
         HktA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1789427839; x=1790032639; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rPKM73fBOFsSjy59aqqxc7UWTKxXfj0ZC9NrA+w1XGc=;
        b=TDdrvu7I6xP8ue4aZyYuDD3Vy7IabwSB+obL2XSnOOLrOTUypnXSd150I+gvIvYP3E
         w4TaoWi+oRpM6yNgCHg6I9t8gJ+gxn6S8sVzfNsP+eeNOp0U9RhQAk/iVBGCWp+fSXjv
         bNPF7H39nPGiQzvliPngqj/xyIZ1vYexLvrMre+4FEfg/2RsNZpxpI/WE8g5xQC5hGNR
         kRWHnFqakCCJgIbw+VeA7AjjrVpNHgxM+K1nUYdM4pte+MySOOS9HJbn+8HvhyxQQGFr
         VvwVCuQjiKWhx5WHGNENNjYZztKDWS7ScFTLWuWTaUc1KE/Ix7mcpo1oLVgviwiq4uUR
         lG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789427839; x=1790032639;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rPKM73fBOFsSjy59aqqxc7UWTKxXfj0ZC9NrA+w1XGc=;
        b=H7E0vSCKrU3FLaVIO0YJ1QT4HFyBSlpYlOqQblePpcUOhIKCqDT0B0pVI4L9QHNUDS
         89LEOJSaNbZCopvfWdfoHCLyn2xD3aZACmEDA9wj24Crb0BCcWVal2EOqHZItmhov5HN
         oKHEpfrqZdmqHkoEELO+m+qZR008Uy0/dLVakKWWUBU5/lN8O7uZxxuWrAlJnXrW3/U2
         6sPYtjJRrKz6YLlpAZEO+u3tRMfjCnwIcMZ0n2gT4yyBjrDqPYZUmfqXJhBFCakyDsqt
         nz9qvRVmB5VuLWFFTLsu6ecm6VFZme/hbxBrIfI8gUUkPKI0vkCdN99sFfUJq6xqDllf
         44jQ==
X-Forwarded-Encrypted: i=1; AKwUvBw1B9BPbXLfcmuXuL6I6MzDjppOW9pKknKg/3/sv7CabCsLcJkjPQNKw9X88Qjn17PN3Oo5Eh+Yj8hu@vger.kernel.org
X-Gm-Message-State: AFuF++nXT18TVa1oziQH/OarEh4wqSPh9ltDfo7mRwOHjymfs8Ozcry6
	y6mEHWglYQS01k6p571s63kgdOm/duauv4fOTC9P9GCbQJrN4cUKN8ylk4w6MPrWM/H3HVQ1Vp1
	N57H2Ib6QxkHRN9uYN8Czpg4d++1BzZ7gT+/wkYWfNw==
X-Gm-Gg: AYBFou3o+aVws+igLKS8+Ib4uMMnPW1CNajgXxgGZJf9cBX1qi3K2KcX1oq6vzfBfVT
	WznIRhtLYzCef1pROQXxyqy6pPqz9qGS7l7co4DXFF2rQqF33v+i/aD9FOY2/no0q5zVZ9B6FuS
	AhYGfdkTIsOJ/d3jDnJ9PuZca07orlw0Gc1BTiXHNOpktvauEQRspXMnyVfusoHsUEUaAx/NDsh
	HFQGREMD3iOa9n2SScUGPh4jY1pmc9doU4f4utXzs5qgHCS5DhI3+BXWkwK2NcNOaF5S4+VmYzb
	a95FdmuDIK//vDN9jmQ6MpQJTWBXtl8FXYxzsEpluo25ILkTn+dBfg4=
X-Received: by 2002:a05:690e:d0a:b0:671:2382:d57b with SMTP id
 956f58d0204a3-6714e00a7efmr1347187d50.44.1789427834988; Mon, 14 Sep 2026
 16:17:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org>
 <20260914-b4-mmap-prepare-vma-flag-sanify-v2-14-7d9781ed5361@kernel.org>
In-Reply-To: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-14-7d9781ed5361@kernel.org>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Mon, 14 Sep 2026 23:17:04 +0000
X-Gm-Features: AcwNN1UnQs5y9ap_T4Dsaa6llmYZN4_govFYy7UyV78s5E1rt3VhMagl8qfkC_o
Message-ID: <CABFh=a7Sa0zMKssts1TVZ+u_x3roWcYVSmJF34K-W++oHEsbEA@mail.gmail.com>
Subject: Re: [PATCH v2 14/40] bpf: arena: mark arena_map_mmap() mappings VM_MIXEDMAP
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Paul Moore <paul@paul-moore.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Doug Gilbert <dgilbert@interlog.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Peter Xu <peterx@redhat.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <pjw@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-arch@vger.kernel.org, 
	kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 3:21=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> The bpf_map->ops->map_mmap callback invoked by bpf_map_mmap() can be set =
to
> one of ringbuf_map_mmap_kern(), ringbuf_map_mmap_user(), array_map_mmap()
> or arena_map_mmap().
>
> It is convention in mm to mark mappings whose pages the kernel manages
> itself with VM_MIXEDMAP, so the core mm knows not to treat them as ordina=
ry
> page cache or anonymous memory.
>
> The map_mmap callbacks ringbuf_map_mmap_kern() and ringbuf_map_mmap_user(=
)
> use remap_vmalloc_range(), which ultimately invokes vm_insert_page() and =
so
> marks the ranges VM_MIXEDMAP, and array_map_mmap() sets VM_MIXEDMAP
> explicitly.
>
> However, the exception to this is arena_map_mmap(), which doesn't set the
> flag.
>
> This patch corrects this and updates the comment to reflect it.
>
> The pages are refcounted and vm_normal_page() finds them regardless of th=
e
> flag, and VM_DONTEXPAND remains set (marking the memory as VM_SPECIAL and
> thus unmergeable). The one effect is that NUMA balancing now skips these
> VMAs, as it already does for the other bpf map mappings, which is the
> reason array_map_mmap() gives for setting the flag.
>
> The intent of this patch is to be able to establish the invariant that on=
ly
> PFN-mapped or mixed map ranges may clear the VM_MAYWRITE flag, as is done
> in bpf_map_mmap().
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Dropped some CC's as Gmail is refusing to retain them in the response.

>  kernel/bpf/arena.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 7b6847200b43..b69fe5e34339 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -620,8 +620,9 @@ static int arena_map_mmap(struct bpf_map *map, struct=
 vm_area_struct *vma)
>          * clears VM_MAYEXEC. Set VM_DONTEXPAND to avoid potential change
>          * of user_vm_start. Set VM_DONTCOPY to prevent arena VMA from
>          * being copied into the child process on fork.
> +        * This is a kernel page so set VM_MIXEDMAP.
>          */
> -       vm_flags_set(vma, VM_DONTEXPAND | VM_DONTCOPY);
> +       vm_flags_set(vma, VM_MIXEDMAP | VM_DONTEXPAND | VM_DONTCOPY);
>         vma->vm_ops =3D &arena_vm_ops;
>         return 0;
>  }
>
> --
> 2.55.0
>
>
