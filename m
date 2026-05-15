Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C0740244A
	for <linux-arch@vger.kernel.org>; Fri, 15 May 2026 08:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833825; cv=pass; b=iW68zsX/+mHCRefwPZt4dP616tgD78pzWnVspVOLsf4wKAyO7Py6kUA/ydW7WurNgjN2n2VigMlQ6v7DOtBOwuJ8kfnE7c/tvlYOuw9wKQxvMEoVNmULYqpMNAe5Q5eXwcag4MaePhGnKCOStbEapDOyteRzUXY0wYGu+korHCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833825; c=relaxed/simple;
	bh=wZoWkMX+eskXzZoY5GSBYclpj+6G3yHCYIb+U539EoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SCcesf+0MFfr7LDACpkV1P1mK5FJFu9bqfpq8Z29+DQGHmsm66vJHj/HuI7kF5Bh/6wE5rxCYnZKkYC3bRQaN18Gw5b7JSeXbmYGANVcP90yOQkO9beCY3tvAgB9b+Mhv8E/LbuT+DfywkO8VQdfIGFibmOrVzTg+7xVZZLtwZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N5Z2s3wb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=moBOv37W; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5Z2s3wb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="moBOv37W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778833822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bl97SG38DqEYm+qLShyfMzefRk/OXd7eX3bX+dxr3ds=;
	b=N5Z2s3wbGD5T2Ur87tk2PSZ7jF5uYSYh5vcEP7+xZ1Y2XhEVw2CrSDg6rxPDb5XxpAOsSk
	hEWj6JV3TPDX1Fr/vrUBvLbNlyFgExNlz5pIXHYjubNnLT7PmGl0N0rHrduz0lhP0Lj+UU
	PvwG9DT8ljWWWqdXTpiP9FSTYHDKmO0=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-jblKhiyXMwCm0sjdxQvmqw-1; Fri, 15 May 2026 04:30:21 -0400
X-MC-Unique: jblKhiyXMwCm0sjdxQvmqw-1
X-Mimecast-MFC-AGG-ID: jblKhiyXMwCm0sjdxQvmqw_1778833821
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-65db7715a7eso15238159d50.1
        for <linux-arch@vger.kernel.org>; Fri, 15 May 2026 01:30:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778833820; cv=none;
        d=google.com; s=arc-20240605;
        b=BpSKXHbHRL+df/ErAzGUeH1yR1KTSSjenbY4J3c6J22QmKOmFhOtJstrN11ARnsVM+
         lqq2T64L5WaC818xOsYtTM4z6Xw62RCSe+ELJGfLsvmPky6za0pyoSwvVWEM2T/Xr98x
         PQdjyjRpABTM7I5UkHLyEKuddplnAgMntzxwAoYEpNwlD0r4q/8pme1MN6dEp1eGCl5i
         R+5k7VJaomL5sprZUdJkJ+K23qQG38HAX6ZinksNrF4EuXe45otJFIwk+6gaRrGO1Q3D
         qK8Yhmk0R6OM9HKR3xttW+Fp86eY7WNsuNhDm4DAPksaBn5U59WU/s6H8fIqI5YBy1qG
         f6wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bl97SG38DqEYm+qLShyfMzefRk/OXd7eX3bX+dxr3ds=;
        fh=pqSYwlfLL3Vi1OCwDzXC9Qs/R3XL77IC74FWVTcwY0Q=;
        b=Y9j9jbCglzAW4aYas/SlOkV/cvNOw+GHFOsAhtvDslcE8sYkbLdq32CRqSTxfsgkkc
         GzCVuYgRoi6/NEUtez39C82vRXfxd4lfYL0AaelSGBjMwcIzbAMIQmNAau5CT67uBiYM
         iZxEgaY09/JDzPNMMGM2fZAblyVLCyLMDLU8M9cgeC1xvOGpMroD9BAiPwd8dnZEwxwP
         0mynBLUKwqJSfBVck8Vqc25zd+oQ3iAQWH4fZWDOqdXDFKkRxU2NTp8MXMoJ++gP1OTW
         JytOKahm49de5TEkkShuq6HdaRnWahTP5ouyHuutIQNB85wQZFaEL8uAvD51npc4z5+8
         dJUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778833820; x=1779438620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bl97SG38DqEYm+qLShyfMzefRk/OXd7eX3bX+dxr3ds=;
        b=moBOv37WWiYuVR+PYqgMMx8AXsAOC6xHOx08+GUEzefo87RqTGCGUWLy+1lFTiA8JI
         dn3MNHJpuloLlMTyyxBQ9xrT+YG5dl/rl+gvAPwjIB0hHOQDyh+9Do9CRJ3vA27NQR1r
         MYC1POdfa58c4ys+xkwoU4vyiUsS4//zKGL9EAdtaYeQkW0wapmS/Jom0OpmwF4kQyW1
         fcA7P5hEYiU2GyvBQVrCUp2HvoJvnbUkWWqA62bsa53ixRDbQqGZ2B9dG0cTxs/10J08
         wzD3fvM/u6Ed/Zmbe0ZS5Vo2BnbWiKfbOgQdnndehi0R+X5hPODY6/PeAAsskLrzJlz+
         pdZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778833820; x=1779438620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bl97SG38DqEYm+qLShyfMzefRk/OXd7eX3bX+dxr3ds=;
        b=U9hG2gNDlQ7GWjneXszV2tCXcrABu8J7i/msBG35S00J3gz2ovkyxiNCEp1MPX8Zan
         D+e7KKsiHlK72YqcUxYAsK8+IltGjBSKKBnaSll0Xz2QJeaRJnTrwMKCQMl79BsHMuE0
         37WBycHCKYYRKTFO7OQ1eTxE2L9gipAwFmVbsq6VmYRd7x9OJ90wrKKYV+vqjz26l6lW
         rbq/eMa0ujwS1tfHHOicMx4HcX+5EFvJG75kgQqVV+EISZv9hn03oCBHGu52M+9/Xy1q
         Q3Y6106lGHgNA+fivnXprIFsts4rxXfzjsVRjFQS8am6TKmQ9bCDSDT0IdaQ5kcAkJVd
         vjyQ==
X-Forwarded-Encrypted: i=1; AFNElJ+poikM8n7UgA+njct1yGr6sAG7kEmbZPtwODjgDpHPG7J6epUCQA03xhJ9NpHjI3xX/u0xwMFyv2nB@vger.kernel.org
X-Gm-Message-State: AOJu0YwYLwlC9TeFG6IzY8YoLg4QyD4Q8SB659XDMXSFfhyXtpDztke4
	2VWDmLruXbxXXQpUj4PE5J91EGCHjFN/w45ZIQiSuvS+kmjqvGez8YBRw+R9+mGkPKeXNOn4bAj
	bzxJ2jR/oyfb5Y95p9pPItMFDB4DjTNzVVIPCk1ygi8oIsA59vSgzOVL50htKvg69berFrJNicn
	UcAO15LB3mw0dj4lNaXH2VJ1xE3Tdz+9E5I2zIMA==
X-Gm-Gg: Acq92OENUe01PITS6GhFWhgHTjBpw54J6tCcJKvKP0vQU7FWJN2VZyg/uBm/CygtPVo
	z+HLIup/OmeZdQZ/Y8WwZ0EVCRv12LBbQgrsCBDrcwHq6rvwDO24N94/RcS85OTOcxuqVUjT73D
	AIQg1K1oWI5MjYTULns3dF0atkWWpkRbhdn5F1ydiwmt0UNN3+0Ya8u/oujsWrKHi6dPuSVcmA0
	NJ9JA==
X-Received: by 2002:a05:690c:d91:b0:7a4:8718:8c73 with SMTP id 00721157ae682-7c959f7eae9mr29527757b3.9.1778833820525;
        Fri, 15 May 2026 01:30:20 -0700 (PDT)
X-Received: by 2002:a05:690c:d91:b0:7a4:8718:8c73 with SMTP id
 00721157ae682-7c959f7eae9mr29527457b3.9.1778833820057; Fri, 15 May 2026
 01:30:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514-kunit_add_support-v11-0-b36a530a6d8f@redhat.com> <20260514-kunit_add_support-v11-2-b36a530a6d8f@redhat.com>
In-Reply-To: <20260514-kunit_add_support-v11-2-b36a530a6d8f@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 15 May 2026 10:30:07 +0200
X-Gm-Features: AVHnY4IpbN1L0iL3JJ5V1KLP5rKC5fDaPhQjSTbBKstC7eTK3NlVXbuxOJbgBlw
Message-ID: <CADSE00KxDcyvw5MzRzrY0haZze8=9Npb8W8SwsxR+wjcS0R9pw@mail.gmail.com>
Subject: Re: [PATCH v11 2/4] kunit: Add backtrace suppression self-tests
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
	peterz@infradead.org, Guenter Roeck <linux@roeck-us.net>, 
	Linux Kernel Functional Testing <lkft@linaro.org>, Alessandro Carminati <acarmina@redhat.com>, Dan Carpenter <error27@gmail.com>, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 1:07=E2=80=AFPM Albert Esteve <aesteve@redhat.com> =
wrote:
>
> From: Guenter Roeck <linux@roeck-us.net>
>
> Add unit tests to verify that warning backtrace suppression works.
>
> Tests cover both API forms:
> - Scoped: kunit_warning_suppress() with in-block count verification
>   and post-block inactivity check.
> - Direct functions: kunit_start/end_suppress_warning() with
>   sequential independent suppression blocks and per-block counts.
>
> Furthermore, tests verify incremental warning counting, that
> kunit_has_active_suppress_warning() transitions correctly around
> suppression boundaries, and that suppression active in the test
> kthread does not leak to a separate kthread.
>
> If backtrace suppression does _not_ work, the unit tests will likely
> trigger unsuppressed backtraces, which should actually help to get
> the affected architectures / platforms fixed.
>
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
> Reviewed-by: David Gow <david@davidgow.net>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  lib/kunit/Makefile                     |   1 +
>  lib/kunit/backtrace-suppression-test.c | 198 +++++++++++++++++++++++++++=
++++++
>  2 files changed, 199 insertions(+)
>
> diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> index 4592f9d0aa8dd..2e8a6b71a2ab0 100644
> --- a/lib/kunit/Makefile
> +++ b/lib/kunit/Makefile
> @@ -22,6 +22,7 @@ obj-$(if $(CONFIG_KUNIT),y) +=3D                hooks.o
>
>  obj-$(CONFIG_KUNIT_TEST) +=3D            kunit-test.o
>  obj-$(CONFIG_KUNIT_TEST) +=3D            platform-test.o
> +obj-$(CONFIG_KUNIT_TEST) +=3D            backtrace-suppression-test.o
>
>  # string-stream-test compiles built-in only.
>  ifeq ($(CONFIG_KUNIT_TEST),y)
> diff --git a/lib/kunit/backtrace-suppression-test.c b/lib/kunit/backtrace=
-suppression-test.c
> new file mode 100644
> index 0000000000000..7a2a59c6a780d
> --- /dev/null
> +++ b/lib/kunit/backtrace-suppression-test.c
> @@ -0,0 +1,198 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit test for suppressing warning tracebacks.
> + *
> + * Copyright (C) 2024, Guenter Roeck
> + * Author: Guenter Roeck <linux@roeck-us.net>
> + */
> +
> +#include <kunit/test.h>
> +#include <linux/bug.h>
> +#include <linux/completion.h>
> +#include <linux/kthread.h>
> +
> +static void backtrace_suppression_test_warn_direct(struct kunit *test)
> +{
> +       if (!IS_ENABLED(CONFIG_BUG))
> +               kunit_skip(test, "requires CONFIG_BUG");
> +
> +       kunit_warning_suppress(test) {
> +               WARN(1, "This backtrace should be suppressed");
> +               /*
> +                * Count must be checked inside the scope; the handle
> +                * is not accessible after the block exits.
> +                */
> +               KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
> +       }
> +       KUNIT_EXPECT_FALSE(test, kunit_has_active_suppress_warning());
> +}
> +
> +static noinline void trigger_backtrace_warn(void)
> +{
> +       WARN(1, "This backtrace should be suppressed");
> +}
> +
> +static void backtrace_suppression_test_warn_indirect(struct kunit *test)
> +{
> +       if (!IS_ENABLED(CONFIG_BUG))
> +               kunit_skip(test, "requires CONFIG_BUG");
> +
> +       kunit_warning_suppress(test) {
> +               trigger_backtrace_warn();
> +               KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
> +       }
> +}
> +
> +static void backtrace_suppression_test_warn_multi(struct kunit *test)
> +{
> +       if (!IS_ENABLED(CONFIG_BUG))
> +               kunit_skip(test, "requires CONFIG_BUG");
> +
> +       kunit_warning_suppress(test) {
> +               WARN(1, "This backtrace should be suppressed");
> +               trigger_backtrace_warn();
> +               KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 2);
> +       }
> +}
> +
> +static void backtrace_suppression_test_warn_on_direct(struct kunit *test=
)
> +{
> +       if (!IS_ENABLED(CONFIG_BUG))
> +               kunit_skip(test, "requires CONFIG_BUG");
> +       if (!IS_ENABLED(CONFIG_DEBUG_BUGVERBOSE) && !IS_ENABLED(CONFIG_KA=
LLSYMS))
> +               kunit_skip(test, "requires CONFIG_DEBUG_BUGVERBOSE or CON=
FIG_KALLSYMS");
> +
> +       kunit_warning_suppress(test) {
> +               WARN_ON(1);
> +               KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
> +       }
> +}
> +
> +static noinline void trigger_backtrace_warn_on(void)
> +{
> +       WARN_ON(1);
> +}
> +
> +static void backtrace_suppression_test_warn_on_indirect(struct kunit *te=
st)
> +{
> +       if (!IS_ENABLED(CONFIG_BUG))
> +               kunit_skip(test, "requires CONFIG_BUG");
> +       if (!IS_ENABLED(CONFIG_DEBUG_BUGVERBOSE))
> +               kunit_skip(test, "requires CONFIG_DEBUG_BUGVERBOSE");
Sashiko says:
"""
Is there a reason why backtrace_suppression_test_warn_on_direct() falls bac=
k
to checking CONFIG_KALLSYMS while
backtrace_suppression_test_warn_on_indirect() does not?
The core warning suppression logic matches on the task, so it seems like
CONFIG_KALLSYMS should be sufficient for both.
Could this cause tests to be unnecessarily skipped on systems with
CONFIG_KALLSYMS enabled but CONFIG_DEBUG_BUGVERBOSE disabled?
"""
This is interesting. I am not sure why they were different; it was
probably an oversight. But after looking at it, this is probably a
leftover from when suppression occurred at the macros. They do not
seem necessary anymore. So I will remove them.

> +
> +       kunit_warning_suppress(test) {
> +               trigger_backtrace_warn_on();
> +               KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
> +       }
> +}
> +
> +static void backtrace_suppression_test_count(struct kunit *test)
> +{
> +       if (!IS_ENABLED(CONFIG_BUG))
> +               kunit_skip(test, "requires CONFIG_BUG");
> +
> +       kunit_warning_suppress(test) {
> +               KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 0);
> +
> +               WARN(1, "suppressed");
> +               KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
> +
> +               WARN(1, "suppressed again");
> +               KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 2);
> +       }
> +}
> +
> +static void backtrace_suppression_test_active_state(struct kunit *test)
> +{
> +       KUNIT_EXPECT_FALSE(test, kunit_has_active_suppress_warning());
> +
> +       kunit_warning_suppress(test) {
> +               KUNIT_EXPECT_TRUE(test, kunit_has_active_suppress_warning=
());
> +       }
> +
> +       KUNIT_EXPECT_FALSE(test, kunit_has_active_suppress_warning());
> +
> +       kunit_warning_suppress(test) {
> +               KUNIT_EXPECT_TRUE(test, kunit_has_active_suppress_warning=
());
> +       }
> +
> +       KUNIT_EXPECT_FALSE(test, kunit_has_active_suppress_warning());
> +}
> +
> +static void backtrace_suppression_test_multi_scope(struct kunit *test)
> +{
> +       struct kunit_suppressed_warning *sw1, *sw2;
> +
> +       if (!IS_ENABLED(CONFIG_BUG))
> +               kunit_skip(test, "requires CONFIG_BUG");
> +       if (!IS_ENABLED(CONFIG_DEBUG_BUGVERBOSE))
> +               kunit_skip(test, "requires CONFIG_DEBUG_BUGVERBOSE");
> +
> +       sw1 =3D kunit_start_suppress_warning(test);
> +       trigger_backtrace_warn_on();
> +       WARN(1, "suppressed by sw1");
> +       kunit_end_suppress_warning(test, sw1);
> +
> +       sw2 =3D kunit_start_suppress_warning(test);
> +       WARN(1, "suppressed by sw2");
> +       kunit_end_suppress_warning(test, sw2);
> +
> +       KUNIT_EXPECT_EQ(test, kunit_suppressed_warning_count(sw1), 2);
> +       KUNIT_EXPECT_EQ(test, kunit_suppressed_warning_count(sw2), 1);
> +}
> +
> +struct cross_kthread_data {
> +       bool was_active;
> +       struct completion done;
> +};
> +
> +static int cross_kthread_fn(void *data)
> +{
> +       struct cross_kthread_data *d =3D data;
> +
> +       d->was_active =3D kunit_has_active_suppress_warning();
> +       complete(&d->done);
> +       while (!kthread_should_stop())
> +               schedule();
> +       return 0;
> +}
> +
> +static void backtrace_suppression_test_cross_kthread(struct kunit *test)
> +{
> +       struct cross_kthread_data data;
> +       struct task_struct *task;
> +
> +       data.was_active =3D false;
> +       init_completion(&data.done);
> +
> +       kunit_warning_suppress(test) {
> +               task =3D kthread_run(cross_kthread_fn, &data, "kunit-cros=
s-test");
> +               KUNIT_ASSERT_FALSE(test, IS_ERR(task));
> +               wait_for_completion(&data.done);
> +               kthread_stop(task);
> +       }
> +
> +       KUNIT_EXPECT_FALSE(test, data.was_active);
> +}
> +
> +static struct kunit_case backtrace_suppression_test_cases[] =3D {
> +       KUNIT_CASE(backtrace_suppression_test_warn_direct),
> +       KUNIT_CASE(backtrace_suppression_test_warn_indirect),
> +       KUNIT_CASE(backtrace_suppression_test_warn_multi),
> +       KUNIT_CASE(backtrace_suppression_test_warn_on_direct),
> +       KUNIT_CASE(backtrace_suppression_test_warn_on_indirect),
> +       KUNIT_CASE(backtrace_suppression_test_count),
> +       KUNIT_CASE(backtrace_suppression_test_active_state),
> +       KUNIT_CASE(backtrace_suppression_test_multi_scope),
> +       KUNIT_CASE(backtrace_suppression_test_cross_kthread),
> +       {}
> +};
> +
> +static struct kunit_suite backtrace_suppression_test_suite =3D {
> +       .name =3D "backtrace-suppression-test",
> +       .test_cases =3D backtrace_suppression_test_cases,
> +};
> +kunit_test_suites(&backtrace_suppression_test_suite);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("KUnit test to verify warning backtrace suppression")=
;
>
> --
> 2.53.0
>

