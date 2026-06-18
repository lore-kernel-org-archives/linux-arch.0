Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EAE33439A
	for <linux-arch@vger.kernel.org>; Thu, 18 Jun 2026 06:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781764804; cv=none; b=mBvnpJkQtppZZxd45D0IRvoTSZQcx8fRpJKfPcbvE8lqJS4IF20nUg7i/JtvpiCIWsBex7tsCJavj6DSUi9B7kgxE8TZzBMZ6OB5hqePVsmWMa6PqOT5739lDeoRJkE/Wyhk5D8aAR9ccS0ojJabWP5IQFOJaVaonwfNFP/AB10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781764804; c=relaxed/simple;
	bh=jhEqjZKx88pIBpeKmrv1Sas4UoMrgqFVYBMP0Df5Ubo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=smuRNwelT8s+ffoA/29UEH191hSM9YR3Dxgj3MlWc8JzfEwlMRUZVJ4JU7ngR9agq/7mvyxQcb5dougHUGwVlk6VbGqhNKJBxXdjvnHyXDXseEW3XiKZ+HoR5YGC3IiUWO056xiWl11skTYhh2+iy4nVE8rUNb5N/Iw6fou+u78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-48952d1c293so1263088b6e.3
        for <linux-arch@vger.kernel.org>; Wed, 17 Jun 2026 23:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781764802; x=1782369602;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hz071LhqoCdVzTS1WyTwcmYkHUJfSiLehw55eYvJ1/U=;
        b=pl5hoy6eeRXlb7hDBu5RGV+ttgg408mmpDSCFW5feZ/t3T3W83nZuAWqa7DZKboAIL
         KdePnyBfzMelTEhUwZJOqThuwIaHCmfMNyS6q1rOHz+yJkV/+dk12uWQxbjQWJMvlCIi
         B6NZGOELp1TilMbLPd+r34lwATASJXcrqBjmy+QzmwnPQkanYEa8j518F2qeewPBXu1Z
         Yxj9UqWu9CxzbY0pHsF8QjoRRePAToo94WDprCYEEwLvO2YI4l90bXMEgvW1TR9P7pc9
         2NjkyR/8AzRInzIZsccAT+RrkLOMp3arGO4HkQfQszW078yZEN56t4sL1nruc01lPwW+
         QviQ==
X-Forwarded-Encrypted: i=1; AFNElJ/WqjQwwDGIve2xMNdJKfpD+jlWlT2s9Dq2lL8fHNdHyASddKI7AA1Enue9Cwo2owu0QlMLVJ1wsAmH@vger.kernel.org
X-Gm-Message-State: AOJu0YzPo0Zp0ZPhc9oByh+ydWTrqGS6+C/OiCRyoQufp0wLXbbzUffL
	i2cBKlVt9STml+5WQTgr0YDzqjCX+y1C0fPanmSqQJDVBhoduzseLV9JQHOuyV0AJssu2arZm6b
	c8Thl5UESQ09hHQ3P6HD8xCV+R66wgiejjkYSNledM+kYSEoVsWNmzYxNV88=
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4fcc:b0:489:443d:a8ec with SMTP id
 5614622812f47-4895d312ba2mr993414b6e.39.1781764801759; Wed, 17 Jun 2026
 23:40:01 -0700 (PDT)
Date: Wed, 17 Jun 2026 23:40:01 -0700
In-Reply-To: <20260618030700.2511668-1-jackzxcui1989@163.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a3392c1.8c9cf54e.2a1067.001c.GAE@google.com>
Subject: [syzbot ci] Re: coredump/fcntl: Add FD_CLOBCOR flag to close fd
 before dumping core
From: syzbot ci <syzbot+ci70676f29c0f1964b@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, allen.lkml@gmail.com, arnd@arndb.de, 
	brauner@kernel.org, chuck.lever@oracle.com, ebiederm@xmission.com, 
	j.granados@samsung.com, jack@suse.cz, jackzxcui1989@163.com, 
	jlayton@kernel.org, keescook@chromium.org, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mcgrof@kernel.org, viro@zeniv.linux.org.uk
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] coredump/fcntl: Add FD_CLOBCOR flag to close fd before dumping core
https://lore.kernel.org/all/20260618030700.2511668-1-jackzxcui1989@163.com
* [PATCH] coredump/fcntl: Add FD_CLOBCOR flag to close fd before dumping core

and found the following issue:
WARNING: suspicious RCU usage in exit_files_before_core

Full report is available here:
https://ci.syzbot.org/series/bda032a0-64d8-4226-8ad1-6a4c99514d61

***

WARNING: suspicious RCU usage in exit_files_before_core

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      2a706d98d50a28dd635b3d028531d839c1f5f19a
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/e0dd4cce-02a0-415c-9720-8816ca17346d/config

=============================
WARNING: suspicious RCU usage
syzkaller #0 Not tainted
-----------------------------
./include/linux/fdtable.h:104 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
no locks held by syz.2.65/5687.

stack backtrace:
CPU: 0 UID: 0 PID: 5687 Comm: syz.2.65 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150
 lockdep_rcu_suspicious+0x13f/0x1d0
 exit_files_before_core+0x35a/0x410
 vfs_coredump+0xa52/0x4550
 get_signal+0x1107/0x1330
 arch_do_signal_or_restart+0xbc/0x830
 irqentry_exit+0x2a4/0x860
 asm_exc_page_fault+0x26/0x30
RIP: 0033:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 002b:0000200000000008 EFLAGS: 00010217
RAX: 0000000000000000 RBX: 00007f3125415fa0 RCX: 00007f312519ce59
RDX: 0000200000000000 RSI: 0000200000000000 RDI: 0000000000000000
RBP: 00007f3125232d6f R08: 0000200000000000 R09: 0000000000000000
R10: 0000200000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3125415fac R14: 00007f3125415fa0 R15: 00007f3125415fa0
 </TASK>


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
