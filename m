Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6550746D542
	for <linux-arch@vger.kernel.org>; Sun,  4 Oct 2026 17:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791134057; cv=pass; b=F+NeTM3ABDa0FoxaYo8QKpn0aFK/Y9m1NByIOPDZn5xKIWcPxXs65j9tasBRolpz5TMBdF/3Ztt95xbEj71BWZZtkKL8dJh8lugEtDdo4wRY0aLkf2J6FdBY8akYtaI1hYw069MtNlwMHOBpCACBbRHGiAxoDYeYMUM+HUJMhKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791134057; c=relaxed/simple;
	bh=DPQmWisOarX73EV4DX8xr1LZtE2t1IZvvp+wtV1goOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g0Dx+9A7yqTtStFsTogYZE9qR4VrAnnzdD61SV6w2/z2+oHfUgvUglL/qBB+hPwcPXK04/yi138bFqVzs+MXcbB4nqQjYNX0i+dOetGKllX4D0GLUPLxX6Rl91+gFZVHPlFpK20XfbsTHLsTLnj5UkzSRcIozHrZ/59us+QYgcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=REEY2iHg; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="REEY2iHg"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5337fa12431so180311cf.1
        for <linux-arch@vger.kernel.org>; Sun, 04 Oct 2026 10:14:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791134052; cv=none;
        d=google.com; s=arc-20260327;
        b=lDE3AP7sRheW27dtlLWcrIZA2myBrYtMdL2CaaonRdGcoCa+yrkMVJB7m9/nZyLXfW
         YcjldWSWH95L6I1h8rNRcfcvh/fhwNfsQEkFikvT9PmFOmeRNaI0aSA529oH7yoQK6yR
         udV7xIa8Zl2w/d1948UN1wEoO23zPDz+zCO2fUwikmPzEZf+kb1c9mQAQUcBjL+hhkif
         da8iyJyQOwvpj804y2VicD/VJfYl02+blguyA6VvzOodcYZghcp/PtdPPjkgdWlL3eNg
         GpmUWY7DZzOVzYuYELU0bs6gUVvOo/GkbYPciE5VjfYZ2EpvPfl2+OqZaQYm9z3T6uVY
         Y3ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oK+gurncHWXSmmPtPu9hgAMG8GgRdX+XUQo4lUX1RzQ=;
        fh=ehX/CVLVhknzKGijsLJdK2PeWaxaPP+dHxDNg0kO7es=;
        b=TnrXL1DSLEfgCa6Dlrqmfja4dzt2g/SvGz2fmVAp9NQXMHwdu2eJRtokjh0/32wPuS
         F/o74Xj+jLJbqpQAJfmCiXaT5wvyquxN4l5NYO8qMokHXf+yfajPRVI0C1m9/XbkBOYj
         HFtPkHe064ecisCcFhxy5mmmj/AZPezSAIPFIUCrNNIWfQjz2Y+9xTKUrErIb8C6xNBE
         CgkTD7x6ExbQ0Yjao8yCax3rPk1AwDTZSNDAMyXxIgCh2fHyD/pLiCzc0/yzWHnHyJ9M
         Q4yvZWqkLP71Zb1npF5wcCTZxGf4QUE+CJCwWml1wKyLvzIEA5u9sZm+zKmUqURJZIac
         ursA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791134052; x=1791738852; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oK+gurncHWXSmmPtPu9hgAMG8GgRdX+XUQo4lUX1RzQ=;
        b=REEY2iHgfq6E0c1XockpGWl3W3wH2KST318DQMwK5qYcmw7fv6zTzsBNLP0SfzqttE
         zGVzJwdIyMq4DIWYsuT1fECedxQWfZywmAvtKi31yxrTUfaK9+USTJUnHo283zeBHgQI
         7POwPekxnno2CBjGY2lXxzz0UdJv9NtHV/9FEa2hADjGFGzmDql7kwcAguem0E4ER9e6
         ofdDJu6KgdpFCDpQbtDlz/Ps6SIljYl0NSBCIL+1/OtdD0zmtVLrVH9LRjyBCZ+JycNl
         PSqZVkeuBPR+aoxg87cyHwj7lIlYbL/1Ln+qAiNgqr2nZ29LsXB5VW4sfIrvr3n4YCUE
         BIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791134052; x=1791738852;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oK+gurncHWXSmmPtPu9hgAMG8GgRdX+XUQo4lUX1RzQ=;
        b=g49hjj9qzun0ginQg72Pq2SHT+rxSPDlVeDBOR6guqpLzYt2fnj9HldLyiVZQx+hi4
         WiWTZ3FFxE33DiIbCcGizoxfZsOTXwOTDTAd6tEYd699XjaDwhLpfhPfE0ejPa6pbt5m
         iIAtjziPQaJqdJ+VomTGqk2b0j9/6dgTQjtMdvV2U2IbZy9Y2yDrh49wsp0qa3wVbCET
         FiUPBh7V0mnjcmHPDxb76hTXLU9eWkqdLlAOZU8rhdFMfb/upO/Pqx7JVLM03IfQ6UET
         8O3v/hr3A6FYjG6DqKJoq0k3V6qsfvBqytBOPpi88u3K510wFVveFiUlPaZuS0yEIDbh
         Fnvg==
X-Forwarded-Encrypted: i=1; AKwUvBzd7bDnYKqXY3E+XO5E4ViUtQp4p/267BDUqCHeCfwXFlxGQ/lQmsplIH4L93xrm7EXYprhXX2VGKpR@vger.kernel.org
X-Gm-Message-State: AFuF++kFQpweGvViKAsnFz51o85nX8qczjtIAdEsyOa68sJTGymHLAJN
	9mCyuBaVX1XxcNluznWdDS6JlOfTperwl+PC9ScRtbRuKgFzbMGYmUvc2eaxdVysWVfTOs6zE5X
	JrEbLvDaUDteCm2B8twCw+FewRO8a4N39Nrr/D7bN
X-Gm-Gg: AYBFou2/WOFih/uSjkWdmB4OozY5PnX4mzt7YtcFskfAnnNovY3b+UwJJWHmBjRhRjF
	NumZNqM+v2e/tZ7q20lcrAE9FsFrF4f/trsR4bMmgtfRX4EsJtykKrZmtWpIyjPZ8+WXyd5Lzy4
	bZuUjomYShWsBUZH6AQcYtZvvkwJ2JoTOX7Lo8/9o7VufU0tynFE5tcRcxOvtQOk1x8p8qDDPgN
	3vz2GFqmSkiumpzSe3+M3zANGY8Z3Y+YP8OhTrpd5A45Xa6fIbkjzSQcTSYnVSH+JYPeysFAELR
	34ia9iBx987nij+BsYgXWDZXAv6g2d9ZSGo2NJhy6Z4evqInX7Vy11/Q
X-Received: by 2002:ac8:574c:0:b0:531:475:4ce6 with SMTP id
 d75a77b69052e-535131b2b85mr16314281cf.9.1791134050552; Sun, 04 Oct 2026
 10:14:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-8-a1f052500fd7@kernel.org>
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-8-a1f052500fd7@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 4 Oct 2026 10:13:59 -0700
X-Gm-Features: AclHuK_YbQsPp6UkU1wteVM53NVi6nuDg9G6v9WzIHWTTGIprDqvC1DHCMGs6A8
Message-ID: <CAJuCfpHPcgvpR+=CtNVJeFkTn4EkF=hSPH3ZvvpkZQqHS5kzug@mail.gmail.com>
Subject: Re: [PATCH v4 08/38] docs: filesystems: update mmap_prepare docs for
 discontig kernel pgs
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Doug Gilbert <dgilbert@interlog.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>, 
	Sebastian Reichel <sre@kernel.org>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Xu Xin <xu.xin@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-rdma@vger.kernel.org, 
	selinux@vger.kernel.org, linux-sound@vger.kernel.org, bpf@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 3, 2026 at 6:35=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Describe the newly introduced discontiguous kernel page mapping mechanism=
,
> detailing how to use it sensibly and how the API looks.
>
> Explicitly detail the various discontiguous actions available and how to
> use them.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>


> ---
>  Documentation/filesystems/mmap_prepare.rst | 81 ++++++++++++++++++++++++=
++++++
>  1 file changed, 81 insertions(+)
>
> diff --git a/Documentation/filesystems/mmap_prepare.rst b/Documentation/f=
ilesystems/mmap_prepare.rst
> index 82c99c95ad85..ddb4434d919a 100644
> --- a/Documentation/filesystems/mmap_prepare.rst
> +++ b/Documentation/filesystems/mmap_prepare.rst
> @@ -164,5 +164,86 @@ pointer. These are:
>    sufficient entries in the page array to cover the entire range of the
>    described VMA.
>
> +* mmap_action_map_discontig_kernel_pages() - Maps a discontiguous range =
of
> +  `struct page` pointers over the VMA. They must span from the start of =
the VMA,
> +  but may terminate prior to the end (leaving the remainder unmapped).
> +
>  **NOTE:** The ``action`` field should never normally be manipulated dire=
ctly,
>  rather you ought to use one of these helpers.
> +
> +Discontiguous Actions
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Some actions can be performed across discontiguous ranges.
> +
> +Map kernel pages
> +----------------
> +
> +To map kernel pages discontiguously, you must provide hooks using ``stru=
ct
> +discontig_kernel_page_ops``:
> +
> +.. code-block:: C
> +
> +    struct discontig_kernel_page_ops {
> +        int (*init)(void *vm_private_data, void **private);
> +        int (*get)(struct discontig_kernel_page_state *state);
> +    };
> +
> +The ``init`` hook is optional and allows state to be established before =
the
> +operation starts, for instance taking a reference count. Nothing is invo=
ked
> +after the operation, so ``init`` must not leave locks held, and state th=
at must
> +be released once the mapping goes away should be released in
> +``vm_ops->close``.
> +
> +The ``init`` hook, if provided, is invoked prior to the operation starti=
ng. It
> +may update what is pointed to by ``vm_private_data`` and/or ``private``.=
 If an
> +error is returned, then the operation is aborted. The ``private`` field =
can be
> +reassigned.
> +
> +**NOTE:** The operation may sleep between invocations of ``get``, so loc=
ks
> +needed to stabilise state must be taken and released within each hook.
> +
> +The ``get`` handler is the key means through which the operation is
> +executed. The current state of the operation is provided through ``struc=
t
> +discontig_kernel_page_state``:
> +
> +.. code-block:: C
> +
> +    struct discontig_kernel_page_state {
> +        /* Map state. */
> +        unsigned long start;            /* Start address of VMA. */
> +        unsigned long end;              /* End address of VMA. */
> +        unsigned long addr;             /* The current address to be map=
ped. */
> +        pgoff_t pgoff;                  /* The current pgoff to be mappe=
d. */
> +        unsigned long nr_pages_mapped;  /* The number of pages mapped. *=
/
> +        unsigned long nr_pages_remain;  /* The number of pages remaining=
. */
> +
> +        /* User-defined state. */
> +        void *vm_private_data;          /* VMA private data. */
> +        void *private;                  /* Mapping private data. */
> +
> +        /* Users should not touch these, use discontig_kernel_map_*() he=
lpers. */
> +        ... internal fields ...
> +    };
> +
> +With ``private`` being an additional user-controllable state variable,
> +initialised via ``mmap_action_map_discontig_kernel_pages()``, and
> +``vm_private_data`` being equal to the ``desc->private_data`` field set =
in
> +the ``mmap_prepare()`` hook.
> +
> +In the ``get`` hook, the user must choose how to map kernel pages:
> +
> +* ``discontig_kernel_map_abort()`` - Call this to abort the operation, w=
hatever
> +  has been mapped so far will be retained, the rest of the mapping will =
SIGBUS
> +  if accessed.
> +* ``discontig_kernel_map_page()`` - Maps a single page, correctly handli=
ng
> +  compound pages (if the compound page is bigger than the remaining page=
s in the
> +  VMA, then only those pages that fit will be mapped). For a compound pa=
ge, the
> +  head page must be passed.
> +* ``discontig_kernel_map_page_range()`` - Map an array of pages of a spe=
cified
> +  size. As with a compound page, if more pages are specified than remain=
 in
> +  the VMA then only those that fit will be mapped.
> +
> +If an error arises after ``init`` succeeded, the core unmaps the VMA, in=
voking
> +``vm_ops->close`` if set, which is therefore the place to release any st=
ate
> +that ``init`` established.
>
> --
> 2.55.0
>
