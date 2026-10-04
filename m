Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF07F46C859
	for <linux-arch@vger.kernel.org>; Sun,  4 Oct 2026 17:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791134314; cv=pass; b=tKGVNtd4STy65fx+P8t3iU0XnisYMrzvqh/E7wVpQQI9NG7D2D2ZMKGX16CjE3w7Mg35II+CdJjFaAVdhprHX9+YtU1QLurqTN/bI0YViDj1WGkU7Iz2gtwCCqL/EDi/KbgPvbAvgrO845Rm2WaoZNdo0Hpx+jzXtfEI2hn+RTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791134314; c=relaxed/simple;
	bh=Og6qpLhWHly4IoZcNfYZyEY8s5xN9sYAkBks0QnUI28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qW4U7qPoXNT5pjpYv3SfkGZlTRHcStubXZSwD/p4h+8AlD1YcSzdy3FKMNBCfC+dPa58V736PuOgjw95HWHlEKM9dihHXEtL9f0NodRIoSMynmy7JyHQluhZREXweDQpk2zBLSde1+DrbIvMMkjRIkFm3WvKGaV7sifrIG+OZfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IeOZJMDE; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IeOZJMDE"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-533202fe429so245821cf.0
        for <linux-arch@vger.kernel.org>; Sun, 04 Oct 2026 10:18:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791134308; cv=none;
        d=google.com; s=arc-20260327;
        b=VJX+oZOUQBNJHSvwJJ+0a1ZjIK/hNSQYoEE2B8te/Kr91R4HEz0wmy0noJOERyitYW
         3FCUhyjk43bFr5U6G7BPOKql2p9BNi8YqmqZAVXI78uPrGxGpQA8R67Otdd0Vr7ThdZE
         mgPv3aqUjtTgnM9hxyjUeM04OyBJod8ls+3cElbjxGvXsQ4o8ZkpUcVs11FDqkIgPR9v
         YIohIEULqNRE3pqJGCt6LQlDp4v9OWbAeYZEhS+ulRSadnReWuqOdSbwjqN7zKIpW/e6
         ApszyEzKmDW06kCJVMNoPPvtdIapqh5sJIWqTloOugMLMOGpzdtBHciAcl8o3j2aOZgE
         aYtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QinBTGgc4+2Xq3VgxIpbr+CWC5UMzdARKszuxAv87KA=;
        fh=k9hHlSZgfOoZZ8ag/oQsbPdvgD7aphtNupHqFQyKRlw=;
        b=WG29lHN5RWh/UWDKRBcz8skA8kyum0Ug6NN6Af5ECjdwad+it5lSvFyBe3XMjX1ZvX
         lwR1SvDtyAWfn3l6r7s3tYSgyBOVF+GXA5E9H6hq2fw8ETUpRf/eS9ENwNKHMFgWOW9x
         CSeiTDYNDl2q11pkf2jy5Q15/qNy2Hm9naDLY9eVuyCZMU2uQTTuk72m3vfK6fCP5U7i
         a7v4UZgJwori1ReJAcWeWTTp28i9zG7qW7L32A+zlg8dGTzFUUPhWFIUkvKMGhc0kbWb
         3Q6ytEQwDeEG4UNjBdLieKqLFjUGR1XAC7D+Ev70d4abClUBPhfM0t/3p86pdJ/glM2v
         zi4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791134308; x=1791739108; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QinBTGgc4+2Xq3VgxIpbr+CWC5UMzdARKszuxAv87KA=;
        b=IeOZJMDEt2qL247lMuxc+jIqy4zsxjPTwxleAIFut5mj8G2+fn0ALfayxMwtNTebBL
         RJbU8GAtzBUM9tsUheu/An8aItKMV0/OD1HywoDP1i5ZuCAEBPfK0+6p8DEX0iH9xnQh
         60NDAP5forHGc7dvpDofgIb+d7yo0My6bjDErncBm9VubHiQskbmc0eNguE4WNxyNEtX
         4EbzRviiNSaJPR8RjIii7dCQOXrUEwckaME4JawxCPYdD4zGpSOVO1IGM/3PERojKv3v
         K3jp1b6IlKprglTroQUMUhkx2M9m+VCLWlPW3xjJvdkP9/cNYbia77DYs/L7VzmOzU/g
         113A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791134308; x=1791739108;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QinBTGgc4+2Xq3VgxIpbr+CWC5UMzdARKszuxAv87KA=;
        b=eRbpNbfozMda6Yp6d+lBfROUOiNvCBN5snDaLUAyqtSBRquVqB/t4k1ZCYnhevunMj
         +lEpRav8e8nuY2AJFF1vXMQ85mLdhfleERpccpIoj8d87P/m3JS+ciCwDeCBcGQQRw3t
         DMibiibGi0J6JiVo6Chkwp0uAcRTu5caU/NhoX16R9TIa+vHxhaYOC10AOcO4rOOeCxl
         cZDGML2WTGYuKKWHXHVuPEp0dTODZ84dCWG6V1LjhlFg72jH4ByR18xSwu4yfvoofCXV
         /ZTd03UkXEwzwR8NGGL2VX7UUWfkKVogd737htpC2g/ia2rqCr3IDn5LIHnXz2r9ZgYm
         AKWQ==
X-Forwarded-Encrypted: i=1; AKwUvBwIvmRUQdvOCdwc1mJCGgyNCXETP08cSCO5RBQ4+Vg9+Sw58EwUZW3ifog0zeHnfNVWK8t5ldwMvo0D@vger.kernel.org
X-Gm-Message-State: AFuF++mFZ+irio5KGIH4sBTJsBtwHpRYSLObPluRGigCmAjh8Ci+S0XJ
	Cy4ksklQ3qSfj086M0T7PxlnH7u8HZA3BA3eJKV79WWEfjhinZKSXTtwUOjQOnDgqlVadP/EpV6
	3/s3Njvo+sdVqP2T83KcIOYJKJC1XaDXaWDnbmMdA
X-Gm-Gg: AYBFou2cN5kEZK+dJSfP90B7P1MHneh9WOGm0YVZQLKh6VHpAJ1qGc71PiwcPipOqCB
	sM4MZOwYRaaz4NP5AWvsO/siwLOweynGcBFRIzrE7yshS99C/P2m/1rU4HYocysFeYfJSd6+3eh
	2aHehyPwusgEhSd+F3oMLVjog9cM/p3Z19lPu1FjeCIJnNh8TGne5JJgDfyS9veYg0F6iFTo9Ab
	xaNSRFBMfDDk87I1TKCDOq3IT00GKY8PfTW8KNXe6Dvj/ibWtxHlU9Gs3W2eo0Dr3xS1mNxjwtS
	fOieAkMCIkAnMd9uu6W5CfPv+QNImsYzcm9vOeVF8yMY7UW6Vd9IqDqH
X-Received: by 2002:a05:622a:1b91:b0:531:34b9:2532 with SMTP id
 d75a77b69052e-535146ce3e1mr16649101cf.4.1791134306600; Sun, 04 Oct 2026
 10:18:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-9-a1f052500fd7@kernel.org>
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-9-a1f052500fd7@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 4 Oct 2026 10:18:15 -0700
X-Gm-Features: AclHuK_AcqqolMBhSGAldWSHQHOOTkitmvHnvL2po1Vgiun02DenXRmiOZ3VQUs
Message-ID: <CAJuCfpFkfK4gvBPVoSiSdKs_3LR-0-dw_08BVxs-NqCvQK0-Mg@mail.gmail.com>
Subject: Re: [PATCH v4 09/38] drivers/usb/mon: update to use mmap_prepare +
 map kernel pages
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

On Sat, Oct 3, 2026 at 6:36=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Replace the deprecated .mmap hook with its replacement .mmap_prepare. As
> part of this change, additionally take the approach of mapping pages upon
> mmap rather than providing a fault handler.
>
> The page span cannot be mutated when an mmap mapping is in place, so this
> is safe to do in advance (the MON_IOCT_RING_SIZE ioctl operation exits
> -EBUSY if it's attempted, gated by the rp->mmap_active reference count).
>
> Utilise the newly introduced mmap_action_map_discontig_kernel_pages() to =
do
> this, which allows for iteration over pages in mon_bin_discontig_get().
>
> mon_bin_discontig_init() increments the rp->mmap_active reference count t=
o
> stabilise page spans. Should an error arise the core unmaps the VMA and
> mon_bin_vma_close() drops the reference again.
>
> The vm_ops->close hook implemented in mon_bin_vma_close() will ensure
> correct reference count arithmetic upon unmap (with mon_bin_vma_open()
> accounting for splitting).
>
> The existing semantics are all retained, including not mapping past the
> range of available pages, with a SIGBUS being raised in a userland proces=
s
> that attempts to access past this point.
>
> Ultimately insert_page() is invoked to insert each page, which increments
> the reference count on each mapped page. This mimics what was being done
> previously, only we pre-map the entire range rather than doing so on
> demand.
>
> The existing fault handler did nothing that required demand paging, and w=
as
> presumably implemented this way for historical reasons.
>
> One behavioural difference: pages are no longer faulted in on demand, so =
a
> page discarded with MADV_DONTNEED is not repopulated and a subsequent
> access raises SIGBUS, as with other pre-populated kernel mappings.
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>


> ---
>  drivers/usb/mon/mon_bin.c | 82 ++++++++++++++++++++++++++++++-----------=
------
>  1 file changed, 53 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/usb/mon/mon_bin.c b/drivers/usb/mon/mon_bin.c
> index 687f6a8981f3..9d00b21a8153 100644
> --- a/drivers/usb/mon/mon_bin.c
> +++ b/drivers/usb/mon/mon_bin.c
> @@ -1219,6 +1219,15 @@ mon_bin_poll(struct file *file, struct poll_table_=
struct *wait)
>         return mask;
>  }
>
> +static void __mon_bin_vma_open(struct mon_reader_bin *rp)
> +{
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&rp->b_lock, flags);
> +       rp->mmap_active++;
> +       spin_unlock_irqrestore(&rp->b_lock, flags);
> +}
> +
>  /*
>   * open and close: just keep track of how many times the device is
>   * mapped, to use the proper memory allocation function.
> @@ -1226,64 +1235,79 @@ mon_bin_poll(struct file *file, struct poll_table=
_struct *wait)
>  static void mon_bin_vma_open(struct vm_area_struct *vma)
>  {
>         struct mon_reader_bin *rp =3D vma->vm_private_data;
> -       unsigned long flags;
>
> -       spin_lock_irqsave(&rp->b_lock, flags);
> -       rp->mmap_active++;
> -       spin_unlock_irqrestore(&rp->b_lock, flags);
> +       __mon_bin_vma_open(rp);
>  }
>
> -static void mon_bin_vma_close(struct vm_area_struct *vma)
> +static void __mon_bin_vma_close(struct mon_reader_bin *rp)
>  {
>         unsigned long flags;
>
> -       struct mon_reader_bin *rp =3D vma->vm_private_data;
>         spin_lock_irqsave(&rp->b_lock, flags);
>         rp->mmap_active--;
>         spin_unlock_irqrestore(&rp->b_lock, flags);
>  }
>
> -/*
> - * Map ring pages to user space.
> - */
> -static vm_fault_t mon_bin_vma_fault(struct vm_fault *vmf)
> +static void mon_bin_vma_close(struct vm_area_struct *vma)
>  {
> -       struct mon_reader_bin *rp =3D vmf->vma->vm_private_data;
> +       struct mon_reader_bin *rp =3D vma->vm_private_data;
> +
> +       __mon_bin_vma_close(rp);
> +}
> +
> +static const struct vm_operations_struct mon_bin_vm_ops =3D {
> +       .open =3D     mon_bin_vma_open,
> +       .close =3D    mon_bin_vma_close,
> +};
> +
> +static int mon_bin_discontig_init(void *vm_private_data, void **private)
> +{
> +       struct mon_reader_bin *rp =3D vm_private_data;
> +
> +       /* Dropped by mon_bin_vma_close() on unmap, including on error. *=
/
> +       __mon_bin_vma_open(rp);
> +       return 0;
> +}
> +
> +static int mon_bin_discontig_get(struct discontig_kernel_page_state *sta=
te)
> +{
> +       struct mon_reader_bin *rp =3D state->vm_private_data;
>         unsigned long offset, chunk_idx;
> -       struct page *pageptr;
>         unsigned long flags;
>
>         spin_lock_irqsave(&rp->b_lock, flags);
> -       offset =3D vmf->pgoff << PAGE_SHIFT;
> +
> +       offset =3D state->pgoff << PAGE_SHIFT;
>         if (offset >=3D rp->b_size) {
>                 spin_unlock_irqrestore(&rp->b_lock, flags);
> -               return VM_FAULT_SIGBUS;
> +               discontig_kernel_map_abort(state);
> +               return 0;
>         }
>         chunk_idx =3D offset / CHUNK_SIZE;
> -       pageptr =3D rp->b_vec[chunk_idx].pg;
> -       get_page(pageptr);
> -       vmf->page =3D pageptr;
> +       discontig_kernel_map_page(state, rp->b_vec[chunk_idx].pg);
> +
>         spin_unlock_irqrestore(&rp->b_lock, flags);
>         return 0;
>  }
>
> -static const struct vm_operations_struct mon_bin_vm_ops =3D {
> -       .open =3D     mon_bin_vma_open,
> -       .close =3D    mon_bin_vma_close,
> -       .fault =3D    mon_bin_vma_fault,
> +static const struct discontig_kernel_page_ops mon_discontig_ops =3D {
> +       .init =3D mon_bin_discontig_init,
> +       .get =3D mon_bin_discontig_get,
>  };
>
> -static int mon_bin_mmap(struct file *filp, struct vm_area_struct *vma)
> +static int mon_bin_mmap_prepare(struct vm_area_desc *desc)
>  {
> -       /* don't do anything here: "fault" will set up page table entries=
 */
> -       vma->vm_ops =3D &mon_bin_vm_ops;
> +       const struct file *filp =3D desc->file;
>
> -       if (vma->vm_flags & VM_WRITE)
> +       if (vma_desc_test(desc, VMA_WRITE_BIT))
>                 return -EPERM;
>
> -       vm_flags_mod(vma, VM_DONTEXPAND | VM_DONTDUMP, VM_MAYWRITE);
> -       vma->vm_private_data =3D filp->private_data;
> -       mon_bin_vma_open(vma);
> +       desc->vm_ops =3D &mon_bin_vm_ops;
> +       vma_desc_clear_flags(desc, VMA_MAYWRITE_BIT);
> +       vma_desc_set_flags(desc, VMA_DONTEXPAND_BIT, VMA_DONTDUMP_BIT);
> +       desc->private_data =3D filp->private_data;
> +
> +       mmap_action_map_discontig_kernel_pages(desc, NULL, &mon_discontig=
_ops);
>         return 0;
>  }
>
> @@ -1298,7 +1322,7 @@ static const struct file_operations mon_fops_binary=
 =3D {
>         .compat_ioctl =3D mon_bin_compat_ioctl,
>  #endif
>         .release =3D      mon_bin_release,
> -       .mmap =3D         mon_bin_mmap,
> +       .mmap_prepare =3D mon_bin_mmap_prepare,
>  };
>
>  static int mon_bin_wait_event(struct file *file, struct mon_reader_bin *=
rp)
>
> --
> 2.55.0
>
