Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5784A33F2
	for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2026 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264185; cv=none; b=g2PSFl2rzuMr+e8Zupt0J9q0hrQc/twRDVaV8Fxp3DQ0c6N0Cf7lkZF+VDMGDlo8ADEf4gHCTph0pH00mzWphbI4SYoZa22ckhcG6+IZNPHei+jeSzP8iwoK39klIYJOfKVyjSKPBVv6DqIa9SW6DDTyIsFBGbO57JeR2DjNTNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264185; c=relaxed/simple;
	bh=Jp2Aln50NgkguwmgPyx5xlIqUgHKmoSn/P6k8EIWKwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kP49hJ0q2oE8Q4QtmHre5CRQzxeExxPpmxTIoVC+ZA4WogD8x5YNP0Yjq+GMylr0X0IOSP+Ldo0hFfQIff8G/cpVxSqKHjhhsfkvhfDIcE9KtQ1cjd8x3VF/eSHJHMpPuvRt0DfnJ7s+/OpbZRhCVSQPnecE+pVGd52ab9OjcPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=erEP7V0q; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erEP7V0q"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-39b910bdf2eso4925a91.2
        for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2026 08:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790264181; x=1790868981; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BcSMTPGgalMKcx++gS/R3rPvteNbhc9fyMuokINX4+g=;
        b=erEP7V0q5Xdr9W8sd6xVthdPzh081F0OmW2M8qni6G1GxL+fZsejBWblnnk26wIsl3
         UBUscwOIi1IoYvx+roan44OETfLoOI0fNuMjizrWEUvjLv6mPAylxgiUpWjRIWuHcx9G
         cO1EF0wM/Go69F2xL0oR8/bbyvOPzG8gu4qHkPAiiTw3z7TZkbTWhet5TjpSP0Vsg7vQ
         jf7hSudriJNNbv+khfAGgG1Ngs+aEsL37YtH6I0DVRmZzmAjkoLWA7s9yrYPDZREvZRm
         fd4jUsAczbBIDfy8xOq9NN35PiCOL6iWr7HSw8hADsvb2IoibKjuxXn5uFNWaEjCDoWx
         tRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790264181; x=1790868981;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BcSMTPGgalMKcx++gS/R3rPvteNbhc9fyMuokINX4+g=;
        b=Ien+Z7fOE5Ffq7j4GhrxP58vlxuFjEwRnZGEpK6aCg3WOAyOlXCyVzZqrw3d+NyrNB
         k+t3wBPUaOWnuN8lotW1+232+Tphru5XUDyukPPogfhbJeLINP64XMlQiQpSHSjw7GEc
         j/Z+IbSPLis9xVA4s0s3m0jJE5GkYvDyLvTrSeWXHoeobWU9iJaU58KxnIgDmIzBcgcm
         XFi/Mi08npsYMGjMkylBhIk9ZWCTVC+cx5DftKfB6XsHxvWcp8oJ0fli1Ciq+mmjJDxH
         M83T/Trljj04IvNlK/00nDv0wO1WB530rec5t/C7MwBsqt5LVIeQhWmzoo4iuPgzYMAN
         L0Lw==
X-Forwarded-Encrypted: i=1; AKwUvBxZRwgVH8pedCZOIMBe+HbOiChFHNK6lgYj1vEXWw9F7WZ+AzRy6NBcWJ/MOmEzuIyM1GnAtFBXcnkX@vger.kernel.org
X-Gm-Message-State: AFuF++m9PIq/oi7wBac3rhufUtV77oLHMNt8TT61/cCj6lna3ESrWKd9
	miq4PCITuJaTH4uZYHPMeO0sISfvztpfSrRyG+K28/JuNDDxHOEbFllx
X-Gm-Gg: AYBFou3HhNXxkQr4Em5TkqnrT1bMv55T3f99yUEHu1RDUx1ngDtw/PqMp9wV1LNtSPD
	PnlMNwNclCfoUcqyDPhSsGqHcNnw0phPcuVeB4Jti+n24ZHJIQh5OMrPjwJaXqitfoZwx0+upHb
	g0wLkLf8Fk/o1x33J3M2Iuqog0gXMUHaaH3N5UZtNpJ4INndVPd07ANJ3O8kbKFvCg1/DVQ6bjB
	eYOawZPfHM9VGJC8s5VBT2VrGcnljiZBBk77Rru7rVuaKM6fZAgN20aLxdr6Nn8FooR3arOw1zf
	xnmVQ31d+gxHMpcz+8vcWqzHReJS5w1jqjiKf6BaRunWNOafIkVDdwOmVQIRV1OQ2mYN1GQD6OJ
	LoUynsX//3zc2o/YMhTUDkGIonWAcwi3JBzyYDcJ3jINDbk+E+3/z3dNA4y3WxFvcwcELGkwC+D
	ujI47IXfTQAQ3BfIiXc4JChE4J/uD19GyJRO0cuY1qlnziQ4lbuyUlHXp6AmX9yqOfmk0v+Cy8F
	+/uqmkFxm3+RhXQaT6E
X-Received: by 2002:a17:90a:e7ca:b0:39e:4c81:6c65 with SMTP id 98e67ed59e1d1-3a0987294ddmr2839319a91.32.1790264181170;
        Thu, 24 Sep 2026 08:36:21 -0700 (PDT)
Received: from Modern-15.. ([223.225.63.228])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972b11d4sm5979066a91.4.2026.09.24.08.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:36:20 -0700 (PDT)
From: mathura kumar <mathura.kumar.tech@gmail.com>
To: brauner@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	corbet@lwn.net,
	mathura.kumar.tech@gmail.com
Subject: [PATCH v4 4/4] Test: Added self-testing and documentation
Date: Thu, 24 Sep 2026 21:05:02 +0530
Message-ID: <20260924153505.620772-5-mathura.kumar.tech@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924153505.620772-1-mathura.kumar.tech@gmail.com>
References: <20260924153505.620772-1-mathura.kumar.tech@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add test coverage to verify system call behavior under
different-different cases.

Update index documentation to include two new doc.
	1) mq_recvmmsg.rst
	2) mq_sendmmsg.rst

The tests validate:
	1) Offset boundries.
	2) Partial success behaviors.
	3) Timeout behavior.

Documentation changes include:
	1) Updated implementation details.
	2) Error handlings mechanism.
	3) Tests details.

Signed-off-by: mathura kumar <mathura.kumar.tech@gmail.com>
---
 Documentation/userspace-api/index.rst       |   2 +
 Documentation/userspace-api/mq_recvmmsg.rst | 207 +++++++++++
 Documentation/userspace-api/mq_sendmmsg.rst | 171 +++++++++
 tools/testing/selftests/ipc/Makefile        |   2 +-
 tools/testing/selftests/ipc/mq_recvmmsg.c   | 392 ++++++++++++++++++++
 tools/testing/selftests/ipc/mq_sendmmsg.c   | 360 ++++++++++++++++++
 6 files changed, 1133 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/userspace-api/mq_recvmmsg.rst
 create mode 100644 Documentation/userspace-api/mq_sendmmsg.rst
 create mode 100644 tools/testing/selftests/ipc/mq_recvmmsg.c
 create mode 100644 tools/testing/selftests/ipc/mq_sendmmsg.c

diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index a68b1bea57a8..4e9cbdd8c3a8 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -22,6 +22,8 @@ System calls
    ioctl/index
    mseal
    rseq
+   mq_recvmmsg
+   mq_sendmmsg
 
 Security-related interfaces
 ===========================
diff --git a/Documentation/userspace-api/mq_recvmmsg.rst b/Documentation/userspace-api/mq_recvmmsg.rst
new file mode 100644
index 000000000000..680e5f1beb0c
--- /dev/null
+++ b/Documentation/userspace-api/mq_recvmmsg.rst
@@ -0,0 +1,207 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+mq_recvmmsg system call
+=============================
+
+This document describes the mq_recvmmsg() system call. It provides
+an overview of the feature, interface specification, design, and
+test specification.
+
+Contents
+--------
+
+        1) Overview
+        2) Functional Specification
+        3) Design
+        4) Test Specification
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
+mq_recvmmsg() introduces a new system call entry point that accepts
+message buffer parameters via a struct argument inside a iovec rather
+than as individual syscall arguments.
+
+One 64-bit variant is provided with compat handling:
+    mq_recvmmsg()
+
+2) Functional Specification
+---------------------------
+
+NAME
+        mq_recvmmsg - receive or peek as a batch of messages from a
+        POSIX message queue
+
+SYNOPSIS
+
+.. code-block:: c
+
+        #include <mqueue.h>
+
+        struct mq_msg_attrs {
+	        __kernel_size_t msg_len;
+	        unsigned int __user *msg_prio;
+	        void __user *msg_ptr;
+        };
+
+        struct mq_mmsg_attrs {
+	        struct iovec __user *msg_attrs_vec;
+	        __kernel_size_t vlen;
+                int *ret;
+        };
+
+        ssize_t mq_recvmmsg(mqd_t mqdes, struct mq_mmsg_attrs *attrs,
+                           unsigned int attrs_len, unsigned int flags,
+                           unsigned long start_idx,
+                           const struct __kernel_timespec *abs_timeout);
+
+
+DESCRIPTION
+        mq_recvmmsg() receives or peeks as a batch of messages from the
+        message queue referred to by the descriptor mqdes.
+
+        The flags argument controls receive behavior. The following
+        flag is defined:
+
+        ``MQ_PEEK``
+                Copies the message into struct mq_msg_attrs without removing it from
+                the queue. The queue is not modified.
+
+        ``MQ_RECV``
+                Copies and consumes messages from the queue up to the count specified
+                by vlen.
+
+        The start_idx argument specifies which message to begin operating on within
+        the priority-ordered queue, relative to the requested batch range.
+
+        The abs_timeout argument specifies an absolute timeout for the entire batch
+        operation. When MQ_PEEK is set, abs_timeout is ignored, since peek is a
+        non-blocking snapshot operation. When MQ_PEEK is not set, abs_timeout be the
+        timeout for the entire batch.
+
+RETURN VALUE
+        On success, returns the number of messages copied into user-space.
+
+        On failure, the function returns an error directly without writing
+        to the ret field of struct mq_mmsg_attrs in two situations:
+
+        * An error occurred before a single message was successfully copied to user space.
+        * new error occurred in writing error itself in ret field of struct mq_mmsg_attrs
+          after partial success before completing batch and passing a bad address in ret can
+          cause successfully dequeued messages to be permanently lost, as userspace has no other
+          way to know about messages already dequeued in the non-peek path.
+
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
+                attrs, msg_ptr, msg_prio, or abs_timeout points to
+                an invalid address or any invalid address.
+
+        ``EINVAL``
+                The batch size is too large, start_idx is inconsistent with the
+                current queue state, flags contains an unrecognized value, or contradictory
+                flags were passed.
+
+        ``EMSGSIZE``
+                msg_len is less than the mq_msgsize attribute of
+                the queue.
+
+        ``E2BIG``
+                attrs_len is greater than PAGE_SIZE.
+
+        ``ETIMEDOUT``
+                Pop path only. The call timed out before a message
+                became available. Never returned on peek path.
+
+        ``ENODATA``
+                No valid message exists matching the given parameters.
+
+        ``ENOMEM``
+                 Insufficient memory to complete the operation.
+
+3) Design
+---------
+
+3.1 Struct-based argument passing
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The message buffer parameters (msg_ptr, msg_len, msg_prio) are consolidated
+into struct mq_msg_attrs rather than passed as individual syscall arguments.
+These are then referenced via struct mq_mmsg_attrs, which contains an
+iovec msg_attrs_vec and a vlen count. The base of msg_attrs_vec holds individual
+mq_msg_attrs entries, and length store struct mq_msg_attrs size.
+
+
+3.2 Compat handling
+~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
+        struct compat_msg_attrs {
+	        compat_size_t msg_len;
+	        compat_uptr_t msg_prio;
+	        compat_uptr_t msg_ptr;
+        };
+
+        struct compat_mq_mmsg_attrs {
+	        compat_uptr_t msg_attrs_vec;
+	        compat_size_t vlen;
+	        compat_uptr_t ret;
+        };
+
+
+The compat entry point performs the necessary conversions before
+calling the shared do_mq_recvmmsg() implementation.
+
+3.3 Peek implementation
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+When MQ_PEEK is set, the implementation locates the target message
+in the priority tree but does not remove it. Two locks are taken:
+the first confirms a message exists before any allocation is
+attempted and retrieve required buffer size to do memory allocation
+outside of critical section, avoiding allocation on empty queues.
+The second protects the kernel temporary buffer copy operation.
+
+3.4 start_idx argument
+~~~~~~~~~~~~~~~~~~~~~~~
+
+The start_idx argument specifies which message to begin operating on within the queue.
+If a batch request fails partway through, user space is expected to supply an updated
+start_idx reflecting the number of messages already handled, failing to do so may result
+in unexpected message delivery.
+
+4) Test Specification
+----------------------
+
+Tests for mq_recvmmsg() should cover the following:
+
+1) Basic receive and peek — Verify that without MQ_PEEK the message is consumed and
+the queue depth decreases by one. Verify that the message body, priority, and return
+value are correct.
+
+2) Offset and boundary handling — Verify that the implementation correctly respects
+batch size and start_idx boundary conditions.
+
+3) Partial success — Verify that when an error occurs mid-batch, the call returns
+successfully with the count of messages processed so far, rather than discarding partial
+results.
+
+
+
+
+
diff --git a/Documentation/userspace-api/mq_sendmmsg.rst b/Documentation/userspace-api/mq_sendmmsg.rst
new file mode 100644
index 000000000000..7b676645177e
--- /dev/null
+++ b/Documentation/userspace-api/mq_sendmmsg.rst
@@ -0,0 +1,171 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+mq_sendmmsg system call
+=============================
+
+This document describes the mq_sendmmsg() system call. It provides
+an overview of the feature, interface specification, design, and
+test specification.
+
+Contents
+--------
+
+        1) Overview
+        2) Functional Specification
+        3) Design
+        4) Test Specification
+
+1) Overview
+-----------
+
+POSIX message queues on Linux provide mq_timedsend() for storing
+messages in a queue one at time.
+
+mq_sendmmsg() introduces a new system call entry point that take
+messages in batch and store in queues.
+
+One 64-bit variant is provided with compat handling:
+    mq_sendmmsg()
+
+2) Functional Specification
+---------------------------
+
+NAME
+        mq_sendmmsg - send messages as a batch to queues.
+
+SYNOPSIS
+
+.. code-block:: c
+
+        #include <mqueue.h>
+
+        struct mq_msg_attrs {
+	        __kernel_size_t msg_len;
+	        unsigned int __user *msg_prio;
+	        void __user *msg_ptr;
+        };
+
+        struct mq_mmsg_attrs {
+	        struct iovec __user *msg_attrs_vec;
+	        __kernel_size_t vlen;
+                int *ret;
+        };
+
+        ssize_t mq_sendmmsg(mqd_t mqdes, struct mq_mmsg_attrs *attrs,
+                           unsigned int attrs_len, unsigned long start_idx,
+                           const struct __kernel_timespec *abs_timeout);
+
+
+DESCRIPTION
+        mq_sendmmsg() send messages in batch to message queue referred
+        to by the descriptor mqdes.
+
+        The start_idx argument specifies which message to begin operating on within
+        relative to the requested batch range.
+
+        The abs_timeout argument specifies an absolute timeout for the entire batch
+        operation.
+
+RETURN VALUE
+        On success, returns the number of messages stored into the queues.
+
+        On failure, the function returns an error directly without writing
+        to the ret field of struct mq_mmsg_attrs in two situations:
+
+        * An error occurred before a single message was successfully stored into the queues.
+        * A new error occurred in writing error itself in ret field of struct mq_mmsg_attrs
+          after partial success before completing batch and passing a bad address in ret can
+          cause successfully enqueued messages to be processed again in a future call, resulting
+          in duplicates, as userspace has no other way to know about messages processed so far in
+          previous call.
+
+
+ERRORS
+        ``EAGAIN``
+                Queue is not empty.
+
+        ``EBADF``
+                mqdes is not a valid message queue descriptor open
+                for reading.
+
+        ``EFAULT``
+                attrs, msg_ptr, msg_prio, or abs_timeout points to
+                an invalid address.
+
+        ``EINVAL``
+                The batch size is too large, start_idx is inconsistent with the
+                current queue state.
+
+        ``EMSGSIZE``
+                msg_len is greater than the mq_msgsize attribute of
+                the queue.
+
+        ``E2BIG``
+                attrs_len is greater than PAGE_SIZE.
+
+        ``ETIMEDOUT``
+                The call timed out before a space became available to store
+                new messages.
+
+        ``ENOMEM``
+                 Insufficient memory to complete the operation.
+
+3) Design
+---------
+
+3.1 Struct-based argument passing
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The message buffer parameters (msg_ptr, msg_len, msg_prio) are consolidated
+into struct mq_msg_attrs rather than passed as individual syscall arguments.
+These are then referenced via struct mq_mmsg_attrs, which contains an
+iovec msg_attrs_vec and a vlen count. The base of msg_attrs_vec holds individual
+mq_msg_attrs entries, and length store struct mq_msg_attrs size.
+
+
+3.2 Compat handling
+~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
+        struct compat_msg_attrs {
+	        compat_size_t msg_len;
+	        compat_uptr_t msg_prio;
+	        compat_uptr_t msg_ptr;
+        };
+
+        struct compat_mq_mmsg_attrs {
+	        compat_uptr_t msg_attrs_vec;
+	        compat_size_t vlen;
+	        compat_uptr_t ret;
+        };
+
+
+The compat entry point performs the necessary conversions before
+calling the shared do_mq_sendmmsg() implementation.
+
+
+3.3 start_idx argument
+~~~~~~~~~~~~~~~~~~~~~~~
+
+The start_idx argument specifies the message at which to begin storing messages in the queue.
+If a batch request fails partway through, user space is expected to supply an updated
+start_idx reflecting the number of messages already handled, failing to do so may result
+in duplicate message passed to the queues.
+
+4) Test Specification
+----------------------
+
+Tests for mq_sendmmsg() should cover the following:
+
+1) Offset and boundary handling — Verify that the implementation work correctly as per
+batch size and start_idx boundary conditions.
+
+2) Partial success — Verify that when an error occurs mid-batch, the call returns
+successfully with the count of messages processed so far.
+
+3) Batch Timeout - Verify batch absolute deadline return expected value when
+queue is completely full.
+
+
+
diff --git a/tools/testing/selftests/ipc/Makefile b/tools/testing/selftests/ipc/Makefile
index fad10f2bb57b..04da0efd67d7 100644
--- a/tools/testing/selftests/ipc/Makefile
+++ b/tools/testing/selftests/ipc/Makefile
@@ -12,7 +12,7 @@ endif
 
 CFLAGS += $(KHDR_INCLUDES)
 
-TEST_GEN_PROGS := msgque
+TEST_GEN_PROGS := msgque mq_recvmmsg mq_sendmmsg
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/ipc/mq_recvmmsg.c b/tools/testing/selftests/ipc/mq_recvmmsg.c
new file mode 100644
index 000000000000..7d464c4d839f
--- /dev/null
+++ b/tools/testing/selftests/ipc/mq_recvmmsg.c
@@ -0,0 +1,392 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+
+#include <fcntl.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/syscall.h>
+#include <sys/uio.h>
+#include <time.h>
+#include <unistd.h>
+#include <linux/time_types.h>
+#include "kselftest.h"
+#include <mqueue.h>
+
+#ifndef __NR_mq_recvmmsg
+#if defined(__alpha__)
+#define __NR_mq_recvmmsg 582
+#else
+#define __NR_mq_recvmmsg 472
+#endif
+#endif
+
+#define MQ_PEEK 0x02
+#define MQ_RECV 0x04
+
+#define MQ_NAME_PREFIX "/mq_peek_test"
+#define MQ_MAXMSG 16
+#define MAX_MSG_SIZE 8192
+
+struct msg_attrs {
+	long msg_len;
+	unsigned int *msg_prio;
+	void *msg_ptr;
+};
+
+struct mmsg_attrs {
+	struct iovec *msg_attrs_vec;
+	long vlen;
+	int *err;
+};
+
+struct batch_slot {
+	struct msg_attrs desc;
+	struct iovec iov;
+	char buf[MAX_MSG_SIZE];
+	unsigned int prio;
+};
+
+static long mq_recvmmsg(mqd_t mqdes, struct mmsg_attrs *attrs, unsigned int attrs_len,
+		       unsigned int flags, unsigned int start_idx,
+		       const struct __kernel_timespec *timeout)
+{
+	return syscall(__NR_mq_recvmmsg, mqdes, attrs, attrs_len, flags,
+		      start_idx, timeout);
+}
+
+static long queue_depth(mqd_t mqd)
+{
+	struct mq_attr attr;
+
+	if (mq_getattr(mqd, &attr))
+		return -1;
+
+	return attr.mq_curmsgs;
+}
+
+static mqd_t open_queue(const char *suffix)
+{
+	static unsigned int seq;
+	char name[128];
+	struct mq_attr attr = {
+		.mq_flags = 0,
+		.mq_maxmsg = MQ_MAXMSG,
+		.mq_msgsize = MAX_MSG_SIZE,
+	};
+
+	mqd_t mqd;
+
+	snprintf(name, sizeof(name), "%s%s_%d_%u", MQ_NAME_PREFIX, suffix, getpid(),
+			seq++);
+
+	mq_unlink(name);
+
+	mqd = mq_open(name, O_NONBLOCK | O_RDWR | O_CREAT | O_EXCL, 0600, &attr);
+	if (mqd == (mqd_t)-1) {
+		ksft_test_result_fail("mq_open(%s) failed: %m\n", name);
+		ksft_exit_fail();
+	}
+
+	mq_unlink(name);
+	return mqd;
+}
+
+static void build_slot(struct batch_slot *slot)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->desc.msg_len = sizeof(slot->buf);
+	slot->desc.msg_prio = &slot->prio;
+	slot->desc.msg_ptr = slot->buf;
+	slot->iov.iov_base = &slot->desc;
+	slot->iov.iov_len = sizeof(slot->desc);
+}
+
+static void build_slots(struct batch_slot *slots, size_t nr)
+{
+	size_t i;
+
+	for (i = 0; i < nr; i++)
+		build_slot(&slots[i]);
+}
+
+static long batch_recv(mqd_t mqd, struct batch_slot *slots, size_t nr,
+		      int *err, unsigned int flags, unsigned int start_idx,
+		      const struct __kernel_timespec *timeout)
+{
+	struct iovec vec[MQ_MAXMSG];
+	struct mmsg_attrs attrs;
+	size_t i;
+
+	for (i = 0; i < nr; i++)
+		vec[i] = slots[i].iov;
+
+	attrs.msg_attrs_vec = vec;
+	attrs.vlen = nr;
+	attrs.err = err;
+
+	return mq_recvmmsg(mqd, &attrs, sizeof(attrs), flags, start_idx,
+			  timeout);
+}
+
+
+static void send_or_die(mqd_t mqd, unsigned int prio, const char *payload)
+{
+	if (mq_send(mqd, payload, strlen(payload), prio)) {
+		ksft_test_result_fail("mq_send(%s, %u) failed: %m\n",
+				      payload, prio);
+		ksft_exit_fail();
+	}
+}
+
+static bool check_slot(const struct batch_slot *slot, const char *payload,
+		      unsigned int prio)
+{
+	size_t len = strlen(payload);
+
+	if (slot->prio != prio)
+		return false;
+	if (memcmp(slot->buf, payload, len))
+		return false;
+	return true;
+}
+
+static void test_peek_batch_success_count(void)
+{
+	mqd_t mqd = open_queue("peek_count");
+	struct batch_slot slots[3];
+	long ret;
+	int err;
+
+	send_or_die(mqd, 1, "low");
+	send_or_die(mqd, 9, "high");
+
+	build_slots(slots, ARRAY_SIZE(slots));
+	ret = batch_recv(mqd, slots, ARRAY_SIZE(slots), &err, MQ_PEEK, 0, NULL);
+
+	if (ret != 2) {
+		ksft_test_result_fail("peek count: ret=%ld expected=2\n", ret);
+		goto out;
+	}
+	if (!check_slot(&slots[0], "high", 9) ||
+	    !check_slot(&slots[1], "low", 1)) {
+		ksft_test_result_fail("peek count: payload/prio mismatch\n");
+		goto out;
+	}
+	if (queue_depth(mqd) != 2) {
+		ksft_test_result_fail("peek count: queue depth changed to %ld\n",
+				      queue_depth(mqd));
+		goto out;
+	}
+
+	ksft_test_result_pass("peek batch returns number of successful messages\n");
+out:
+	mq_close(mqd);
+}
+
+static void test_receive_batch_success_count(void)
+{
+	static const struct __kernel_timespec expired = { 0, 0 };
+	mqd_t mqd = open_queue("recv_count");
+	struct batch_slot slots[3];
+	long ret;
+	int err;
+
+	send_or_die(mqd, 2, "two");
+	send_or_die(mqd, 7, "seven");
+
+	build_slots(slots, ARRAY_SIZE(slots));
+	ret = batch_recv(mqd, slots, ARRAY_SIZE(slots), &err, MQ_RECV, 0, &expired);
+
+	if (ret != 2) {
+		ksft_test_result_fail("receive count: ret=%ld expected=2\n", ret);
+		goto out;
+	}
+	if (!check_slot(&slots[0], "seven", 7) ||
+	    !check_slot(&slots[1], "two", 2)) {
+		ksft_test_result_fail("receive count: payload/prio mismatch\n");
+		goto out;
+	}
+	if (queue_depth(mqd) != 0) {
+		ksft_test_result_fail("receive count: queue depth=%ld expected=0\n",
+				      queue_depth(mqd));
+		goto out;
+	}
+
+	ksft_test_result_pass("receive batch returns success count and consumes messages\n");
+out:
+	mq_close(mqd);
+}
+
+static void test_peek_start_idx_uses_absolute_index(void)
+{
+	mqd_t mqd = open_queue("peek_offset");
+	struct batch_slot slots[3];
+	long ret;
+	int err;
+
+	send_or_die(mqd, 9, "high");
+	send_or_die(mqd, 5, "mid");
+	send_or_die(mqd, 1, "low");
+
+	build_slots(slots, ARRAY_SIZE(slots));
+	memset(slots[0].buf, 0x5a, sizeof(slots[0].buf));
+	ret = batch_recv(mqd, slots, ARRAY_SIZE(slots), &err, MQ_PEEK, 1, NULL);
+
+	if (ret != 2) {
+		ksft_test_result_fail("peek start_idx: ret=%ld expected=2\n", ret);
+		goto out;
+	}
+	if (!check_slot(&slots[1], "mid", 5) ||
+	    !check_slot(&slots[2], "low", 1)) {
+		ksft_test_result_fail("peek start_idx: wrong messages returned\n");
+		goto out;
+	}
+	if (slots[0].buf[0] != 0x5a) {
+		ksft_test_result_fail("peek start_idx: slot 0 was written by kernel unnecessarily\n");
+		goto out;
+	}
+
+	ksft_test_result_pass("peek start_idx maps directly to queue\n");
+out:
+	mq_close(mqd);
+}
+
+static void test_receive_start_idx_not_receives_from_outside_range(void)
+{
+	mqd_t mqd = open_queue("recv_offset");
+	struct batch_slot slots[3];
+	long ret;
+	int err;
+
+	send_or_die(mqd, 8, "first");
+	send_or_die(mqd, 3, "second");
+
+	build_slots(slots, ARRAY_SIZE(slots));
+	memset(slots[0].buf, 0x6b, sizeof(slots[0].buf));
+	ret = batch_recv(mqd, slots, ARRAY_SIZE(slots), &err, MQ_RECV, 1, NULL);
+
+	if (ret != 2) {
+		ksft_test_result_fail("receive start_idx: ret=%ld expected=2\n",
+				     ret);
+		goto out;
+	}
+	if (!check_slot(&slots[1], "first", 8) ||
+		!check_slot(&slots[2], "second", 3)) {
+		ksft_test_result_fail("receive start_idx: wrong receive order\n");
+		goto out;
+	}
+	if (slots[0].buf[0] != 0x6b) {
+		ksft_test_result_fail("receive start_idx: slot 0 was written by kernel unnecessarily\n");
+		goto out;
+	}
+
+	ksft_test_result_pass("non-peek path ignores queue indexing and receives from head within range\n");
+out:
+	mq_close(mqd);
+}
+
+static void test_peek_partial_success_on_small_buffer(void)
+{
+	mqd_t mqd = open_queue("peek_small");
+	struct batch_slot slots[2];
+	long ret;
+	int err;
+
+	send_or_die(mqd, 9, "abc");
+	send_or_die(mqd, 4, "1234");
+
+	build_slots(slots, ARRAY_SIZE(slots));
+	slots[1].desc.msg_len = 1;
+	ret = batch_recv(mqd, slots, ARRAY_SIZE(slots), &err, MQ_PEEK, 0, NULL);
+
+	if (ret != 1) {
+		ksft_test_result_fail("peek partial small buffer: ret=%ld expected=1\n",
+				      ret);
+		goto out;
+	}
+	if (!check_slot(&slots[0], "abc", 9)) {
+		ksft_test_result_fail("peek partial small buffer: first slot mismatch\n");
+		goto out;
+	}
+	if (queue_depth(mqd) != 2) {
+		ksft_test_result_fail("peek partial small buffer: queue depth=%ld expected=2\n",
+				      queue_depth(mqd));
+		goto out;
+	}
+
+	ksft_test_result_pass("peek batch reports completed so far before EMSGSIZE\n");
+out:
+	mq_close(mqd);
+}
+
+static void test_receive_partial_success_on_bad_desc_len(void)
+{
+	mqd_t mqd = open_queue("recv_desc");
+	struct batch_slot slots[2];
+	long ret;
+	int err;
+
+	send_or_die(mqd, 6, "driver");
+	send_or_die(mqd, 2, "module");
+
+	build_slots(slots, ARRAY_SIZE(slots));
+	slots[1].iov.iov_len = sizeof(slots[1].desc) - 1;
+	ret = batch_recv(mqd, slots, ARRAY_SIZE(slots), &err, MQ_RECV, 0, NULL);
+
+	if (ret != 1) {
+		ksft_test_result_fail("receive partial desc len: ret=%ld expected=1\n",
+				      ret);
+		goto out;
+	}
+	if (!check_slot(&slots[0], "driver", 6)) {
+		ksft_test_result_fail("receive partial desc len: first slot mismatch\n");
+		goto out;
+	}
+	if (queue_depth(mqd) != 1) {
+		ksft_test_result_fail("receive partial desc len: queue depth=%ld expected=1\n",
+				      queue_depth(mqd));
+		goto out;
+	}
+
+	ksft_test_result_pass("receive batch reports completed so far before descriptor error\n");
+out:
+	mq_close(mqd);
+}
+
+static const struct {
+	const char *name;
+	void (*fn)(void);
+} tests[] = {
+	{ "peek batch success count", test_peek_batch_success_count },
+	{ "receive batch success count", test_receive_batch_success_count },
+	{ "peek absolute index with start_idx", test_peek_start_idx_uses_absolute_index },
+	{ "receive start_idx obey offset boundary", test_receive_start_idx_not_receives_from_outside_range },
+	{ "peek partial success before EMSGSIZE", test_peek_partial_success_on_small_buffer },
+	{ "receive partial success before desc error", test_receive_partial_success_on_bad_desc_len },
+};
+
+int main(void)
+{
+	size_t i;
+	struct batch_slot probe;
+	long ret;
+	int err;
+
+	ksft_print_header();
+
+	build_slot(&probe);
+	ret = batch_recv((mqd_t)-1, &probe, 1, &err, MQ_PEEK, 0, NULL);
+	if (ret == -1 && errno == ENOSYS)
+		ksft_exit_skip("mq_recvmmsg syscall not available\n");
+
+	ksft_set_plan(ARRAY_SIZE(tests));
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		ksft_print_msg("[%02zu] %s\n", i + 1, tests[i].name);
+		tests[i].fn();
+	}
+
+	return ksft_get_fail_cnt() ? 1 : 0;
+}
diff --git a/tools/testing/selftests/ipc/mq_sendmmsg.c b/tools/testing/selftests/ipc/mq_sendmmsg.c
new file mode 100644
index 000000000000..3f51ba75d1cb
--- /dev/null
+++ b/tools/testing/selftests/ipc/mq_sendmmsg.c
@@ -0,0 +1,360 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+
+#include <fcntl.h>
+#include <mqueue.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/syscall.h>
+#include <sys/uio.h>
+#include <time.h>
+#include <unistd.h>
+#include <linux/time_types.h>
+#include "kselftest.h"
+
+#ifndef __NR_mq_sendmmsg
+#if defined(__alpha__)
+#define __NR_mq_sendmmsg 583
+#else
+#define __NR_mq_sendmmsg 473
+#endif
+#endif
+
+#define MQ_NAME_PREFIX "/mq_sendmmsg_test_"
+#define MQ_MAXMSG 16
+#define MAX_MSG_SIZE 128
+
+struct msg_attrs {
+	long msg_len;
+	unsigned int *msg_prio;
+	void *msg_ptr;
+};
+
+struct mmsg_attrs {
+	struct iovec *msg_attrs_vec;
+	long vlen;
+	int *err;
+};
+
+struct send_slot {
+	struct msg_attrs desc;
+	struct iovec iov;
+	const char *payload;
+	unsigned int prio;
+};
+
+static long mq_sendmmsg(mqd_t mqdes, struct mmsg_attrs *attrs,
+		       unsigned int attrs_len, unsigned long start_idx,
+		       const struct __kernel_timespec *timeout)
+{
+	return syscall(__NR_mq_sendmmsg, mqdes, attrs, attrs_len, start_idx,
+		      timeout);
+}
+
+static mqd_t open_queue_rw(const char *suffix, unsigned int O_FLAGS, long maxmsg)
+{
+	static unsigned int seq;
+	char name[128];
+	struct mq_attr attr = {
+		.mq_flags = 0,
+		.mq_maxmsg = maxmsg,
+		.mq_msgsize = MAX_MSG_SIZE,
+	};
+
+	mqd_t mqd;
+
+	snprintf(name, sizeof(name), "%s%s_%d_%u", MQ_NAME_PREFIX, suffix, getpid(), seq++);
+	mq_unlink(name);
+
+	mqd = mq_open(name, O_FLAGS, 0600, &attr);
+	if (mqd == (mqd_t)-1) {
+		ksft_test_result_fail("mq_open(%s) failed: %m\n", name);
+		ksft_exit_fail();
+	}
+
+	mq_unlink(name);
+	return mqd;
+}
+
+static void init_send_slot(struct send_slot *slot, const char *payload,
+			  unsigned int prio)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->payload = payload;
+	slot->prio = prio;
+	slot->desc.msg_len = strlen(payload);
+	slot->desc.msg_prio = &slot->prio;
+	slot->desc.msg_ptr = (void *)payload;
+	slot->iov.iov_base = &slot->desc;
+	slot->iov.iov_len = sizeof(slot->desc);
+}
+
+static void init_send_slots(struct send_slot *slots, char *const *payloads,
+			   const unsigned int *prios, size_t nr)
+{
+	size_t i;
+
+	for (i = 0; i < nr; i++)
+		init_send_slot(&slots[i], payloads[i], prios[i]);
+}
+
+static long batch_send(mqd_t mqd, struct send_slot *slots, size_t nr, int *err,
+		      unsigned int start_idx,
+		      const struct __kernel_timespec *timeout)
+{
+	struct iovec vec[MQ_MAXMSG];
+	struct mmsg_attrs attrs;
+	size_t i;
+
+	for (i = 0; i < nr; i++)
+		vec[i] = slots[i].iov;
+
+	attrs.msg_attrs_vec = vec;
+	attrs.vlen = nr;
+	attrs.err = err;
+
+	return mq_sendmmsg(mqd, &attrs, sizeof(attrs), start_idx, timeout);
+}
+
+static long queue_depth(mqd_t mqd)
+{
+	struct mq_attr attr;
+
+	if (mq_getattr(mqd, &attr))
+		return -1;
+
+	return attr.mq_curmsgs;
+}
+
+static bool recv_expect(mqd_t mqd, const char *payload, unsigned int prio)
+{
+	char buf[MAX_MSG_SIZE];
+	unsigned int got_prio = 0;
+	ssize_t ret;
+	size_t len = strlen(payload);
+
+	memset(buf, 0, sizeof(buf));
+	ret = mq_receive(mqd, buf, sizeof(buf), &got_prio);
+	if (ret < 0)
+		return false;
+	if ((size_t)ret != len)
+		return false;
+	if (got_prio != prio)
+		return false;
+	if (memcmp(buf, payload, len))
+		return false;
+	return true;
+}
+
+static void test_start_idx_obeys_offset(void)
+{
+	mqd_t mqd = open_queue_rw("offset", O_NONBLOCK | O_RDWR | O_CREAT | O_EXCL, MQ_MAXMSG);
+	struct send_slot slots[3];
+	static char *const payloads[] = { "first", "second", "third" };
+	unsigned int prios[] = { 1, 5, 9 };
+	long ret;
+	int err;
+
+	init_send_slots(slots, payloads, prios, ARRAY_SIZE(slots));
+	ret = batch_send(mqd, slots, ARRAY_SIZE(slots), &err, 1, NULL);
+
+	if (ret != 2) {
+		ksft_test_result_fail("start_idx skip: ret=%ld expected=2\n", ret);
+		goto out;
+	}
+	if (queue_depth(mqd) != 2) {
+		ksft_test_result_fail("start_idx skip: queue depth=%ld expected=2\n",
+				     queue_depth(mqd));
+		goto out;
+	}
+	if (!recv_expect(mqd, "third", 9) ||
+		!recv_expect(mqd, "second", 5)) {
+		ksft_test_result_fail("start_idx skip: wrong messages sent\n");
+		goto out;
+	}
+
+	ksft_test_result_pass("start_idx skips earlier descriptors\n");
+out:
+	mq_close(mqd);
+}
+
+static void test_partial_success_on_null_prio(void)
+{
+	mqd_t mqd = open_queue_rw("null_prio", O_NONBLOCK | O_RDWR | O_CREAT | O_EXCL, MQ_MAXMSG);
+	struct send_slot slots[2];
+	static char *const payloads[] = { "ok", "bad" };
+	unsigned int prios[] = { 7, 3 };
+	long ret;
+	int err;
+
+	init_send_slots(slots, payloads, prios, ARRAY_SIZE(slots));
+	slots[1].desc.msg_prio = NULL;
+	ret = batch_send(mqd, slots, ARRAY_SIZE(slots), &err, 0, NULL);
+
+	if (ret != 1) {
+		ksft_test_result_fail("partial null prio: ret=%ld expected=1\n", ret);
+		goto out;
+	}
+	if (queue_depth(mqd) != 1 || !recv_expect(mqd, "ok", 7)) {
+		ksft_test_result_fail("partial null prio: queue contents mismatch\n");
+		goto out;
+	}
+
+	ksft_test_result_pass("completed prefix is returned before NULL prio error\n");
+out:
+	mq_close(mqd);
+}
+
+static void test_partial_success_on_bad_desc_len(void)
+{
+	mqd_t mqd = open_queue_rw("bad_desc", O_NONBLOCK | O_RDWR | O_CREAT | O_EXCL, MQ_MAXMSG);
+	struct send_slot slots[2];
+	static char *const payloads[] = { "ok", "bad" };
+	unsigned int prios[] = { 8, 2 };
+	long ret;
+	int err;
+
+	init_send_slots(slots, payloads, prios, ARRAY_SIZE(slots));
+	slots[1].iov.iov_len = sizeof(slots[1].desc) - 1;
+	ret = batch_send(mqd, slots, ARRAY_SIZE(slots), &err, 0, NULL);
+
+	if (ret != 1) {
+		ksft_test_result_fail("partial bad desc len: ret=%ld expected=1\n", ret);
+		goto out;
+	}
+	if (queue_depth(mqd) != 1 || !recv_expect(mqd, "ok", 8)) {
+		ksft_test_result_fail("partial bad desc len: queue contents mismatch\n");
+		goto out;
+	}
+
+	ksft_test_result_pass("completed prefix is returned before descriptor error\n");
+out:
+	mq_close(mqd);
+}
+
+static void test_partial_success_on_bad_prio_ptr(void)
+{
+	mqd_t mqd = open_queue_rw("bad_prio_ptr", O_NONBLOCK | O_RDWR | O_CREAT | O_EXCL, MQ_MAXMSG);
+	struct send_slot slots[2];
+	static char *const payloads[] = { "ok", "bad" };
+	unsigned int prios[] = { 6, 4 };
+	long ret;
+	int err;
+
+	init_send_slots(slots, payloads, prios, ARRAY_SIZE(slots));
+	slots[1].desc.msg_prio = (void *)1;
+	ret = batch_send(mqd, slots, ARRAY_SIZE(slots), &err, 0, NULL);
+
+	if (ret != 1) {
+		ksft_test_result_fail("partial bad prio ptr: ret=%ld expected=1\n", ret);
+		goto out;
+	}
+	if (queue_depth(mqd) != 1 || !recv_expect(mqd, "ok", 6)) {
+		ksft_test_result_fail("partial bad prio ptr: queue contents mismatch\n");
+		goto out;
+	}
+
+	ksft_test_result_pass("completed prefix is returned before bad prio pointer fault\n");
+out:
+	mq_close(mqd);
+}
+
+static void test_full_queue_timeout(void)
+{
+	static const struct __kernel_timespec expired = { 0, 0 };
+	mqd_t mqd = open_queue_rw("full_timeout", O_RDWR | O_CREAT | O_EXCL, 1);
+	struct send_slot slot;
+	long ret;
+	int err;
+
+	init_send_slot(&slot, "first", 1);
+	ret = batch_send(mqd, &slot, 1, &err, 0, NULL);
+	if (ret != 1)
+		ksft_exit_fail_msg("failed to prefill queue\n");
+
+	init_send_slot(&slot, "second", 2);
+	ret = batch_send(mqd, &slot, 1, &err, 0, &expired);
+
+	if (ret == -1 && errno == ETIMEDOUT && queue_depth(mqd) == 1)
+		ksft_test_result_pass("full queue with expired timeout returns ETIMEDOUT\n");
+	else
+		ksft_test_result_fail("full queue timeout: ret=%ld errno=%d depth=%ld\n",
+				     ret, errno, queue_depth(mqd));
+
+	mq_close(mqd);
+}
+
+static void test_partial_success_when_queue_fills(void)
+{
+	static const struct __kernel_timespec expired = { 0, 0 };
+	mqd_t mqd = open_queue_rw("queue_fills", O_NONBLOCK | O_RDWR | O_CREAT | O_EXCL, 2);
+	struct send_slot slots[2];
+	static char *const payloads[] = { "fit", "overflow" };
+	unsigned int prios[] = { 1, 2 };
+	long ret;
+	int err;
+
+	init_send_slot(&slots[0], "prefill", 3);
+	ret = batch_send(mqd, &slots[0], 1, &err, 0, NULL);
+	if (ret != 1)
+		ksft_exit_fail_msg("failed to prefill queue\n");
+
+	init_send_slots(slots, payloads, prios, ARRAY_SIZE(slots));
+	ret = batch_send(mqd, slots, ARRAY_SIZE(slots), &err, 0, &expired);
+
+	if (ret != 1) {
+		ksft_test_result_fail("queue fills partial: ret=%ld expected=1\n", ret);
+		goto out;
+	}
+	if (queue_depth(mqd) != 2) {
+		ksft_test_result_fail("queue fills partial: depth=%ld expected=2\n",
+				     queue_depth(mqd));
+		goto out;
+	}
+	if (!recv_expect(mqd, "prefill", 3) || !recv_expect(mqd, "fit", 1)) {
+		ksft_test_result_fail("queue fills partial: queue contents mismatch\n");
+		goto out;
+	}
+
+	ksft_test_result_pass("completed operation is returned when queue fills mid-batch\n");
+out:
+	mq_close(mqd);
+}
+
+static const struct {
+	const char *name;
+	void (*fn)(void);
+} tests[] = {
+	{ "start_idx obey offset", test_start_idx_obeys_offset },
+	{ "partial success on NULL prio", test_partial_success_on_null_prio },
+	{ "partial success on bad desc len", test_partial_success_on_bad_desc_len },
+	{ "partial success on bad prio pointer", test_partial_success_on_bad_prio_ptr },
+	{ "full queue timeout", test_full_queue_timeout },
+	{ "partial success when queue fills", test_partial_success_when_queue_fills },
+};
+
+int main(void)
+{
+	size_t i;
+	struct send_slot probe;
+	long ret;
+	int err;
+
+	ksft_print_header();
+
+	init_send_slot(&probe, "probe", 1);
+	ret = batch_send((mqd_t)-1, &probe, 1, &err, 0, NULL);
+	if (ret == -1 && errno == ENOSYS)
+		ksft_exit_skip("mq_sendmmsg syscall not available\n");
+
+	ksft_set_plan(ARRAY_SIZE(tests));
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		ksft_print_msg("[%02zu] %s\n", i + 1, tests[i].name);
+		tests[i].fn();
+	}
+
+	return ksft_get_fail_cnt() ? 1 : 0;
+}
-- 
2.43.0

