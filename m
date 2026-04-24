Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1341A316E
	for <linux-arch@vger.kernel.org>; Fri, 24 Apr 2026 00:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776990213; cv=none; b=ctYwNVKRWGjbmQXs/KR8ewd6jLGLPAp9afhG/+nj8HU9fJEpprfCthFLqN+LYd7NHZX+1rT6y25caLzHQ2pDgtpeJOKfUiKL+vhWyEXLBXDcfkpisb47Aft/rhj8nABL32Fp63Md/AhlybcaGo6V1MYYPM10oKYX/kRckPvI6k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776990213; c=relaxed/simple;
	bh=vO7pS2Bwmwp3RX6JlgAxL78nLvFDd5cJbYZAKhWnjmE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KWPy+qNGT/lZiFWh7o4sr4kOWO5+EH6sA7yKSBfABkL9hlxdODwq9HpQ+FeNGGNQjb0vL1Iyl8ebui7cwB3BmOSVL+guqczTFBR/oyzJqNd11PJJ6zImbi9eDGkhJRkyLzisYDs79f2PHAxml7fbKPnHmW+h3BnCT89NzMYQWlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-42393e9b4aeso6704499fac.0
        for <linux-arch@vger.kernel.org>; Thu, 23 Apr 2026 17:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776990211; x=1777595011;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=toPj91gHoyvrb/6k9QW3xQFCS5cPHJVPPzwARqoevbM=;
        b=PnNPDREbrkgXOQW+6XeGGXeqlfLX+3/5KZdfjpxs7Sg/aA50iwtNmcCuixMbiH9les
         xP0/pGf1JrOfLLcomX45bNFSQOO6AEoM4tTO4rql+LFQcQ8GTjZAzQ2+U9MDl8EpLRDL
         /gnxv69Z1rZt9dVKcXZBN7iHYUgC6V9Ho8TZ5wlgfdTVbWnP80woi3eT1oiM35yDuWaV
         ix+HNWHj0aqHo2YW4xMvwdUTMBGu5tsnoL2RtJBC5is2xxD54I67t5JqgA6A9xMnHlGu
         252B5XBqudQmpt/vg+ROpFpfwwM74wchyMN32G2+fj3adJFQtaiyzEjTbpJL+Yb0FCH/
         nB+w==
X-Forwarded-Encrypted: i=1; AFNElJ8jx9YwLniewb+iH/M27XM712tpM5ncK+uGEwNgU7+i0sEkBY8Reh5Wf5AkOrGCvviXMIsw8UyFcRtK@vger.kernel.org
X-Gm-Message-State: AOJu0YwTOkcQfZiNzHp5rP5021fl+7rbUcvuAopJDTztTCU2b3F6cOrf
	JfFYKIDXzyrbrEuDLJzrCmdMzYGdZm0F6raDhYjG8nO7z6iQMdJGAhxTnj0Xug31NNRz6LEph7B
	2lbK1j+0T9G8vqCS57YmV9CwkGd4OTjB9TqkWomFaraoZSh7TibGUzYd2sIM=
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:e84a:0:b0:692:a19b:af6b with SMTP id
 006d021491bc7-69462e57b48mr15598213eaf.13.1776990211136; Thu, 23 Apr 2026
 17:23:31 -0700 (PDT)
Date: Thu, 23 Apr 2026 17:23:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69eab803.a00a0220.17a17.004a.GAE@google.com>
Subject: [syzbot] [arch?] [mm?] BUG: sleeping function called from invalid
 context in tlb_flush_mmu
From: syzbot <syzbot+98bfe400bc653d89958c@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, aneesh.kumar@kernel.org, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	npiggin@gmail.com, peterz@infradead.org, syzkaller-bugs@googlegroups.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    70c8a7ec6715 Add linux-next specific files for 20260422
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1586ae6a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d941ac7f11ceb230
dashboard link: https://syzkaller.appspot.com/bug?extid=98bfe400bc653d89958c
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a920efda9ff7/disk-70c8a7ec.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7d7626f0c3dc/vmlinux-70c8a7ec.xz
kernel image: https://storage.googleapis.com/syzbot-assets/261effff1138/bzImage-70c8a7ec.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+98bfe400bc653d89958c@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at mm/mmu_gather.c:142
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 5808, name: udevd
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
2 locks held by udevd/5808:
 #0: ffff8880387090b0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock include/linux/mmap_lock.h:536 [inline]
 #0: ffff8880387090b0 (&mm->mmap_lock){++++}-{4:4}, at: exit_mmap+0x2c2/0x9e0 mm/mmap.c:1308
 #1: ffffffff8dfc81c0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #1: ffffffff8dfc81c0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #1: ffffffff8dfc81c0 (rcu_read_lock){....}-{1:3}, at: folio_lruvec_lock_irqsave+0x24/0x540 mm/memcontrol.c:1452
CPU: 0 UID: 0 PID: 5808 Comm: udevd Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 __might_resched+0x329/0x480 kernel/sched/core.c:9162
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:142 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:151 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:417 [inline]
 tlb_flush_mmu+0x6f2/0xa30 mm/mmu_gather.c:424
 tlb_finish_mmu+0xf9/0x230 mm/mmu_gather.c:549
 exit_mmap+0x498/0x9e0 mm/mmap.c:1313
 __mmput+0xcb/0x3e0 kernel/fork.c:1178
 exit_mm+0x18e/0x250 kernel/exit.c:581
 do_exit+0x6a2/0x22c0 kernel/exit.c:963
 do_group_exit+0x21b/0x2d0 kernel/exit.c:1117
 __do_sys_exit_group kernel/exit.c:1128 [inline]
 __se_sys_exit_group kernel/exit.c:1126 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1126
 x64_sys_call+0x221a/0x2240 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f62bcd8c6c5
Code: Unable to access opcode bytes at 0x7f62bcd8c69b.
RSP: 002b:00007fff29267f78 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 000055dbfa9391d0 RCX: 00007f62bcd8c6c5
RDX: 00000000000000e7 RSI: fffffffffffffe68 RDI: 0000000000000000
RBP: 000055dbfa6da910 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff29267fc0 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

=============================
[ BUG: Invalid wait context ]
syzkaller #0 Tainted: G        W          
-----------------------------
udevd/5808 is trying to lock:
ffff8880406438b8 (&sb->s_type->i_mutex_key#13){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:1029 [inline]
ffff8880406438b8 (&sb->s_type->i_mutex_key#13){+.+.}-{4:4}, at: __sock_release+0x89/0x250 net/socket.c:725
other info that might help us debug this:
context-{5:5}
1 lock held by udevd/5808:
 #0: ffffffff8dfc81c0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #0: ffffffff8dfc81c0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff8dfc81c0 (rcu_read_lock){....}-{1:3}, at: folio_lruvec_lock_irqsave+0x24/0x540 mm/memcontrol.c:1452
stack backtrace:
CPU: 0 UID: 0 PID: 5808 Comm: udevd Tainted: G        W           syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4832 [inline]
 check_wait_context kernel/locking/lockdep.c:4904 [inline]
 __lock_acquire+0xec1/0x2cf0 kernel/locking/lockdep.c:5189
 lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5870
 down_write+0x3a/0x50 kernel/locking/rwsem.c:1625
 inode_lock include/linux/fs.h:1029 [inline]
 __sock_release+0x89/0x250 net/socket.c:725
 sock_close+0x1c/0x30 net/socket.c:1529
 __fput+0x461/0xa70 fs/file_table.c:510
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x70f/0x22c0 kernel/exit.c:975
 do_group_exit+0x21b/0x2d0 kernel/exit.c:1117
 __do_sys_exit_group kernel/exit.c:1128 [inline]
 __se_sys_exit_group kernel/exit.c:1126 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1126
 x64_sys_call+0x221a/0x2240 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f62bcd8c6c5
Code: Unable to access opcode bytes at 0x7f62bcd8c69b.
RSP: 002b:00007fff29267f78 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 000055dbfa9391d0 RCX: 00007f62bcd8c6c5
RDX: 00000000000000e7 RSI: fffffffffffffe68 RDI: 0000000000000000
RBP: 000055dbfa6da910 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff29267fc0 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
