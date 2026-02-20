Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F201E30C350
	for <linux-arch@vger.kernel.org>; Fri, 20 Feb 2026 21:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771623373; cv=pass; b=jLDsVISA8X3hj2ZaCzRlUoG0ZSSaiHjDV/ZNfCD3ZlHIFpUDKys7hJ0j+o9yVvTeb8WlpKizDUoyZOniDxHdgdQDjQp3jlJgI8VBQVTpx0oQS7X/jjTElykz61xzWk2ApYsYUe4L7iENGyPk40srUO6duZcU4HqKUH1tSnkLU1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771623373; c=relaxed/simple;
	bh=k8cRk/7KXIJNpCyVHvXlLZIO4xOlnX+uRv93eIdUMzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o1/GslXk/MPyOkxP0XalJwvnn27C8ZYkvJ/HnExSYwSyWd+8xENRgmdrBAerr9hvGHU28Rk6jsytkUaBP9Qg8v+rthrUqNCtc88nwtZBNkLwRm19NjJTjoH13A5o79gb9xxa11+dBVH+ZeJXhfshj+YCCtxi1+/qkZR2DHlmBO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k/ZllTeM; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k/ZllTeM"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a964077671so20855ad.0
        for <linux-arch@vger.kernel.org>; Fri, 20 Feb 2026 13:36:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771623371; cv=none;
        d=google.com; s=arc-20240605;
        b=U1azrNOQ3Ifw14mkqbqURyBIzdnFknAXvchGzmFmVZAONaavHHPZ82p3V2kVPW3DuW
         73p7gXdypMxnnjVpQR+pm954kk+P9/uggasQ6B4y8pvBRfCvX5U9GKzPWEnZPTQ/6c7R
         NYvOkoHxxtTa5YWvi/81DP5uwmYWn1wOaiFgHs8LZzzJYXuIfDB85VEly0bNxkpC34Ju
         JqVNziiA8yWL28FWB90+K4SuF3WE1Zdb6CjhQ562ROkkHydF6YWuNOUc9gyX8/HJHUn7
         iEmI1dj3hS3oGz1V9GDBBRC46U/y8MYlvGoflGtZczo/rqChGt18/rQ4PMUUZYkH8Iys
         ysWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hz25v6lNfFpsqcoUVzeMgcEtFNoS0C98fF1StYX9804=;
        fh=txEr64/dmSy7qB98HXGDw7dENDywLpKmKuDWaVq0gQo=;
        b=djjYYxeofbDqc3PMcewE0pxI++CWZjo15zEcTv1M/DRc31w31cWgwHPRfA+fgXjw50
         HbOTa4XzYgWQyECy+wt5SjHSAAEyoqs7LniEJGaMvEIZoFJx+s6q0OyZMJiJEe5o2ssE
         Q8hA8wnODWyauE6k4EW76g9irUe54l9YrvGhy0YVbPt2hgy553jT61KjNBcVLtukJocC
         zhG9oovPoSVJue9eDFAvnu0/vtpuAG3Tf50fE+qJwQgMtco2TKpjklVtUgiHhfF7pVx4
         e2nQXXI4UsmpfqhgFZZYxAoioJ+Jlz+E1pHpc+g4PscyZm1RsFxD7Ng7MNlPPOqRb9UE
         gnMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771623371; x=1772228171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hz25v6lNfFpsqcoUVzeMgcEtFNoS0C98fF1StYX9804=;
        b=k/ZllTeMnxS0P7ewldZmYOYGacva28QrO9vx6SCBSqUuWiE1oFd69VdNPmkh7Hnz7U
         6ljX9DYxDeJtxJTxA35C608iMAovesF1+xzClzeJUCxUyx1Rcb1knhKtG75HQ3jXYy69
         1EaLAkaYyPlfCpmzGzPqhu87DSzu/1WEDpK91THVS2Ziy8rwgqi1b5cS70/2qF7Si6dR
         kaw0Iqcj3CyG5Yzz0raUuG0Upg0ZVht3oQKHiVdxg6bhiEt2PTU+wWmZE6CLldfDmNJH
         jEu9y1sUq6FuKLUtPI26Ft++cKZVzfwhORaC/1F0TQ20kkcb7LfGZ8JXHi9OwxvLz5KJ
         rdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771623371; x=1772228171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hz25v6lNfFpsqcoUVzeMgcEtFNoS0C98fF1StYX9804=;
        b=EXYBoGbnk5Nl+emFS5wv/DXFV8AtVMvbjr6KtIHGUYikrslvwer2/1KImQGKrGgw8f
         yzKiSQ13+uzLy904Bu55btBrot9YxqXLyUNwnfED748Da4iA9qJoWrX0zDRp7w3hxhUY
         eVdsnlyfVLO0/a9D45s8E0lPTCmcGu7XK9xKZ+3c8qH6pk8KX80k5BX9L7eqx2MnldZR
         aPjKy1HRGpJ/Ys8frCsfa/8pvJSWVyCQkgQAKnKO3QbBLAAAw0VpNB83IVygrXC3pxyb
         wa+M5lbMRBOp2r1FSLXgZyhQDVmVM6mDVICsiS3saYHX5DNpIOj6Pm9ww/cy5isE957M
         pgxw==
X-Forwarded-Encrypted: i=1; AJvYcCWycXfT0WNBMC1VpIBWH14iUvsJYx/JwLIKrF8vrfA5P86SgAAxMMAdbA6eH6Fp/KLP+75s/Z2xoGnC@vger.kernel.org
X-Gm-Message-State: AOJu0YyVQv6qFxSEcvGH+u6GHNwkbHR20kSaSPtVOb2q+I0lqY7mjcUK
	8r9wHh8TH2L8bhoqdl6jZXyYIwT5xvqZyls0lPsyDouv3XPoqQu7uJ5MWloEi2TG17RQFYEcZ7Y
	reBhKBXnloXN9gyQKS0N5rj+3Bzexapeakm/uxRyj
X-Gm-Gg: AZuq6aKKYsgwFonzuliRxNDrtD+bYGS/FWtpedlOrpSr0WZ3O+NPydgCEPO6BZoICx6
	p6Yht/BozJknLzIlnOECoBvWO0/TpvsnOlPjkaGFCDvjnP2lcyH9+PAs4fM6Cz4cK0y1wy+kzJO
	PnUkQibMn54sJUGODwHDlEP3HNrcg5+4m0gG9YcHGPIrfbOg9cM5/CC3ucxl3w8zBEVXE55XQrm
	f1UDLAW4hNNUw0ZqYwA0hGerDGSOkjqKMoHnl8v9taFDruRgB6Djq+ys7BJ1LUkHnz4UO5/sm+e
	TGeesh0pZ39+R4Pqxx3MPxHhsAOsuAyuxWbMsqA0
X-Received: by 2002:a17:903:15ce:b0:2a7:5652:50b2 with SMTP id
 d9443c01a7336-2ad75d67a7fmr60225ad.9.1771623370611; Fri, 20 Feb 2026 13:36:10
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820010415.699353-1-anthony.yznaga@oracle.com>
In-Reply-To: <20250820010415.699353-1-anthony.yznaga@oracle.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Fri, 20 Feb 2026 13:35:58 -0800
X-Gm-Features: AaiRm50GP3k8OLUJ3qKyKn32C8iCar6BHko2HVxt-jsOwPsBNQoXEdqDCA-OlWM
Message-ID: <CAC_TJvcaJdEzK8n9BK0qgEXdzjzXtbA_Zk-ybfmG8kjNExVCzw@mail.gmail.com>
Subject: Re: [PATCH v3 00/22] Add support for shared PTEs across processes
To: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, andreyknvl@gmail.com, 
	arnd@arndb.de, bp@alien8.de, brauner@kernel.org, bsegall@google.com, 
	corbet@lwn.net, dave.hansen@linux.intel.com, david@redhat.com, 
	dietmar.eggemann@arm.com, ebiederm@xmission.com, hpa@zytor.com, 
	jakub.wartak@mailbox.org, jannh@google.com, juri.lelli@redhat.com, 
	khalid@kernel.org, liam.howlett@oracle.com, linyongting@bytedance.com, 
	lorenzo.stoakes@oracle.com, luto@kernel.org, markhemm@googlemail.com, 
	maz@kernel.org, mhiramat@kernel.org, mgorman@suse.de, mhocko@suse.com, 
	mingo@redhat.com, muchun.song@linux.dev, neilb@suse.de, osalvador@suse.de, 
	pcc@google.com, peterz@infradead.org, pfalcato@suse.de, rostedt@goodmis.org, 
	rppt@kernel.org, shakeel.butt@linux.dev, surenb@google.com, 
	tglx@linutronix.de, vasily.averin@linux.dev, vbabka@suse.cz, 
	vincent.guittot@linaro.org, viro@zeniv.linux.org.uk, vschneid@redhat.com, 
	willy@infradead.org, x86@kernel.org, xhao@linux.alibaba.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 6:57=E2=80=AFPM Anthony Yznaga
<anthony.yznaga@oracle.com> wrote:
>
> Memory pages shared between processes require page table entries
> (PTEs) for each process. Each of these PTEs consume some of
> the memory and as long as the number of mappings being maintained
> is small enough, this space consumed by page tables is not
> objectionable. When very few memory pages are shared between
> processes, the number of PTEs to maintain is mostly constrained by
> the number of pages of memory on the system. As the number of shared
> pages and the number of times pages are shared goes up, amount of
> memory consumed by page tables starts to become significant. This
> issue does not apply to threads. Any number of threads can share the
> same pages inside a process while sharing the same PTEs. Extending
> this same model to sharing pages across processes can eliminate this
> issue for sharing across processes as well.
>
> Some of the field deployments commonly see memory pages shared
> across 1000s of processes. On x86_64, each page requires a PTE that
> is 8 bytes long which is very small compared to the 4K page
> size. When 2000 processes map the same page in their address space,
> each one of them requires 8 bytes for its PTE and together that adds
> up to 8K of memory just to hold the PTEs for one 4K page. On a
> database server with 300GB SGA, a system crash was seen with
> out-of-memory condition when 1500+ clients tried to share this SGA
> even though the system had 512GB of memory. On this server, in the
> worst case scenario of all 1500 processes mapping every page from
> SGA would have required 878GB+ for just the PTEs. If these PTEs
> could be shared, the a substantial amount of memory saved.
>
> This patch series implements a mechanism that allows userspace
> processes to opt into sharing PTEs. It adds a new in-memory
> filesystem - msharefs. A file created on msharefs represents a
> shared region where all processes mapping that region will map
> objects within it with shared PTEs. When the file is created,
> a new host mm struct is created to hold the shared page tables
> and vmas for objects later mapped into the shared region. This
> host mm struct is associated with the file and not with a task.
> When a process mmap's the shared region, a vm flag VM_MSHARE
> is added to the vma. On page fault the vma is checked for the
> presence of the VM_MSHARE flag. If found, the host mm is
> searched for a vma that covers the fault address. Fault handling
> then continues using that host vma which establishes PTEs in the
> host mm. Fault handling in a shared region also links the shared
> page table to the process page table if the shared page table
> already exists.
>
> Ioctls are used to map and unmap objects in the shared region and
> to (eventually) perform other operations on the shared objects such
> as changing protections.
>
> API
> =3D=3D=3D
>
> The steps to use this feature are:
>
> 1. Mount msharefs on /sys/fs/mshare -
>         mount -t msharefs msharefs /sys/fs/mshare
>
> 2. mshare regions have alignment and size requirements. The start
>    address for the region must be aligned to an address boundary and
>    be a multiple of fixed size. This alignment and size requirement
>    can be obtained by reading the file /sys/fs/mshare/mshare_info
>    which returns a number in text format. mshare regions must be
>    aligned to this boundary and be a multiple of this size.
>
> 3. For the process creating an mshare region:
>         a. Create a file on /sys/fs/mshare, for example -
>                 fd =3D open("/sys/fs/mshare/shareme",
>                                 O_RDWR|O_CREAT|O_EXCL, 0600);
>
>         b. Establish the size of the region
>                 ftruncate(fd, BUFFER_SIZE);
>
>         c. Map some memory in the region
>                 struct mshare_create mcreate;
>
>                 mcreate.region_offset =3D 0;
>                 mcreate.size =3D BUFFER_SIZE;
>                 mcreate.offset =3D 0;
>                 mcreate.prot =3D PROT_READ | PROT_WRITE;
>                 mcreate.flags =3D MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED;
>                 mcreate.fd =3D -1;
>
>                 ioctl(fd, MSHAREFS_CREATE_MAPPING, &mcreate)
>
>         d. Map the mshare region into the process
>                 mmap((void *)TB(2), BUFFER_SIZE, PROT_READ | PROT_WRITE,
>                         MAP_FIXED | MAP_SHARED, fd, 0);
>
>         e. Write and read to mshared region normally.
>
> 4. For processes attaching an mshare region:
>         a. Open the file on msharefs, for example -
>                 fd =3D open("/sys/fs/mshare/shareme", O_RDWR);
>
>         b. Get information about mshare'd region from the file:
>                 struct stat sb;
>
>                 fstat(fd, &sb);
>                 mshare_size =3D sb.st_size;
>
>         c. Map the mshare'd region into the process
>                 mmap((void *)TB(2), mshare_size, PROT_READ | PROT_WRITE,
>                         MAP_FIXED | MAP_SHARED, fd, 0);
>
> 5. To delete the mshare region -
>                 unlink("/sys/fs/mshare/shareme");
>
>
>
> Example Code
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Snippet of the code that a donor process would run looks like below:
>
> -----------------
>         struct mshare_create mcreate;
>
>         fd =3D open("/sys/fs/mshare/mshare_info", O_RDONLY);
>         read(fd, req, 128);
>         alignsize =3D atoi(req);
>         close(fd);
>         fd =3D open("/sys/fs/mshare/shareme", O_RDWR|O_CREAT|O_EXCL, 0600=
);
>         start =3D alignsize * 4;
>         size =3D alignsize * 2;
>
>         ftruncate(fd, size);
>
>         mcreate.region_offset =3D 0;
>         mcreate.size =3D size;
>         mcreate.offset =3D 0;
>         mcreate.prot =3D PROT_READ | PROT_WRITE;
>         mcreate.flags =3D MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED;
>         mcreate.fd =3D -1;
>         ret =3D ioctl(fd, MSHAREFS_CREATE_MAPPING, &mcreate);
>         if (ret < 0)
>                 perror("ERROR: MSHAREFS_CREATE_MAPPING");
>
>         addr =3D mmap((void *)start, size, PROT_READ | PROT_WRITE,
>                         MAP_FIXED | MAP_SHARED, fd, 0);
>         if (addr =3D=3D MAP_FAILED)
>                 perror("ERROR: mmap failed");
>
>         strncpy(addr, "Some random shared text",
>                         sizeof("Some random shared text"));
> -----------------
>
> Snippet of code that a consumer process would execute looks like:
>
> -----------------
>         fd =3D open("/sys/fs/mshare/shareme", O_RDONLY);
>
>         fstat(fd, &sb);
>         size =3D sb.st_size;
>
>         if (!size)
>                 perror("ERROR: mshare region not init'd");
>
>         addr =3D mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0)=
;
>
>         printf("Guest mmap at %px:\n", addr);
>         printf("%s\n", addr);
>         printf("\nDone\n");
>
> -----------------

Hi Anthony,

Thanks for continuing to push this forward, and apologies for joining
this discussion late. I am likely missing some context from the
various previous iterations of this feature, but I'd like to throw
another use case into the mix to be considered around the design of
the sharing API.

We are exploring a similar optimization for Android to reduce page
table overhead. In Android, we preload many ELF mappings in the Zygote
process to help application launch times. Since the Zygote model is
fork-but-no-exec, all applications inherit these mappings, which can
result in upwards of 200 MB of redundant page table overhead per
device.

I believe that managing a pseudo-filesystem (msharefs) and mapping via
ioctl during process creation could introduce overhead that impacts
app startup latency. Ideally, child apps shouldn't be aware of this
sharing or need to manage the pseudo-filesystem on their end. To
achieve this "transparent" sharing, I would prefer Khalid's previous
API from his 2022 RFC [1]. By attaching the shared mm directly to the
file's address_space and exposing a MAP_SHARED_PT flag, child apps
could transparently inherit the shared page tables during fork().

Regarding David's and Matthew's discussion on VMA-modifying functions,
I would lean towards the standard VMA manipulating APIs should be
preferred over custom ioctls to preserve transparency for user-space.
Perhaps whether or not these modifications persist across all sharing
processes needs to be configurable? It seems that for database
workloads, having the updates reflected everywhere would be the
desired behavior. In the use case described for Android, we don't want
apps to be able to modify these shared ELF mappings. To handle this,
it's likely we would do something like mseal() the VMAs in the dynamic
loader before forking.

Perhaps we could decouple the core sharing logic from the sharing API
itself? Since the sharing interface seems one of  the main areas where
we don't have a good consensus yet, perhaps we could land the core
sharing logic first. Keeping the core infrastructure generic would
allow it to be used transparently via MAP_SHARED_PT on standard files
(revisiting Khalid's approach), while msharefs could act as a specific
frontend for the database use cases?

[1] https://lore.kernel.org/all/cover.1682453344.git.khalid.aziz@oracle.com=
/

Thanks,
Kalesh

>
> v3:
>   - Based on mm-new as of 2025-08-15
>   - (Fix) When unmapping an msharefs VMA, unlink the shared page tables
>     from the process page table using the new unmap_page_range vm_ops hoo=
k
>     rather than having free_pgtables() skip mshare VMAs (Jann Horn).
>   - (Fix) Keep a reference count on shared PUD pages to prevent UAF when
>     the unmap of objects in the mshare region also frees shared page
>     tables.
>   - (New) Support mapping files and anonymous hugetlb memory in an mshare
>     region.
>   - (New) Implement ownership of mshare regions. The process that
>     creates an mshare region is assigned as the owner. See the patch for
>     details.
>   - (Changed) Undid previous attempt at cgroup support. Cgroup accounting
>     is now directed to the owner process.
>   - (TBD) Support for mmu notifiers is not yet implemented. There are som=
e
>     hurdles to be overcome. Mentioned here because it came up in comments
>     on the v2 series (Jann Horn).
>
> v2:
>   (https://lore.kernel.org/all/20250404021902.48863-1-anthony.yznaga@orac=
le.com/)
>   - Based on mm-unstable as of 2025-04-03 (8ff02705ba8f)
>   - Set mshare size via fallocate or ftruncate instead of MSHAREFS_SET_SI=
ZE.
>     Removed MSHAREFS_SET_SIZE/MSHAREFS_GET_SIZE ioctls. Use stat to get s=
ize.
>     (David H)
>   - Remove spinlock from mshare_data. Initializing the size is protected =
by
>     the inode lock.
>   - Support mapping a single mshare region at different virtual addresses=
.
>   - Support system selection of the start address when mmap'ing an mshare
>     region.
>   - Changed MSHAREFS_CREATE_MAPPING and MSHAREFS_UNMAP to use a byte offs=
et
>     to specify the start of a mapping.
>   - Updated documentation.
>
> v1:
>   (https://lore.kernel.org/linux-mm/20250124235454.84587-1-anthony.yznaga=
@oracle.com/)
>   - Based on mm-unstable mm-hotfixes-stable-2025-01-16-21-11
>   - Use mshare size instead of start address to check if mshare region
>     has been initialized.
>   - Share page tables at PUD level instead of PGD.
>   - Rename vma_is_shared() to vma_is_mshare() (James H / David H)
>   - Introduce and use mmap_read_lock_nested() (Kirill)
>   - Use an mmu notifier to flush all TLBs when updating shared pagetable
>     mappings. (Dave Hansen)
>   - Move logic for finding the shared vma to use to handle a fault from
>     handle_mm_fault() to do_user_addr_fault() because the arch-specific
>     fault handling checks vma flags for access permissions.
>   - Add CONFIG_MSHARE / ARCH_SUPPORTS_MSHARE
>   - Add msharefs_get_unmapped_area()
>   - Implemented vm_ops->unmap_page_range (Kirill)
>   - Update free_pgtables/free_pgd_range to free process pagetable levels
>     but not shared pagetable levels.
>   - A first take at cgroup support
>
> RFC v2 -> v3:
>   - Now based on 6.11-rc5
>   - Addressed many comments from v2.
>   - Simplified filesystem code. Removed refcounting of the
>     shared mm_struct allocated for an mshare file. The mm_struct
>     and the pagetables and mappings it contains are freed when
>     the inode is evicted.
>   - Switched to an ioctl-based interface. Ioctls implemented
>     are used to set and get the start address and size of an
>     mshare region and to map objects into an mshare region
>     (only anon shared memory is supported in this series).
>   - Updated example code
>
> [1] v2: https://lore.kernel.org/linux-mm/cover.1656531090.git.khalid.aziz=
@oracle.com/
>
> RFC v1 -> v2:
>   - Eliminated mshare and mshare_unlink system calls and
>     replaced API with standard mmap and unlink (Based upon
>     v1 patch discussions and LSF/MM discussions)
>   - All fd based API (based upon feedback and suggestions from
>     Andy Lutomirski, Eric Biederman, Kirill and others)
>   - Added a file /sys/fs/mshare/mshare_info to provide
>     alignment and size requirement info (based upon feedback
>     from Dave Hansen, Mark Hemment and discussions at LSF/MM)
>   - Addressed TODOs in v1
>   - Added support for directories in msharefs
>   - Added locks around any time vma is touched (Dave Hansen)
>   - Eliminated the need to point vm_mm in original vmas to the
>     newly synthesized mshare mm
>   - Ensured mmap_read_unlock is called for correct mm in
>     handle_mm_fault (Dave Hansen)
>
> Anthony Yznaga (15):
>   mm/mshare: allocate an mm_struct for msharefs files
>   mm/mshare: add ways to set the size of an mshare region
>   mm/mshare: flush all TLBs when updating PTEs in an mshare range
>   sched/numa: do not scan msharefs vmas
>   mm: add mmap_read_lock_killable_nested()
>   mm: add and use unmap_page_range vm_ops hook
>   mm: introduce PUD page table shared count
>   x86/mm: enable page table sharing
>   mm: create __do_mmap() to take an mm_struct * arg
>   mm: pass the mm in vma_munmap_struct
>   sched/mshare: mshare ownership
>   mm/mshare: Add an ioctl for unmapping objects in an mshare region
>   mm/mshare: support mapping files and anon hugetlb in an mshare region
>   mm/mshare: provide a way to identify an mm as an mshare host mm
>   mm/mshare: charge fault handling allocations to the mshare owner
>
> Khalid Aziz (7):
>   mm: Add msharefs filesystem
>   mm/mshare: pre-populate msharefs with information file
>   mm/mshare: make msharefs writable and support directories
>   mm/mshare: Add a vma flag to indicate an mshare region
>   mm/mshare: Add mmap support
>   mm/mshare: prepare for page table sharing support
>   mm/mshare: Add an ioctl for mapping objects in an mshare region
>
>  Documentation/filesystems/index.rst           |   1 +
>  Documentation/filesystems/msharefs.rst        |  96 ++
>  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>  arch/Kconfig                                  |   3 +
>  arch/x86/Kconfig                              |   1 +
>  arch/x86/mm/fault.c                           |  40 +-
>  include/linux/mm.h                            |  52 +
>  include/linux/mm_types.h                      |  38 +-
>  include/linux/mmap_lock.h                     |   7 +
>  include/linux/mshare.h                        |  25 +
>  include/linux/sched.h                         |   5 +
>  include/trace/events/mmflags.h                |   7 +
>  include/uapi/linux/magic.h                    |   1 +
>  include/uapi/linux/msharefs.h                 |  38 +
>  ipc/shm.c                                     |  17 +
>  kernel/exit.c                                 |   1 +
>  kernel/fork.c                                 |   1 +
>  kernel/sched/fair.c                           |   3 +-
>  mm/Kconfig                                    |  11 +
>  mm/Makefile                                   |   4 +
>  mm/hugetlb.c                                  |  25 +
>  mm/memory.c                                   |  76 +-
>  mm/mmap.c                                     |  10 +-
>  mm/mshare.c                                   | 942 ++++++++++++++++++
>  mm/vma.c                                      |  22 +-
>  mm/vma.h                                      |   3 +-
>  26 files changed, 1385 insertions(+), 45 deletions(-)
>  create mode 100644 Documentation/filesystems/msharefs.rst
>  create mode 100644 include/linux/mshare.h
>  create mode 100644 include/uapi/linux/msharefs.h
>  create mode 100644 mm/mshare.c
>
> --
> 2.47.1
>
>
