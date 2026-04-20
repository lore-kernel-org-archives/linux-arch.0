Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE71239EF22
	for <linux-arch@vger.kernel.org>; Mon, 20 Apr 2026 12:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776688140; cv=none; b=rKqCYqw9JHuC+Tyu+w4cw+ZK2vQouNsv+ZatDLrTpQQiu+CtK8DvJPuivO9peyPk38DfO9vMjt3XszFI/YEH0Dq+4wXqBgK68uCUqYI5R0JmRuLRVZUK6HsYbdezt6mopfaRDxnBIQhLBr+0iJwAL/IjBR3z4AGGslp97GjYrh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776688140; c=relaxed/simple;
	bh=YrG/fz4XHy0lJrNq0ioWe/eV0p1dqVvTCjwS+fLU/zA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NWN9z1ni9Q1knHNetpqN7ecDTkaxeUU+e9c9a5kqlfSskFf2WXvJquuJWqSYjAKqSd6zmh4zUVt0Z3fh1pemTmVYJUdiIFJ8ow8LeXXHJAe0rEslEXyogJ0V7loY9GPa0aMltwfEEIYslq3uGrHYhXdgZLlTy1P+LzDA+6mCyAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ExcHd0My; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ExcHd0My"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776688138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3l6GbX/2lVpz4UfXca0mAc0lkb+4W+wizL4Pd4I2yo4=;
	b=ExcHd0MyB5WBB/9GXeNvXFScnoEXDaTj7BmEbWJP5j75YEEE4F9s0bKK6nREiofJu6d9Mz
	ifChEBjO5NI7Fbv8VD6d3ZG0MHnXYbxJP+95C8Us+EMkftDAn5zRVVetj/CfjF0UIp2dcQ
	fs6eq0/u+EI5qOBo4bWhLtw4fjCnYzI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-P4q0mrtLNheUCtkDTUhjUQ-1; Mon,
 20 Apr 2026 08:28:52 -0400
X-MC-Unique: P4q0mrtLNheUCtkDTUhjUQ-1
X-Mimecast-MFC-AGG-ID: P4q0mrtLNheUCtkDTUhjUQ_1776688129
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 70F0D1955E98;
	Mon, 20 Apr 2026 12:28:48 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 031F1195608E;
	Mon, 20 Apr 2026 12:28:40 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v7 0/5] kunit: Add support for suppressing warning
 backtraces
Date: Mon, 20 Apr 2026 14:28:02 +0200
Message-Id: <20260420-kunit_add_support-v7-0-e8bc6e0f70de@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23OQQqDMBCF4auUrBtJIoltV71HEYnOWEPRyCRKi
 3j3RkHoost/8T7ewgKSw8Bup4URzi44P6QozifWdHZ4IneQmimhjMil4q9pcLGyAFWYxtFT5Kr
 N9UWYWl4BWNqNhK177+ajTN2S73nsCO0haaGVkbkqtM6kMVILLrltLPVusHdC6GzMGt9vWudC9
 PTZD85mM48vxZ8vs+GCAyhlsc5b1PCrleu6fgFJm/oM8QAAAA==
X-Change-ID: 20260312-kunit_add_support-2f35806b19dd
To: Arnd Bergmann <arnd@arndb.de>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Rae Moar <raemoar63@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 dri-devel@lists.freedesktop.org, workflows@vger.kernel.org, 
 linux-doc@vger.kernel.org, peterz@infradead.org, 
 Alessandro Carminati <acarmina@redhat.com>, 
 Guenter Roeck <linux@roeck-us.net>, Kees Cook <kees@kernel.org>, 
 Albert Esteve <aesteve@redhat.com>, 
 Linux Kernel Functional Testing <lkft@linaro.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Kees Cook <kees@kernel.org>, Simona Vetter <simona.vetter@ffwll.ch>, 
 David Gow <david@davidgow.net>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776688120; l=9728;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=YrG/fz4XHy0lJrNq0ioWe/eV0p1dqVvTCjwS+fLU/zA=;
 b=q5SKRV4o4hy7KRKMOH2/JPN3oAAbwazbCSZH2r6W5M8vvM7GKK+d/EMQ1uIyqN9JbB9TY1Lca
 MDedWnPfyLjCvYsXteZ+iuMz6LkErvJb/1ePt8cB5JFgN5bgQtbZIko
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Some unit tests intentionally trigger warning backtraces by passing bad
parameters to kernel API functions. Such unit tests typically check the
return value from such calls, not the existence of the warning backtrace.

Such intentionally generated warning backtraces are neither desirable
nor useful for a number of reasons:
- They can result in overlooked real problems.
- A warning that suddenly starts to show up in unit tests needs to be
  investigated and has to be marked to be ignored, for example by
  adjusting filter scripts. Such filters are ad hoc because there is
  no real standard format for warnings. On top of that, such filter
  scripts would require constant maintenance.

One option to address the problem would be to add messages such as
"expected warning backtraces start/end here" to the kernel log.
However, that would again require filter scripts, might result in
missing real problematic warning backtraces triggered while the test
is running, and the irrelevant backtrace(s) would still clog the
kernel log.

Solve the problem by providing a means to identify and suppress specific
warning backtraces while executing test code. Support suppressing multiple
backtraces while at the same time limiting changes to generic code to the
absolute minimum.

Overview:
Patch#1 Introduces the suppression infrastructure.
Patch#2 Mitigates the impact of suppression.
Patch#3 Adds selftests to validate the functionality.
Patch#4 Demonstrates real-world usage in the DRM subsystem.
Patch#5 Documents the new API and usage guidelines.

Design Notes:
The objective is to suppress unwanted WARN*() generated messages.

Although most major architectures share common bug handling via `lib/bug.c`
and `report_bug()`, some minor or legacy architectures still rely on their
own platform-specific handling. This divergence must be considered in any
such feature. Additionally, a key challenge in implementing this feature is
the fragmentation of `WARN*()` message emission: part of the output is
produced in the macro itself (via __warn_printk()), and part in the exception
handler.

Lessons from the Previous Attempt:
In earlier iterations, suppression logic was added inside the
`__report_bug()` function to intercept WARN*() output. To implement the
check in the bug handler code, two strategies were considered:

* Strategy #1: Use `kallsyms` to infer the originating function. This
  approach proved unreliable due to compiler-induced transformations
  such as inlining, cloning, and code fragmentation.

* Strategy #2: Store function name `__func__` in `struct bug_entry` in
  the `__bug_table`. However, `__func__` is a compiler-generated symbol,
  which complicates relocation and linking in position-independent code.
  Additionally, architectures not using the unified `BUG()` path would
  still require ad-hoc handling.

A per-macro solution was also attempted (v5-v6), injecting checks
directly into the `WARN*()` macros in `include/asm-generic/bug.h`.
While this offered full control, it required modifying the generic
bug header and was considered too invasive and damaging the critical
path, and thus incorrect [1].

Current Proposal: Check in `warn_slowpath_fmt()` and `__report_bug()`.
Suppression is checked at two points in the warning path:
- In `warn_slowpath_fmt()` (kernel/panic.c), for architectures without
  __WARN_FLAGS. The check runs before any output, fully suppressing
  both message and backtrace.
- In `__report_bug()` (lib/bug.c), for architectures that define
  __WARN_FLAGS. The check runs before `__warn()` is called, suppressing
  the backtrace and stack dump. On this path, the `WARN()` format message
  may still appear in the kernel log since `__warn_printk()` executes
  before the trap.
This approach avoids modifying include/asm-generic/bug.h entirely,
requires no architecture-specific code, and limits changes to generic
code to the absolute minimum.

A helper function, `__kunit_is_suppressed_warning()`, walks an RCU-
protected list of active suppressions, matching by current task. The
suppression state is dynamically allocated via kunit_kzalloc() and
tied to the KUnit test lifecycle via kunit_add_action(), ensuring
automatic cleanup at test exit.

To minimize runtime impact when no suppressions are active, an atomic
counter tracks the number of active suppressions.
`__kunit_is_suppressed_warning()` checks this counter first and returns
immediately when it is zero, avoiding the RCU-protected list traversal
in the common case.

This series is based on the RFC patch and subsequent discussion at
https://patchwork.kernel.org/project/linux-kselftest/patch/02546e59-1afe-4b08-ba81-d94f3b691c9a@moroto.mountain/
and offers a more comprehensive solution of the problem discussed there.

[1] https://lore.kernel.org/all/CAGegRW76X8Fk_5qqOBw_aqBwAkQTsc8kXKHEuu9ECeXzdJwMSw@mail.gmail.com/

Changes since RFC:
- Introduced CONFIG_KUNIT_SUPPRESS_BACKTRACE
- Minor cleanups and bug fixes
- Added support for all affected architectures
- Added support for counting suppressed warnings
- Added unit tests using those counters
- Added patch to suppress warning backtraces in dev_addr_lists tests

Changes since v1:
- Rebased to v6.9-rc1
- Added Tested-by:, Acked-by:, and Reviewed-by: tags
  [I retained those tags since there have been no functional changes]
- Introduced KUNIT_SUPPRESS_BACKTRACE configuration option, enabled by
  default.

Changes since v2:
- Rebased to v6.9-rc2
- Added comments to drm warning suppression explaining why it is needed.
- Added patch to move conditional code in arch/sh/include/asm/bug.h
  to avoid kerneldoc warning
- Added architecture maintainers to Cc: for architecture specific patches
- No functional changes

Changes since v3:
- Rebased to v6.14-rc6
- Dropped net: "kunit: Suppress lock warning noise at end of dev_addr_lists tests"
  since 3db3b62955cd6d73afde05a17d7e8e106695c3b9
- Added __kunit_ and KUNIT_ prefixes.
- Tested on interessed architectures.

Changes since v4:
- Rebased to v6.15-rc7
- Dropped all code in __report_bug()
- Moved all checks in WARN*() macros.
- Dropped all architecture specific code.
- Made __kunit_is_suppressed_warning nice to noinstr functions.

Changes since v5:
- Rebased to v7.0-rc3
- Added RCU protection for the suppressed warnings list.
- Added static key and branching optimization.
- Removed custom `strcmp` implementation and reworked
  __kunit_is_suppressed_warning() entrypoint function.

Changes since v6:
- Moved suppression checks from WARN*() macros to warn_slowpath_fmt()
  and __report_bug().
- Replaced stack-allocated suppression struct with kunit_kzalloc() heap
  allocation tied to the KUnit test lifecycle.
- Changed suppression strategy from function-name matching to task-scoped:
  all warnings on the current task are suppressed between START and END,
  rather than only warnings originating from a specific named function.
- Simplified macro API: removed KUNIT_DECLARE_SUPPRESSED_WARNING(),
  the START macro now takes (test) and handles allocation internally.
- Removed static key and branching optiomization, as by the time it
  was executed, callers are already in warn slowpaths.
- Link to v6: https://lore.kernel.org/r/20260317-kunit_add_support-v6-0-dd22aeb3fe5d@redhat.com

Alessandro Carminati (2):
  bug/kunit: Core support for suppressing warning backtraces
  bug/kunit: Suppressing warning backtraces reduced impact on WARN*()
    sites

Guenter Roeck (3):
  Add unit tests to verify that warning backtrace suppression works.
  drm: Suppress intentional warning backtraces in scaling unit tests
  kunit: Add documentation for warning backtrace suppression API

 Documentation/dev-tools/kunit/usage.rst |  30 ++++++-
 drivers/gpu/drm/tests/drm_rect_test.c   |  16 ++++
 include/asm-generic/bug.h               |  48 +++++++----
 include/kunit/bug.h                     |  62 ++++++++++++++
 include/kunit/test.h                    |   1 +
 lib/kunit/Kconfig                       |   9 ++
 lib/kunit/Makefile                      |   9 +-
 lib/kunit/backtrace-suppression-test.c  | 105 ++++++++++++++++++++++++
 lib/kunit/bug.c                         |  54 ++++++++++++
 9 files changed, 316 insertions(+), 18 deletions(-)
 create mode 100644 include/kunit/bug.h
 create mode 100644 lib/kunit/backtrace-suppression-test.c
 create mode 100644 lib/kunit/bug.c

--
2.34.1

---
Alessandro Carminati (2):
      bug/kunit: Core support for suppressing warning backtraces
      bug/kunit: Reduce runtime impact of warning backtrace suppression

Guenter Roeck (3):
      kunit: Add backtrace suppression self-tests
      drm: Suppress intentional warning backtraces in scaling unit tests
      kunit: Add documentation for warning backtrace suppression API

 Documentation/dev-tools/kunit/usage.rst | 30 ++++++++++-
 drivers/gpu/drm/tests/drm_rect_test.c   | 14 +++++
 include/kunit/bug.h                     | 56 ++++++++++++++++++++
 include/kunit/test.h                    |  1 +
 kernel/panic.c                          |  8 ++-
 lib/bug.c                               |  8 +++
 lib/kunit/Kconfig                       |  9 ++++
 lib/kunit/Makefile                      |  9 +++-
 lib/kunit/backtrace-suppression-test.c  | 90 ++++++++++++++++++++++++++++++++
 lib/kunit/bug.c                         | 91 +++++++++++++++++++++++++++++++++
 10 files changed, 312 insertions(+), 4 deletions(-)
---
base-commit: 80234b5ab240f52fa45d201e899e207b9265ef91
change-id: 20260312-kunit_add_support-2f35806b19dd

Best regards,
-- 
Albert Esteve <aesteve@redhat.com>

