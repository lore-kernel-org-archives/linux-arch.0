From: syzbot <syzbot+dd9e89c646e1d8c05c62@syzkaller.appspotmail.com>
Subject: general protection fault in tlb_finish_mmu
Date: Tue, 17 Mar 2020 09:46:13 -0700
Message-ID: <0000000000007bf0e105a10facff@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io1-f71.google.com ([209.85.166.71]:45295 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgCQQqO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 17 Mar 2020 12:46:14 -0400
Received: by mail-io1-f71.google.com with SMTP id h76so8617101iof.12
        for <linux-arch@vger.kernel.org>; Tue, 17 Mar 2020 09:46:14 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, npiggin@gmail.com, peterz@infradead.org, syzkaller-bugs@googlegroups.com, will@kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    3cc6e2c5 Merge tag 'for-linus-5.6-2' of git://github.com/c..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16e3bb65e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c2e311dba9a02ba9
dashboard link: https://syzkaller.appspot.com/bug?extid=dd9e89c646e1d8c05c62
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+dd9e89c646e1d8c05c62@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xe0000a0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: probably user-memory-access in range [0x0000700000000000-0x0000700000000007]
CPU: 0 PID: 9753 Comm: syz-executor.2 Not tainted 5.6.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:tlb_batch_list_free mm/mmu_gather.c:60 [inline]
RIP: 0010:tlb_finish_mmu+0xd8/0x3c0 mm/mmu_gather.c:331
Code: 85 99 02 00 00 49 bd 00 00 00 00 00 fc ff df 49 8b 6c 24 30 48 85 ed 75 05 eb 2d 48 89 dd e8 8f 23 d0 ff 48 89 e8 48 c1 e8 03 <42> 80 3c 28 00 0f 85 4f 02 00 00 48 8b 5d 00 31 f6 48 89 ef e8 9f
RSP: 0018:ffffc900062efc30 EFLAGS: 00010206
RAX: 00000e0000000000 RBX: 0000700000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81a1f201 RDI: 0000000000000282
RBP: 0000700000000000 R08: ffff88804a694540 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffc900062efc80
R13: dffffc0000000000 R14: ffffc900062efc80 R15: ffff888045d94500
FS:  00000000020f0940(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdc866ef000 CR3: 00000000a916c000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 exit_mmap+0x2ca/0x510 mm/mmap.c:3128
 __mmput kernel/fork.c:1082 [inline]
 mmput+0x168/0x4b0 kernel/fork.c:1103
 exit_mm kernel/exit.c:485 [inline]
 do_exit+0xa51/0x2dd0 kernel/exit.c:788
 do_group_exit+0x125/0x340 kernel/exit.c:899
 __do_sys_exit_group kernel/exit.c:910 [inline]
 __se_sys_exit_group kernel/exit.c:908 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:908
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45c679
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:0000000000c7fae8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 000000000000000b RCX: 000000000045c679
RDX: 0000000000416151 RSI: 0000000000c870f0 RDI: 0000000000000000
RBP: 00000000004c2040 R08: 000000000000000c R09: 0000000000c7fbf0
R10: 00000000020f0940 R11: 0000000000000246 R12: 000000000076bfa0
R13: 0000000000000003 R14: 0000000000000001 R15: 000000000076bfac
Modules linked in:
---[ end trace cb94cd759cc2503d ]---
RIP: 0010:tlb_batch_list_free mm/mmu_gather.c:60 [inline]
RIP: 0010:tlb_finish_mmu+0xd8/0x3c0 mm/mmu_gather.c:331
Code: 85 99 02 00 00 49 bd 00 00 00 00 00 fc ff df 49 8b 6c 24 30 48 85 ed 75 05 eb 2d 48 89 dd e8 8f 23 d0 ff 48 89 e8 48 c1 e8 03 <42> 80 3c 28 00 0f 85 4f 02 00 00 48 8b 5d 00 31 f6 48 89 ef e8 9f
RSP: 0018:ffffc900062efc30 EFLAGS: 00010206
RAX: 00000e0000000000 RBX: 0000700000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81a1f201 RDI: 0000000000000282
RBP: 0000700000000000 R08: ffff88804a694540 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffc900062efc80
R13: dffffc0000000000 R14: ffffc900062efc80 R15: ffff888045d94500
FS:  00000000020f0940(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdc866ef000 CR3: 00000000a916c000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
