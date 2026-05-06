Received: from sphereful.davidgow.net (sphereful.davidgow.net [203.29.242.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654263E4C7F;
	Wed,  6 May 2026 09:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.242.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060468; cv=none; b=HIACZMEHeue0+CIe0B2AvF2WsVG7zjoOGkTZq2Ae1HtKEaqC7OfeCfzlXHIRUhmkdqUh7CxQQAYOsLElqbpJ8nL21ejedYAv/zf05hO1uvAm8uzb5J1Ncr9olvcxdHnahqtGWtN9Mm52W1ydZqhFIpo5sk3PrFl+DwKWeSREvro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060468; c=relaxed/simple;
	bh=6tB+6jOaCyQ7E3hH/j4dCBk9Ou53D5QZH+hA9+t+gxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B1TV2ATZhLUV0IVOy4kwXzSbeWaM7s6oZtsxfZHBJkQw6SS4NrhMJNbrdrSX/hnBWPTTSE5kWd7N6vdsw3NteGBqqeokAB9XxEV6uuB0wwvPsP1diB7X1zpUhJhOU5xLO/b9QLhheHMAEhBhVeIZfYIoa08qmUi49tSOcjBDO/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=davidgow.net; spf=pass smtp.mailfrom=davidgow.net; dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b=XnjIgZxn; dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b=UFkuNwst; arc=none smtp.client-ip=203.29.242.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=davidgow.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidgow.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b="XnjIgZxn";
	dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b="UFkuNwst"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
	s=201606; t=1778060464;
	bh=6tB+6jOaCyQ7E3hH/j4dCBk9Ou53D5QZH+hA9+t+gxY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XnjIgZxnHwhQMWQa8qY5SCGnkqzWiS/T7pOyPiYnz0dGf5fhvLfU+wYf6W9Aiw3Om
	 0ZlerwrIkBSa51HQ7X7KpPA5JHUylojVrIlJVFokij0nxLBpMVgWYY/EJjg/+LDnSr
	 bCidMmFjoYAnC7BfstdDjSQJhepAMQrIc9nSpB9gKTjJ/xug61ul0q5rWPpo5Ge0ON
	 dUbE05+EE8dccsP4ZHpsgUn3EAd4+HaNERwTKbdDviqpA021ah3fkkiMLYzsFCgUBX
	 GG8XvQmeepI2/gxiiTFo6nPVRKlfUoTlrksiZh93U7mwCahyDwhpeehDUFZ2Bk3ayA
	 aoRWUIAH+0qb5a3Rg0el/KFVUb8bSImqZe7FUT1jkCuot7qeKvTDdDT3j4qEmCs4bT
	 XH24FesllkaYpfL49HaN+MtThhOSS184RzO5WYMfm44+OpyjIXWcv89qe4KB2i1Hct
	 gtsnWTNJw/0xV5fO4qIxLxRB0Ras5Df4S53WgGX3TiXDRfBLyDxmcVFmSoO2KhgfxW
	 23UyLurHvOv2iM6h0Y2R6cHAq9M4/sMtr2EFa3/zmlrwGf944q7BrxRZIT+3WjuTE6
	 Rri8jhbzkAl7964sf028R7hA5F3op3hWSyoc/V0fmCNLne8O//M6jKRs0XNUU7grYL
	 UYzSb0ud9p6JZbmU8uYqJ8ro=
Received: by sphereful.davidgow.net (Postfix, from userid 119)
	id 176FD1E935E; Wed,  6 May 2026 17:41:04 +0800 (AWST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
	s=201606; t=1778060326;
	bh=6tB+6jOaCyQ7E3hH/j4dCBk9Ou53D5QZH+hA9+t+gxY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UFkuNwstOzZg177E0QL1KqkA5Zl7hC3GlM9cqu+F+HZYFmq7iHVuP08alv2n8tzdE
	 UPSiYHDgpXEDMmhwyr7zSKCQ8bHHhKdR71aIWt54zbwP0RoiI2Xqab4reQvaAqK2NI
	 W5zQlNxJ04jr2Vxqawes5Cc3da6yTkfFHvAa6x5UoSJhRKzhMdzBY2RsrD04PvyXEe
	 2zGE0YzKTzwWrFVvxYWRymfafEDiWoPuNdAgg5sB57TDqGErp83PZ/c8O2131fPHbr
	 poH3vN8M5SDR3m0n4Hd8vHXkc7OhbF7TWv0spUxQ4aYah0ZavxA8eZxPg2ZrkRb5yr
	 EvR/yGGhCJnlfnlb02pHR1px6COis+p5wQCGOhcFS8ZsIJ3696uG6vUYCfRT0ULIbK
	 Qoc0r405/XG3rMtafaZkO3WL7l9OZBcjsBmXT69QuDROUlTVfxhim1X3i1DeeyQPfF
	 S4Y+VShkK0+QZ7RDVFjl19s8UqqXZBGps7wNoJyfMDhg2nbKAs1ZHdZIORHuQVYrtD
	 t0QkivG48Zom1Rut1aWMQZRhvtetavnekGNbLZ9mXuw7JJPKq+c69JNdJMxQ7uM98u
	 bUGbE+bwMTNVz8pSpy57kSRyJqyJt23woVOj+7G0biHCn++FxbKftsx/odOXs5Pg48
	 6A+xtPUevIqYuC85k5OEV3q8=
Received: from [IPV6:2001:8003:8810:ea00:ed87:ca88:5326:e11d] (unknown [IPv6:2001:8003:8810:ea00:ed87:ca88:5326:e11d])
	by sphereful.davidgow.net (Postfix) with ESMTPSA id AAE421E86FC;
	Wed,  6 May 2026 17:38:46 +0800 (AWST)
Message-ID: <240b1b10-61f3-4e14-8312-dea1ade5bc59@davidgow.net>
Date: Wed, 6 May 2026 17:38:46 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/4] kunit: Add backtrace suppression self-tests
To: Albert Esteve <aesteve@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <raemoar63@gmail.com>,
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
 peterz@infradead.org, Guenter Roeck <linux@roeck-us.net>,
 Linux Kernel Functional Testing <lkft@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Alessandro Carminati <acarmina@redhat.com>, Kees Cook <kees@kernel.org>
References: <20260504-kunit_add_support-v8-0-3e5957cdd235@redhat.com>
 <20260504-kunit_add_support-v8-2-3e5957cdd235@redhat.com>
Content-Language: fr
From: David Gow <david@davidgow.net>
In-Reply-To: <20260504-kunit_add_support-v8-2-3e5957cdd235@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 04/05/2026 à 3:41 PM, Albert Esteve a écrit :
> From: Guenter Roeck <linux@roeck-us.net>
> 
> Add unit tests to verify that warning backtrace suppression works.
> 
> Tests cover all three API forms:
> - Scoped: kunit_warning_suppress() with in-block count verification
>    and post-block inactivity check.
> - Manual macros: KUNIT_START/END_SUPPRESSED_WARNING() with WARN()
>    and WARN_ON(), both direct and through helper functions, as well
>    as multiple warnings in a single block.
> - Direct functions: kunit_start/end_suppress_warning() with
>    sequential independent suppression blocks and per-block counts.
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

Looks good to me, thanks!

This is still:

Reviewed-by: David Gow <david@davidgow.net>

Cheers,
-- David

>   lib/kunit/Makefile                     |   1 +
>   lib/kunit/backtrace-suppression-test.c | 184 +++++++++++++++++++++++++++++++++
>   2 files changed, 185 insertions(+)
> 
> diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> index 4592f9d0aa8dd..2e8a6b71a2ab0 100644
> --- a/lib/kunit/Makefile
> +++ b/lib/kunit/Makefile
> @@ -22,6 +22,7 @@ obj-$(if $(CONFIG_KUNIT),y) +=		hooks.o
>   
>   obj-$(CONFIG_KUNIT_TEST) +=		kunit-test.o
>   obj-$(CONFIG_KUNIT_TEST) +=		platform-test.o
> +obj-$(CONFIG_KUNIT_TEST) +=		backtrace-suppression-test.o
>   
>   # string-stream-test compiles built-in only.
>   ifeq ($(CONFIG_KUNIT_TEST),y)
> diff --git a/lib/kunit/backtrace-suppression-test.c b/lib/kunit/backtrace-suppression-test.c
> new file mode 100644
> index 0000000000000..0e6fb685d2cbb
> --- /dev/null
> +++ b/lib/kunit/backtrace-suppression-test.c
> @@ -0,0 +1,184 @@
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
> +	kunit_warning_suppress(test) {
> +		WARN(1, "This backtrace should be suppressed");
> +		/*
> +		 * Count must be checked inside the scope; the handle
> +		 * is not accessible after the block exits.
> +		 */
> +		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
> +	}
> +	KUNIT_EXPECT_FALSE(test, kunit_has_active_suppress_warning());
> +}
> +
> +static void trigger_backtrace_warn(void)
> +{
> +	WARN(1, "This backtrace should be suppressed");
> +}
> +
> +static void backtrace_suppression_test_warn_indirect(struct kunit *test)
> +{
> +	KUNIT_START_SUPPRESSED_WARNING(test);
> +	trigger_backtrace_warn();
> +	KUNIT_END_SUPPRESSED_WARNING(test);
> +
> +	KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
> +}
> +
> +static void backtrace_suppression_test_warn_multi(struct kunit *test)
> +{
> +	KUNIT_START_SUPPRESSED_WARNING(test);
> +	WARN(1, "This backtrace should be suppressed");
> +	trigger_backtrace_warn();
> +	KUNIT_END_SUPPRESSED_WARNING(test);
> +
> +	KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 2);
> +}
> +
> +static void backtrace_suppression_test_warn_on_direct(struct kunit *test)
> +{
> +	if (!IS_ENABLED(CONFIG_DEBUG_BUGVERBOSE) && !IS_ENABLED(CONFIG_KALLSYMS))
> +		kunit_skip(test, "requires CONFIG_DEBUG_BUGVERBOSE or CONFIG_KALLSYMS");
> +
> +	KUNIT_START_SUPPRESSED_WARNING(test);
> +	WARN_ON(1);
> +	KUNIT_END_SUPPRESSED_WARNING(test);
> +
> +	KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
> +}
> +
> +static void trigger_backtrace_warn_on(void)
> +{
> +	WARN_ON(1);
> +}
> +
> +static void backtrace_suppression_test_warn_on_indirect(struct kunit *test)
> +{
> +	if (!IS_ENABLED(CONFIG_DEBUG_BUGVERBOSE))
> +		kunit_skip(test, "requires CONFIG_DEBUG_BUGVERBOSE");
> +
> +	KUNIT_START_SUPPRESSED_WARNING(test);
> +	trigger_backtrace_warn_on();
> +	KUNIT_END_SUPPRESSED_WARNING(test);
> +
> +	KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
> +}
> +
> +static void backtrace_suppression_test_count(struct kunit *test)
> +{
> +	KUNIT_START_SUPPRESSED_WARNING(test);
> +
> +	KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 0);
> +
> +	WARN(1, "suppressed");
> +	KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
> +
> +	WARN(1, "suppressed again");
> +	KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 2);
> +
> +	KUNIT_END_SUPPRESSED_WARNING(test);
> +}
> +
> +static void backtrace_suppression_test_active_state(struct kunit *test)
> +{
> +	KUNIT_EXPECT_FALSE(test, kunit_has_active_suppress_warning());
> +
> +	KUNIT_START_SUPPRESSED_WARNING(test);
> +	KUNIT_EXPECT_TRUE(test, kunit_has_active_suppress_warning());
> +	KUNIT_END_SUPPRESSED_WARNING(test);
> +
> +	KUNIT_EXPECT_FALSE(test, kunit_has_active_suppress_warning());
> +
> +	kunit_warning_suppress(test) {
> +		KUNIT_EXPECT_TRUE(test, kunit_has_active_suppress_warning());
> +	}
> +
> +	KUNIT_EXPECT_FALSE(test, kunit_has_active_suppress_warning());
> +}
> +
> +static void backtrace_suppression_test_multi_scope(struct kunit *test)
> +{
> +	struct kunit_suppressed_warning *sw1, *sw2;
> +
> +	if (!IS_ENABLED(CONFIG_DEBUG_BUGVERBOSE))
> +		kunit_skip(test, "requires CONFIG_DEBUG_BUGVERBOSE");
> +
> +	sw1 = kunit_start_suppress_warning(test);
> +	trigger_backtrace_warn_on();
> +	WARN(1, "suppressed by sw1");
> +	kunit_end_suppress_warning(test, sw1);
> +
> +	sw2 = kunit_start_suppress_warning(test);
> +	WARN(1, "suppressed by sw2");
> +	kunit_end_suppress_warning(test, sw2);
> +
> +	KUNIT_EXPECT_EQ(test, kunit_suppressed_warning_count(sw1), 2);
> +	KUNIT_EXPECT_EQ(test, kunit_suppressed_warning_count(sw2), 1);
> +}
> +
> +struct cross_kthread_data {
> +	bool was_active;
> +	struct completion done;
> +};
> +
> +static int cross_kthread_fn(void *data)
> +{
> +	struct cross_kthread_data *d = data;
> +
> +	d->was_active = kunit_has_active_suppress_warning();
> +	complete(&d->done);
> +	return 0;
> +}
> +
> +static void backtrace_suppression_test_cross_kthread(struct kunit *test)
> +{
> +	struct cross_kthread_data data;
> +	struct task_struct *task;
> +
> +	init_completion(&data.done);
> +
> +	KUNIT_START_SUPPRESSED_WARNING(test);
> +
> +	task = kthread_run(cross_kthread_fn, &data, "kunit-cross-test");
> +	KUNIT_ASSERT_FALSE(test, IS_ERR(task));
> +	wait_for_completion(&data.done);
> +
> +	KUNIT_END_SUPPRESSED_WARNING(test);
> +
> +	KUNIT_EXPECT_FALSE(test, data.was_active);
> +}
> +
> +static struct kunit_case backtrace_suppression_test_cases[] = {
> +	KUNIT_CASE(backtrace_suppression_test_warn_direct),
> +	KUNIT_CASE(backtrace_suppression_test_warn_indirect),
> +	KUNIT_CASE(backtrace_suppression_test_warn_multi),
> +	KUNIT_CASE(backtrace_suppression_test_warn_on_direct),
> +	KUNIT_CASE(backtrace_suppression_test_warn_on_indirect),
> +	KUNIT_CASE(backtrace_suppression_test_count),
> +	KUNIT_CASE(backtrace_suppression_test_active_state),
> +	KUNIT_CASE(backtrace_suppression_test_multi_scope),
> +	KUNIT_CASE(backtrace_suppression_test_cross_kthread),
> +	{}
> +};
> +
> +static struct kunit_suite backtrace_suppression_test_suite = {
> +	.name = "backtrace-suppression-test",
> +	.test_cases = backtrace_suppression_test_cases,
> +};
> +kunit_test_suites(&backtrace_suppression_test_suite);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("KUnit test to verify warning backtrace suppression");
> 

