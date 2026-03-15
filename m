Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ACD224B1E
	for <linux-arch@vger.kernel.org>; Sun, 15 Mar 2026 04:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773547764; cv=none; b=ZoKher/Lj8JkhMjaCsBJbP9BB4YO+iJ3Z8ca/rWKFWaqo+BIFDj2aHrO1z/M/LVow+oaLRm8xk5RiAowomd0rhmd3NshUbpBoyRKPlBB0ki0RH4UmSIYkwPi4EDWBfKNEFqVb/O+uN1PjjNwGIVhIy5Ihrntkijypp6RVRyieDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773547764; c=relaxed/simple;
	bh=INKAE0GpPshGqlXYveQDAFAlGDjfbfIa112TnAVqrkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EDV+LgBYsv9X/kSQx4Hks9TzpP2rwZIlwZSNoNhbxUszzkBmK2l8XImwYPRREfrWXXzKnY+hm3Fc99wHgVSSMA0h292W2ItoWLntNHCDKXUCLVt31LfMHxPuMIByF5TWRZAs6KfSpPIcwau0Kk9hEjbKIyc71z9CCgoNQUBwhjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRMP9zxM; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRMP9zxM"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82a3d3235c9so79321b3a.2
        for <linux-arch@vger.kernel.org>; Sat, 14 Mar 2026 21:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773547762; x=1774152562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5r2zR4WWCFiXxARP5TrvCjNx825jrBhU1fBEzJevtCY=;
        b=LRMP9zxMKo9NlbWMv02usUwr73Vjwa3rwFrxNKpn7+Yvfxlz6ffTnOXA4o2JuMARx2
         /c4mr0DOQwwbh9Vvo0tABKrYdCvgz6aWAC+v9aW8tg9W8ODI4PuVEbYKAgicKF8Uqd1J
         /HIny7+q+0bhfX5qSVZ5dAspLDQhQvmWIDYJzJpWBa9o5W57pGJLSMgwLWJdBubHFVT6
         3dZDtbU5//g9JOpmp65utZpqw0h7BYjKmNq7Vucq4RpwOUOLL5o34wLIdGS6RLZkyG5J
         3NEditgME2Yw7S/fpU8cEQTYkfqqWUnoCDLO/P6xzmXYtW/nZSoVQqsHnt7uQtLEXyLs
         I53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773547762; x=1774152562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5r2zR4WWCFiXxARP5TrvCjNx825jrBhU1fBEzJevtCY=;
        b=FOxiIc04cFgtvtSFeiBDocV9UiIvsuZ1xmI796DylohZJ71Qgfque79UVyJwcwKJy8
         zBjvKPgNrJ/Msb6my39WWG8zXqai952SlUcTXbS+zOreRoHpsy/bXyh4GK3SWFh9hs2n
         16j+hOvEBENhNwKA+BHrAO+FF/nMANeN0kPoU1t42ECrXswDruX8QQzYCM1BtLTFItFO
         cHYNM4wvdjack/eGQbwsc5L184v3GHRZRHrri9uLVHJJ3sfgAt8QxpkZ5z4fNr5a9pfx
         foFDqX9L+9IqT4K5As0hpLKBA2i9EkmBUIiX+Te45lkNcb/0Di74dTDjYYwRlyQhunS/
         D+Dg==
X-Forwarded-Encrypted: i=1; AJvYcCWMOfWT+z305vwrDSHoZ399Ebtqd0Km5g1h9u/c1p5T4lSeeze2Cjj+JOjuSbm5xOImtbKwmFCLefjU@vger.kernel.org
X-Gm-Message-State: AOJu0YwD+MgC9lVs6/ox05NQMa3HMy+BUbQbu+MshQnewNJhvK/l+SkK
	Aqq0CBmLIMxo6lre8PhpLhgoNR3q4lhosanniDCibOeHLBXQ8hYQgUpt
X-Gm-Gg: ATEYQzx7/LWvydrf7PZu/QD1oD5ruKfSF+JlQuGKd1xt6x6lMfFZ06ZgNK9zjj8GZHS
	DcZQ+ogSeUBWqWjMsQMr37pdZHNkfq63Ij7tHRUJtnU1ukFIS0PaalxJfoYCHz0paNentDdEpEB
	Pzn/SZ73u5Mec/X8qQdtPSdFLZ2ZuQ+okjSGdn2ySeF8S224pz7e57l7+41v16AenClRNAtIUva
	0YWezdcamFrWa43tLI0vxLSgUFrWBJ/zUmSOiO925bxZrpUN4lFipFQWIFMYAoRQb3p32Q3MPcx
	WAu79v0Xi8rQnWTyrMOTryUle9LJkdg7TTilRMaMKyigcaHPC+FQH7znXF2C12LmRd+9FGpKho6
	CS3NS1uvfAiEbOQP/PdwKWzDgm/uXY42quRaioTsRYCp89HsFK54oXwb2k0y6Ovv+L1Hi9r+MS7
	Qabh/TsUTUQ8jNEJolsWXI+9aZ/DeymGkgtg==
X-Received: by 2002:a05:6a00:896:b0:829:7e6d:cf20 with SMTP id d2e1a72fcca58-82a19941b44mr8203865b3a.58.1773547761565;
        Sat, 14 Mar 2026 21:09:21 -0700 (PDT)
Received: from Modern-15.. ([2401:4900:b50e:ee5b:78d:f26b:704b:c464])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a072449fesm10192206b3a.13.2026.03.14.21.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 21:09:21 -0700 (PDT)
From: Mathura_Kumar <academic1mathura@gmail.com>
To: brauner@kernel.org
Cc: academic1mathura@gmail.com,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: [PATCH 0/4] Add new system call for non-destructive peek and inspection to posix ipc mqueue
Date: Sun, 15 Mar 2026 09:37:56 +0530
Message-ID: <20260315040827.156558-1-academic1mathura@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit



Patch series overview:

  1. Add New system call do_mq_timedreceive2() and handler implementation
  2. Add system call number in all  most common arch.
  3. Prepared Documentation and test
  4. Add entry in performance tools all most common file


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
 include/uapi/linux/mqueue.h                   |  18 +-
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
 44 files changed, 1282 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/userspace-api/ipc.rst
 create mode 100644 tools/testing/selftests/ipc/mq_peek.c

-- 
2.43.0

