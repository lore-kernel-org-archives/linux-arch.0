From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v5 10/12] kunit: Add 'kunit_shutdown' option
Date: Fri, 26 Jun 2020 14:40:32 -0700
Message-ID: <202006261436.DEF4906A5@keescook>
References: <20200626210917.358969-1-brendanhiggins@google.com>
 <20200626210917.358969-11-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgFZVkf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Jun 2020 17:40:35 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B518BC03E97A
        for <linux-arch@vger.kernel.org>; Fri, 26 Jun 2020 14:40:34 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id z5so5499418pgb.6
        for <linux-arch@vger.kernel.org>; Fri, 26 Jun 2020 14:40:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200626210917.358969-11-brendanhiggins@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Brendan Higgins <brendanhiggins@google.com>
Cc: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, arnd@arndb.de, skhan@linuxfoundation.org, alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com, akpm@linux-foundation.org, rppt@linux.ibm.com, frowand.list@gmail.com, catalin.marinas@arm.com, will@kernel.org, monstr@monstr.eu, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, chris@zankel.net, jcmvbkbc@gmail.com, gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com, mcgrof@kernel.org, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org

On Fri, Jun 26, 2020 at 02:09:15PM -0700, Brendan Higgins wrote:
> From: David Gow <davidgow@google.com>
> 
> Add a new kernel command-line option, 'kunit_shutdown', which allows the
> user to specify that the kernel poweroff, halt, or reboot after
> completing all KUnit tests; this is very handy for running KUnit tests
> on UML or a VM so that the UML/VM process exits cleanly immediately
> after running all tests without needing a special initramfs.
> 
> Signed-off-by: David Gow <davidgow@google.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  lib/kunit/executor.c                | 20 ++++++++++++++++++++
>  tools/testing/kunit/kunit_kernel.py |  2 +-
>  tools/testing/kunit/kunit_parser.py |  2 +-
>  3 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index a95742a4ece73..38061d456afb2 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> +#include <linux/reboot.h>
>  #include <kunit/test.h>
>  
>  /*
> @@ -11,6 +12,23 @@ extern struct kunit_suite * const * const __kunit_suites_end[];
>  
>  #if IS_BUILTIN(CONFIG_KUNIT)
>  
> +static char *kunit_shutdown;
> +core_param(kunit_shutdown, kunit_shutdown, charp, 0644);
> +
> +static void kunit_handle_shutdown(void)
> +{
> +	if (!kunit_shutdown)
> +		return;
> +
> +	if (!strcmp(kunit_shutdown, "poweroff"))
> +		kernel_power_off();
> +	else if (!strcmp(kunit_shutdown, "halt"))
> +		kernel_halt();
> +	else if (!strcmp(kunit_shutdown, "reboot"))
> +		kernel_restart(NULL);
> +
> +}

If you have patches that do something just before the initrd, and then
you add more patches to shut down immediately after an initrd, people
may ask you to just use an initrd instead of filling the kernel with
these changes...

I mean, I get it, but it's not hard to make an initrd that poke a sysctl
to start the tests...

In fact, you don't even need a initrd to poke sysctls these days.

-- 
Kees Cook
