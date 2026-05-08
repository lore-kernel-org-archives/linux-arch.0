Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AFA3F9F31
	for <linux-arch@vger.kernel.org>; Fri,  8 May 2026 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778252598; cv=none; b=uV9S/5Y2qcbR3HFU8pLZH/W+plCfJ+KjbjIg7TTKzBJdFzT2X31p6Le60NjVRjhu7jD2MjO1ynPov4rKYlBMYdKyCNfnic+eXTHHZDUCrGhYIgt+WKdTkzA9cLPiC40ZBuKqu0FXiF/Ey8WlR+hiHpYLaFM3ddZplh1FlnbzNDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778252598; c=relaxed/simple;
	bh=8xWxjgj6GG2jezhUlaEtpjc6ZhQKLzry3m/rVm2AAH8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Jpi8/MFCZevvLLh2AypRHza4ADeeMFpvjvw93spVFu44cX94S4Ge/LLU4r2qNbzuxn2hhVXqZIPfJd6WdFrybuBIGcQ6A7cZITdebJCOgO6G0nQu/qQM9bS4sMlfNkbB8RVcYwMYQleFDlZLEpN7CfTpSYGKqbE5x8wMrKkmrpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A/jx3z//; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A/jx3z//"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778252592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ik/8Z8gDiRLPaXagOm1v4Os+dRe4w6p7nwhRLAZV8lc=;
	b=A/jx3z//+hOHUXqRdl+nOhEN9cXA/BjsxnF6yBjHQ42RZwxzPZzll6zKMz2chzBjHzj9pR
	wTLUDitBnvS7TPqwExW0Aknp2LLzu0q3PzZk8ZZFfEzDxnbiKuzgh7DO+brNoJfjVizKB2
	mjGdZJ3i+YTby/jayYnvEgCuN4eRRK0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-fXLlb8MVOZWjxRHvGCyYfg-1; Fri,
 08 May 2026 11:03:07 -0400
X-MC-Unique: fXLlb8MVOZWjxRHvGCyYfg-1
X-Mimecast-MFC-AGG-ID: fXLlb8MVOZWjxRHvGCyYfg_1778252582
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4BEF619560AB;
	Fri,  8 May 2026 15:03:01 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3CA3B1800374;
	Fri,  8 May 2026 15:02:52 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v9 0/4] kunit: Add support for suppressing warning
 backtraces
Date: Fri, 08 May 2026 17:02:44 +0200
Message-Id: <20260508-kunit_add_support-v9-0-99df7aa880f6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23Oy2rDMBCF4VcJWldBl4xkZ9X3KCXImlEtii0jK
 6Yl+N0rB0Ja6uVZnI//xmbKkWZ2PtxYpiXOMY11tC8H5ns3fhCPWDdTQhmhpeKf1zGWi0O8zNd
 pSrlwFTQ0wnSyRWT1N2UK8etuvr3XHXIaeOkzuYcEApSRWlmAozRGguCSO+/yEEf3mgl7V44+D
 ZvWx7mk/H0PXMxmPlrsTstiuOCISjnqdCDA39oWs9gncVJij7CVoKbzhkSwAukf0TwJEKc9oqm
 EJmjB+hqj4Q+xrusPFCKOT3cBAAA=
X-Change-ID: 20260312-kunit_add_support-2f35806b19dd
To: Arnd Bergmann <arnd@arndb.de>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Rae Moar <raemoar63@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 dri-devel@lists.freedesktop.org, workflows@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org, 
 peterz@infradead.org, Alessandro Carminati <acarmina@redhat.com>, 
 Guenter Roeck <linux@roeck-us.net>, Kees Cook <kees@kernel.org>, 
 Albert Esteve <aesteve@redhat.com>, 
 Linux Kernel Functional Testing <lkft@linaro.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Dan Carpenter <error27@gmail.com>, Kees Cook <kees@kernel.org>, 
 Simona Vetter <simona.vetter@ffwll.ch>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778252571; l=8375;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=8xWxjgj6GG2jezhUlaEtpjc6ZhQKLzry3m/rVm2AAH8=;
 b=mPomJy2oz2IgFvKbcK8sHrFS2RWzqn6s5hhpOVCEfCYnQz+U0RBbNj8PTh/eEsUliLnkcfABb
 X5HSMH0SzMaCpsLTqa2LEpPq9c2jntD0jPs4Nv4XaP2go8oEIVXjanA
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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

Solve the problem by providing a means to suppress warning backtraces
originating from the current kthread while executing test code.
Since each KUnit test runs in its own kthread, this effectively scopes
suppression to the test that enabled it, without requiring any
architecture-specific code.

Overview:
Patch#1 Introduces the suppression infrastructure integrated into
        KUnit's hook mechanism.
Patch#2 Adds selftests to validate the functionality.
Patch#3 Demonstrates real-world usage in the DRM subsystem.
Patch#4 Documents the new API and usage guidelines.

Design Notes:
Suppression is integrated into the existing KUnit hooks infrastructure,
reusing the kunit_running static branch for zero overhead
when no tests are running. The implementation lives entirely in the
kunit module; only a static-inline wrapper and a function pointer
slot are added to built-in code.

Suppression is checked at three points in the warning path:
- In `warn_slowpath_fmt()` (kernel/panic.c), for architectures without
  __WARN_FLAGS. The check runs before any output, fully suppressing
  both message and backtrace.
- In `__warn_printk()` (kernel/panic.c), for architectures that define
  __WARN_FLAGS but not their own __WARN_printf (arm64, loongarch,
  parisc, powerpc, riscv, sh). The check suppresses the warning message
  text that is printed before the trap enters __report_bug().
- In `__report_bug()` (lib/bug.c), for architectures that define
  __WARN_FLAGS. The check runs before `__warn()` is called, suppressing
  the backtrace and stack dump. 

To avoid double-counting on architectures where both `__warn_printk()`
and `__report_bug()` run for the same warning, the hook takes a bool
parameter: true to increment the suppression counter, false to suppress
without counting.

The suppression state is dynamically allocated via kunit_kzalloc() and
tied to the KUnit test lifecycle via `kunit_add_action()`, ensuring
automatic cleanup at test exit. Writer-side access to the global
suppression list is serialized with a spinlock; readers use RCU.

Two API forms are provided:
- kunit_warning_suppress(test) { ... }: scoped blocks with automatic
  cleanup. The suppression handle is not accessible outside the block,
  so warning counts (if needed) must be checked inside. Multiple
  suppression blocks are allowed.
- kunit_start/end_suppress_warning(test): direct functions that return
  an explicit handle. Use when the handle needs to be retained, or passed
  across helpers. Multiple suppression blocks are allowed.

This series is based on the RFC patch and subsequent discussion at
https://patchwork.kernel.org/project/linux-kselftest/patch/02546e59-1afe-4b08-ba81-d94f3b691c9a@moroto.mountain/
and offers a more comprehensive solution of the problem discussed there.

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

Changes since v7:
- Integrated suppression into existing KUnit hooks infrastructure
- Removed CONFIG_KUNIT_SUPPRESS_BACKTRACE
- Added suppression check in __warn_printk()
- Added spinlock for writer-side RCU protection
- Replaced explicit rcu_read_lock/unlock with guard(rcu)()
- Added scoped API (kunit_warning_suppress) using __cleanup attribute
- Updated DRM patch to use scoped API
- Expanded self-tests: incremental counting, cross-kthread isolation
- Rewrote documentation covering all three API forms with examples
- Link to v7: https://lore.kernel.org/r/20260420-kunit_add_support-v7-0-e8bc6e0f70de@redhat.com

Changes since v8:
- Rebased to v7.1-rc2
- Remove KUNIT_START/END_SUPPRESSED_WARNING() macros
- Add KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT checks to drm tests
- Link to v8: https://lore.kernel.org/r/20260504-kunit_add_support-v8-0-3e5957cdd235@redhat.com

--
2.34.1

---
Alessandro Carminati (1):
      bug/kunit: Core support for suppressing warning backtraces

Guenter Roeck (3):
      kunit: Add backtrace suppression self-tests
      drm: Suppress intentional warning backtraces in scaling unit tests
      kunit: Add documentation for warning backtrace suppression API

 Documentation/dev-tools/kunit/usage.rst |  46 ++++++++-
 drivers/gpu/drm/tests/drm_rect_test.c   |  27 ++++-
 include/kunit/test-bug.h                |  25 +++++
 include/kunit/test.h                    |  98 ++++++++++++++++++
 kernel/panic.c                          |  15 ++-
 lib/bug.c                               |  10 ++
 lib/kunit/Makefile                      |   4 +-
 lib/kunit/backtrace-suppression-test.c  | 176 ++++++++++++++++++++++++++++++++
 lib/kunit/bug.c                         | 115 +++++++++++++++++++++
 lib/kunit/hooks-impl.h                  |   2 +
 10 files changed, 510 insertions(+), 8 deletions(-)
---
base-commit: 74fe02ce122a6103f207d29fafc8b3a53de6abaf
change-id: 20260312-kunit_add_support-2f35806b19dd

Best regards,
-- 
Albert Esteve <aesteve@redhat.com>

