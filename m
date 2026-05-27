Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2FE2BEC5F;
	Wed, 27 May 2026 12:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883511; cv=none; b=fr5lXvr0GtJE7VE2qQ0/IMtLLl6kqBI001A+d08nCgrgMDaOeLuS5krWTEnA1PYu/bIHH8WPBuTCZXLaAxjwS5nS2qN2LlG6caaWJWgz64QrGKdwLXXXk+IM/YyUa2DUX+gu4sO/NOkSqKlGGQmVgFWZ/AXZnDdtC+SORwPRjC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883511; c=relaxed/simple;
	bh=G8y29eByo9Vd74elGBiAptyOBSNFkxSYcTOOZanUKqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AS/RtNksKZ2eE3orHgKlxhbaxmoGztPLqXogetrNOeR7r6ZIJ4n0EX8AphtSo/y+Dhm6oz34twzN98PEF0VGm9fSgrlegTMA/pP58fzdRntMVu6ba2v6glRiWsn0NBfluOCjhBC+auLRYRJWQQmrZ0SEzdSLxu5kfuJE2AaUlDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iV776Edg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iV776Edg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EDA1F00A3A;
	Wed, 27 May 2026 12:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779883509;
	bh=vb+nQUG5DZIwXW194zA/OGtxfBqg13OGT67u0JOBSdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iV776Edg8kbbFFPZFImy8PLyuTrEVAExqe/twlbP7u/sSmtJ3yVDDoHGAq7tBeHIt
	 4juj6R4QlA/kKD2lZGffm6rzicMp3nV7YbeVCKaF0UI2BKu69EzZR5yx33Baw7QYw6
	 yJEPO4w/ha3DQgeMnJ4+L0pQ/95r/Tuu77XzdOa+Hf83gV6QwSAiTDzecdFd5S6zD2
	 qGheJZsL6ikieRlQ43efmz641qVeEecyQUym61paQESzg1SNryVH4eoTvVwKFrsele
	 z749nZui7B5aqSQKpK5+ABaMdY3iTsG1oUT9iFMQgbP2Diw9qdJiGxCCP9lL3pjSJU
	 UPo55TRN57gHw==
Date: Wed, 27 May 2026 13:05:03 +0100
From: Will Deacon <will@kernel.org>
To: syzbot <syzbot+a169a27b0538ba43e5d3@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, aneesh.kumar@kernel.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, npiggin@gmail.com, peterz@infradead.org,
	syzkaller-bugs@googlegroups.com, david@kernel.org,
	qi.zheng@linux.dev
Subject: Re: [syzbot] [mm?] [arch?] BUG: sleeping function called from
 invalid context in __tlb_batch_free_encoded_pages
Message-ID: <ahbd7_KaUn45GK3v@willie-the-truck>
References: <69f302ff.170a0220.3c4978.0016.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69f302ff.170a0220.3c4978.0016.GAE@google.com>

I finally got a chance to look at this one...

On Thu, Apr 30, 2026 at 12:21:35AM -0700, syzbot wrote:
> syzbot found the following issue on:
> 
> HEAD commit:    dca922e019dd Merge tag 'xsa48x-7.1-tag' of git://git.kerne..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11cd6b6c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=59da38148f3a3d24
> dashboard link: https://syzkaller.appspot.com/bug?extid=a169a27b0538ba43e5d3
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-dca922e0.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7b447b1b93a9/vmlinux-dca922e0.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/af7830f5dabf/bzImage-dca922e0.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+a169a27b0538ba43e5d3@syzkaller.appspotmail.com
> 
> BUG: sleeping function called from invalid context at mm/mmu_gather.c:142
> in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 5677, name: rm
> preempt_count: 0, expected: 0
> RCU nest depth: 1, expected: 0
> 2 locks held by rm/5677:
>  #0: ffff888022c20338 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock include/linux/mmap_lock.h:536 [inline]
>  #0: ffff888022c20338 (&mm->mmap_lock){++++}-{4:4}, at: exit_mmap+0x22c/0xa10 mm/mmap.c:1308
>  #1: ffffffff8e7e54e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire.constprop.0+0x7/0x30 include/linux/rcupdate.h:300
> CPU: 1 UID: 0 PID: 5677 Comm: rm Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
>  __might_resched.cold+0x1ec/0x232 kernel/sched/core.c:9162
>  __tlb_batch_free_encoded_pages+0x11e/0x280 mm/mmu_gather.c:142
>  tlb_batch_pages_flush mm/mmu_gather.c:151 [inline]

... so we're getting deep in the gather code tearing down an mm, where
we free the unmapped pages but we're somehow inside an RCU read-side
critical section.

The last report on the sysbot dashboard is from 30th April, which
coincides with 99ebc509eef5 ("mm: memcontrol: fix rcu unbalance in
get_non_dying_memcg_end()") landing upstream. Unfortunately, there's no
reproducer available to test that concretely but it looks like we can
end up in there via the page freeing path. So hopefully this is fixed.

As an aside, it's a bit of a pity that the rcu_read_lock() callsite is
identified only as the useless rcu_lock_acquire.constprop.0() function
in this backtrace.

Will

>  tlb_flush_mmu_free mm/mmu_gather.c:417 [inline]
>  tlb_flush_mmu mm/mmu_gather.c:424 [inline]
>  tlb_finish_mmu+0x1b0/0x810 mm/mmu_gather.c:549
>  exit_mmap+0x454/0xa10 mm/mmap.c:1313
>  __mmput+0x12a/0x410 kernel/fork.c:1178
>  mmput+0x67/0x80 kernel/fork.c:1201
>  exit_mm kernel/exit.c:581 [inline]
>  do_exit+0x833/0x2a60 kernel/exit.c:963
>  do_group_exit+0xd5/0x2a0 kernel/exit.c:1117
>  __do_sys_exit_group kernel/exit.c:1128 [inline]
>  __se_sys_exit_group kernel/exit.c:1126 [inline]
>  __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1126
>  x64_sys_call+0x102c/0x1530 arch/x86/include/generated/asm/syscalls_64.h:232
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x10b/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f9fc102d6c5
> Code: Unable to access opcode bytes at 0x7f9fc102d69b.
> RSP: 002b:00007ffd51104bf8 EFLAGS: 00000202 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 00007f9fc112efe8 RCX: 00007f9fc102d6c5
> RDX: 00000000000000e7 RSI: ffffffffffffff88 RDI: 0000000000000000
> RBP: 0000000000000001 R08: 00007ffd51104b88 R09: 0000000000000000
> R10: 00007ffd51104a20 R11: 0000000000000202 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f9fc112d680 R15: 00007f9fc112f000
>  </TASK>
> 
> ====================================
> WARNING: rm/5677 still has locks held!
> syzkaller #0 Tainted: G        W          
> ------------------------------------
> 1 lock held by rm/5677:
>  #0: ffffffff8e7e54e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire.constprop.0+0x7/0x30 include/linux/rcupdate.h:300
> 
> stack backtrace:
> CPU: 1 UID: 0 PID: 5677 Comm: rm Tainted: G        W           syzkaller #0 PREEMPT(full) 
> Tainted: [W]=WARN
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
>  print_held_locks_bug kernel/locking/lockdep.c:6752 [inline]
>  debug_check_no_locks_held+0x90/0xa0 kernel/locking/lockdep.c:6760
>  do_exit+0x13ea/0x2a60 kernel/exit.c:997
>  do_group_exit+0xd5/0x2a0 kernel/exit.c:1117
>  __do_sys_exit_group kernel/exit.c:1128 [inline]
>  __se_sys_exit_group kernel/exit.c:1126 [inline]
>  __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1126
>  x64_sys_call+0x102c/0x1530 arch/x86/include/generated/asm/syscalls_64.h:232
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x10b/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f9fc102d6c5
> Code: Unable to access opcode bytes at 0x7f9fc102d69b.
> RSP: 002b:00007ffd51104bf8 EFLAGS: 00000202 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 00007f9fc112efe8 RCX: 00007f9fc102d6c5
> RDX: 00000000000000e7 RSI: ffffffffffffff88 RDI: 0000000000000000
> RBP: 0000000000000001 R08: 00007ffd51104b88 R09: 0000000000000000
> R10: 00007ffd51104a20 R11: 0000000000000202 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f9fc112d680 R15: 00007f9fc112f000
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
