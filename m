Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036F5388368
	for <linux-arch@vger.kernel.org>; Sun,  3 May 2026 07:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777791823; cv=none; b=t62nJZp6/ZP6h563RyijmEDNp2YuGBHt5+gd/z5eNl2SBdMsOJIbsgLTVyyyz6klZSYbSzF37X9bsWamltJtw6emX/w9VKf4kJKVNDE9Yra8+DWm2/PMOl8y5k/N8nI40NaZvkRikynXxFXYjDjmLP+YyhP0OdnpcT3HP7Ek31g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777791823; c=relaxed/simple;
	bh=wGxz3rbUssja1ypzxi5nCGlSsj833kzvtSZIyIrvo60=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=bTfMEAQborJec+HfZFE2IDACbYXdu4RXoOCIcrOkwpyv9K9Jq9QPEl0O3Iz4Y3art/ntV5X82Wf9bb6fpU5+W2RxgPN6JRHtnzBvgb/zBfwLrWY6T22wFagslcGaeEqneJk2VGZId3Or2qsHzeGrdSn7WdARNTX8xfXSNkfWY3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7de4be150b9so7340211a34.1
        for <linux-arch@vger.kernel.org>; Sun, 03 May 2026 00:03:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777791818; x=1778396618;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LXRy6ZrZDA96i+zqKJ7WK1XTFNL01WADp6Dn55Yxdvs=;
        b=oyvBFkqCMTbncKEbbCGDCXm5ot/qfuCnL1NIht4KCffnh4GM1bOIbxjUzofaimErM/
         HXnTVM20FwWbX3PMpg9sZUp/8AW8/9mq2ldfZ0+gCTxyD09wwZ7bRrT/wTXDuGfz9VBF
         IvFnnnuVtPV19bK+OiLu0qKn94iPK5gIJzkYn3w6Rh09JlwVOk2Q29cUXZSVh8xlAB8r
         oUBBq/AsBJXp6JVQc2nifBg2nlgEGMtB4lidgkGkXvMgbXIt8RgQEaT4AfeObtN0a7O+
         YuuxyLuo2UOS0WEEHPA2MuT6Nzksh3sNRWuuNWz/beWqysnmDgR3vSxKj4PtJAb8+wqv
         ChWw==
X-Forwarded-Encrypted: i=1; AFNElJ+FBC/CfmXfpPsLqzQ31mzbMVKS0LGcNP8fp0TQTqeGE+QpLKhxMRKzuPe/RpP9kcJ+M4ZX/Pn9XHA/@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc2uRFhlmKjP4i7SDMfVTVM+RY8s7Road4fscqjcqflIbnS9XO
	+NVPLzNsq1h5wDd0k82ejm0AjoUbWT4xCBzpy8fAD8LnkEOAaxFsoN7GHxRqAcQMLuw/ympYVey
	whljT9u5wSpl+zGX2jgsiBMDFrsyut38j7MSWALVzch+V4HCz45yoTBg8jgU=
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1693:b0:694:9e10:fdce with SMTP id
 006d021491bc7-696979cf651mr2447276eaf.4.1777791817968; Sun, 03 May 2026
 00:03:37 -0700 (PDT)
Date: Sun, 03 May 2026 00:03:37 -0700
In-Reply-To: <20260501-thp_cow-v1-0-005377483738@tencent.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69f6f349.050a0220.312cd3.002b.GAE@google.com>
Subject: [syzbot ci] Re: mm: Support selecting doing direct COW for anonymous
 pmd entry
From: syzbot ci <syzbot+ci680a261c60429f2e@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, arnd@arndb.de, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, corbet@lwn.net, david@kernel.org, 
	dev.jain@arm.com, jannh@google.com, kasong@tencent.com, lance.yang@linux.dev, 
	liam@infradead.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org, 
	lukabai@tencent.com, lukafocus@icloud.com, mhocko@suse.com, npache@redhat.com, 
	rppt@kernel.org, ryan.roberts@arm.com, skhan@linuxfoundation.org, 
	surenb@google.com, vbabka@kernel.org, ziy@nvidia.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] mm: Support selecting doing direct COW for anonymous pmd entry
https://lore.kernel.org/all/20260501-thp_cow-v1-0-005377483738@tencent.com
* [PATCH 1/5] mm: add basic madvise helpers and branch for THP setup
* [PATCH 2/5] mm: add pmd level THP COW parameter in sysfs
* [PATCH 3/5] mm: add pmd level THP COW judgement helpers
* [PATCH 4/5] mm: enable map_anon_folio_pmd_nopf to handle unshare
* [PATCH 5/5] mm: support choosing to do THP COW for anonymous pmd entry.

and found the following issue:
general protection fault in __page_table_check_pmds_set

Full report is available here:
https://ci.syzbot.org/series/37e78e03-c08b-4de1-9b07-a21c64f4f462

***

general protection fault in __page_table_check_pmds_set

tree:      mm-new
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/akpm/mm.git
base:      41cd9e3d23b8fd9e6c3c0311e9cb0304442c6141
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/fcdd679f-29e8-43db-8792-d4fd97c62d91/config
syz repro: https://ci.syzbot.org/findings/87820d58-5d91-4c2e-b80b-5a75006e230d/syz_repro

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 UID: 0 PID: 5807 Comm: syz.1.18 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:__page_table_check_pmds_set+0x1d4/0x340 mm/page_table_check.c:240
Code: 00 00 4c 89 6c 24 08 4c 89 3c 24 4a 8d 2c fd f8 ff ff ff 31 db 49 bf 00 00 00 00 00 fc ff df 49 8d 3c 1e 48 89 f8 48 c1 e8 03 <42> 80 3c 38 00 74 05 e8 00 29 f4 ff 4d 8b 24 1e 45 89 e5 41 81 e5
RSP: 0018:ffffc90003c46ee0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff8881102a1d80 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000001 R09: 1ffff110242081d8
R10: dffffc0000000000 R11: ffffed10242081d9 R12: dffffc0000000000
R13: 0000000025c008e7 R14: 0000000000000000 R15: dffffc0000000000
FS:  00007fbef78216c0(0000) GS:ffff88818dc91000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32f63fff CR3: 000000002350a000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 page_table_check_pmds_set include/linux/page_table_check.h:92 [inline]
 set_pmd_at arch/x86/include/asm/pgtable.h:1209 [inline]
 map_anon_folio_pmd_nopf+0x452/0x480 mm/huge_memory.c:1449
 collapse_huge_page mm/khugepaged.c:1411 [inline]
 mthp_collapse mm/khugepaged.c:1530 [inline]
 collapse_scan_pmd mm/khugepaged.c:1773 [inline]
 collapse_single_pmd+0x4691/0x5540 mm/khugepaged.c:2786
 madvise_collapse+0x300/0x7a0 mm/khugepaged.c:3218
 madvise_vma_behavior+0x11b0/0x4210 mm/madvise.c:1383
 madvise_walk_vmas+0x573/0xae0 mm/madvise.c:1738
 madvise_do_behavior+0x386/0x540 mm/madvise.c:1954
 do_madvise+0x1fa/0x2e0 mm/madvise.c:2047
 __do_sys_madvise mm/madvise.c:2056 [inline]
 __se_sys_madvise mm/madvise.c:2054 [inline]
 __x64_sys_madvise+0xa6/0xc0 mm/madvise.c:2054
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbef699cdd9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbef7821028 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 00007fbef6c15fa0 RCX: 00007fbef699cdd9
RDX: 0000000000000019 RSI: 0000000000400000 RDI: 0000200000000000
RBP: 00007fbef6a32d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fbef6c16038 R14: 00007fbef6c15fa0 R15: 00007ffdddd640f8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__page_table_check_pmds_set+0x1d4/0x340 mm/page_table_check.c:240
Code: 00 00 4c 89 6c 24 08 4c 89 3c 24 4a 8d 2c fd f8 ff ff ff 31 db 49 bf 00 00 00 00 00 fc ff df 49 8d 3c 1e 48 89 f8 48 c1 e8 03 <42> 80 3c 38 00 74 05 e8 00 29 f4 ff 4d 8b 24 1e 45 89 e5 41 81 e5
RSP: 0018:ffffc90003c46ee0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff8881102a1d80 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000001 R09: 1ffff110242081d8
R10: dffffc0000000000 R11: ffffed10242081d9 R12: dffffc0000000000
R13: 0000000025c008e7 R14: 0000000000000000 R15: dffffc0000000000
FS:  00007fbef78216c0(0000) GS:ffff88818dc91000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32f63fff CR3: 000000002350a000 CR4: 00000000000006f0
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	4c 89 6c 24 08       	mov    %r13,0x8(%rsp)
   7:	4c 89 3c 24          	mov    %r15,(%rsp)
   b:	4a 8d 2c fd f8 ff ff 	lea    -0x8(,%r15,8),%rbp
  12:	ff
  13:	31 db                	xor    %ebx,%ebx
  15:	49 bf 00 00 00 00 00 	movabs $0xdffffc0000000000,%r15
  1c:	fc ff df
  1f:	49 8d 3c 1e          	lea    (%r14,%rbx,1),%rdi
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction
  2f:	74 05                	je     0x36
  31:	e8 00 29 f4 ff       	call   0xfff42936
  36:	4d 8b 24 1e          	mov    (%r14,%rbx,1),%r12
  3a:	45 89 e5             	mov    %r12d,%r13d
  3d:	41                   	rex.B
  3e:	81                   	.byte 0x81
  3f:	e5                   	.byte 0xe5


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a patch for this bug, please reply with `#syz test`
(should be on a separate line).

The patch should be attached to the email.
Note: arguments like custom git repos and branches are not supported.
