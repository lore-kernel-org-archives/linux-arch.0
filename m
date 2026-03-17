Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78FA34F498
	for <linux-arch@vger.kernel.org>; Tue, 17 Mar 2026 09:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773739508; cv=none; b=AWtqWXprAPrpGL1G7r+TsA3aq7CqBch09YULIck2Hg3X/6PpNmvt0/dTAyU5B1pLJlirQiUzP1IhuzX5Cp2UCxp+aYGQdhkXt3+JZUI3m87a7j2vE9yyzKH5Xm6bPD3Gonv9RjPPTPJnjto8lKm4OGqPAsO07mzv4Dr9QX0aEGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773739508; c=relaxed/simple;
	bh=bJiw2fCIyVOW1mxKKbHzwEUXYne2FJgUTUWqzDnzFLo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ht9nCEK0/hr4zpOOTkCow3lVaEMHBu9qfbJ/6w6Lzsl3WsShxxpy6iJStrFdm2eRv7jAMIZVCcSZwcErIXn9OvKNpjEf4suvcMzkdNlH4F6QqsmIeJ5HdHkcm/NN2swF+R8TcYBh89Yn98ChnvtE+I1zL/PPajNn4sCwcThKa64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RQbBrzxN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQbBrzxN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773739504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v2L3IsKbVCXlEY8N3babcTFT7cMuipE4uuM+dNpsWbk=;
	b=RQbBrzxNtQ4r1K39TgM0zxUDFxgOwohlrmzIxFFkY0b7iQ8ymKq/KpB5grVflNHpnxtuDd
	bhhWHh4fGZjarJvaFAl/oiA6GKRWfmbEWJbthqObcfNbhhSQUHquqPMVxt2R8Rzo4g0W54
	VAoU1fQo1BmtGKGz8X1VR4uWrpRGCeE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-ulCBqY83NIKoaRAp6HatOg-1; Tue,
 17 Mar 2026 05:25:01 -0400
X-MC-Unique: ulCBqY83NIKoaRAp6HatOg-1
X-Mimecast-MFC-AGG-ID: ulCBqY83NIKoaRAp6HatOg_1773739497
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D93F1944EB8;
	Tue, 17 Mar 2026 09:24:56 +0000 (UTC)
Received: from [192.168.1.153] (unknown [10.45.224.69])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 659B8180035F;
	Tue, 17 Mar 2026 09:24:46 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v6 0/5] kunit: Add support for suppressing warning
 backtraces
Date: Tue, 17 Mar 2026 10:24:40 +0100
Message-Id: <20260317-kunit_add_support-v6-0-dd22aeb3fe5d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zXMTQrCMBBA4auUWZuSpCT+rLyHSBmbqR2kSZmkI
 pTe3SC4/BbvbZBJmDJcmg2E3pw5xQp/aGCYMD5JcagGq63XnbHqtUYuPYbQ53VZkhRlx86dtH+
 YcwhQu0Vo5M/vebtXj5JmVSYh/J+cdtabzh6da433xmllFA4oM0e8CoUJSzukGfb9C1wN+oyhA
 AAA
X-Change-ID: 20260312-kunit_add_support-2f35806b19dd
To: Arnd Bergmann <arnd@arndb.de>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Rae Moar <raemoar63@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 dri-devel@lists.freedesktop.org, workflows@vger.kernel.org, 
 linux-doc@vger.kernel.org, Alessandro Carminati <acarmina@redhat.com>, 
 Guenter Roeck <linux@roeck-us.net>, Kees Cook <kees@kernel.org>, 
 Albert Esteve <aesteve@redhat.com>, 
 Linux Kernel Functional Testing <lkft@linaro.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Kees Cook <kees@kernel.org>, Simona Vetter <simona.vetter@ffwll.ch>, 
 David Gow <david@davidgow.net>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773739485; l=10237;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=bJiw2fCIyVOW1mxKKbHzwEUXYne2FJgUTUWqzDnzFLo=;
 b=ABn9We0fiidxQc8J1WKKczkQopcxc+TgYe29t+Mbi0bdyZsh54tNUBtocIUQu97QBwx+fodNA
 35vFRYe7M8cB0fst+v+36X3BN8jeMbdyIRgTZSkgh0ybmyPUYvVWTRg
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
Patch#2 Mitigate the impact at WARN*() sites.
Patch#3 Adds selftests to validate the functionality.
Patch#4 Demonstrates real-world usage in the DRM subsystem.
Patch#5 Documents the new API and usage guidelines.

Design Notes:
The objective is to suppress unwanted WARN*() generated messages.

Although most major architectures share common bug handling via `lib/bug.c`
and `report_bug()`, some minor or legacy architectures still rely on their
own platform-specific handling. This divergence must be considered in any
such feature. Additionally, a key challenge in implementing this feature is
the fragmentation of `WARN*()` messages emission: specific part in the
macro, common with BUG*() part in the exception handler.
As a result, any intervention to suppress the message must occur before the
illegal instruction.

Lessons from the Previous Attempt
In earlier iterations, suppression logic was added inside the
`__report_bug()` function to intercept WARN*() messages not producing
messages in the macro.
To implement the check in the bug handler code, two strategies were
considered:

* Strategy #1: Use `kallsyms` to infer the originating functionid, namely
  a pointer to the function. Since in any case, the user interface relies
  on function names, they must be translated in addresses at suppression-
  time or at check-time.
  Assuming to translate at suppression-time, the `kallsyms` subsystem needs
  to be used to determine the symbol address from the name, and again to
  produce the functionid from `bugaddr`. This approach proved unreliable
  due to compiler-induced transformations such as inlining, cloning, and
  code fragmentation. Attempts to preventing them is also unconvenient
  because several `WARN()` sites are in functions intentionally declared
  as `__always_inline`.

* Strategy #2: Store function name `__func__` in `struct bug_entry` in
  the `__bug_table`. This implementation was used in the previous version.
  However, `__func__` is a compiler-generated symbol, which complicates
  relocation and linking in position-independent code. Workarounds such as
  storing offsets from `.rodata` or embedding string literals directly into
  the table would have significantly either increased complexity or
  increase the __bug_table size.
  Additionally, architectures not using the unified `BUG()` path would
  still require ad-hoc handling. Because current WARN*() message production
  strategy, a few WARN*() macros still need a check to suppress the part of
  the message produced in the macro itself.

As a result, previous version proposed a per-macro solution, which offers
better control on where the suppression logic is applied.

For this iteration, the `__report_bug()` centralized approach was
revisited after the discussion in the previous version [1].
However, again this approach did not work because:
- Some warning output is generated directly in the macros before calling
  the centralized functions (e.g., `__warn_printk()` in `__WARN_printf()`)
- Functions in the warning path like `warn_slowpath_fmt()` are marked
  `__always_inline`, making it difficult to intercept early enough
- So, by the time `__report_bug()` is called, output has already been written
  to the console, making suppression ineffective

Current Proposal: Check Directly in the `WARN()` Macros.
This avoids the need for function symbol resolution or ELF section
modification.
Suppression is implemented directly in the `WARN*()` macros.

A helper function, `__kunit_is_suppressed_warning()`, is used to determine
whether suppression applies. It is marked as `noinstr`, since some `WARN*()`
sites reside in non-instrumentable sections. The function uses a static
branch for the fast path check (which is `noinstr`-safe), and only calls
the actual suppression check (which uses `strcmp`, and is surrounded by
instrumentation_begin()/end() calls) when suppressions are active.
The list of suppressed warnings is protected with RCU (Read-Copy-Update)
to allow concurrent read access without locks.

To minimize runtime impact when no suppressions are active, static branching
is used via a static key (`kunit_suppress_warnings_key`). The branch is
automatically enabled when the first suppression starts and disabled when the
last suppression ends, tracked via an atomic counter. This keeps the suppression
check code out-of-line, reducing code bloat at each `WARN*()` site while
maintaining minimal runtime overhead in the common case (no active suppressions).

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
      bug/kunit: Suppressing warning backtraces reduced impact on WARN*() sites

Guenter Roeck (3):
      Add unit tests to verify that warning backtrace suppression works.
      drm: Suppress intentional warning backtraces in scaling unit tests
      kunit: Add documentation for warning backtrace suppression API

 Documentation/dev-tools/kunit/usage.rst |  30 ++++++++-
 drivers/gpu/drm/tests/drm_rect_test.c   |  16 +++++
 include/asm-generic/bug.h               |  44 ++++++++-----
 include/kunit/bug.h                     |  61 ++++++++++++++++++
 include/kunit/test.h                    |   1 +
 lib/kunit/Kconfig                       |   9 +++
 lib/kunit/Makefile                      |   9 ++-
 lib/kunit/backtrace-suppression-test.c  | 109 ++++++++++++++++++++++++++++++++
 lib/kunit/bug.c                         |  71 +++++++++++++++++++++
 9 files changed, 332 insertions(+), 18 deletions(-)
---
base-commit: 80234b5ab240f52fa45d201e899e207b9265ef91
change-id: 20260312-kunit_add_support-2f35806b19dd

Best regards,
-- 
Albert Esteve <aesteve@redhat.com>

