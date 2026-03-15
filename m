Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE1E361DA6
	for <linux-arch@vger.kernel.org>; Sun, 15 Mar 2026 21:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773611248; cv=none; b=sWQ1YLeSnfEgrsIvmUR+T5RVZWDHhxz6f0CtEHAcaSvL3tD0RsOJAT4LqRW/O9HC4OkHWkaUK7VdFLhjqLY2IJtx9gIEMLHGdZqdIO+DMHxo7qcfZ0aZ9HourYxoW/diB1MbjOOC1ycE0W7sSF94eiDTkm8rXojaUEGqtqUbNBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773611248; c=relaxed/simple;
	bh=L0ImKeUVRlFI64Fm4ckLOZoebK/E/m+VSIf6+ARhVAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ivcMCjtUMk0t0pbb2zx0o/Wixgeuj07rn5NkbEZHtsT6zdn1THsBz+7KBvIWCgY8pi+x/H5ARiyfSvVjG7egdY9Ubfmz/pLGinOUoHMcUbzlT/D09ufyGmqphqZjrQ4NSixsB6HO9Hdq4S7gN+NbimxJMCef9QwTU8JSFw8e3Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1iME8lx; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1iME8lx"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2aae4816912so25708945ad.2
        for <linux-arch@vger.kernel.org>; Sun, 15 Mar 2026 14:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773611246; x=1774216046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Boxo8YzEHVSn33T5tEdtnluF5VSfpOffudHMqq6cHc=;
        b=S1iME8lxezlEAtysKAOZD2UCgaM+ZqEGjzUG9cQUEINI2mo55M3YsNEMFFwYyNKzqf
         F5FwxQ6JvMz6p8cn9fhBwiRR3iAp3P7LSXcvNEjtinV0fdok4zThPgKGT01Rwmew0I94
         3n0SlYn0qL749lgR/wsQ+yTDsn6U6Uuk3rb9nPEpgbe3TEIIqs1giinMJ0rOSuAamq+I
         iHHvJZvftHq2dEp1d3cgD1b+UvNfERyQgSG4SRzQc/VlsouNT5wLDhky0VdvTUOqGY9t
         VPUiVoVyAgkgWLicUpHqeRFJGJg4KRaA/NwCulWncNsVsOFAfTjEvc+/OQiWfXtNKaFq
         BPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773611246; x=1774216046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Boxo8YzEHVSn33T5tEdtnluF5VSfpOffudHMqq6cHc=;
        b=HU5y1ttBYenXoqrOiHXhvJ8s4vXU3xlTAdaSH6DYM8s36L2cnNtI6Pkkodt+xfypOj
         2VeHRbuT99wHF0vneuAjk3h9jidG5u6FrTOVxmLOFV9wUJJHesZPDjSP+7oVk1njomD0
         yOPHgCC+WG4daOmlpKIaMiVA1178TCGPftfS/gyHB0XX3D7fc3YxL+2ikfm8WShstk1V
         HbHYurXEfbC67Mdr15ZlRBiqLi9xE26qQiJea8ZvFOHbG1IWffAWv9O0PJVwcmjUF0Lw
         6Pn2kc1wqL8MU0WZ1vn7Xs0CdJFR28avLY4+wWJa4WDrceVaSdvvSYhMYOkQCz4LXz0P
         mRSw==
X-Forwarded-Encrypted: i=1; AJvYcCWTNw5KBu2pUln7B7O0xcinB8Z4Lwd3sgPKdGWunvSEt8sNpKRkgywEwDthKno5MYx+bR+dhpdoEjDq@vger.kernel.org
X-Gm-Message-State: AOJu0YwVmHg+XsB6j0H5ot2KM1HnSAuBU5PWTVJO8PJMA6FKTz1ylH/I
	9ExF8UlYMjFywf0vxc5fVXt1CtSziyZBweFX62vTItZ3ANQdn5QJtDiY
X-Gm-Gg: ATEYQzwRGzlIkBkQoaqEGl5iyNdbou0S8DNnJhe4e4O5JvRu3Lz9pKJgwhcAFgX03mq
	OAVHF5jimjnSBV+gQdctaml06aWT+9HBW/btNFAWbqsI/bk/uQLuIxgCWNJsYP60OlLWLGo9VAq
	LLJGBrEjCrnGZvnuSWPtGIMrtq5crxcledBGy6++C1qFE9XdI1n6rPOfK3A3ShzjCYzZID5j9PM
	lmK0XwgGtO/JW4Rc50EqQFf8qAxy8TvRWMHqx4WkLbk1vPweyefAfopa4FaQPzZRyB7+3QLcACI
	jgSCO/W8DsDHv74Vzhn87kXIRZd2dV4ABtrWIu7Qvl59Ho5ImerPZH2TEkdFiNOoWEHkgPAAIlZ
	WmPaHDuUtvnSSpzxMmvpNa8MQNTG3QGojQOZJ4wvQsPaspgfJpCPXFUBNQLkGwr+hVlmmuquTep
	uKOm/biLFYm0r6BL14A6V9ShP7o8E3DWZevyE=
X-Received: by 2002:a17:903:18b:b0:2ae:804f:5640 with SMTP id d9443c01a7336-2aecac9c348mr110776595ad.51.1773611246321;
        Sun, 15 Mar 2026 14:47:26 -0700 (PDT)
Received: from Modern-15.. ([2401:4900:b4fc:c14c:ba99:ba0e:908b:8404])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b04f40f515sm34153085ad.74.2026.03.15.14.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 14:47:26 -0700 (PDT)
From: Mathura_Kumar <academic1mathura@gmail.com>
To: brauner@kernel.org
Cc: academic1mathura@gmail.com,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: [PATCH v2 0/4] Add new system call for non-destructive peek and inspection to posix ipc mqueue
Date: Mon, 16 Mar 2026 03:16:50 +0530
Message-ID: <20260315214656.658590-1-academic1mathura@gmail.com>
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

change since v1:
 - minor update, header guard was removed from include/uapi/linux/mqueue.h 
 - v1 Link: https://lore.kernel.org/all/20260315040827.156558-1-academic1mathura@gmail.com/T/#t

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

