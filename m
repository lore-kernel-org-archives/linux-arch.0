Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E189B2F9DA1
	for <linux-arch@vger.kernel.org>; Sat, 26 Sep 2026 03:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790395103; cv=none; b=sPbwqLQ1YcwUcCW6WRTTns61xcq4ROVBUfYWHi/T06l3tDtmDu2paMc9NXSjVx84EQRQOf/J1f5glgk8OdNuodx0+qoR0cRyxJC71PHOjYGSmlTxz+FWM8I/A5lJLd3Q+0A1XQ8a9VG/gK31O6OdsAuqVijTLIP/DZQiv7bmYTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790395103; c=relaxed/simple;
	bh=3T0fIXqcvXOZV/S7e3pt0pv9VnXxwiBuxeb/dP/F3bU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ci27ynmhdUxKIUWBr4OFxdLnx6fKigbsgpCzT47pX5aSTlX4yjXZ5hxxq0UP29LuRYRVvjMZQU7BisdcA2kV51rUI3OQa7v7kRXWby5ZMTNxviJ9jGVe69v5igaQBSSVwXrhk4W6bGvwANxf7/+ycMsGZEUdKaJ1354pWaWzZeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pb+9Dv/d; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pb+9Dv/d"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664ef791so853265eec.3
        for <linux-arch@vger.kernel.org>; Fri, 25 Sep 2026 20:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790395101; x=1790999901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=feSWp0FeA2kSuVMH2CMgZ8PGvP6pWP5LzQDclYVaTIQ=;
        b=pb+9Dv/dz1Zy86ezAMT2uUH5GWa9og67AGQjgAINdGFDgvMOSB30SoKdkRvoy6S6Ih
         B/b28wOuhUnBRrnmSZK1ZQmgBsiGTbf1s65PUCZ6Y8Y+TKDApfbwLvKqzg/bYWFRQuyg
         ezWE0kEUoXjvIDb+R9bciICm+zKKTBwx2T3s33fwaLH3giQCCzNC2eEfx/TRKqNidt2W
         U2TBQMfsENiWUTgPjru63ODjd7TcJBZaQqRA8KtkB+1hTxAJlcK+V81ZFd6RZCAQZKXd
         YwSQiO24bXMgVop+c+9KPiKKvBKS5HdSe2dSoB51cdGtY8SMkPGchbSm3JCJ0/1Jw8YU
         3lRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790395101; x=1790999901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=feSWp0FeA2kSuVMH2CMgZ8PGvP6pWP5LzQDclYVaTIQ=;
        b=lCQVp9v9v7dWgic32FEIr8yhmIGeSIXQ1aDOYJqdMyT8atLsgW+10NMdErvxOCyoFb
         JGk9mASuSSf1l0CLkDyfYlOVNbpnVD4lOuB8sfwXOevp58yRlIjDwaUkzhsYL9oN1U0y
         cR6Rkidh7hq84EPa0coPF0tAytLvkoZg7h/oApYJs2JxhaKPEAS0Q3UKTaeSLuzabHej
         CxZeDii8pi2Kj97ik4+tYLmvQ18zCnNM1v03o+8hLnGri/byRwiu7V/bmLYTeZwL45NZ
         5shRhNyPUGv6LuX48g4ABryUh/k2+Sllx+ZzKS5uEcvef5hp2PlgEPuLr7gOvIsiWNt3
         PCjg==
X-Forwarded-Encrypted: i=1; AKwUvBw6ICg2jALx3RQa+PsvgjIe98MRN0NJ5c5IuHSo6YD+uqHYggrmLpLjC+RQilMWp6OTgkV8YgkP8dw5@vger.kernel.org
X-Gm-Message-State: AFuF++nPFfKN4RUyqaREvWzIZWIa2pMpAzmSlZ6aAPoGyl5uAEQsKKHi
	r+1bfPFq1v6BHDcSJrcDt8R/GwqREccArY8swmOFhI64XMWjbmgr821l
X-Gm-Gg: AYBFou1CMnm9vMsYDj6qH4CEC4JN18uC56Ds1OY6u20ua3a09wXiLGVWCGmy2lrMnxz
	fojtd1DDJbo8eSoIiy1H1Zr9AHFF5dXXQWHHIvIKVkALsqR+VeJ5rhA/8/ijR6+CVw3rwk6FkTh
	K1FR1401Vh3SggGfx/+93cD+mdzQPwQjccf15Cni6dP7uHHaxjPFiN3goZsCuyEPLnL/1KylnHf
	iNdtuRSnbA3rbglE/KGHpAdEOGXGdv1RuFvkVMCbkXrG/pM3/oG6JjaEcpWL8o9StQt/ANYpHZQ
	uW/XPE+uXie2Jpvl4CSdMK9LmjNvh7Yoo/n4DCqauZKdyENDYvJ89COQI+AvUDGF125hIktTgeM
	STaJa28CUdwmZ4AGl1Kcvt+tq7ivRMqtndyjM2xPfJmORTqhHIQ+8Y8ESd66DHdirBMk/Rs/Qhb
	YRMbBncOJfnxaBAqa4kbarv3uXTcilUCQ235kDomp+GxxMz6W9IVoPBD0fQxgjtx6/5seSdk+O0
	zvwhlJvPLmbfQ==
X-Received: by 2002:a05:7301:1448:b0:342:6595:d750 with SMTP id 5a478bee46e88-342711aadcdmr1815588eec.2.1790395100853;
        Fri, 25 Sep 2026 20:58:20 -0700 (PDT)
Received: from Modern-15.. ([2401:4900:8206:fc0b:ca44:7562:7898:358b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-343539989casm364689eec.14.2026.09.25.20.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 20:58:20 -0700 (PDT)
From: mathura kumar <mathura.kumar.tech@gmail.com>
To: brauner@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	corbet@lwn.net,
	mathura.kumar.tech@gmail.com
Subject: [PATCH v5 0/4] Add two new system call mq_recvmmsg() and mq_sendmmsg() to posix ipc mqueue
Date: Sat, 26 Sep 2026 09:26:59 +0530
Message-ID: <20260926035705.307233-1-mathura.kumar.tech@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit



Patch series overview:

  1. Add New system call mq_recvmmsg(), mq_sendmmsg() and handler implementation.
  2. Add system call number in all most common architectures.
  3. Add entries in performance tools.
  4. Prepared Documentation and test.

  I am unware of some error code like ERESTARTSYS, it has special meaning and purpose
  I had just sent v4  couple of day ago but was not handling it correctly.
  
  now with lot of continous grind I corrected it and done some optimization


change since v4:

 - optimization is done regarding memory footprint for userspace caller
  by introducing two mode flag

 - error handling and error propogation is improved

 - documentation and test updated

 - v4 Link: https://lore.kernel.org/all/20260924153505.620772-1-mathura.kumar.tech@gmail.com/



mathura kumar (4):
  IPC: Added two new system call mq_recvmmsg() and  mq_sendmmsg()
  IPC: Added system call entry in all of most common  architectures
  IPC: Added system call entry in performance tool
  Test: Added self-testing and documentation

 Documentation/userspace-api/index.rst         |   2 +
 Documentation/userspace-api/mq_recvmmsg.rst   | 224 ++++++
 Documentation/userspace-api/mq_sendmmsg.rst   | 174 +++++
 arch/alpha/kernel/syscalls/syscall.tbl        |   2 +
 arch/arm/tools/syscall.tbl                    |   2 +
 arch/arm64/tools/syscall_32.tbl               |   3 +
 arch/m68k/kernel/syscalls/syscall.tbl         |   2 +
 arch/microblaze/kernel/syscalls/syscall.tbl   |   2 +
 arch/mips/kernel/syscalls/syscall_n32.tbl     |   2 +
 arch/mips/kernel/syscalls/syscall_n64.tbl     |   3 +
 arch/mips/kernel/syscalls/syscall_o32.tbl     |   2 +
 arch/parisc/kernel/syscalls/syscall.tbl       |   2 +
 arch/powerpc/kernel/syscalls/syscall.tbl      |   2 +
 arch/s390/kernel/syscalls/syscall.tbl         |   3 +
 arch/sh/kernel/syscalls/syscall.tbl           |   2 +
 arch/sparc/kernel/syscalls/syscall.tbl        |   3 +
 arch/x86/entry/syscalls/syscall_32.tbl        |   2 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   3 +-
 arch/xtensa/kernel/syscalls/syscall.tbl       |   2 +
 include/linux/compat.h                        |  12 +-
 include/linux/syscalls.h                      |   9 +
 include/uapi/asm-generic/unistd.h             |   9 +-
 include/uapi/linux/mqueue.h                   |  27 +-
 ipc/mqueue.c                                  | 664 +++++++++++++++++-
 ipc/msg.c                                     |   2 +-
 ipc/msgutil.c                                 |  45 +-
 ipc/util.h                                    |   3 +-
 kernel/sys_ni.c                               |   6 +
 scripts/syscall.tbl                           |   2 +
 tools/include/uapi/asm-generic/unistd.h       |   8 +-
 .../arch/alpha/entry/syscalls/syscall.tbl     |   4 +
 .../perf/arch/arm/entry/syscalls/syscall.tbl  |   3 +
 .../arch/arm64/entry/syscalls/syscall_32.tbl  |   3 +
 .../arch/mips/entry/syscalls/syscall_n64.tbl  |   2 +
 .../arch/parisc/entry/syscalls/syscall.tbl    |   3 +
 .../arch/powerpc/entry/syscalls/syscall.tbl   |   3 +
 .../perf/arch/s390/entry/syscalls/syscall.tbl |   2 +
 tools/perf/arch/sh/entry/syscalls/syscall.tbl |   2 +
 .../arch/sparc/entry/syscalls/syscall.tbl     |   2 +
 .../arch/x86/entry/syscalls/syscall_32.tbl    |   2 +
 .../arch/x86/entry/syscalls/syscall_64.tbl    |   2 +
 .../arch/xtensa/entry/syscalls/syscall.tbl    |   2 +
 tools/scripts/syscall.tbl                     |   2 +
 tools/testing/selftests/ipc/Makefile          |   2 +-
 tools/testing/selftests/ipc/mq_recvmmsg.c     | 393 +++++++++++
 tools/testing/selftests/ipc/mq_sendmmsg.c     | 360 ++++++++++
 46 files changed, 1945 insertions(+), 66 deletions(-)
 create mode 100644 Documentation/userspace-api/mq_recvmmsg.rst
 create mode 100644 Documentation/userspace-api/mq_sendmmsg.rst
 create mode 100644 tools/testing/selftests/ipc/mq_recvmmsg.c
 create mode 100644 tools/testing/selftests/ipc/mq_sendmmsg.c

-- 
2.43.0

