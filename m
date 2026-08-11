Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7893B41F7FD;
	Tue, 11 Aug 2026 09:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786439062; cv=none; b=au+EJ3IrAH9ixld6XS7B6K/9951yYXmVBxjmzHCHDmTVmq+4GoiUtbLw+MzBx4ceSGdq7nZWce1YL6Tx55ijk8ZDiFrhQXUXF/Lg2u3PUUKJFhg9nWY4iW9y9S/lJk9OfAMOU+Obhd1RDgVIAGUm6vtvCU+SETh/Cdwe8qA+JrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786439062; c=relaxed/simple;
	bh=waC/AdJISJeR6gHcI5Nkc4l+p8YrofY9kCJja8ll1rM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxwltlHTSEaV/e7y5mUHECbySFhoVS7D8MCcj1xvOqxjrRShw6AyzrJc7D0PLy1VsBIJKWwRz+SBMwNLatL3YwlX05tcaCSNkXwO2mImaI128FL0jhsvO4/2WW9zLyHdmdVfL61zDmBfY+tX+g06jueMS91ANhtT4/Be9vL+mEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHxjSLAZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHxjSLAZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267BA1F000E9;
	Tue, 11 Aug 2026 09:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786439061;
	bh=bqd0jBYucjRBBUhQ/CcI4j1gic+E8ObUl1M7bAWuqvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DHxjSLAZxstCOZdlWaaelyCKBFtsdMcV2ge5KXIjA8vZ65GdLVQy+H8GIqOPLJFZW
	 Da1rDvYNPw06du5swwJ7r0/NQbszmClZgdoff1tArrkF87WMAR10wknrraAmE6rbgN
	 SZ4RBiAnvBqn2i6r1HBwy+AKmOkvUTd2DITf+Fg8u8nxC3agSFHVCsAi68JjPzdFPh
	 /AZTX9D9GBoFatNuuNYjyqFo/dThjXpU7v6bFji6dwmz0z0pLEfbnJT9jQ0+g1LRB2
	 V24q6/KCYtKJHuzgK5StDbdVSLjk+JD9IRKklOBpDSCS+occ+mU9I8A651lncFP0pL
	 gxKMbkhkr3xgQ==
Date: Tue, 11 Aug 2026 11:04:12 +0200
From: Christian Brauner <brauner@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Xin Zhao <jackzxcui1989@163.com>, ljs@kernel.org, rppt@kernel.org, 
	pfalcato@suse.de, viro@zeniv.linux.org.uk, corbet@lwn.net, 
	skhan@linuxfoundation.org, akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, 
	surenb@google.com, mhocko@suse.com, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, mjguzik@gmail.com, 
	ebiederm@xmission.com, jack@suse.cz, jlayton@kernel.org, chuck.lever@oracle.com, 
	alex.aring@gmail.com, arnd@arndb.de, keescook@chromium.org, mcgrof@kernel.org, 
	j.granados@samsung.com, allen.lkml@gmail.com, kuba@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6] coredump: Add bit 9 of coredump_filter for pre-exit
 files before dumping
Message-ID: <20260811-abzweigen-zukunft-einpacken-668f1aad2ed1@brauner>
References: <20260804001703.1340667-1-jackzxcui1989@163.com>
 <8c763f1b-85ad-44b9-b36c-becd7598fe77@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8c763f1b-85ad-44b9-b36c-becd7598fe77@kernel.org>

On Thu, Aug 06, 2026 at 04:01:55PM +0200, David Hildenbrand (Arm) wrote:
> On 8/4/26 02:17, Xin Zhao wrote:
> > A coredump typically takes seconds or even longer to complete. If we
> > happen to hold a write lock with flock just before triggering the
> > coredump, that write lock will not be released during the entire coredump
> > process. As a result, other processes attempting to acquire the same write
> > lock may experience significant delays. Another typical scenario is that
> > some custom management modules for shared memory also need to release the
> > reference counts of the related buffers as soon as possible, rather than
> > waiting until the coredump is complete.
> > 
> > Add a new bit(9) of coredump_filter to tag whether need to dump fd list.
> > We set it by default because tools like systemd-coredump go through the
> > fds. Some other coredump pipe programs like minicoredump do not use fds by
> > default. If you are sure that your coredump backend does not use the fds,
> > you can clear bit 9, which will allow some file resources without VMA
> > references to be released earlier.
> > 
> > In fput(), check FP_DUMPCORE task flags to NOT release file by task work,
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
> > If NOT set bit9 of subscriber coredump_filter, max hold_time is 19591ms.
> > If set bit9 of subscriber coredump_filter, max hold_time is 320ms.
> > 
> > Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
> > ---
> > 
> > Change in v6:
> > - Fix operator precedence in PF_KTHREAD/PF_DUMPCORE check.
> > 
> > Change in v5:
> > - Not add another bootargs for the feature,
> >   as suggested by Christian Brauner and Lorenzo Stoakes.
> >   Add bit9 of coredump_filter to tag whether need to dump fd list.
> >   Set bit9 to 1 as default.
> > - Al Viro, Christian Brauner and Lorenzo Stoakes point out so many
> >   problems of the code related to umap that was added in v4, delete all of
> >   it which is unnecessary. The management of reference counting for shared
> >   memory generally does not need to be released through the release
> >   operation of files that have VMA references. Traversing all the threads
> >   within the process and executing exit_files() is sufficient.
> > - Fulfill comments and commit log,
> >   as suggested by Pedro Falcato and Lorenzo Stoakes.
> > - Link to v5: https://lore.kernel.org/all/20260630075604.52533-1-jackzxcui1989@163.com/
> > 
> > Change in v4:
> > - Christian pointed out that the coredump process will traverse file
> >   descriptors (fd), so certain fds should not be closed by default.
> >   Rework the whole feature, add /proc/<pid>/coredump_pre_exit for user
> >   pre-exit resources selection, default is NOT pre-exit anything.
> > - Mateusz suggested that walking the fd table and release the file-lock is
> >   reasonable. No longer release all the fd(s). Based on user config, only
> >   the flock fd(s) and the fd(s) correspondent to file-backed shared memory
> >   will be released at most.
> > - Link to v4: https://lore.kernel.org/all/20260624145552.70143-1-jackzxcui1989@163.com/
> > 
> > Change in v3:
> > - Add comment and commit-log to explain why do the MMF_DUMP_MAPPED_SHARED
> >   mm_flags_test() check, note that memory mapped files keep their own
> >   separate references to the files. The case to work around is that early
> >   unlocking a flock on a file allows other processes to lock and modify
> >   the mapped data protected by the flock,
> >   as suggested by Pedro Falcato.
> > - Link to v3: https://lore.kernel.org/all/20260619122419.3954581-1-jackzxcui1989@163.com/
> > 
> > Change in v2:
> > - Get rid of the implement of adding new fcntl API, the issue does not
> >   worth inflicting the cost on everyone,
> >   as suggested by Al Viro.
> > - Call exit_files() in coredump_wait(),
> >   as suggested by Eric W. Biederman.
> >   Add MMF_DUMP_MAPPED_SHARED mm_flags_test() check to filter cases that
> >   need to dump file-backed shared memory.
> > - Link to v2: https://lore.kernel.org/lkml/20260618150301.3226517-1-jackzxcui1989@163.com/
> > 
> > v1:
> > - Link to v1: https://lore.kernel.org/all/20260618030700.2511668-1-jackzxcui1989@163.com/
> > ---
> >  Documentation/filesystems/proc.rst | 14 ++++++++++++--
> >  fs/coredump.c                      | 21 +++++++++++++++++++++
> >  fs/file_table.c                    |  7 ++++++-
> >  include/linux/mm_types.h           |  6 ++++--
> >  4 files changed, 43 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> > index db6167bef..d590a1dda 100644
> > --- a/Documentation/filesystems/proc.rst
> > +++ b/Documentation/filesystems/proc.rst
> > @@ -1939,6 +1939,7 @@ The following 9 memory types are supported:
> >    - (bit 6) hugetlb shared memory
> >    - (bit 7) DAX private memory
> >    - (bit 8) DAX shared memory
> > +  - (bit 9) fd list
> 
> "The following 9 memory types are supported: ... fd list"

Fwiw, I still refuse this patch for the reasons I mentioned in the
various other postings of this...
