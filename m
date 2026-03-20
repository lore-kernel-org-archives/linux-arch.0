Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA182EA15C
	for <linux-arch@vger.kernel.org>; Fri, 20 Mar 2026 05:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773984285; cv=none; b=kAi4Hi1jzPl0eXrLtc8LqaKnyLf3vA+ptgxOFXID46XnhsxZLqK3OT75eWgY+REaxP++5SN760Apn01b7D8GUEPnNy9A1VLUayWzkSDi2SjfbZ6vcmmvQQ9ynhIEthrZHeJ1be6tIsRcXbml8RL/fT+USgfBGbqrN7EtUsuPD14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773984285; c=relaxed/simple;
	bh=/DeFAgUlo+qfAIACLhOuCQe8PHw7H0K7rpvGU0P4cFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A/4cr40jcp6RcX/9NUWnTxH7aWt1gJlmKLk1VgvcXugtLA31H2RO1idzlqF1OPz/fQnaBNVDIp1CR5V+7PCAwRQgnZEkpN22tZxgI6p9q+6F0n6wIWH+/lUXP9k8i/EV86INSYtrk2uVd1y2QqV1x5rQZhUmCO6F4Zff8zdrkgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QzZz4D3d; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzZz4D3d"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35b88a4f123so727129a91.1
        for <linux-arch@vger.kernel.org>; Thu, 19 Mar 2026 22:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773984281; x=1774589081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/F6J/Pk6HOeSdS86B2FiCbfUiuBicwWuCfGXC04QbhQ=;
        b=QzZz4D3dhwmBXMu/w7kJMtAx97adTGBAVYUwsg7sCQ7WBggY9n4cxvGGrZFbyzpKtG
         wUGWEn+5l+EN5+7ggTpyxzYwAqzMTEMlkUs1WWPsTexVH4lt2MwDnZ2LktMdC8To0KOW
         6fv2y7YJOlDJXj6bimHStAeb/p+SzlqxKnjN/m7fHkuafHtoZiciksKQZLK+KpmMlsXZ
         fp/5xYhh4ShmqyhuV0C605jRwMK4NBcccPaOWgQ/nIV39nza+5v02f6jSi49x+8IDPVH
         Doo9We4Yt5DVysHEL7/IBgYDdI1i+8HF4pF5d3hJxBfbPNFrmPjBz7j8LlcyHXE0PPih
         Ultg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773984281; x=1774589081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/F6J/Pk6HOeSdS86B2FiCbfUiuBicwWuCfGXC04QbhQ=;
        b=IIOI2V5iugaBpMMfhM1q8k+KJ9OBvHYCpGa4ygrm3sUxL4yUxzVwJHNzRZeXTjBXor
         4CD54a1kJyohE1pr2+R06ef1fO/DAM3BBa38Q2nEesaAQjfdmUl8qyn0XkKU6Nt2kU3k
         UE6O1qdJDZswRiWFrADStjx4JIeSSCNh7L/65FpGMV2nlge2PaC5ZNO5urQHlTEgnVBm
         +3wsM2Um1BUsIv4gz9H3oQxPCGFt8DZcwrCluCGwxTuckfZYBdzdI09vP27w7XiibIxC
         RZli4YSEq2QGP9kIFMxUzXMzXa3qDlwiJ9iCHOLMYptXQBFLsoa1iSU2HlJpKh45q1Xa
         EDlw==
X-Forwarded-Encrypted: i=1; AJvYcCXaQTjn9lc9ExWIDhMRBfpDSQ72WEAqO2ubiXLSXowVdh7o8R3x0nRcBU5NEHAYqAodmFuO3a+xTQY1@vger.kernel.org
X-Gm-Message-State: AOJu0YzVzu/o5qqBEfLNTqhwrP9omJ2RWslUrdoWrRiMH2XSrvjgR+xd
	Khsh39lXpA4iz4srpH+j88aGnUYUArpK8SBkL9ssu+PsQKQQKngnxthb
X-Gm-Gg: ATEYQzyOHGR8v+y+NoZMX66w+mZpwAFxB9gK+DU4cxUFkFCJa6CnMKbQvvBMcVUexhN
	WTSO5ZGYvjib5JUiwBYNC9XNHnXJneJ8uAc6TsVxsHMSb+gz6ftOrF9tcrIH/F2RAJIgEVs5yrO
	G2etoaMxZqNj7jAduqni03XW3C5X8QXnAlEGjInMua7rEPp/O7gfhTBmNMcg32jfxdQPIhihqZS
	3ycme/t/ZI0HI1GvSMy76kNk4UJW2ziHyBHBfeQHuJqBtsDPSfdrNfmtTarItki29/Eke1Wh9P8
	cqCdHf0sQsO9V+gCpz8b6L8Xu3SwsnhhYy50uoKIVLPPGmzdUe7hpWnLMmyUJXSGXT3otmLXup4
	QvPO9EMXEy5zGbZ7+2d0WguZ6nWbdHnqR6jPPf+psVjJNaEq4EIKrIB7cJ6/mFOZwfuzg6HDmOo
	3oiPshCLW9XUUfJuMbEMoFdAHF18yCi1tO5TfojQX6O/qSlg==
X-Received: by 2002:a17:90a:dfd0:b0:35a:117:9521 with SMTP id 98e67ed59e1d1-35bd27cb0bemr1281499a91.10.1773984281258;
        Thu, 19 Mar 2026 22:24:41 -0700 (PDT)
Received: from Modern-15.. ([2401:4900:b471:fd0e:76f1:2fa0:b416:4f73])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd40e4bfdsm779344a91.9.2026.03.19.22.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 22:24:40 -0700 (PDT)
From: Mathura_Kumar <academic1mathura@gmail.com>
To: brauner@kernel.org
Cc: academic1mathura@gmail.com,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: [PATCH RESEND v2 3/4]IPC: Prepared Documentation  and test
Date: Fri, 20 Mar 2026 10:53:37 +0530
Message-ID: <20260320052340.6696-4-academic1mathura@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260320052340.6696-1-academic1mathura@gmail.com>
References: <20260320052340.6696-1-academic1mathura@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Mathura_Kumar <academic1mathura@gmail.com>
---
 Documentation/userspace-api/index.rst  |   1 +
 Documentation/userspace-api/ipc.rst    | 222 +++++++
 tools/testing/selftests/ipc/.gitignore |   1 +
 tools/testing/selftests/ipc/Makefile   |   9 +-
 tools/testing/selftests/ipc/mq_peek.c  | 785 +++++++++++++++++++++++++
 5 files changed, 1017 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/userspace-api/ipc.rst
 create mode 100644 tools/testing/selftests/ipc/mq_peek.c

diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index a68b1bea57a8..bf747a91e74a 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -22,6 +22,7 @@ System calls
    ioctl/index
    mseal
    rseq
+   ipc
 
 Security-related interfaces
 ===========================
diff --git a/Documentation/userspace-api/ipc.rst b/Documentation/userspace-api/ipc.rst
new file mode 100644
index 000000000000..14a5f0ce7230
--- /dev/null
+++ b/Documentation/userspace-api/ipc.rst
@@ -0,0 +1,222 @@
+mq_timedreceive2 system call
+=============================
+
+This document describes the mq_timedreceive2() system call. It provides
+an overview of the feature, interface specification, design, and
+test specification.
+
+Contents
+--------
+
+        1) Overview
+        2) Functional Specification
+        3) Design
+        4) Implementation Notes
+        5) Test Specification
+
+1) Overview
+-----------
+
+POSIX message queues on Linux provide mq_timedreceive() for consuming
+messages from a queue.This interface requires the caller to pass the
+message buffer, length and priority pointer as individual arguments to
+the system call. This imposes a fixed calling convention that cannot be
+extended without breaking the ABI.
+
+mq_timedreceive2() introduces a new system call entry point that accepts
+message buffer parameters via a struct argument rather than as individual
+syscall arguments. This frees the remaining syscall argument slots for
+new functionality flags and a message index, enabling non-destructive
+peek and indexed access semantics that are not possible with the
+original interface.
+
+One 64-bit variant is provided with compat handling:
+    mq_timedreceive2()
+
+2) Functional Specification
+---------------------------
+
+NAME
+        mq_timedreceive2 - receive or peek at a message from a
+        POSIX message queue
+
+SYNOPSIS
+
+.. code-block:: c
+
+        #include <mqueue.h>
+
+        struct mq_timedreceive2_args {
+                size_t         msg_len;
+                unsigned int  *msg_prio;
+                char          *msg_ptr;
+        };
+
+        ssize_t mq_timedreceive2(mqd_t mqdes,
+                                 struct mq_timedreceive2_args *uargs,
+                                 unsigned int flags,
+                                 unsigned long index,
+                                 const struct timespec *abs_timeout);
+
+Note: No glibc wrapper exists for this syscall. Callers must invoke it
+directly using syscall(2).
+
+DESCRIPTION
+        mq_timedreceive2() receives or peeks at a message from the
+        message queue referred to by the descriptor mqdes.
+
+        The uargs structure provides the message buffer parameters:
+
+        ``msg_ptr``
+                Userspace buffer to receive the message body.
+
+        ``msg_len``
+                Size of msg_ptr in bytes. Must be greater than or equal
+                to the mq_msgsize attribute of the queue.
+
+        ``msg_prio``
+                If not NULL, the priority of the received message is
+                stored here.
+
+        The flags argument controls receive behavior. The following
+        flag is defined:
+
+        ``MQ_PEEK``
+                Copy the message into msg_ptr without removing it from
+                the queue. The queue is not modified. If this flag is
+                not set, behavior is identical to mq_timedreceive() and
+                the message is consumed.
+
+        The index argument selects which message to operate on within
+        the priority-ordered queue. index 0 refers to the highest
+        priority message. When MQ_PEEK is not set, index is ignored
+        but must be non-empty.
+
+        The abs_timeout argument specifies an absolute timeout. When
+        MQ_PEEK is set, abs_timeout is ignored since peek is a
+        non-blocking snapshot operation. When MQ_PEEK is not set,
+        abs_timeout behaves identically to mq_timedreceive().
+
+RETURN VALUE
+        On success, returns the number of bytes copied into msg_ptr.
+        On failure, returns -1 and sets errno.
+
+ERRORS
+        ``EAGAIN``
+                Queue is empty and MQ_PEEK is set. Peek is always
+                non-blocking and returns immediately on empty queue.
+
+        ``EBADF``
+                mqdes is not a valid message queue descriptor open
+                for reading.
+
+        ``EFAULT``
+                uargs, msg_ptr, msg_prio, or abs_timeout points to
+                an invalid address.
+
+        ``EINVAL``
+                flags contains an unknown value, or index is nonzero
+                and MQ_PEEK is not set.
+
+        ``EMSGSIZE``
+                msg_len is less than the mq_msgsize attribute of
+                the queue.
+
+        ``ETIMEDOUT``
+                Pop path only. The call timed out before a message
+                became available. Never returned on peek path.
+
+3) Design
+---------
+
+3.1 Struct-based argument passing
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The message buffer parameters (msg_ptr, msg_len, msg_prio) are
+consolidated into struct mq_timedreceive2_args rather than passed
+as individual syscall arguments. Due to limited six arguments,
+The original mq_timedreceive() consumes all six slots,
+leaving no room for extension. Consolidating the buffer parameters
+into a struct recovers two argument slots for flags and index while
+keeping the interface clean and forward-compatible.
+
+Future extensions can be made by adding new flag bits without
+requiring a new syscall number.
+
+3.2 Compat handling
+~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
+        struct compat_mq_timedreceive2_args {
+                compat_size_t  msg_len;
+                compat_uptr_t  msg_prio;
+                compat_uptr_t  msg_ptr;
+        };
+
+The compat entry point performs the necessary conversions before
+calling the shared do_mq_timedreceive2() implementation.
+
+3.3 Peek implementation
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+When MQ_PEEK is set, the implementation locates the target message
+in the priority tree but does not remove it. Two locks are taken:
+the first confirms a message exists before any allocation is
+attempted, avoiding allocation on empty queues. The second protects
+the kernel temporary buffer copy operation. The message is copied to
+userspace and both locks are released with the queue unmodified.
+
+3.4 Index argument
+~~~~~~~~~~~~~~~~~~~
+
+The priority tree is walked to the node at position index within
+the priority ordering. index 0 is always the highest priority
+message, consistent with what an unconditional mq_timedreceive()
+would return.
+
+4) Implementation Notes
+-----------------------
+
+The implementation lives in ipc/mqueue.c. The syscall entry
+point mq_timedreceive2 are thin wrappers that validate and convert
+arguments before calling the shared internal function do_mq_timedreceive2().
+
+Syscall numbers are assigned for all of most common architectures. Refer
+to the respective syscall table files under arch/ for per-architecture
+numbers.
+
+5) Test Specification
+---------------------
+
+Tests for mq_timedreceive2() should cover the following:
+
+1) Basic receive: verify that without MQ_PEEK the message is consumed
+   and queue depth decreases by one. Verify message body and priority
+   are correct.
+
+2) Peek semantics: verify that with MQ_PEEK the message body and
+   priority are returned correctly and the queue depth is unchanged
+   after the call.
+
+3) Repeated peek: verify that calling mq_timedreceive2() with MQ_PEEK
+   multiple times on the same queue returns the same message each time
+   without modifying the queue.
+
+4) Index argument: verify that index 0 returns the highest priority
+   message. Verify that out-of-range index returns ENOENT.
+
+5) Empty queue: verify that peek on an empty queue returns EAGAIN
+   immediately without blocking.
+
+6) Memory behavior: verify that both small and large message copies
+   work correctly without corruption.
+
+7) Invalid arguments: verify EBADF for invalid mqdes, EFAULT for bad
+   pointers in uargs, EINVAL for unknown flags, EMSGSIZE for msg_len
+   smaller than queue mq_msgsize.
+
+8) Concurrent access: verify that simultaneous peek from multiple
+   threads returns consistent results and does not corrupt queue
+   state. Verify that a concurrent mq_receive() and mq_peek() do
+   not race.
diff --git a/tools/testing/selftests/ipc/.gitignore b/tools/testing/selftests/ipc/.gitignore
index 9ed280e4c704..fe609d98ecb2 100644
--- a/tools/testing/selftests/ipc/.gitignore
+++ b/tools/testing/selftests/ipc/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 msgque_test
 msgque
+mq_peek
diff --git a/tools/testing/selftests/ipc/Makefile b/tools/testing/selftests/ipc/Makefile
index 50e9c299fc4a..1a8b27127ca8 100644
--- a/tools/testing/selftests/ipc/Makefile
+++ b/tools/testing/selftests/ipc/Makefile
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 uname_M := $(shell uname -m 2>/dev/null || echo not)
 ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/i386/)
+CC = gcc
+CFLAGS = -static -O2
 ifeq ($(ARCH),i386)
         ARCH := x86
 	CFLAGS := -DCONFIG_X86_32 -D__i386__
@@ -9,10 +11,15 @@ ifeq ($(ARCH),x86_64)
 	ARCH := x86
 	CFLAGS := -DCONFIG_X86_64 -D__x86_64__
 endif
+ifeq ($(ARCH),aarch64)
+        ARCH := arm64
+        CFLAGS := -DCONFIG_ARM64
+endif
 
 CFLAGS += $(KHDR_INCLUDES)
 
-TEST_GEN_PROGS := msgque
+TEST_GEN_PROGS := msgque mq_peek
+LDLIBS += -lrt -lpthread
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/ipc/mq_peek.c b/tools/testing/selftests/ipc/mq_peek.c
new file mode 100644
index 000000000000..d08596ae6e1c
--- /dev/null
+++ b/tools/testing/selftests/ipc/mq_peek.c
@@ -0,0 +1,785 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*  - Correct priority-rank indexed access (index 0 = highest priority)
+ *  - FIFO ordering within same priority level
+ *  - Concurrent peek + receive / peek + send races
+ */
+
+#define _GNU_SOURCE
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdint.h>
+#include <unistd.h>
+#include <errno.h>
+#include <pthread.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <time.h>
+#include "mqueue.h"
+#include "kselftest.h"
+#include "linux/types.h"
+
+#ifndef __NR_mq_timedreceive2
+
+#if defined(__alpha__)
+#define __NR_mq_timedreceive2 582
+
+#elif defined(__x86_64__)
+#define __NR_mq_timedreceive2 548
+
+#else
+/* common value used by many architectures:
+ * arm  m68k, microblaze, mips
+ * parisc, x86_32, and others
+ */
+#define __NR_mq_timedreceive2 472
+
+#endif
+#endif
+
+#define MQ_PEEK 2U
+
+#ifndef ARRAY_SIZE
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+#endif
+
+struct mq_timedreceive2_args {
+	size_t msg_len;
+	unsigned int *msg_prio;
+	char *msg_ptr;
+};
+
+static long mq_timedreceive2(mqd_t mqdes, struct mq_timedreceive2_args *uargs,
+			     unsigned int flags, unsigned long index,
+			     const struct timespec *timeout)
+{
+	return syscall(__NR_mq_timedreceive2, (long)mqdes, uargs, (long)flags,
+		       index, timeout);
+}
+
+#define MQ_NAME_PREFIX "/mq_peek_test_"
+#define MAX_MSG_SIZE 128
+#define LARGE_MSG_SIZE 4064
+#define MQ_MAXMSG 16
+
+#define PRIO_HIGH 9
+#define PRIO_MED 5
+#define PRIO_LOW 1
+
+static mqd_t open_queue(const char *suffix, long msgsize)
+{
+	char name[64];
+	struct mq_attr attr = {
+		.mq_flags = 0,
+		.mq_maxmsg = MQ_MAXMSG,
+		.mq_msgsize = msgsize,
+		.mq_curmsgs = 0,
+	};
+	mqd_t mqd;
+
+	snprintf(name, sizeof(name), "%s%s", MQ_NAME_PREFIX, suffix);
+	mq_unlink(name);
+
+	mqd = mq_open(name, O_NONBLOCK | O_RDWR | O_CREAT | O_EXCL, 0600, &attr);
+	if (mqd == (mqd_t)-1) {
+		ksft_test_result_fail("mq_open(%s): %m\n", name);
+		ksft_exit_fail();
+	}
+
+	mq_unlink(name);
+	return mqd;
+}
+
+static void send_msg(mqd_t mqd, unsigned int prio, const char *text, size_t len)
+{
+	if (mq_send(mqd, text, len, prio) != 0) {
+		ksft_test_result_fail("mq_send(prio=%u): %m\n", prio);
+		ksft_exit_fail();
+	}
+}
+
+static long peek(mqd_t mqd, unsigned long index, char *buf, size_t bufsz,
+		 unsigned int *prio)
+{
+	struct mq_timedreceive2_args args = {
+		.msg_len = bufsz,
+		.msg_prio = prio,
+		.msg_ptr = buf,
+	};
+	return mq_timedreceive2(mqd, &args, MQ_PEEK, index, NULL);
+}
+
+static long queue_depth(mqd_t mqd)
+{
+	struct mq_attr attr;
+
+	if (mq_getattr(mqd, &attr) != 0)
+		return -1;
+	return attr.mq_curmsgs;
+}
+
+static void test_peek_empty_queue(void)
+{
+	mqd_t mqd = open_queue("empty", MAX_MSG_SIZE);
+	char buf[MAX_MSG_SIZE];
+	unsigned int prio;
+	long ret;
+
+	ret = peek(mqd, 0, buf, sizeof(buf), &prio);
+	if (ret == -1 && errno == EAGAIN)
+		ksft_test_result_pass("peek on empty queue [EAGAIN]\n");
+	else
+		ksft_test_result_fail("peek on empty queue: expected EAGAIN, got ret=%ld errno=%d (%m)\n",
+								ret, errno);
+
+	mq_close(mqd);
+}
+
+static void test_peek_invalid_fd(void)
+{
+	char buf[MAX_MSG_SIZE];
+	unsigned int prio;
+	long ret;
+
+	ret = peek((mqd_t)-1, 0, buf, sizeof(buf), &prio);
+	if (ret == -1 && errno == EBADF)
+		ksft_test_result_pass("peek invalid fd [ EBADF]\n");
+	else
+		ksft_test_result_fail("peek invalid fd: expected EBADF, got ret=%ld errno=%d\n",
+							   ret, errno);
+}
+
+static void test_peek_non_mqueue_fd(void)
+{
+	int pipefd[2];
+	char buf[MAX_MSG_SIZE];
+	unsigned int prio;
+	long ret;
+
+	if (pipe(pipefd) != 0) {
+		ksft_test_result_skip("pipe() failed, skipping non-mqueue-fd test\n");
+		return;
+	}
+
+	ret = peek((mqd_t)pipefd[0], 0, buf, sizeof(buf), &prio);
+	if (ret == -1 && errno == EBADF)
+		ksft_test_result_pass("peek on pipe fd [EBADF]\n");
+	else
+		ksft_test_result_fail("peek non-mqueue fd: expected EBADF, got ret=%ld errno=%d\n",
+								ret, errno);
+
+	close(pipefd[0]);
+	close(pipefd[1]);
+}
+
+static void test_peek_writeonly_fd(void)
+{
+	char name[] = "/ksft_mq_peek_wo";
+	struct mq_attr attr = { .mq_maxmsg = 4, .mq_msgsize = MAX_MSG_SIZE };
+	mqd_t rw, wo;
+	char buf[MAX_MSG_SIZE];
+	unsigned int prio;
+	long ret;
+
+	mq_unlink(name);
+	rw = mq_open(name, O_RDWR | O_CREAT, 0600, &attr);
+	if (rw == (mqd_t)-1) {
+		ksft_test_result_skip("mq_open RW failed: %m\n");
+		return;
+	}
+	wo = mq_open(name, O_WRONLY);
+	mq_unlink(name);
+
+	if (wo == (mqd_t)-1) {
+		ksft_test_result_skip("mq_open WO failed: %m\n");
+		mq_close(rw);
+		return;
+	}
+
+	send_msg(rw, PRIO_HIGH, "x", 1);
+
+	ret = peek(wo, 0, buf, sizeof(buf), &prio);
+	if (ret == -1 && errno == EBADF)
+		ksft_test_result_pass("peek on O_WRONLY fd [EBADF]\n");
+	else
+		ksft_test_result_fail("peek WO fd: expected EBADF, got ret=%ld errno=%d\n",
+								ret, errno);
+
+	mq_close(wo);
+	mq_close(rw);
+}
+
+static void test_peek_buffer_too_small(void)
+{
+	mqd_t mqd = open_queue("small", MAX_MSG_SIZE);
+	char tiny[1]; /* deliberately too small */
+	unsigned int prio;
+	struct mq_timedreceive2_args args = {
+		.msg_len = sizeof(tiny),
+		.msg_prio = &prio,
+		.msg_ptr = tiny,
+	};
+	long ret;
+
+	send_msg(mqd, PRIO_HIGH, "hello", 5);
+
+	ret = mq_timedreceive2(mqd, &args, MQ_PEEK, 0, NULL);
+	if (ret == -1 && errno == EMSGSIZE)
+		ksft_test_result_pass("peek with small buf [EMSGSIZE]\n");
+	else
+		ksft_test_result_fail("peek small buf: expected EMSGSIZE, got ret=%ld errno=%d\n",
+								ret, errno);
+
+	mq_close(mqd);
+}
+
+static void test_peek_bad_msg_ptr(void)
+{
+	mqd_t mqd = open_queue("bad_ptr", MAX_MSG_SIZE);
+	unsigned int prio;
+
+	struct mq_timedreceive2_args args = {
+		.msg_len = MAX_MSG_SIZE,
+		.msg_prio = &prio,
+		.msg_ptr = (char *)0x1,
+	};
+
+	long ret;
+
+	send_msg(mqd, PRIO_HIGH, "payload", 7);
+	ret = mq_timedreceive2(mqd, &args, MQ_PEEK, 0, NULL);
+	if (ret == -1 && errno == EFAULT)
+		ksft_test_result_pass("peek bad msg_ptr [EFAULT]\n");
+	else
+		ksft_test_result_fail("peek bad msg_ptr: expected EFAULT, got ret=%ld errno=%d\n",
+								ret, errno);
+
+	mq_close(mqd);
+}
+
+static void test_peek_index_out_of_range(void)
+{
+	mqd_t mqd = open_queue("oob", MAX_MSG_SIZE);
+	char buf[MAX_MSG_SIZE];
+	unsigned int prio;
+	long ret;
+
+	send_msg(mqd, PRIO_MED, "one", 3);
+	ret = peek(mqd, 1, buf, sizeof(buf), &prio);
+	if (ret == -1 && errno == ENOENT)
+		ksft_test_result_pass("peek OOB index [ENOENT]\n");
+	else
+		ksft_test_result_fail("peek OOB: expected ENOENT, got ret=%ld errno=%d\n",
+								ret, errno);
+
+	mq_close(mqd);
+}
+
+static void test_peek_basic_data(void)
+{
+	mqd_t mqd = open_queue("basic", MAX_MSG_SIZE);
+	const char *payload = "peek-test-payload";
+	char buf[MAX_MSG_SIZE];
+	unsigned int prio = 0;
+	long ret;
+
+	send_msg(mqd, PRIO_HIGH, payload, strlen(payload));
+
+	memset(buf, 0, sizeof(buf));
+	ret = peek(mqd, 0, buf, sizeof(buf), &prio);
+
+	if (ret < 0) {
+		ksft_test_result_fail("basic peek failed: ret=%ld errno=%d (%m)\n", ret, errno);
+		goto out;
+	}
+	if ((size_t)ret != strlen(payload)) {
+		ksft_test_result_fail("basic peek: wrong size %ld (expected %zu)\n", ret, strlen(payload));
+		goto out;
+	}
+	if (memcmp(buf, payload, strlen(payload)) != 0) {
+		ksft_test_result_fail("basic peek: payload mismatch\n");
+		goto out;
+	}
+	if (prio != PRIO_HIGH) {
+		ksft_test_result_fail("basic peek: wrong prio %u (expected %d)\n", prio, PRIO_HIGH);
+		goto out;
+	}
+	ksft_test_result_pass("basic peek: correct data and priority\n");
+out:
+	mq_close(mqd);
+}
+
+static void test_peek_nondestructive(void)
+{
+	mqd_t mqd = open_queue("nodestr", MAX_MSG_SIZE);
+	char buf[MAX_MSG_SIZE];
+	unsigned int prio;
+	int i;
+
+	send_msg(mqd, PRIO_HIGH, "A", 1);
+	send_msg(mqd, PRIO_MED, "B", 1);
+	send_msg(mqd, PRIO_LOW, "C", 1);
+
+	if (queue_depth(mqd) != 3) {
+		ksft_test_result_fail("initial depth != 3\n");
+		mq_close(mqd);
+		return;
+	}
+
+	for (i = 0; i < 10; i++) {
+		peek(mqd, 0, buf, sizeof(buf), &prio);
+		peek(mqd, 1, buf, sizeof(buf), &prio);
+		peek(mqd, 2, buf, sizeof(buf), &prio);
+	}
+
+	if (queue_depth(mqd) == 3)
+		ksft_test_result_pass("peek is non-destructive (depth stays 3)\n");
+	else
+		ksft_test_result_fail("peek modified queue: depth=%ld (expected 3)\n", queue_depth(mqd));
+
+	mq_close(mqd);
+}
+
+static void test_peek_priority_order(void)
+{
+	mqd_t mqd = open_queue("prio_order", MAX_MSG_SIZE);
+	char buf[MAX_MSG_SIZE];
+	unsigned int prio;
+	long ret;
+	int pass = 1;
+
+	send_msg(mqd, PRIO_LOW, "low", 3);
+	send_msg(mqd, PRIO_HIGH, "high", 4);
+	send_msg(mqd, PRIO_MED, "med", 3);
+
+	/* index 0 must return highest priority */
+	ret = peek(mqd, 0, buf, sizeof(buf), &prio);
+	if (ret < 0 || prio != PRIO_HIGH) {
+		ksft_test_result_fail("prio_order index0: prio=%u ret=%ld errno=%d\n", prio,
+								ret, errno);
+		pass = 0;
+	}
+	if (pass && memcmp(buf, "high", 4) != 0) {
+		ksft_test_result_fail("prio_order index0: wrong payload\n");
+		pass = 0;
+	}
+
+	/* index 1 must return medium priority */
+	ret = peek(mqd, 1, buf, sizeof(buf), &prio);
+	if (pass && (ret < 0 || prio != PRIO_MED)) {
+		ksft_test_result_fail("prio_order index1: prio=%u ret=%ld\n",
+				      prio, ret);
+		pass = 0;
+	}
+	if (pass && memcmp(buf, "med", 3) != 0) {
+		ksft_test_result_fail("prio_order index1: wrong payload\n");
+		pass = 0;
+	}
+
+	/* index 2 must return lowest priority */
+	ret = peek(mqd, 2, buf, sizeof(buf), &prio);
+	if (pass && (ret < 0 || prio != PRIO_LOW)) {
+		ksft_test_result_fail("prio_order index2: prio=%u ret=%ld\n",
+				      prio, ret);
+		pass = 0;
+	}
+	if (pass && memcmp(buf, "low", 3) != 0) {
+		ksft_test_result_fail("prio_order index2: wrong payload\n");
+		pass = 0;
+	}
+
+	if (pass)
+		ksft_test_result_pass("priority ordering: index0=HIGH, index1=MED, index2=LOW\n");
+
+	mq_close(mqd);
+}
+
+static void test_peek_fifo_within_priority(void)
+{
+	mqd_t mqd = open_queue("fifo", MAX_MSG_SIZE);
+	char buf[MAX_MSG_SIZE];
+	unsigned int prio;
+	long ret;
+	int pass = 1;
+
+	send_msg(mqd, PRIO_HIGH, "first", 5);
+	send_msg(mqd, PRIO_HIGH, "second", 6);
+	send_msg(mqd, PRIO_HIGH, "third", 5);
+
+	memset(buf, 0, sizeof(buf));
+	ret = peek(mqd, 0, buf, sizeof(buf), &prio);
+	if (ret < 0 || memcmp(buf, "first", 5) != 0) {
+		ksft_test_result_fail("FIFO peek[0]: expected 'first', got '%.*s' ret=%ld\n",
+								(int)ret, buf, ret);
+		pass = 0;
+	}
+
+	if (pass) {
+		char rbuf[MAX_MSG_SIZE];
+		unsigned int rprio;
+
+		ssize_t r = mq_receive(mqd, rbuf, sizeof(rbuf), &rprio);
+
+		if (r < 0 || memcmp(rbuf, "first", 5) != 0) {
+			ksft_test_result_fail("mq_receive 'first' failed\n");
+			pass = 0;
+		}
+	}
+
+	if (pass) {
+		char rbuf[MAX_MSG_SIZE];
+		unsigned int rprio;
+
+		memset(buf, 0, sizeof(buf));
+
+		ret = peek(mqd, 0, buf, sizeof(buf), &prio);
+		if (ret < 0 || memcmp(buf, "second", 6) != 0) {
+			ksft_test_result_fail("FIFO peek after receive: expected 'second', got '%.*s'\n",
+									(int)ret, buf);
+			pass = 0;
+		}
+	}
+
+	if (pass)
+		ksft_test_result_pass("FIFO within same priority is correct\n");
+
+	mq_close(mqd);
+}
+
+static void test_peek_all_indices(void)
+{
+	const unsigned int prios[] = { 2, 7, 4, 9, 1, 6 };
+	const int N = ARRAY_SIZE(prios);
+	mqd_t mqd = open_queue("all_idx", MAX_MSG_SIZE);
+	char buf[MAX_MSG_SIZE];
+	char expected_payload[MAX_MSG_SIZE];
+	unsigned int prio;
+	long ret;
+	int i, pass = 1;
+	unsigned int sorted[6];
+
+	for (i = 0; i < N; i++) {
+		snprintf(expected_payload, sizeof(expected_payload),
+			 "msg_prio_%u", prios[i]);
+		send_msg(mqd, prios[i], expected_payload,
+			 strlen(expected_payload));
+		sorted[i] = prios[i];
+	}
+
+	for (i = 0; i < N - 1; i++) {
+		int j;
+
+		for (j = i + 1; j < N; j++) {
+			if (sorted[j] > sorted[i]) {
+
+				unsigned int tmp = sorted[i];
+				sorted[i] = sorted[j];
+				sorted[j] = tmp;
+			}
+		}
+	}
+
+	for (i = 0; i < N && pass; i++) {
+		memset(buf, 0, sizeof(buf));
+
+		ret = peek(mqd, (unsigned long)i, buf, sizeof(buf), &prio);
+
+		if (ret < 0) {
+			ksft_test_result_fail("all_indices peek[%d] failed: ret=%ld errno=%d\n",
+								i, ret, errno);
+			pass = 0;
+			break;
+		}
+		if (prio != sorted[i]) {
+			ksft_test_result_fail("all_indices peek[%d]: prio=%u expected=%u\n",
+								i, prio, sorted[i]);
+			pass = 0;
+		}
+
+		snprintf(expected_payload, sizeof(expected_payload),
+			 "msg_prio_%u", sorted[i]);
+		if (memcmp(buf, expected_payload, strlen(expected_payload))) {
+			ksft_test_result_fail("all_indices peek[%d]: payload mismatch\n", i);
+			pass = 0;
+		}
+	}
+
+	if (pass && queue_depth(mqd) != N) {
+		ksft_test_result_fail("all_indices: depth=%ld expected=%d after peek\n",
+							queue_depth(mqd), N);
+		pass = 0;
+	}
+
+	if (pass) {
+		ret = peek(mqd, (unsigned long)N, buf, sizeof(buf), &prio);
+		if (!(ret == -1 && errno == ENOENT)) {
+			ksft_test_result_fail("all_indices OOB[%d]: expected ENOENT, got ret=%ld errno=%d\n",
+								N, ret, errno);
+			pass = 0;
+		}
+	}
+
+	if (pass)
+		ksft_test_result_pass("all-indices: correct prio order + OOB ENOENT\n");
+
+	mq_close(mqd);
+}
+
+static void test_peek_large_message(void)
+{
+	mqd_t mqd = open_queue("large", LARGE_MSG_SIZE);
+	char *send_buf, *recv_buf;
+	unsigned int prio = 0;
+	long ret;
+	int pass = 1;
+
+	send_buf = malloc(LARGE_MSG_SIZE);
+	recv_buf = calloc(1, LARGE_MSG_SIZE);
+	if (!send_buf || !recv_buf) {
+		ksft_test_result_skip("OOM allocating large message buffers\n");
+		goto out;
+	}
+
+	for (int i = 0; i < LARGE_MSG_SIZE; i++)
+		send_buf[i] = (char)(i & 0xFF);
+
+	send_msg(mqd, PRIO_HIGH, send_buf, LARGE_MSG_SIZE);
+
+	ret = peek(mqd, 0, recv_buf, LARGE_MSG_SIZE, &prio);
+	if (ret != LARGE_MSG_SIZE) {
+		ksft_test_result_fail("large msg peek: ret=%ld expected=%d\n",
+				      ret, LARGE_MSG_SIZE);
+		pass = 0;
+	}
+	if (pass && memcmp(send_buf, recv_buf, LARGE_MSG_SIZE) != 0) {
+		ksft_test_result_fail("large msg peek: payload mismatch\n");
+		pass = 0;
+	}
+	if (pass && prio != PRIO_HIGH) {
+		ksft_test_result_fail("large msg peek: prio=%u expected=%d\n", prio, PRIO_HIGH);
+		pass = 0;
+	}
+	if (pass && queue_depth(mqd) != 1) {
+		ksft_test_result_fail("large msg peek: queue modified (depth=%ld)\n", queue_depth(mqd));
+		pass = 0;
+	}
+	if (pass)
+		ksft_test_result_pass("large (%d B) multi-segment peek: correct\n", LARGE_MSG_SIZE);
+out:
+	free(send_buf);
+	free(recv_buf);
+	mq_close(mqd);
+}
+
+static void test_no_peek_flag_is_receive(void)
+{
+	mqd_t mqd = open_queue("nopeek", MAX_MSG_SIZE);
+	char buf[MAX_MSG_SIZE];
+	unsigned int prio = 0;
+	struct mq_timedreceive2_args args = {
+		.msg_len = sizeof(buf),
+		.msg_prio = &prio,
+		.msg_ptr = buf,
+	};
+	long ret;
+
+	send_msg(mqd, PRIO_HIGH, "consume-me", 10);
+
+	ret = mq_timedreceive2(mqd, &args, 0, 0, NULL);
+	if (ret < 0) {
+		ksft_test_result_fail("no-peek receive failed: ret=%ld errno=%d\n", ret, errno);
+		mq_close(mqd);
+		return;
+	}
+	if (queue_depth(mqd) != 0)
+		ksft_test_result_fail("no-peek: queue still has messages (depth=%ld)\n", queue_depth(mqd));
+	else
+		ksft_test_result_pass("without MQ_PEEK the message is consumed normally\n");
+
+	mq_close(mqd);
+}
+
+struct race_ctx {
+	mqd_t mqd;
+	int errors;
+};
+
+static void *receiver_thread(void *arg)
+{
+	struct race_ctx *ctx = arg;
+	char buf[MAX_MSG_SIZE];
+	unsigned int prio;
+	ssize_t r;
+
+	while ((r = mq_receive(ctx->mqd, buf, sizeof(buf), &prio)) > 0)
+		;
+
+	return NULL;
+}
+
+static void test_peek_concurrent_receive(void)
+{
+	struct race_ctx ctx;
+	pthread_t tid;
+	char buf[MAX_MSG_SIZE];
+	unsigned int prio;
+	long ret;
+	int i;
+
+	ctx.mqd = open_queue("concurrent", MAX_MSG_SIZE);
+	ctx.errors = 0;
+
+	for (i = 0; i < MQ_MAXMSG; i++) {
+		char payload[32];
+
+		snprintf(payload, sizeof(payload), "msg%d", i);
+		send_msg(ctx.mqd, (unsigned int)(i % 5) + 1, payload,
+			 strlen(payload));
+	}
+
+	if (pthread_create(&tid, NULL, receiver_thread, &ctx) != 0) {
+		ksft_test_result_skip("pthread_create failed\n");
+		mq_close(ctx.mqd);
+		return;
+	}
+
+	/*
+     * Peek repeatedly.The queue is being drained concurrently.
+	 */
+	for (i = 0; i < 200; i++) {
+		ret = peek(ctx.mqd, (unsigned long)(i % 4), buf, sizeof(buf),
+			   &prio);
+		if (ret < 0 && errno != EAGAIN && errno != ENOENT) {
+			ctx.errors++;
+		}
+	}
+
+	pthread_join(tid, NULL);
+
+	if (ctx.errors == 0)
+		ksft_test_result_pass("concurrent peek+receive: no unexpected errors\n");
+	else
+		ksft_test_result_fail("concurrent peek+receive: %d unexpected errors\n", ctx.errors);
+
+	mq_close(ctx.mqd);
+}
+
+static void test_peek_null_prio_ptr(void)
+{
+	mqd_t mqd = open_queue("null_prio", MAX_MSG_SIZE);
+	char buf[MAX_MSG_SIZE];
+	struct mq_timedreceive2_args args = {
+		.msg_len = sizeof(buf),
+		.msg_prio = NULL,
+		.msg_ptr = buf,
+	};
+	long ret;
+
+	send_msg(mqd, PRIO_MED, "no-prio-needed", 14);
+
+	ret = mq_timedreceive2(mqd, &args, MQ_PEEK, 0, NULL);
+	if (ret >= 0)
+		ksft_test_result_pass("peek with NULL msg_prio ptr: OK\n");
+	else
+		ksft_test_result_fail("peek NULL msg_prio: ret=%ld errno=%d (%m)\n", ret, errno);
+
+	mq_close(mqd);
+}
+
+static void test_peek_priority_matches_receive(void)
+{
+	mqd_t mqd = open_queue("prio_match", MAX_MSG_SIZE);
+	char peek_buf[MAX_MSG_SIZE], recv_buf[MAX_MSG_SIZE];
+	unsigned int peek_prio = 0, recv_prio = 0;
+	long peek_ret;
+	ssize_t recv_ret;
+	int pass = 1;
+
+	send_msg(mqd, PRIO_MED, "consistent-prio", 15);
+
+	peek_ret = peek(mqd, 0, peek_buf, sizeof(peek_buf), &peek_prio);
+	if (peek_ret < 0) {
+		ksft_test_result_fail("peek failed: %m\n");
+		mq_close(mqd);
+		return;
+	}
+
+	recv_ret = mq_receive(mqd, recv_buf, sizeof(recv_buf), &recv_prio);
+	if (recv_ret < 0) {
+		ksft_test_result_fail("mq_receive failed: %m\n");
+		mq_close(mqd);
+		return;
+	}
+
+	if (peek_prio != recv_prio) {
+		ksft_test_result_fail("prio mismatch: peek=%u receive=%u\n",
+							peek_prio, recv_prio);
+		pass = 0;
+	}
+	if (pass && peek_ret != recv_ret) {
+		ksft_test_result_fail("size mismatch: peek=%ld receive=%zd\n",
+				      peek_ret, recv_ret);
+		pass = 0;
+	}
+	if (pass && memcmp(peek_buf, recv_buf, (size_t)recv_ret) != 0) {
+		ksft_test_result_fail("payload mismatch between peek and receive\n");
+		pass = 0;
+	}
+	if (pass)
+		ksft_test_result_pass("peeked priority/payload matches mq_receive output\n");
+
+	mq_close(mqd);
+}
+
+static const struct {
+	const char *name;
+	void (*fn)(void);
+} tests[] = {
+	{ "empty queue → EAGAIN", test_peek_empty_queue },
+	{ "invalid fd → EBADF", test_peek_invalid_fd },
+	{ "non-mqueue fd → EBADF", test_peek_non_mqueue_fd },
+	{ "O_WRONLY fd → EBADF", test_peek_writeonly_fd },
+	{ "buffer too small → EMSGSIZE", test_peek_buffer_too_small },
+	{ "bad msg_ptr → EFAULT", test_peek_bad_msg_ptr },
+	{ "OOB index → ENOENT", test_peek_index_out_of_range },
+	{ "basic data+prio correctness", test_peek_basic_data },
+	{ "non-destructive semantics", test_peek_nondestructive },
+	{ "priority ordering across indices", test_peek_priority_order },
+	{ "FIFO within same priority", test_peek_fifo_within_priority },
+	{ "all distinct priority indices", test_peek_all_indices },
+	{ "large multi-segment message", test_peek_large_message },
+	{ "no MQ_PEEK → normal receive", test_no_peek_flag_is_receive },
+	{ "concurrent peek + receive", test_peek_concurrent_receive },
+	{ "NULL msg_prio ptr", test_peek_null_prio_ptr },
+	{ "peeked prio matches mq_receive",
+	  test_peek_priority_matches_receive },
+};
+
+int main(void)
+{
+	unsigned int i;
+	long sc_ret;
+
+	ksft_print_header();
+	ksft_set_plan(ARRAY_SIZE(tests));
+
+	{
+		struct mq_timedreceive2_args probe_args = { 0 };
+
+		sc_ret = mq_timedreceive2((mqd_t)-1, &probe_args, MQ_PEEK, 0,
+					  NULL);
+		if (sc_ret == -1 && errno == ENOSYS)
+			ksft_exit_skip("mq_timedreceive2 syscall not available (NR=%d ENOSYS) — is the kernel too old?\n",
+						__NR_mq_timedreceive2);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		ksft_print_msg("--- [%02u] %s ---\n", i + 1, tests[i].name);
+		tests[i].fn();
+	}
+
+	return ksft_get_fail_cnt() ? 1 : 0;
+}
-- 
2.43.0

