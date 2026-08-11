Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3A1453A25
	for <linux-arch@vger.kernel.org>; Tue, 11 Aug 2026 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786465391; cv=pass; b=sB3S2kwnn3TsUDYMQ/QrdNjyEEDPCkZbjiwY+KYwxSDEB0h7HpkqWnLFD4Nm048FjvgsfKZDcb1xUv5XUTrfpxBZYjfA2KeWQ3rzhSNLgdTJniub2bcm8ndTciWMWvWX6ti4bQCt0kndFkIyeA4SBfqO/DcE8ODYLdFuJI5W3P4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786465391; c=relaxed/simple;
	bh=EQLc+ZZyBOzObxUyMWJ+vsLfdjSyags/xAI8y0fQ/xI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rg6IGXzayCp3k0PMG66YqajfZKiza5aEDJBIcIWdQu2KF3YDJdC4WY7twfkXXNk0tFvHq/Z1boKCsg987fB3fIuQdfod15+yg5+8d3u+2zmVkPHvlhR7t9ru6eRoQb58+2NxQxsJcuM8+81OeSE/bNUPvE6RQBiU/sb/16P2dc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1IKMR+8; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1IKMR+8"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c2020421077so1825866b.3
        for <linux-arch@vger.kernel.org>; Tue, 11 Aug 2026 09:23:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786465387; cv=none;
        d=google.com; s=arc-20260327;
        b=WIH9WyhgUAv9AheWHIQlj0LyCSNlu6iUSI4FbZJvIMAJoGam0lQugQAy5+avNDGXBp
         vImqZ5bhc9nQQDXCkJCGAcSoDsuXJJRQpIH+fGtDWyvJi50b+aK4Amdu3oNiRkDITLwl
         VrSB4D7WjW/74qcqSy/gzRPNWcGf+uiY0T0pz+YOr9NrCDydppSpFZat53AC+vtNN3IU
         x4TjVx5wLXbYfMzECtBuwYFcB2HovLPqr4QsPEAnJv1sqSvWdQny3pTefDeGDqJYk4qI
         u+say8sO3kKJgPLESMgFigleTlZZxZ4MN+UnfsaJ//Rd5AI3zZrtjaGHJ1LPsmHepzFY
         Gv5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qzsxg0SY/U6IfS55mTTNvzZ0Cp4+HE5FIJRTaudsYBg=;
        fh=TsjnX4Z02GQQHKo8Mrhb2/lfWVuFTyUhoFI+wTLG/FQ=;
        b=pSDvvX9mhI4mkTaBFz2d0lmc8RorYQt6bQBw4epfxLqJ0h+njEVL9hn4DxVAbbUXRq
         1TSRsULQJw0YlYPXHhn20SnzKRzhu1b5r9mh8iKL0FBap/ITAiYbIX2700BtLrjBdWZI
         MLri6xo8nYbGLF5nzYnd8NiwMR2ZxD5Ilb2HrndLgrT0/kefpvJAZufIXlvlv2X5rs12
         DeGyX6dSxmK/reo35tngiso9EIPbB44R4q0No+EJi2IWxn1yUw9zCmLX7Har4AlhVKEF
         suYX9+MoJUVWVCkTj1hTHg0kHPXtepX2WOuc4H6hPOOnZLTu5kbPs04deEHo4BPWXcHf
         cjUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786465387; x=1787070187; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qzsxg0SY/U6IfS55mTTNvzZ0Cp4+HE5FIJRTaudsYBg=;
        b=X1IKMR+8vNdsVnoQ2NTdJrrcrGg89pooOSgCY4DXWH3OrCyP5T/cjtiuCL27IwaRMo
         Tdp+d/HuC4pKPxyoj80uXD2xGd7gfJ6/TjWx54WYk8/z47YoDdcYe0CaFgLSsCGOMPeo
         AESusFUCF5hyv7AZ2YT+Bbfs3PmTrTd+RnoFEonVzNdngI5p++90/4umlKAwxgq9tQMX
         ptukuB4vTWIsR43EckfVH+9e0TULxIDZfcRGsP5KVpB5PWAz3TbLoqxrLuXnMXbqCSS5
         NbYkIQqZagS1apn6J9NCHEZR2XqtFxzJ51dx/n1DSrP8Zx2ZrpWOzpy4UNYoitNiu+pf
         YlMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786465387; x=1787070187;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qzsxg0SY/U6IfS55mTTNvzZ0Cp4+HE5FIJRTaudsYBg=;
        b=aF8nnrhe+/DUbA5DrwlFUq7J3Yx+wbuFBvebPaZao5NYH+kWOVSWOyNDqoCt62n32a
         p+P+HZ14KfFNnXm8Uld7vW65/NiWzDwXa/nM8q1gW2AJg/IC7IXxWNbKcbFx4pUBI5s3
         2o36A2Ae1fCMX0HOGiF0mL/T/Nn1hLicoFpeFUwdIusQj42UGE+Bu4dKruuWMVNTM+pz
         e9dsWRs95SHgKRfOwPu1AJh5PLjJZ4aOxS9AxgvmKhpdk0eDFN2gzI2V9K/iZAb/65B9
         mH2oO17n+jGnRtYecBmqU63iRZAmbDbdUBwsRrh/zm6FBGUQ/gwkO4UJO8C6s+pGFkE2
         cZ4w==
X-Forwarded-Encrypted: i=1; AHgh+RqWmGC6S3N7DXwA8NxjaK7sNRTgu/ITqdF+bVWugkXJmafnblLBFwyVRjPoMVOxpKNN8pomd1G9smZE@vger.kernel.org
X-Gm-Message-State: AOJu0YyPmxoswovFOblMP05b9eVmKJAa/N373TlZIyh7NKB/4b6xA/Uc
	RliD3lpyHs9ruAoQpbGN+y2OkSwwMk/iJpps1yBXYNRZqjWKsx7iqn42DCFE/Ln9Do3TCV4r0gc
	oMFN4TmlBPGzLDAfAEMsnoIVWYNd7PbU=
X-Gm-Gg: AR+sD10lR/yywL3uNpNfeFGQ+N8X+OItafgsV6LNpTTbWi/w48JAaVlgY3lWJaR5Eky
	83nG+14+MXNCzw4n/qD5GP/yB2LQwgYnyfcL9ItnkNi76ZqkiVaRwZ1PkRnavZ8gyAVFavScc8C
	K74J9F7L5pbSCbUEfWPPBZQI5PjWGlI8SuAGLg4f6D/NpO/2n2p6zKgDJKtt4aDHtQfDeL8eGlU
	OXTVsDFbIqF9kqUwuZfjQf1WGQsa5mxEOmT+Ivt4WT+vuVhk7h5GUoid40WEaJ/kKkzWbPSxwQm
	sqlpQ4DF7KdX4mEMe0rjHPOFt8B2nWbh3Le1nNr84RBtZe/mr0HAdfL6I3T3VcjAw7CqqKxQpJR
	X
X-Received: by 2002:a17:907:6d04:b0:c1f:c03a:960b with SMTP id
 a640c23a62f3a-c20e6317b05mr238926866b.32.1786465386997; Tue, 11 Aug 2026
 09:23:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808052732.2589657-1-jackzxcui1989@163.com> <20260811-zerfallen-boiler-bissfest-cdb998278337@brauner>
In-Reply-To: <20260811-zerfallen-boiler-bissfest-cdb998278337@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 11 Aug 2026 18:22:54 +0200
X-Gm-Features: AUfX_my7RrpW5x2bkYwMaUE0UjYUyZu6pwxULeOHYxOTAhMA3cZycO0hfNh3N9Q
Message-ID: <CAGudoHG8ff=8RA+8e6JUtESDxBHFjZ65UiCaM4X_6qSU6-Q9Nw@mail.gmail.com>
Subject: Re: [PATCH v8] coredump: Add bit 9 of coredump_filter for pre-exit
 files before dumping
To: Christian Brauner <brauner@kernel.org>
Cc: Xin Zhao <jackzxcui1989@163.com>, david@kernel.org, ljs@kernel.org, 
	rppt@kernel.org, pfalcato@suse.de, viro@zeniv.linux.org.uk, corbet@lwn.net, 
	skhan@linuxfoundation.org, akpm@linux-foundation.org, liam@infradead.org, 
	vbabka@kernel.org, surenb@google.com, mhocko@suse.com, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	ebiederm@xmission.com, jack@suse.cz, jlayton@kernel.org, 
	chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
	keescook@chromium.org, mcgrof@kernel.org, j.granados@samsung.com, 
	allen.lkml@gmail.com, rdunlap@infradead.org, kuba@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 11:09=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Sat, Aug 08, 2026 at 01:27:32PM +0800, Xin Zhao wrote:
> > A coredump typically takes seconds or even longer to complete. If we
> > happen to hold a write lock with flock just before triggering the
> > coredump, that write lock will not be released during the entire coredu=
mp
> > process. As a result, other processes attempting to acquire the same wr=
ite
> > lock may experience significant delays. Another typical scenario is tha=
t
> > some custom management modules for shared memory also need to release t=
he
> > reference counts of the related buffers as soon as possible, rather tha=
n
> > waiting until the coredump is complete.
> >
> > Add a new bit(9) of coredump_filter to tag whether need to dump fd list=
.
> > We set it by default because tools like systemd-coredump go through the
> > fds. Some other coredump pipe programs like minicoredump do not use fds=
 by
> > default. If you are sure that your coredump backend does not use the fd=
s,
> > you can clear bit 9, which will allow some file resources without VMA
> > references to be released earlier.
> >
> > In fput(), check FP_DUMPCORE task flags to NOT release file by task wor=
k,
> > otherwise file put operation will NOT execute util coredump finish.
> >
> > Test Case One - flock
> > Test program send signal SIGABRT to the program which owns the flock,
> > output the wait time(unit ms) to successfully attach the flock.
> > Test program malloc 500MB heap and memset it.
> > If NOT set bit9 of coredump_filter, waitms is 11280.
> > If set bit9 of coredump_filter, waitms is 0.
> >
> > Test Case Two - ion buffer
> > Test programs include ion buffer publisher and ion buffer subscriber.
> > Ion buffer publisher output the ion buffer hold_time if the subscriber
> > NOT send ack to publisher and NOT release it. The subscriber will trig
> > coredump by itself in some time.
> > If NOT set bit9 of subscriber coredump_filter, max hold_time is 19591ms=
.
> > If set bit9 of subscriber coredump_filter, max hold_time is 320ms.
> >
> > Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
> > ---
> >
> > Change in v8:
> > - Delete the duplicate description of default value of coredump_filter =
in
> >   proc.rst, as suggested by Randy Dunlap.
> >
> > Change in v7:
> > - Fix description error in proc.rst. Since bit9 has been added, the
> >   supported memory types should now be 10,
> >   as suggested by David Hildenbrand (Arm).
> > - Link to v7: https://lore.kernel.org/all/20260807040124.1706927-1-jack=
zxcui1989@163.com/
> >
> > Change in v6:
> > - Fix operator precedence in PF_KTHREAD/PF_DUMPCORE check.
> > - Link to v6: https://lore.kernel.org/all/20260804001703.1340667-1-jack=
zxcui1989@163.com/
> >
> > Change in v5:
> > - Not add another bootargs for the feature,
> >   as suggested by Christian Brauner and Lorenzo Stoakes.
> >   Add bit9 of coredump_filter to tag whether need to dump fd list.
> >   Set bit9 to 1 as default.
> > - Al Viro, Christian Brauner and Lorenzo Stoakes point out so many
> >   problems of the code related to umap that was added in v4, delete all=
 of
> >   it which is unnecessary. The management of reference counting for sha=
red
> >   memory generally does not need to be released through the release
> >   operation of files that have VMA references. Traversing all the threa=
ds
> >   within the process and executing exit_files() is sufficient.
> > - Fulfill comments and commit log,
> >   as suggested by Pedro Falcato and Lorenzo Stoakes.
> > - Link to v5: https://lore.kernel.org/all/20260630075604.52533-1-jackzx=
cui1989@163.com/
> >
> > Change in v4:
> > - Christian pointed out that the coredump process will traverse file
> >   descriptors (fd), so certain fds should not be closed by default.
> >   Rework the whole feature, add /proc/<pid>/coredump_pre_exit for user
> >   pre-exit resources selection, default is NOT pre-exit anything.
> > - Mateusz suggested that walking the fd table and release the file-lock=
 is
> >   reasonable. No longer release all the fd(s). Based on user config, on=
ly
> >   the flock fd(s) and the fd(s) correspondent to file-backed shared mem=
ory
> >   will be released at most.
> > - Link to v4: https://lore.kernel.org/all/20260624145552.70143-1-jackzx=
cui1989@163.com/
> >
> > Change in v3:
> > - Add comment and commit-log to explain why do the MMF_DUMP_MAPPED_SHAR=
ED
> >   mm_flags_test() check, note that memory mapped files keep their own
> >   separate references to the files. The case to work around is that ear=
ly
> >   unlocking a flock on a file allows other processes to lock and modify
> >   the mapped data protected by the flock,
> >   as suggested by Pedro Falcato.
> > - Link to v3: https://lore.kernel.org/all/20260619122419.3954581-1-jack=
zxcui1989@163.com/
> >
> > Change in v2:
> > - Get rid of the implement of adding new fcntl API, the issue does not
> >   worth inflicting the cost on everyone,
> >   as suggested by Al Viro.
> > - Call exit_files() in coredump_wait(),
> >   as suggested by Eric W. Biederman.
> >   Add MMF_DUMP_MAPPED_SHARED mm_flags_test() check to filter cases that
> >   need to dump file-backed shared memory.
> > - Link to v2: https://lore.kernel.org/lkml/20260618150301.3226517-1-jac=
kzxcui1989@163.com/
> >
> > v1:
> > - Link to v1: https://lore.kernel.org/all/20260618030700.2511668-1-jack=
zxcui1989@163.com/
> > ---
> >  Documentation/filesystems/proc.rst | 17 ++++++++++++-----
> >  fs/coredump.c                      | 21 +++++++++++++++++++++
> >  fs/file_table.c                    |  7 ++++++-
> >  include/linux/mm_types.h           |  6 ++++--
> >  4 files changed, 43 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesys=
tems/proc.rst
> > index db6167bef..aee03858b 100644
> > --- a/Documentation/filesystems/proc.rst
> > +++ b/Documentation/filesystems/proc.rst
> > @@ -1927,7 +1927,7 @@ will be dumped when the <pid> process is dumped. =
coredump_filter is a bitmask
> >  of memory types. If a bit of the bitmask is set, memory segments of th=
e
> >  corresponding memory type are dumped, otherwise they are not dumped.
> >
> > -The following 9 memory types are supported:
> > +The following 10 memory types are supported:
> >
> >    - (bit 0) anonymous private memory
> >    - (bit 1) anonymous shared memory
> > @@ -1939,6 +1939,7 @@ The following 9 memory types are supported:
> >    - (bit 6) hugetlb shared memory
> >    - (bit 7) DAX private memory
> >    - (bit 8) DAX shared memory
> > +  - (bit 9) fd list
> >
> >    Note that MMIO pages such as frame buffer are never dumped and vDSO =
pages
> >    are always dumped regardless of the bitmask status.
> > @@ -1946,13 +1947,19 @@ The following 9 memory types are supported:
> >    Note that bits 0-4 don't affect hugetlb or DAX memory. hugetlb memor=
y is
> >    only affected by bit 5-6, and DAX is only affected by bits 7-8.
> >
> > -The default value of coredump_filter is 0x33; this means all anonymous=
 memory
> > -segments, ELF header pages and hugetlb private memory are dumped.
> > +  Note that bit 9 is set by default because tools like systemd-coredum=
p go
> > +  through the fds. If you do not set bit 9, files that are not referen=
ced by
> > +  any VMA are released before dumping core. Some file release logic, s=
uch as
> > +  exiting flock or releasing references to shared buffers is executed =
much
> > +  earlier.
> > +
> > +The default value of coredump_filter is 0x233; this means all anonymou=
s memory
> > +segments, ELF header pages, hugetlb private memory and fd list are dum=
ped.
> >
> >  If you don't want to dump all shared memory segments attached to pid 1=
234,
> > -write 0x31 to the process's proc file::
> > +write 0x231 to the process's proc file::
> >
> > -  $ echo 0x31 > /proc/1234/coredump_filter
> > +  $ echo 0x231 > /proc/1234/coredump_filter
> >
> >  When a new process is created, the process inherits the bitmask status=
 from its
> >  parent. It is useful to set up coredump_filter before the program runs=
.
> > diff --git a/fs/coredump.c b/fs/coredump.c
> > index bb6fdb1f4..ed4d30916 100644
> > --- a/fs/coredump.c
> > +++ b/fs/coredump.c
> > @@ -521,6 +521,25 @@ static int zap_threads(struct task_struct *tsk,
> >       return nr;
> >  }
> >
> > +/*
> > + * If do not dump fd list, files that are not referenced by any VMA
> > + * can be released before dumping core. Therefore, some file release
> > + * logic, such as exiting flock or releasing references to shared
> > + * buffers is executed much earlier. Note that do_coredump() often
> > + * takes several seconds or even longer to execute.
> > + */
> > +static void coredump_pre_exit(void)
> > +{
> > +     struct task_struct *tsk =3D current, *t;
> > +
> > +     if (mm_flags_test(MMF_DUMP_FD_LIST, tsk->mm))
> > +             return;
> > +
> > +     for_each_thread(tsk, t) {
> > +             exit_files(t);
> > +     }
> > +}
> > +
> >  static int coredump_wait(int exit_code, struct core_state *core_state)
> >  {
> >       struct task_struct *tsk =3D current;
> > @@ -1124,6 +1143,8 @@ static void do_coredump(struct core_name *cn, str=
uct coredump_params *cprm,
> >       if (cn->mask & COREDUMP_REJECT)
> >               return;
> >
> > +     coredump_pre_exit();
> > +
> >       /* get us an unshared descriptor table; almost always a no-op */
> >       /* The cell spufs coredump code reads the file descriptor tables =
*/
> >       if (unshare_files())
> > diff --git a/fs/file_table.c b/fs/file_table.c
> > index 16e52e7fc..6ed8ace8c 100644
> > --- a/fs/file_table.c
> > +++ b/fs/file_table.c
> > @@ -566,7 +566,12 @@ static void __fput_deferred(struct file *file)
> >               return;
> >       }
> >
> > -     if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
> > +     /*
> > +      * coredump_pre_exit() may release files before dumping core.
> > +      * Cannot use task_work in the case, needs to release files
> > +      * earlier.
> > +      */
> > +     if (likely(!in_interrupt() && !(task->flags & (PF_KTHREAD | PF_DU=
MPCORE)))) {
>
> Still NAK to this whole appraoch.

Would you be ok with a variant which merely unlocks prior to dumping?
File descriptors remain in place like they always did, but that bit
about them is changed.
