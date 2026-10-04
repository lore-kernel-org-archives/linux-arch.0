Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482CD480DFC
	for <linux-arch@vger.kernel.org>; Sun,  4 Oct 2026 18:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791138265; cv=pass; b=ZAbHuv6ChCkmOvNHMv8Ob4Vas7ZOPlxdromc4/GEuJNNVL7id/IuNUKjBfsBYEiIa0+J6oTmimPa3/9E75JgGeNfPKvZzThfUzV2CKYwZG1qIgQiUUKelbW4b6on+ligt/fVgXa5sRRSGf7myg6K4k+R7tDTWObmiAjNs/qc6nE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791138265; c=relaxed/simple;
	bh=3aBRZG0J7nrNd8eWZI+tOUTLRCjKVPsGyHM+wAKTgfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZGJt29VtRu3+IbZjx1g+Hi+h+4eAwv2uGhoiPYYLNNl1q6ZWhMJbYx9LNqpwE4JUTUvGh8Qz9xV5ji13lbR4bQ2FsY/4MM6T4sGqkq5y+xJK5yyY061xxEFEb3CAd0Y61NjlAM+d7WjITAZl5xf+cek4oUxOLXtfsdX9ktpKzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f8vk+6UF; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f8vk+6UF"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso5490a12.1
        for <linux-arch@vger.kernel.org>; Sun, 04 Oct 2026 11:24:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791138260; cv=none;
        d=google.com; s=arc-20260327;
        b=QWPRDQuXSjN/XQIL+z4WNlbGB0RerSlHW8pWWv4vlwF2cMy8e+llbljgEM1rsLbBcJ
         cOluL/v+AWlfKpCcimvojKXigaLO+I7FDzRxozHeyVpm8X6wtC2LYVpa4Ifl/yf5IVjn
         vkbaNHdN3dHPcrBj5vo+pzqLPU18dD7SYuehHLvGmcrDbx2CZe1818MFtx7J1bz/WRvn
         JFcx0AKmsrdNLytue2VR3qQ19od5RjkI9/Am9RDOQkTMu0WouEnBYKfj96LpXYBnchq3
         lDdf/9NJixnsS6evaL1XzcumDe+e82gdNpHWR7Bd/KkR0sg83f1G74yvzzw6N12pOO/7
         Z8qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=COuPsBcUBk1eT8Q71dO8QdpqB3ZPgP0C77xCCCNJQiA=;
        fh=95LEd4029REAEfSOFLsEEB7kLtD2FXPzYmeSg9ODw7A=;
        b=P2vDDMx1Sz492g8QJYyZTQRkbtilSjD7qgYYIFJns9mMwWRahfUJ9IMvrqRj7bcF4h
         uXvZDcuIDbdNd58WEkBZ26Q8Xamzhf9/roW+ctkePruAwW+gbNZOTM55q9ULXp+7TxYN
         rglZt1UCjDSL8AtQY2+HrkYlYoz1svTjqSfyKsGg1qMN2o4Pm1n6DZXN6eYNUO/LcUCc
         KeKqeff/fdtEahzp9TzXsK+flrRSek3Lu2S3V1fr/zGQS9ol0XwwGWeSwYjMeDt5xR3r
         s2qR3aypG8uzhSHjAN6kotrhz168cerpQ/Pd3QUq6S7Wc+tNbzadc20fT9fkTRBqp7hA
         JRNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791138260; x=1791743060; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=COuPsBcUBk1eT8Q71dO8QdpqB3ZPgP0C77xCCCNJQiA=;
        b=f8vk+6UFWZB9hoCvStnFL044+6aRT6xa5kAVBI9KkzKS7tGKQiXqW/AGoPYjSNmpfV
         5V3att+4ZDHkm96mXkBBSDYm5zWIFpFJiQaCEfS2PL2ujDeWJw6EpyGCPiuHOKpFXRPb
         Iurm+B2ECPgliexc3YIHy3Q02ZY8qxdRaOHTKxr+txvSie6zOeAqHIOx20yT212hGHNZ
         8utbadwdgS+CLQNTLwD3KgZM6udmJEuCzk/IeUiu9nSTi6gLPJsUTIlzpfsm8DDXCVUC
         fO7ppbKh9USxfk3Qu3KoZ2jgZFDjXTule4hZXiSgHMu9EwKm6oJG35ATUrk0WK8+xyVi
         CrSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791138260; x=1791743060;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=COuPsBcUBk1eT8Q71dO8QdpqB3ZPgP0C77xCCCNJQiA=;
        b=BwLDDnTdmE96tXb1KPUm/4Odk4+mvG/umdS3IKhcP8Q/JY4PUS5hahkgjna8UvWo3T
         UfhOq9MguBYBrwQ3GKtuVSQRDiZTJyStYZFWxocpHaAMDv9e9fc/5bi199o+tx+4khHv
         ygzfOafAXlRXa/Uc8YbBrsSj6QLwMJzSFhYuYTFPTV9v6ivMC5ik4V4QBkqIQs6MQbh+
         jOoVffFkM2rDEUBIAX7KSXW4f0lhl97QBT1/bO5JOoQAmKbEFLxpjiqFxbVWmssR4Wpg
         UqMouykUeN/ckskS5WAGiYB3QcxVguWnEbTonrsyud1aaOwUKc1/V7FB4vkdQC2Zd9w2
         mExw==
X-Forwarded-Encrypted: i=1; AKwUvBzq82DGRCDSd/jei9WTP4dZQsc62zS9+b+Tn1hFq+Ep+JvNLkL+cmUxSB41ZtG4koN4BWrdk/8lzM92@vger.kernel.org
X-Gm-Message-State: AFq9FYJtKU1t/ly2YbzDcSN8kFUrtbVArsEgcVAqnqjEZifCNagvDztg
	EvBqpidRerEcO/RAEvoQC82uKoz4Npow7jhCbERFXnOWQl/SRqSa4p6VlxV0Kb8626nWDiNQ6DH
	kPeKtZTMe0TkmBXgn23ZSc2NOJT0nWFoamB2t3ICX
X-Gm-Gg: AYBFou1PVzkITbIFF3iSe6HuCpcESimw1N6dyd+oXwOpNKuPlW3DmQfo8eHCa+5RG19
	wstpWbMGgYwMDec7t2yitZ7Tu41pPawXfjgaVtzSo7l6eug3idWQPGl2nyurq2gQTq0z0r8CHAq
	cJd0QXqbEaPLU1r+QniW7YHdy9VjSD8f4WOrKPEJAvPUqMPWxHIWD6kmzZnjfciz+qDZN9jziYL
	Axzi8WaRrAfQuZeMnJ22O+q/Kuf+fbVWf+VMdEEMhI4ez98Bhwg+PsY0Cl5MBVAdT0y/MlfuA+R
	lDXCG6sMGSkcwtq+DYpC3pcuIR1bVun439hOMiHHUHd+6lFVgnojVxKo3BOLr+Shtaw=
X-Received: by 2002:a05:6402:a2cb:10b0:6af:7a5a:97e4 with SMTP id
 4fb4d7f45d1cf-6afaf6bf03amr34523a12.12.1791138257648; Sun, 04 Oct 2026
 11:24:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-20-a1f052500fd7@kernel.org>
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-20-a1f052500fd7@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 4 Oct 2026 11:24:03 -0700
X-Gm-Features: AclHuK9H1gPgFkK4n-5s4Gd8NQjwfuvbGlNRYoPrM6gC5ICSAC1H3Sf5qTdT1bA
Message-ID: <CAJuCfpHOo8UhAZMvO5A3dKbqxQGAWtKGMHXJ+Fc=qwH=Nm0b6w@mail.gmail.com>
Subject: Re: [PATCH v4 20/38] mm/gup: error out early on !VMA_MAYREAD_BIT VMAs
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

On Sat, Oct 3, 2026 at 6:40=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> When populating a VMA range via the aptly named populate_vma_page_range()
> an unreadable VMA will always eventually fail with -EFAULT.
>
> That a VMA is accessible is always checked, however VMA_MAYREAD_BIT is no=
t.
>
> All user mappings always have VMA_MAYREAD_BIT set, so this check only
> impacts kernel mappings.
>
> It is implemented specifically to disallow population of uprobes XOL
> mappings which are exec-only.
>
> A nasty interaction with these mappings may occur if they are mlocked, so
> actively disallow this early.
>
> This allows a subsequent commit to remove the VM_IO check in
> __mm_populate() which otherwise requires non-MMIO mappings to be wrongly
> flagged simply as a workaround.
>
> Acked-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>


> ---
>  mm/gup.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/mm/gup.c b/mm/gup.c
> index c2dfcb4744bc..e6310a7cc05b 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1836,6 +1836,10 @@ long populate_vma_page_range(struct vm_area_struct=
 *vma,
>         if (!vma_is_accessible(vma))
>                 return -EFAULT;
>
> +       /* Unreadable VMAs also cannot be faulted in. */
> +       if (!vma_test(vma, VMA_MAYREAD_BIT))
> +               return -EFAULT;
> +
>         gup_flags =3D FOLL_TOUCH;
>         /*
>          * We want to touch writable mappings with a write fault in order
>
> --
> 2.55.0
>
