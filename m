Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A97F3A0E9A
	for <linux-arch@vger.kernel.org>; Thu, 30 Apr 2026 07:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777533697; cv=none; b=R7B2FAB4FiPnlhNP/AZpmmLM0K3Ub2X683d+tC5/d5H/KNjawVHtRDB+ozwGF2YV/NuN6+MRiTc8OPgOpAvlGA+EXv3/9hBLRB/4hAJj6yAEdIfaNCxwrJh9B7YvvkOwopaiGJi+t9D8QK3JnNP/1vk+xB9qMH3VfiqPT998yw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777533697; c=relaxed/simple;
	bh=4VusnHywV4bam18X0a5tat1IWW5qj0QueYZRqogCnwA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rMNCSwBnFqTQvCxOqKRIASiNTU+bvKOlwhrkAvBT55jHxQsQ0kS4l+q+ZU+garD6QghHJR0aa/9ETJWy0HNlhbN7UrVXzfbtBEJYpK2vuTRs2Dg9vHtgKTzBIQm0TodkAWfKkBjkDE/IH1XM7aKcPrHPAqc1wWc2kE2XAWSh6Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-7dcd7302f00so575081a34.0
        for <linux-arch@vger.kernel.org>; Thu, 30 Apr 2026 00:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777533695; x=1778138495;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tj5be/vz078Ksw2i/CCD9yJb0B5aXAIaoedvEJnz1N4=;
        b=ZdGauF35N5KeIJNqVF9pJRh8ww2sL6FJ2xck4cAzir5cpwqgApxjIVhz1zF0uTMfC2
         SwBVA9BN7N7kjSA6DHARnkwToR/e/hNcH+kA0dNTXuSM+mO8r11tJu+urgJvTlryduwW
         WYDYC+bC8/0fr5D/tabvDQTY+KSoRTNi1CvupNRmWRQj3Tsky8TxBiLjBQZjxq3PcVcj
         nYdqVrqa4ZVEXPStECFp2nI8ZKMhAnr3iaqI+Vm9coHUK/IS2I5TlXc2uEhddsrrYxw+
         CNFG9rrc50OEm787ORbh21exaLxmp1L9extlPZSjbAvI4ojX9fB/Jf/AgZuMhUQ1mJ2X
         7jdw==
X-Forwarded-Encrypted: i=1; AFNElJ+5oQs1P3Oho4D8j0Z7yuHVWEwCYSgvZXshL2bjv/SJFWmxlst8EzrWCSzq4/h7fREw2S35foeJMHNb@vger.kernel.org
X-Gm-Message-State: AOJu0YxYIqPTIuU4/1F5XS3X1cSt4TRChNbFiL8h+hk5jSZryN+nQrf/
	SGVUw6QWHisdl1z8LNAI+ytgkZUAjBIXWUv7F5sgYmVFau1LfxwDLMbF3CkCY41WvdehSvVfnEu
	clqtAlkDgrY5ILtGsVH3X1nJ7rfcXXFkxEDokmBeKaDCr7LsJ3tTVNPDUuPE=
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:99a:b0:695:66d5:6a72 with SMTP id
 006d021491bc7-6967a6254cbmr761567eaf.50.1777533695038; Thu, 30 Apr 2026
 00:21:35 -0700 (PDT)
Date: Thu, 30 Apr 2026 00:21:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69f302ff.170a0220.3c4978.0016.GAE@google.com>
Subject: [syzbot] [mm?] [arch?] BUG: sleeping function called from invalid
 context in __tlb_batch_free_encoded_pages
From: syzbot <syzbot+a169a27b0538ba43e5d3@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, aneesh.kumar@kernel.org, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	npiggin@gmail.com, peterz@infradead.org, syzkaller-bugs@googlegroups.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    dca922e019dd Merge tag 'xsa48x-7.1-tag' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11cd6b6c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59da38148f3a3d24
dashboard link: https://syzkaller.appspot.com/bug?extid=a169a27b0538ba43e5d3
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-dca922e0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7b447b1b93a9/vmlinux-dca922e0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/af7830f5dabf/bzImage-dca922e0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a169a27b0538ba43e5d3@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at mm/mmu_gather.c:142
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 5677, name: rm
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
2 locks held by rm/5677:
 #0: ffff888022c20338 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock include/linux/mmap_lock.h:536 [inline]
 #0: ffff888022c20338 (&mm->mmap_lock){++++}-{4:4}, at: exit_mmap+0x22c/0xa10 mm/mmap.c:1308
 #1: ffffffff8e7e54e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire.constprop.0+0x7/0x30 include/linux/rcupdate.h:300
CPU: 1 UID: 0 PID: 5677 Comm: rm Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 __might_resched.cold+0x1ec/0x232 kernel/sched/core.c:9162
 __tlb_batch_free_encoded_pages+0x11e/0x280 mm/mmu_gather.c:142
 tlb_batch_pages_flush mm/mmu_gather.c:151 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:417 [inline]
 tlb_flush_mmu mm/mmu_gather.c:424 [inline]
 tlb_finish_mmu+0x1b0/0x810 mm/mmu_gather.c:549
 exit_mmap+0x454/0xa10 mm/mmap.c:1313
 __mmput+0x12a/0x410 kernel/fork.c:1178
 mmput+0x67/0x80 kernel/fork.c:1201
 exit_mm kernel/exit.c:581 [inline]
 do_exit+0x833/0x2a60 kernel/exit.c:963
 do_group_exit+0xd5/0x2a0 kernel/exit.c:1117
 __do_sys_exit_group kernel/exit.c:1128 [inline]
 __se_sys_exit_group kernel/exit.c:1126 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1126
 x64_sys_call+0x102c/0x1530 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x10b/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9fc102d6c5
Code: Unable to access opcode bytes at 0x7f9fc102d69b.
RSP: 002b:00007ffd51104bf8 EFLAGS: 00000202 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f9fc112efe8 RCX: 00007f9fc102d6c5
RDX: 00000000000000e7 RSI: ffffffffffffff88 RDI: 0000000000000000
RBP: 0000000000000001 R08: 00007ffd51104b88 R09: 0000000000000000
R10: 00007ffd51104a20 R11: 0000000000000202 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f9fc112d680 R15: 00007f9fc112f000
 </TASK>

====================================
WARNING: rm/5677 still has locks held!
syzkaller #0 Tainted: G        W          
------------------------------------
1 lock held by rm/5677:
 #0: ffffffff8e7e54e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire.constprop.0+0x7/0x30 include/linux/rcupdate.h:300

stack backtrace:
CPU: 1 UID: 0 PID: 5677 Comm: rm Tainted: G        W           syzkaller #0 PREEMPT(full) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_held_locks_bug kernel/locking/lockdep.c:6752 [inline]
 debug_check_no_locks_held+0x90/0xa0 kernel/locking/lockdep.c:6760
 do_exit+0x13ea/0x2a60 kernel/exit.c:997
 do_group_exit+0xd5/0x2a0 kernel/exit.c:1117
 __do_sys_exit_group kernel/exit.c:1128 [inline]
 __se_sys_exit_group kernel/exit.c:1126 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1126
 x64_sys_call+0x102c/0x1530 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x10b/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9fc102d6c5
Code: Unable to access opcode bytes at 0x7f9fc102d69b.
RSP: 002b:00007ffd51104bf8 EFLAGS: 00000202 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f9fc112efe8 RCX: 00007f9fc102d6c5
RDX: 00000000000000e7 RSI: ffffffffffffff88 RDI: 0000000000000000
RBP: 0000000000000001 R08: 00007ffd51104b88 R09: 0000000000000000
R10: 00007ffd51104a20 R11: 0000000000000202 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f9fc112d680 R15: 00007f9fc112f000
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
