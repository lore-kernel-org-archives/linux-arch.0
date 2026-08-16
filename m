Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7A83B9956
	for <linux-arch@vger.kernel.org>; Sun, 16 Aug 2026 15:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786894763; cv=none; b=U7SFC3mL/2TKMF+Gx6PVB83IPosd2L9i3CBQjQqCu25E1Tljqnt5ApweX1SwSpm2qXe1O4oUyYYzvsvXQVtjQZgFKCBXkYIQnSyJHBATUbUjakY2685VoJrj+Mhb6gnSG99EVE3HFgDYYwJV2iWky2IWsD28jUij5Xg40O97fzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786894763; c=relaxed/simple;
	bh=fuXMHtXZNdDkh9SMvcuo1KEh+S2GgVCMae+AfB9+6o0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a1D1xAZqk11UVLhiF3t5worGvJQc2O99eXKk3hotMKxOXoBiSYyJM3goXdTOGqSlBSxsVzYG0Q+IGy2TVkL0i0CHOTH22VcPm3IPJdGVTkbp3w0YPM2/obkeWxx6JG92wHzD/0hlb5jnB/IpZoa+9GDZKFc5It1mWRBccu2/pc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzmH2bcg; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzmH2bcg"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2caea3f742bso44832665ad.0
        for <linux-arch@vger.kernel.org>; Sun, 16 Aug 2026 08:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786894761; x=1787499561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P73PRx+EDTzK8cprRxXBiawz3Zha2PqE84oSBC9bew0=;
        b=RzmH2bcgP6HFOxDuYoOHtQqjUuHN5zwtu4CbZs7EP5FTTrDGWuiY+Ty1hw6C7ryeBz
         CPWHGnm0vmZ6pYRMX8vg8408f/xd1V/MOsCM3MWwKoyNYiyG8wLByJWUPApJ16ecuEhi
         TwQWz9g+J/UrIMnIbZfUI5zmyOWMh+ejZtoNoX2OQFRgP+UeW+/657+itRT1se6BAu0O
         nroIa54Bwn41PIvSrSgemtCnTy5gHR/qoMQGNlCcY00QXfU5d0Zflp/apSo2vV/Zdsr4
         Xs4NGX+G9GGNgKKydcMOy9M9veUqP+kIeD1I3THx0kSow8MzZKhVqn88il5qF06jI5oe
         5DDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786894761; x=1787499561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P73PRx+EDTzK8cprRxXBiawz3Zha2PqE84oSBC9bew0=;
        b=Z5ggKa9R9JNpwL4ITkq9aDfkAJSlyjlOAUSpYvAFBGLT13ieG0bXzJBGpNIpgX0xt+
         LMIGBw2wGQsHKI9fc9dU64+MmPf/OIsHMBRaAHDtBr2HmxPeJVSUjwbyMWORCD00L22K
         QBzChuyCK85ZeyD6jS/Bp2I9IidNatt831kXUUZa56YHVCvujSGdiGegQuD5l6kzIrJ2
         LPc2iD1I5MIHPVOfjsCCAaciSbMMhTu37gLyqqcZcdItRcLrFPpDQKpoOSsv4ZTylAzL
         I0DE6PNNSmrjTtu1oZ4AvICdfXN9QZk6grhT7N9p/iBT3g6hlCxBUz+cW+gy9Q+2KZx2
         G3pw==
X-Forwarded-Encrypted: i=1; AHgh+Rr9Hm5bhX8TQkF1m4b47fL4GH91mC/lnhrKMdd2VNIA8c7q9kwEnVo6buPBbbugJn5WtN4JiAPP2gxF@vger.kernel.org
X-Gm-Message-State: AOJu0YxrGYBsEzy6SdKGl9ICu7UxicyNBJkw8dOR0jPG3OjIyKchVaBp
	zJ0mPIg7p8pcYhhFhR32jV1nZ9RZ2x06pwDz2BPryxGAsKaSA9To0wtRZwTrPlX1YOUp0g==
X-Gm-Gg: AR+sD12XrvKi9DIPpmT5UFaRLrKKqywVgvPmsbnu7OQaVbSaRy2IJ5lTMohKtioKdEj
	TCM4oWEC0gOtxw5gLaHRu6svxf/UE4uiliO799Bbv5++7kDpss6iASqAXn2zbP/L54aRRDonhgd
	AbqT6F/a5oMWgAVqosIoLIixJgn6whTITy1v2RmhtbLRiS9qcrIvPScoGmG+FRK4USMcbk0s6T5
	8D2BHF7KA6Uort68sJVZARthxT+tMabC5dRXJmgNs0lJnyTSrUywyuS26zCreCbs346UZ9wy3sN
	o55A7wRwYXcPJPA1en1i2p1O56Tpu9U6aXTBb2JOr1UNFHHS4KmwxTGfuctXQAbvFCgftc/Vhv/
	d1WKiBGZPpGa7W/Xza6ca5stvVQHJ+WzvtAfWVTZGwgegmdhtL6MKhs9Yo5yjAZhMQt3+1hDlOW
	q8ViNKMlJPhuKuKjbSVm2bo0VZ90YHfgOxB48zCn4v3WJViIGaNbon/Og0citj2Y0HLhcY/hHCs
	rY=
X-Received: by 2002:a05:6a21:599:b0:3bf:5b7a:fc8b with SMTP id adf61e73a8af0-3cc717540ddmr19928465637.0.1786894761070;
        Sun, 16 Aug 2026 08:39:21 -0700 (PDT)
Received: from Modern-15.. ([2401:4900:a069:993b:8f9f:648d:c9a9:d989])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ea804233sm24501914eec.26.2026.08.16.08.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 08:39:13 -0700 (PDT)
From: mathura kumar <mathura.kumar.tech@gmail.com>
To: brauner@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	corbet@lwn.net,
	mathura.kumar.tech@gmail.com
Subject: [PATCH v3 0/4] Add two new system call mq_recvmmsg() and mq_sendmmsg() to posix ipc mqueue
Date: Sun, 16 Aug 2026 21:04:19 +0530
Message-ID: <20260816153811.1085261-1-mathura.kumar.tech@gmail.com>
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

Hi Everyone,

It has been couple of month since last work but yeah I had quite hectic schedule
and has been recieved lot of feedback to improve many thing. I am also new in kernel
development so its hard in early month to digest lot of subtle things in code,
flow etc.
Therefore i have taken time to deep dive..

so now,I will be gratefull if you spend little bit of time in reviewing current work.

Thanks,

change since v2:

 -  my official mail changed to <mathura.kumar.tech@gmail.com> from <academic1mathura@gmail.com>

 -  iovec is introduced for arguments.

 - since v2 does not contain batch operation and I introduced batch support now
    in recv or peek, due to that I added one more system call to support 
    batch during send as well otherwise i don't see any benefites of having
    batching in consumer side only.

 -  tree is augmented with two new field for improving traversal complexity.

 - lot of edges cases got handled like compat layer, Flag check for unkown operation to
    make it robust and resilient.

 - self test is updated
 - documentation is updated appropriately.

 - v2 Link: https://lore.kernel.org/linux-arch/20260320052340.6696-1-academic1mathura@gmail.com/T/#t



mathura kumar (4):
  IPC: Added two new system call mq_recvmmsg() and  mq_sendmmsg()
  IPC: Added system call entry in all of most common  architectures
  IPC: Added system call entry in performance tool
  Test: Added self-testing and documentation

 Documentation/userspace-api/index.rst         |   2 +
 Documentation/userspace-api/mq_recvmmsg.rst   | 205 +++++++
 Documentation/userspace-api/mq_sendmmsg.rst   | 168 ++++++
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
 ipc/mqueue.c                                  | 568 +++++++++++++++++-
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
 tools/testing/selftests/ipc/mq_recvmmsg.c     | 392 ++++++++++++
 tools/testing/selftests/ipc/mq_sendmmsg.c     | 360 +++++++++++
 46 files changed, 1823 insertions(+), 66 deletions(-)
 create mode 100644 Documentation/userspace-api/mq_recvmmsg.rst
 create mode 100644 Documentation/userspace-api/mq_sendmmsg.rst
 create mode 100644 tools/testing/selftests/ipc/mq_recvmmsg.c
 create mode 100644 tools/testing/selftests/ipc/mq_sendmmsg.c

-- 
2.43.0

