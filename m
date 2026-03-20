Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D91E2C11E4
	for <linux-arch@vger.kernel.org>; Fri, 20 Mar 2026 05:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773984259; cv=none; b=YGhUJhwsWt2zVz5VLp1MLl54wnzPkKVnCh1A2NhrpiNqL4cdr7f/lEDGUHqMnlebVgUw+0eeK865ei+SOlSHvJ0zTu51W22fwOXs9zhGbVaFXXw2NDaO49AOPAhYj8nKDNdeYy2E3Oc9p3/McTc/iG1w8USLOF3IicuGfsMkEGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773984259; c=relaxed/simple;
	bh=Ah4XhcWdq3LFfRD+iK/PMR58q9yX285hlNdGRu7M0sc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DzmFKd8biE/n9l2ecGgR3fBdHRGX9D9ZKoPPGxR9uIKgn+wc7Uk2GPQvzj7bv1jqumWHFkSJ3QlImpgTh83U6aiPlAmH+0oqn9G/FNXKJUHnolBU6vhUKKd2Y9ecmMMX9TC+4xOO0kUQYEg30nQN1nx7smucH0jjmklT8O/SuCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bg237aBR; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bg237aBR"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35a09e0dd63so327065a91.3
        for <linux-arch@vger.kernel.org>; Thu, 19 Mar 2026 22:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773984257; x=1774589057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nAjfJJMhGZqUIYBG61Zr1CD60OsC4X03KbvQMqZWBsg=;
        b=bg237aBRfcSYZq5xOhdkY0NWGlB+ItVyVIVadiD18A0enmKpwAlFKFBok0TQfel7Mg
         Yj26x2WxFpdB7PZmcw2mghK5hw7d5nMjPpqn0wL8K8L6zeFRUA4EDfPW85Y+zjHCkV7m
         V6YD1AZw3DWRMjhf8/QUCPdwXx4qks1XVJSoSsiUBHEnMm9fPYCaMf3lYu8aavk1sDSv
         5btJLfKMiqvNbD6uk3FEy3IrNLNI3p6qviwuFh/wHZHFlZnMLVYxlbjujec/G4SyQ8AU
         hI/s8dmzgLg9BK5n1Y2d4e9g02s0kNB6+STDTE4rxpTWhSiJo54JIvPjaTv0KWDuCKYh
         jtiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773984257; x=1774589057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAjfJJMhGZqUIYBG61Zr1CD60OsC4X03KbvQMqZWBsg=;
        b=dwVLxzugJSMLP4hS8+Ye/oiiFQeBgMuT5SFi+uVrUBjTqmeRsUWSL54T3j69lhjDM6
         b7vvZmuB4yuhTZAxOXvoP9/JHiYxTWHJr6ni6SpiLudhzLysHs26fKQ2dnZFQHv357jn
         GPXubLn0grkmJyUeJ3YwxwH3gQ+HC8LW5ufBvKZ+vApCXpRBiJvcaPYq7EThTQP1nXT5
         xP8Z5tNUTsg0WaB95RQYvUmYAU9gYYXy2IezWlY9FyQtWIsSZ4fNbpEffPmbm1XdjHwy
         0wJVD9GXfewmVhI4VrJYPH2cC9YlYnWrKd4sfjZcEr5DrY8EgTt+xG3kk5qrxL1AadDl
         a8qw==
X-Forwarded-Encrypted: i=1; AJvYcCUajDFEWEdWfj5pJK1hV0u1+UsuGXS9DPQ0Slaq1pSZIyysvIqLcpy2LRX2vjeGNdpdmmVKK83+axKi@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa6R1ZnCvyuR4R8wS5YJ0IBG737jfemebVi1WoYnp1Tb0lqvkP
	xJxho+XkHrYZOXF2sDO4rg1Hqzs3ns7XbazBQbZ0Xij9vgShcXsA20/g
X-Gm-Gg: ATEYQzwK/Jt0+5l5jdqDu8FluZIVA7NNB1q+eQJ16bjTut7wvf6KnJTaihVkyGu7c7u
	KJ02e+bXk8fySCYZiwnTvSiYfAm8gnfPhYxuuefhVFkiD8vUINbyZo/K7sKguIc3nePAO8rQow2
	cNDGbQRBaNJ61Y8jXTDnT9gaMzrTm64bS4uz4lgwNtGMYwtbqe32bLMaHKuFH1Uben7zpUs0qJN
	tzXRz8HvWdW9Z26y+bscfoeUJsDg+OBo8lDEcDxgXFjnQYHYRxHFHY7dk5sPsNYYs5OPXR65yUn
	Mf19rKCbqPtwcPqTplQbuRRiOMZAYUJO+vhKRzI4hY41S/RoLzYc/qtOM1vidAUB/4HBxdh4loT
	S7IQWiZveGrBJPNGHdE9tuhI59Mse8aEn/GtSX0rg4TSv4az2TQrxC1i/r34tzeyWHbg8xdAol0
	u1NF7s9UqdnAy8RKqxJZKC6xWakrPrVDUb4qo=
X-Received: by 2002:a17:90b:1e43:b0:35b:a8cf:7960 with SMTP id 98e67ed59e1d1-35bd2c2068bmr1447716a91.3.1773984257336;
        Thu, 19 Mar 2026 22:24:17 -0700 (PDT)
Received: from Modern-15.. ([2401:4900:b471:fd0e:76f1:2fa0:b416:4f73])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd40e4bfdsm779344a91.9.2026.03.19.22.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 22:24:17 -0700 (PDT)
From: Mathura_Kumar <academic1mathura@gmail.com>
To: brauner@kernel.org
Cc: academic1mathura@gmail.com,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: [PATCH RESEND v2 0/4] Add new system call for non-destructive peek and inspection to posix ipc mqueue
Date: Fri, 20 Mar 2026 10:53:34 +0530
Message-ID: <20260320052340.6696-1-academic1mathura@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Patch series overview:

  1. Add New system call do_mq_timedreceive2() and handler implementation
  2. Add system call number in all  most common arch.
  3. Prepared Documentation and test
  4. Add entry in performance tools all most common file

This is a fresh patch series starting from v1. It completely replaces 
the previous series (v1–v5) sent about a month ago, so please do not 
confuse it with the older thread.I preferred to start a new series instead of 
continuing the old one, as it had become messy and almost everything has been rewritten.
All feedback from the earlier series has been taken into account and incorporated here.



Short Description:

    POSIX message queues currently lack a mechanism to read
    a message without removing it from the queue. This is a
    long-standing limitation,when we require inspection of queue state
    without altering it.


    Design considerations:
    Two approaches for copying message data to userspace
    were evaluated:

    1) Refcount-based message lifecycle handling
       - This can help us  Avoids intermediate temp kernel copy
       - Extends message lifetime
       -But this may increase writer starvation under heavy load and
        add unnecessary complication on priority  management and
        delay more time to free space in inode due refcount may prevent

    2) Temporary kernel buffer copy
       - Copies message into a bounded kernel buffer
       - Reduces time message remains locked
       - Improves fairness under write-heavy workloads
       - Simpler lifetime management

    My implementation adopts the temporary buffer approach
    to minimize starvation and reduce locking complexity.
    The design allows future transition if refcounting is
    deemed preferable.

    Testing:
      - 17 functional test cases
      - Multi-threaded producer/consumer scenarios
      - concurrent pop and peek
      - Edge cases: empty queue, FIFO
        invalid flags, signal interruption etc.

Use Case:

1) Observability in distributed systems
 e.g Monitoring tools can inspect queue contents without interfering with
    normal processing

2) Check pointing system like CRIU can have a look into queue without consuming and can store messages

3) Resource-aware processing

4) Selective Consumption for Specialized Workers

change since v1:
 - minor update, header guard was removed from include/uapi/linux/mqueue.h 
 - v1 Link: https://lore.kernel.org/all/20260315040827.156558-1-academic1mathura@gmail.com/T/#t

note for 

  Thanks for reviewing.


 Documentation/userspace-api/index.rst         |   1 +
 Documentation/userspace-api/ipc.rst           | 222 +++++
 arch/alpha/kernel/syscalls/syscall.tbl        |   1 +
 arch/arm/tools/syscall.tbl                    |   1 +
 arch/arm64/tools/syscall_32.tbl               |   1 +
 arch/m68k/kernel/syscalls/syscall.tbl         |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl     |   1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl     |   1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl     |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl       |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl      |   1 +
 arch/s390/kernel/syscalls/syscall.tbl         |   1 +
 arch/sh/kernel/syscalls/syscall.tbl           |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
 arch/xtensa/kernel/syscalls/syscall.tbl       |   1 +
 include/linux/compat.h                        |   6 +-
 include/linux/syscalls.h                      |   6 +
 include/uapi/asm-generic/unistd.h             |   7 +-
 include/uapi/linux/mqueue.h                   |  14 +-
 ipc/mqueue.c                                  | 186 ++++-
 ipc/msg.c                                     |   2 +-
 ipc/msgutil.c                                 |  48 +-
 ipc/util.h                                    |   3 +-
 kernel/sys_ni.c                               |   1 +
 scripts/syscall.tbl                           |   1 +
 .../arch/alpha/entry/syscalls/syscall.tbl     |   1 +
 .../perf/arch/arm/entry/syscalls/syscall.tbl  |   1 +
 .../arch/arm64/entry/syscalls/syscall_32.tbl  |   1 +
 .../arch/mips/entry/syscalls/syscall_n64.tbl  |   1 +
 .../arch/parisc/entry/syscalls/syscall.tbl    |   1 +
 .../arch/powerpc/entry/syscalls/syscall.tbl   |   1 +
 .../perf/arch/s390/entry/syscalls/syscall.tbl |   1 +
 tools/perf/arch/sh/entry/syscalls/syscall.tbl |   1 +
 .../arch/sparc/entry/syscalls/syscall.tbl     |   1 +
 .../arch/x86/entry/syscalls/syscall_32.tbl    |   1 +
 .../arch/x86/entry/syscalls/syscall_64.tbl    |   1 +
 .../arch/xtensa/entry/syscalls/syscall.tbl    |   1 +
 tools/scripts/syscall.tbl                     |   1 +
 tools/testing/selftests/ipc/.gitignore        |   1 +
 tools/testing/selftests/ipc/Makefile          |   9 +-
 tools/testing/selftests/ipc/mq_peek.c         | 785 ++++++++++++++++++
 44 files changed, 1278 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/userspace-api/ipc.rst
 create mode 100644 tools/testing/selftests/ipc/mq_peek.c

-- 
2.43.0

