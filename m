Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E49E394780;
	Mon, 29 Jun 2026 07:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782717139; cv=none; b=hpB2LnZxmswmO+Spa4J5KB7A5qNKNv8Jdwy7MMqtnOqrMoNHr1YBeOPNlNVZQVMP84QzVnCD9DGgBrgX96FSc6WabjSenm7nCMbxPmpNyH91aGgjYZZ/8FWpf0B1Wj8hZfxuOxB+f2JFsxlKSqxVZ+wXMeVrx9SfjV9/GYyG+V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782717139; c=relaxed/simple;
	bh=iIFLBAM/tIt0dQ5zz76F+VqqO3DXDSEYi0YBpjgPesI=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=lFs3+RDLtcsU8mkzKWXe4UCJU0BT3ySCzWi0Ek5cZ0IJsJG0gW6hMIEZlTm7eIKx0jXgbqe3RhMsJlWQD1NxxKnF7nmUpeBjrzS2ge5PJ9BYvENx5dmDjHGfldBy4HtNWLhjgcbgfQ5wXeu6yBI2z0zyH7WeM5xLP0rfVtRMa+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrYJJ0zh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrYJJ0zh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2920C1F000E9;
	Mon, 29 Jun 2026 07:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782717137;
	bh=RfYGT01dvLOEc8FqHgrZrGneidKm26R2Z1JVOqhWxrM=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=MrYJJ0zhU6cSrLl39RQigi+2QZvaFhOxbtu1yEA6hTyfVFpe/kYj8ZS00AXP7ptpn
	 Zs/rJ4Dk4D534ofnWSAGcbnEwLBN/KnvzIci93vQYjVXwfpFlx1AlhBW9Fl152Ded2
	 /d2CVFTAmvwi5kDgZUn7qhQmYO2wdcMIKJ4WVa+ZCyvoFeewkXIeIOzYKTxPYfM626
	 SjdOu9pZ7M9zKvR4x37LFNlLbmDD8YtYoeFwpksA/Z471kU6qCbYSB3sCDLkxfcAQi
	 JOMt77dEy2HlYYsyn4/PmvnAsM7jCjaWO0fNwc7DiAVI1I8URakcULdgc+Xyp2+ihr
	 o5UyVL2HDf0Jw==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4] coredump: Add /proc/<pid>/coredump_pre_exit for
 pre-exit before dumping
From: Christian Brauner <brauner@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>, 
 Christian Brauner <brauner@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, mjguzik@gmail.com, ebiederm@xmission.com, 
 viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org, 
 chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
 keescook@chromium.org, mcgrof@kernel.org, j.granados@samsung.com, 
 allen.lkml@gmail.com, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 Xin Zhao <jackzxcui1989@163.com>, linux-mm@kvack.org
In-Reply-To: <9a8e189a-39b4-4571-bdd5-400cf6443204@kernel.org>
References: <20260624145552.70143-1-jackzxcui1989@163.com>
 <20260625-wappnen-drohbrief-wermutstropfen-c53538f01547@brauner>
 <9105c433-44a7-4e8f-bacb-def93d11a7f2@kernel.org>
 <aj0Mr3e9yt0kU-Qj@pedro-suse>
 <9a8e189a-39b4-4571-bdd5-400cf6443204@kernel.org>
Date: Mon, 29 Jun 2026 09:11:33 +0200
Message-Id: <20260629-zunutze-wirkt-furor-e9ed5e4c31ee@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2891; i=brauner@kernel.org;
 h=from:subject:message-id; bh=iIFLBAM/tIt0dQ5zz76F+VqqO3DXDSEYi0YBpjgPesI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ5Se197O5/9JN18ZuQuB087FV2hsyBitO0r6+OvXRY1
 uRYwsnzHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNpn8HwV3pngYVt49uynd6p
 3+a2TZzmxvVtguLbMr6tfY9XBIX9bWX4n9C9UiVUPda/2qBRe06i9a2NodH7fbWCpnPt/WTjph3
 PAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-06-25 13:43 +0200, David Hildenbrand (Arm) wrote:
> On 6/25/26 13:18, Pedro Falcato wrote:
> > On Thu, Jun 25, 2026 at 12:57:02PM +0200, David Hildenbrand (Arm) wrote:
> >>>
> >>> This makes no sense. I think you really need to sit down and think about
> >>> a design for this that doesn't introduce state machinery for boot, mm,
> >>> and the VFS in one shot to solve a fringe problem...
> >>
> >> Staring at exit_mmap_mapped_shared(), ... this looks rather hacky ("let's fake
> >> munmap and set some magical flags").
> >>
> >> We're essentially saying "we don't want (pretty much) anything that's MAP_SHARED
> >> in the coredump". And for some reason someone should configure that, that's a
> >> rather weird toggle tbh.
> >>
> >> And the granularity ("file-backed shared memory") is completely odd.
> >>
> >>
> >> Aren't there other ways we could optimize this internally?
> >>
> >> Like, if we know that a process is dead and cannot run anymore, downgrade writes
> >> to reads (and make sure we block GUP write attempts accordingly), or would that
> >> also not be sufficient?
> >>
> >>
> >> Another thought:
> >>
> >> fs/coredump.c calls get_dump_page().
> >>
> >> get_dump_page() will not fault in any memory. So if a page is not in the page
> >> tables at the time of the dump, it will not get included in the coredump. Which
> >> means, that whether most non-anonymous memory will be included in a coredump is
> >> already like playing the lottery.
> >>
> >> This is true for MAP_SHARED file mappings and MAP_PRIVATE file mappings without
> >> private modifications.
> >>
> >> Which makes me wonder: How much is tooling relying on file-backed pages to end
> >> up in a coredump?
> > 
> > FWIW this mechanism already exists, see /proc/self/coredump_filter. The
> > default is bits 0, 1, 4 and 5 (see core(5)), which maps back to no file pages
> > being dumped to a core dump, apart from ELF headers (these help the debugger
> > trace back the mapped binary to the debug info using the buildid).
> > 
> > So the answer to this question is "approximately none" :)
> > 
> 
> Ah, thanks! vma_dump_size() honors this, and I am sure through some magical
> routing the information stored in m->dump_size will end up not dumping these pages.
> 
> Staring at elf_core_dump(), this "unmap some stuff" part is really, really
> nasty, as it effectively removes the VMAs->segments from the dump. (unless I am
> missing something important)

I would not mind if you would clean the mm portion of coredump up as I
think it's pretty ancient and - as you can see - rather questionable.

Fwiw, for the coredump socket I added a "userspace" mode a little while
ago where the kernel doesn't actually generate the coredump at all but
let's userspace do it. Android has the same model but uses signal
handler tricks (iirc) to do this.

