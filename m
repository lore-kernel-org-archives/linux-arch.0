From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v5 01/12] vmlinux.lds.h: add linker section for KUnit
 test suites
Date: Fri, 26 Jun 2020 14:20:13 -0700
Message-ID: <202006261416.F4EAAE47E3@keescook>
References: <20200626210917.358969-1-brendanhiggins@google.com>
 <20200626210917.358969-2-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgFZVUQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Jun 2020 17:20:16 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A73C03E979
        for <linux-arch@vger.kernel.org>; Fri, 26 Jun 2020 14:20:15 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d10so4712594pls.5
        for <linux-arch@vger.kernel.org>; Fri, 26 Jun 2020 14:20:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200626210917.358969-2-brendanhiggins@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Brendan Higgins <brendanhiggins@google.com>
Cc: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, arnd@arndb.de, skhan@linuxfoundation.org, alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com, akpm@linux-foundation.org, rppt@linux.ibm.com, frowand.list@gmail.com, catalin.marinas@arm.com, will@kernel.org, monstr@monstr.eu, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, chris@zankel.net, jcmvbkbc@gmail.com, gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com, mcgrof@kernel.org, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org

On Fri, Jun 26, 2020 at 02:09:06PM -0700, Brendan Higgins wrote:
> Add a linker section where KUnit can put references to its test suites.
> This patch is the first step in transitioning to dispatching all KUnit
> tests from a centralized executor rather than having each as its own
> separate late_initcall.
> 
> Co-developed-by: Iurii Zaikin <yzaikin@google.com>
> Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  include/asm-generic/vmlinux.lds.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index db600ef218d7d..4f9b036fc9616 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -881,6 +881,13 @@
>  		KEEP(*(.con_initcall.init))				\
>  		__con_initcall_end = .;
>  
> +/* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */

Nit on naming:

> +#define KUNIT_TEST_SUITES						\

I would call this KUNIT_TABLE to maintain the same names as other things
of this nature.

> +		. = ALIGN(8);						\
> +		__kunit_suites_start = .;				\
> +		KEEP(*(.kunit_test_suites))				\
> +		__kunit_suites_end = .;
> +
>  #ifdef CONFIG_BLK_DEV_INITRD
>  #define INIT_RAM_FS							\
>  	. = ALIGN(4);							\
> @@ -1056,6 +1063,7 @@
>  		INIT_CALLS						\
>  		CON_INITCALL						\
>  		INIT_RAM_FS						\
> +		KUNIT_TEST_SUITES					\
>  	}

Nack: this must be in INIT_DATA, not in INIT_DATA_SECTION. Not all
architectures use the INIT_DATA_SECTION macro (e.g. arm64), but everything
uses INIT_DATA.


-- 
Kees Cook
