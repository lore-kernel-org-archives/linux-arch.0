Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389A842EEBD
	for <linux-arch@vger.kernel.org>; Fri, 15 May 2026 11:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778845595; cv=pass; b=GUjjOpdPudCW918qJ6iSVskPuFMISwjRp4HuveC4Iplj9bmUJxVVnEUUKhCT55TNTxdGy6Om4TG7g2MNVTupKLmNQMvp/Am+EkSPGouwItaMt5fLDqAh+uNRuAaCm7RwlILrTEBuKDZXwtydVqHHW8opY/itY53iqY6BXc49Uh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778845595; c=relaxed/simple;
	bh=3zMGjQi0bU9clnSPv+RLM86gFwghnrSrNt8wdtNHwrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CwGbNRW8nEESQL8j8cM2ZVawUae7RdGHHBKG+ZSegdek+p/ioBT+K3yg3gRDxVuk0HHCehMP95X5FKFeZNmZkJQHga8T4xqJYfg/813PqDM+dPYzcJC/eTbBacGgfLDBAM/M872Yh1EUOAxk+LMcMrlaEPkoIo3pwlgUsHXqlsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YYbxeEmx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rrtfIG6w; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YYbxeEmx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rrtfIG6w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778845591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SNN8cMKgiaWqMObumUCkNPIVEL2/GCdXnUUQepHs9Og=;
	b=YYbxeEmxcW81JtPojyhmfVyi4BOR6QE/1ulIs9j1sIsGO78KbwBtGsNyeRDv9MGT1Rp8a/
	/C1LhY1y2pppGUElt2mYcV4oj9w+uMVYDdd7EOo7Ree58CUGw//0cHU+ykTO2BchzPAONw
	m5noVeuExS1B+BnuLsp1LMGcJMzIwWs=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-DKMtgfoQOsudVhdwKG5N3A-1; Fri, 15 May 2026 07:46:30 -0400
X-MC-Unique: DKMtgfoQOsudVhdwKG5N3A-1
X-Mimecast-MFC-AGG-ID: DKMtgfoQOsudVhdwKG5N3A_1778845589
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-65e0d38adcbso8304560d50.3
        for <linux-arch@vger.kernel.org>; Fri, 15 May 2026 04:46:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778845589; cv=none;
        d=google.com; s=arc-20240605;
        b=K7hMKY14WzoAaPqEdN511Y4+Z1scqlBTrDJCW6GQvsbkhfJwxQyKJTsyrwWtgWnPyQ
         Pjy5jsRM+44zqsTcWL/EuB7TGSJmliAFeyapZ9nMh9idGqwEJYakjDGwuTzNXsnojgQK
         sTdtwjFuKo7au0Hkzrh7ge8c0oLEAo2fi16NFj7IfCWkV5qSK0KcwNCp0lUMgecS+6ep
         ta5mEOHDff8oZLQbf2vlM+Xpb50uNyJh+4mqdzVXoB5LGA/tgj2s+wH7qLDZGsqKF9Ne
         mTYVUaqeWM2vUov1QcsNvJbXYIU6F0WzqGVSaUbfxEoTrgstkU8BoK5bc1fZ2JXuFuMr
         w3lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SNN8cMKgiaWqMObumUCkNPIVEL2/GCdXnUUQepHs9Og=;
        fh=zHIn8R41/odvtc0r1QPsWW7iMdRmkwRyrXwvMARAnM4=;
        b=k0ma26GXy1WJ6hN8Cpc7+HV6Bu8N1ErsEl1a/MCTL0pXNnVQRIo8A4ZyPz7rZIgrnX
         C2DwJEV9ks3Ykx1ycyaLuTRKS3sHmhkPMwQ7OiStx8FVEMFb279raGq9+r9NJEvLne5+
         f6LNJuJWktMth/+vczKZRAOrsE1sO7zWFtm0xll1YvtVGhDfJpsZCCI2WdTbWtzcS1n4
         NqHEqX6g0Vpk8hMZGLTqqquYwD7rOhhRhQcefgmSLD75HMJSABjh0alMMh+3A2RTZsZ2
         D98qwGAersjEJxRcUI5Ke3ZVEHB8EkxIdRcAqFoL/dsqWlIQe6hNtyZ/rxEmn2joxHjJ
         BYpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778845589; x=1779450389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNN8cMKgiaWqMObumUCkNPIVEL2/GCdXnUUQepHs9Og=;
        b=rrtfIG6wXBB23sPQdK90cR3r/k/3Nc+oZPeZzmUUoBfqigp+ZQt/cRXoUqY/gtZeoq
         H6H6Vorbecg30JtRUQLgYz+BXEaBhXCUXIvcH5s/NGu7lByhbeK3vzf35hXdK9kHjNxU
         Ja266ny2KmmYVwa74UG7P9tb1qzB1yfOpfDaMHMsARwq01fd4Z2Q7b44OMOPGIUJ71+B
         sItndlA61M1AH6OnS032eTkmpLulIoOXtydYnqRvO1UIXNAqxV5fZYS1Hc9mWmnWzdT4
         b4PYia2tNXL3+aclBXEejQxeWPDygztZ6IL8smH92HVyzEztQl6FEQ3/KRTby6bmek06
         qQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778845589; x=1779450389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SNN8cMKgiaWqMObumUCkNPIVEL2/GCdXnUUQepHs9Og=;
        b=GWc5LBzbqn6sw03kBKhbWYxVdVG46DgXeaarVI6BoGplxNG9BZnxYcxPmZ5V698yyQ
         fki0oANZAJRMFA/bX6o5TyLF2AqaLb/Vlujkfu3L4echNmeSAwpYGYkaUFMfLA0PrSvA
         c91WjfqyxaG3SjHsnn8W28N/hEJhAyHpTz54ZpPYzKGt+IHdZY1HeOmciEL0kTeGciGp
         QZFEHQGXdaJYigxmVtzmDjphx91qpY4gHtfopbJAhm2ghFaqkSmkUJ4bLWf3raT72l7X
         Q0itQFmmoVG9CYd0n38uO4Xh0ouBv8yR2Cph4uFXnbMom2WcK3gcEgDqOqDedAst0x/P
         aBaA==
X-Forwarded-Encrypted: i=1; AFNElJ+VAL8RHBohZB24B0/zM8NbM4ev+3JhYl2CYTh9lpvhRTrOl0y3k1/cLCiTZ/kqfFxui/8gk/6eat82@vger.kernel.org
X-Gm-Message-State: AOJu0Yye2Ygh5RsRX6L3ike2qH4sHZ4ZBtTdmo0kYdknPbpTwu6k9eB0
	UecW6ND6LtGnDRbJFQpXsQA4VCddMa2ajxSVtNDQZ3AzbFolGb9PNL4/80cIcpMQP6uB5yKCQCZ
	RMz5KvHBnjfcagHos8eU+K+cwZ3WV5ArwOdLfQpRs5nFURxt2FgF6BGKW4ECdjGj0KIgmWEUNw5
	l2sqVGcoL1xRLuzDfp0347MQ6nexk5bPlU2Aq93w==
X-Gm-Gg: Acq92OHu1UG0STm1iKu6K36flK2x1ch0CkhAvMyuTMRmyOcKoBKA6wzytRSncudrD7w
	R9xXLwrn8hYm1UKWjZdw7Qor5G8/pd6GRum+Cy93SNOmjKwTKYfGp03owv0TNz9kk5nhbKFYCg0
	ldTeDBDChaS5HzD1vMwEMeUrQTDGqxLd/oy7LPqammTTUGNx9vwC8ms5fiNyiTR/9CgnAev49jv
	mClAQ==
X-Received: by 2002:a05:690c:698b:b0:7ba:f0ed:c5d0 with SMTP id 00721157ae682-7c95a472aa4mr36853437b3.13.1778845589277;
        Fri, 15 May 2026 04:46:29 -0700 (PDT)
X-Received: by 2002:a05:690c:698b:b0:7ba:f0ed:c5d0 with SMTP id
 00721157ae682-7c95a472aa4mr36852927b3.13.1778845588675; Fri, 15 May 2026
 04:46:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515-kunit_add_support-v12-0-a216dc228be8@redhat.com>
In-Reply-To: <20260515-kunit_add_support-v12-0-a216dc228be8@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 15 May 2026 13:46:15 +0200
X-Gm-Features: AVHnY4ImVOLCGbUqAjanuMO8o_HdN74f9pc42KZvCOECahFSsf1msDLsnbmjkj0
Message-ID: <CADSE00J3yXd7wcNNZKYf+UNPkqO3jJAJhgEuvD4xny-C7XBxzw@mail.gmail.com>
Subject: Re: [PATCH v12 0/4] kunit: Add support for suppressing warning backtraces
To: Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
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
	Linux Kernel Functional Testing <lkft@linaro.org>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Dan Carpenter <error27@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 10:53=E2=80=AFAM Albert Esteve <aesteve@redhat.com>=
 wrote:
>
> Some unit tests intentionally trigger warning backtraces by passing bad
> parameters to kernel API functions. Such unit tests typically check the
> return value from such calls, not the existence of the warning backtrace.
>
> Such intentionally generated warning backtraces are neither desirable
> nor useful for a number of reasons:
> - They can result in overlooked real problems.
> - A warning that suddenly starts to show up in unit tests needs to be
>   investigated and has to be marked to be ignored, for example by
>   adjusting filter scripts. Such filters are ad hoc because there is
>   no real standard format for warnings. On top of that, such filter
>   scripts would require constant maintenance.
>
> One option to address the problem would be to add messages such as
> "expected warning backtraces start/end here" to the kernel log.
> However, that would again require filter scripts, might result in
> missing real problematic warning backtraces triggered while the test
> is running, and the irrelevant backtrace(s) would still clog the
> kernel log.
>
> Solve the problem by providing a means to suppress warning backtraces
> originating from the current kthread while executing test code.
> Since each KUnit test runs in its own kthread, this effectively scopes
> suppression to the test that enabled it, without requiring any
> architecture-specific code.
>
> Overview:
> Patch#1 Introduces the suppression infrastructure integrated into
>         KUnit's hook mechanism.
> Patch#2 Adds selftests to validate the functionality.
> Patch#3 Demonstrates real-world usage in the DRM subsystem.
> Patch#4 Documents the new API and usage guidelines.
>
> Design Notes:
> Suppression is integrated into the existing KUnit hooks infrastructure,
> reusing the kunit_running static branch for zero overhead
> when no tests are running. The implementation lives entirely in the
> kunit module; only a static-inline wrapper and a function pointer
> slot are added to built-in code.
>
> Suppression is checked at three points in the warning path:
> - In `warn_slowpath_fmt()` (kernel/panic.c), for architectures without
>   __WARN_FLAGS. The check runs before any output, fully suppressing
>   both message and backtrace.
> - In `__warn_printk()` (kernel/panic.c), for architectures that define
>   __WARN_FLAGS but not their own __WARN_printf (arm64, loongarch,
>   parisc, powerpc, riscv, sh). The check suppresses the warning message
>   text that is printed before the trap enters __report_bug().
> - In `__report_bug()` (lib/bug.c), for architectures that define
>   __WARN_FLAGS. The check runs before `__warn()` is called, suppressing
>   the backtrace and stack dump.
>
> To avoid double-counting on architectures where both `__warn_printk()`
> and `__report_bug()` run for the same warning, the hook takes a bool
> parameter: true to increment the suppression counter, false to suppress
> without counting.
>
> The suppression state is dynamically allocated via kunit_kzalloc() and
> tied to the KUnit test lifecycle via `kunit_add_action()`, ensuring
> automatic cleanup at test exit. Writer-side access to the global
> suppression list is serialized with a spinlock; readers use RCU.
>
> Two API forms are provided:
> - kunit_warning_suppress(test) { ... }: scoped blocks with automatic
>   cleanup. The suppression handle is not accessible outside the block,
>   so warning counts (if needed) must be checked inside. Multiple
>   suppression blocks are allowed.
> - kunit_start/end_suppress_warning(test): direct functions that return
>   an explicit handle. Use when the handle needs to be retained, or passed
>   across helpers. Multiple suppression blocks are allowed.
>
> This series is based on the RFC patch and subsequent discussion at
> https://patchwork.kernel.org/project/linux-kselftest/patch/02546e59-1afe-=
4b08-ba81-d94f3b691c9a@moroto.mountain/
> and offers a more comprehensive solution of the problem discussed there.
>
> Changes since RFC:
> - Introduced CONFIG_KUNIT_SUPPRESS_BACKTRACE
> - Minor cleanups and bug fixes
> - Added support for all affected architectures
> - Added support for counting suppressed warnings
> - Added unit tests using those counters
> - Added patch to suppress warning backtraces in dev_addr_lists tests
>
> Changes since v1:
> - Rebased to v6.9-rc1
> - Added Tested-by:, Acked-by:, and Reviewed-by: tags
>   [I retained those tags since there have been no functional changes]
> - Introduced KUNIT_SUPPRESS_BACKTRACE configuration option, enabled by
>   default.
>
> Changes since v2:
> - Rebased to v6.9-rc2
> - Added comments to drm warning suppression explaining why it is needed.
> - Added patch to move conditional code in arch/sh/include/asm/bug.h
>   to avoid kerneldoc warning
> - Added architecture maintainers to Cc: for architecture specific patches
> - No functional changes
>
> Changes since v3:
> - Rebased to v6.14-rc6
> - Dropped net: "kunit: Suppress lock warning noise at end of dev_addr_lis=
ts tests"
>   since 3db3b62955cd6d73afde05a17d7e8e106695c3b9
> - Added __kunit_ and KUNIT_ prefixes.
> - Tested on interessed architectures.
>
> Changes since v4:
> - Rebased to v6.15-rc7
> - Dropped all code in __report_bug()
> - Moved all checks in WARN*() macros.
> - Dropped all architecture specific code.
> - Made __kunit_is_suppressed_warning nice to noinstr functions.
>
> Changes since v5:
> - Rebased to v7.0-rc3
> - Added RCU protection for the suppressed warnings list.
> - Added static key and branching optimization.
> - Removed custom `strcmp` implementation and reworked
>   __kunit_is_suppressed_warning() entrypoint function.
>
> Changes since v6:
> - Moved suppression checks from WARN*() macros to warn_slowpath_fmt()
>   and __report_bug().
> - Replaced stack-allocated suppression struct with kunit_kzalloc() heap
>   allocation tied to the KUnit test lifecycle.
> - Changed suppression strategy from function-name matching to task-scoped=
:
>   all warnings on the current task are suppressed between START and END,
>   rather than only warnings originating from a specific named function.
> - Simplified macro API: removed KUNIT_DECLARE_SUPPRESSED_WARNING(),
>   the START macro now takes (test) and handles allocation internally.
> - Removed static key and branching optiomization, as by the time it
>   was executed, callers are already in warn slowpaths.
> - Link to v6: https://lore.kernel.org/r/20260317-kunit_add_support-v6-0-d=
d22aeb3fe5d@redhat.com
>
> Changes since v7:
> - Integrated suppression into existing KUnit hooks infrastructure
> - Removed CONFIG_KUNIT_SUPPRESS_BACKTRACE
> - Added suppression check in __warn_printk()
> - Added spinlock for writer-side RCU protection
> - Replaced explicit rcu_read_lock/unlock with guard(rcu)()
> - Added scoped API (kunit_warning_suppress) using __cleanup attribute
> - Updated DRM patch to use scoped API
> - Expanded self-tests: incremental counting, cross-kthread isolation
> - Rewrote documentation covering all three API forms with examples
> - Link to v7: https://lore.kernel.org/r/20260420-kunit_add_support-v7-0-e=
8bc6e0f70de@redhat.com
>
> Changes since v8:
> - Rebased to v7.1-rc2
> - Remove KUNIT_START/END_SUPPRESSED_WARNING() macros
> - Add KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT checks to drm tests
> - Link to v8: https://lore.kernel.org/r/20260504-kunit_add_support-v8-0-3=
e5957cdd235@redhat.com
>
> Changes since v9:
> - Fix silent false-pass when kunit_start_suppress_warning() returns NULL
> - Fix RCU lockdep splat for kunit_is_suppressed_warning() calls
> - Move disable_trace_on_warning() in __report_bug()
> - Make suppress counter atomic
> - Mark helper warn functions in selftest as noinline
> - Add kunit_skip() for CONFIG_BUG=3Dn in selftests
> - Fix potentially uninitialized data.was_active in kthread seltest
> - Add kthread_stop() in kthread selftest early exit
> - Initialize scaling_factor to INT_MIN in DRM scaling tests
> - Add include for bool in test-bug.h to fix CONFIG_KUNIT=3Dn case
> - Link to v9: https://lore.kernel.org/r/20260508-kunit_add_support-v9-0-9=
9df7aa880f6@redhat.com
>
> Changes since v10:
> - Remove synchronize_rcu() to avoid sleeping in atomic context
> - Pin task_struct refcount to prevent ABA false-positive matches
> - Loop in suppression selftest to prevent use-after-free on kthread exit
> - Skip DRM rect tests on CONFIG_BUG=3Dn
> - Link to v10: https://lore.kernel.org/r/20260513-kunit_add_support-v10-0=
-e379d206c8cd@redhat.com
>
> Changes since v11:
> - Use call_rcu() to defer free without blocking
> - Remove #ifdef CONFIG_KUNIT guard in lib/bug.c
> - Remove stale config checks from selftest
> - Replace skip on DRM rect tests with conditional expectation
> - Link to v11: https://lore.kernel.org/r/20260514-kunit_add_support-v11-0=
-b36a530a6d8f@redhat.com

A regression occurred in this version because `kunit_kzalloc` was
removed, following sashiko's suggestions in the last version. The
handle cannot be used after the kunit_end_suppress_warning() call
because we explicitly kfree(), resulting in a use-after-free. I
should've seen it, but the tests passed so it did not click (not sure
why exactly, probably the memory was still mapped during the grace
period so the access succeeded spuriously). This back and forth is not
going well, so I will revert lib/kunit/bug.c to v9, before removing
`synchronize_rcu()`, which was working fine. It used `kunit_kzalloc`
so KUnit correctly handled the memory lifetime. The problem is that
`synchronize_rcu()` requires process context, which is always the case
here, it should never be called under a spinlock or RCU read lock.
Re-adding may trigger a comment from the automatic review, but I think
it is the safest option.

This time sashiko found another issue and suggested `in_task()`, which
sounds like a nice addition to avoid suppressing real warnings within
interrupt handlers. So one more version it is...

>
> --
> 2.34.1
>
> ---
> To: Brendan Higgins <brendan.higgins@linux.dev>
> To: David Gow <david@davidgow.net>
> To: Rae Moar <raemoar63@gmail.com>
> To: Andrew Morton <akpm@linux-foundation.org>
> To: Paul Walmsley <pjw@kernel.org>
> To: Palmer Dabbelt <palmer@dabbelt.com>
> To: Albert Ou <aou@eecs.berkeley.edu>
> To: Alexandre Ghiti <alex@ghiti.fr>
> To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> To: Maxime Ripard <mripard@kernel.org>
> To: Thomas Zimmermann <tzimmermann@suse.de>
> To: David Airlie <airlied@gmail.com>
> To: Simona Vetter <simona@ffwll.ch>
> To: Jonathan Corbet <corbet@lwn.net>
> To: Shuah Khan <skhan@linuxfoundation.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> Cc: linux-riscv@lists.infradead.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: workflows@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
>
> ---
> Alessandro Carminati (1):
>       bug/kunit: Core support for suppressing warning backtraces
>
> Guenter Roeck (3):
>       kunit: Add backtrace suppression self-tests
>       drm: Suppress intentional warning backtraces in scaling unit tests
>       kunit: Add documentation for warning backtrace suppression API
>
>  Documentation/dev-tools/kunit/usage.rst |  46 +++++++-
>  drivers/gpu/drm/tests/drm_rect_test.c   |  36 +++++-
>  include/kunit/test-bug.h                |  26 +++++
>  include/kunit/test.h                    |  98 ++++++++++++++++
>  kernel/panic.c                          |  11 ++
>  lib/bug.c                               |  12 +-
>  lib/kunit/Makefile                      |   4 +-
>  lib/kunit/backtrace-suppression-test.c  | 192 ++++++++++++++++++++++++++=
++++++
>  lib/kunit/bug.c                         | 131 ++++++++++++++++++++++
>  lib/kunit/hooks-impl.h                  |   2 +
>  10 files changed, 548 insertions(+), 10 deletions(-)
> ---
> base-commit: 74fe02ce122a6103f207d29fafc8b3a53de6abaf
> change-id: 20260312-kunit_add_support-2f35806b19dd
>
> Best regards,
> --
> Albert Esteve <aesteve@redhat.com>
>

