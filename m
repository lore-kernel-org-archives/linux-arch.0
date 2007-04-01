Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pasmtpa.tele.dk ([80.160.77.114]:35672 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933629AbXDAQYU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 1 Apr 2007 12:24:20 -0400
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpA.tele.dk (Postfix) with ESMTP id 28C598009C1
	for <linux-arch@vger.kernel.org>; Sun,  1 Apr 2007 18:00:38 +0200 (CEST)
Date: Sun, 1 Apr 2007 18:01:23 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: missing syscalls
Message-ID: <20070401160123.GA9178@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

I have run the "missing syscalls" check for the cross compilers I
have available at the moment.

alpha: 38
arm: 8
mips: 3
sparc: 4
sparc64: 0
x86_64: 2
ia64: 10
i386: 0 (this is the reference anyway)

Result is pasted in below.

	Sam

============== alpha ================
  CALL    /home/sam/kernel/kbuild.git/scripts/checksyscalls.sh
<stdin>:128:2: warning: #warning syscall creat not implemented
<stdin>:148:2: warning: #warning syscall time not implemented
<stdin>:176:2: warning: #warning syscall getpid not implemented
<stdin>:192:2: warning: #warning syscall getuid not implemented
<stdin>:204:2: warning: #warning syscall alarm not implemented
<stdin>:212:2: warning: #warning syscall pause not implemented
<stdin>:216:2: warning: #warning syscall utime not implemented
<stdin>:284:2: warning: #warning syscall getgid not implemented
<stdin>:292:2: warning: #warning syscall geteuid not implemented
<stdin>:296:2: warning: #warning syscall getegid not implemented
<stdin>:352:2: warning: #warning syscall getppid not implemented
<stdin>:688:2: warning: #warning syscall fdatasync not implemented
<stdin>:1220:2: warning: #warning syscall kexec_load not implemented
<stdin>:1260:2: warning: #warning syscall migrate_pages not implemented
<stdin>:1264:2: warning: #warning syscall openat not implemented
<stdin>:1268:2: warning: #warning syscall mkdirat not implemented
<stdin>:1272:2: warning: #warning syscall mknodat not implemented
<stdin>:1276:2: warning: #warning syscall fchownat not implemented
<stdin>:1280:2: warning: #warning syscall futimesat not implemented
<stdin>:1288:2: warning: #warning syscall unlinkat not implemented
<stdin>:1292:2: warning: #warning syscall renameat not implemented
<stdin>:1296:2: warning: #warning syscall linkat not implemented
<stdin>:1300:2: warning: #warning syscall symlinkat not implemented
<stdin>:1304:2: warning: #warning syscall readlinkat not implemented
<stdin>:1308:2: warning: #warning syscall fchmodat not implemented
<stdin>:1312:2: warning: #warning syscall faccessat not implemented
<stdin>:1316:2: warning: #warning syscall pselect6 not implemented
<stdin>:1320:2: warning: #warning syscall ppoll not implemented
<stdin>:1324:2: warning: #warning syscall unshare not implemented
<stdin>:1328:2: warning: #warning syscall set_robust_list not implemented
<stdin>:1332:2: warning: #warning syscall get_robust_list not implemented
<stdin>:1336:2: warning: #warning syscall splice not implemented
<stdin>:1340:2: warning: #warning syscall sync_file_range not implemented
<stdin>:1344:2: warning: #warning syscall tee not implemented
<stdin>:1348:2: warning: #warning syscall vmsplice not implemented
<stdin>:1352:2: warning: #warning syscall move_pages not implemented
<stdin>:1356:2: warning: #warning syscall getcpu not implemented
<stdin>:1360:2: warning: #warning syscall epoll_pwait not implemented

============== arm ================
  CALL    /home/sam/kernel/kbuild.git/scripts/checksyscalls.sh
<stdin>:1092:2: warning: #warning syscall fadvise64 not implemented
<stdin>:1176:2: warning: #warning syscall fadvise64_64 not implemented
<stdin>:1220:2: warning: #warning syscall kexec_load not implemented
<stdin>:1260:2: warning: #warning syscall migrate_pages not implemented
<stdin>:1316:2: warning: #warning syscall pselect6 not implemented
<stdin>:1320:2: warning: #warning syscall ppoll not implemented
<stdin>:1340:2: warning: #warning syscall sync_file_range not implemented
<stdin>:1360:2: warning: #warning syscall epoll_pwait not implemented

============== mips ================
  CALL    /home/sam/kernel/kbuild.git/scripts/checksyscalls.sh
<stdin>:424:2: warning: #warning syscall select not implemented
<stdin>:856:2: warning: #warning syscall vfork not implemented
<stdin>:1176:2: warning: #warning syscall fadvise64_64 not implemented

============== sparc ================
  CALL    /home/sam/kernel/kbuild.git/scripts/checksyscalls.sh
<stdin>:752:2: warning: #warning syscall setresuid not implemented
<stdin>:756:2: warning: #warning syscall getresuid not implemented
<stdin>:776:2: warning: #warning syscall setresgid not implemented
<stdin>:780:2: warning: #warning syscall getresgid not implemented

============== sparc64 ================
  CALL    /home/sam/kernel/kbuild.git/scripts/checksyscalls.sh

============== x86_64 ================
  CALL    /home/sam/kernel/kbuild.git/scripts/checksyscalls.sh
<stdin>:1356:2: warning: #warning syscall getcpu not implemented
<stdin>:1360:2: warning: #warning syscall epoll_pwait not implemented

============== ia64 ================
  CALL    /home/sam/kernel/kbuild.git/scripts/checksyscalls.sh
<stdin>:104:2: warning: #warning syscall fork not implemented
<stdin>:148:2: warning: #warning syscall time not implemented
<stdin>:204:2: warning: #warning syscall alarm not implemented
<stdin>:212:2: warning: #warning syscall pause not implemented
<stdin>:216:2: warning: #warning syscall utime not implemented
<stdin>:356:2: warning: #warning syscall getpgrp not implemented
<stdin>:856:2: warning: #warning syscall vfork not implemented
<stdin>:1316:2: warning: #warning syscall pselect6 not implemented
<stdin>:1320:2: warning: #warning syscall ppoll not implemented
<stdin>:1360:2: warning: #warning syscall epoll_pwait not implemented
