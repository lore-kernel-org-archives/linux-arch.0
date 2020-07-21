From: Marco Elver <elver@google.com>
Subject: Re: [PATCH 5/8] kcsan: Test support for compound instrumentation
Date: Tue, 21 Jul 2020 13:06:02 +0200
Message-ID: <20200721110602.GA3311326@elver.google.com>
References: <20200721103016.3287832-1-elver@google.com>
 <20200721103016.3287832-6-elver@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbgGULGL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 07:06:11 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4909C0619D8
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 04:06:10 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f139so2425654wmf.5
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 04:06:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200721103016.3287832-6-elver@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulmck@kernel.org
Cc: will@kernel.org, peterz@infradead.org, arnd@arndb.de, mark.rutland@arm.com, dvyukov@google.com, glider@google.com, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tue, Jul 21, 2020 at 12:30PM +0200, Marco Elver wrote:
[...]
> diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
> index 3d282d51849b..cde5b62b0a01 100644
> --- a/lib/Kconfig.kcsan
> +++ b/lib/Kconfig.kcsan
> @@ -40,6 +40,11 @@ menuconfig KCSAN
>  
>  if KCSAN
>  
> +# Compiler capabilities that should not fail the test if they are unavailable.
> +config CC_HAS_TSAN_COMPOUND_READ_BEFORE_WRITE
> +	def_bool (CC_IS_CLANG && $(cc-option,-fsanitize=thread -mllvm -tsan-compound-read-before-write=1)) || \
> +		 (CC_IS_GCC && $(cc-option,-fsanitize=thread --param -tsan-compound-read-before-write=1))
> +
>  config KCSAN_VERBOSE
>  	bool "Show verbose reports with more information about system state"
>  	depends on PROVE_LOCKING

Ah, darn, one too many '-' on the CC_IS_GCC line.

	s/--param -tsan/--param tsan/

Below is what this chunk should have been. Not
that it matters right now, because GCC doesn't have this option
(although I hope it gains it eventually).

Paul, if you prefer v2 of the series with the fix, please let me know.
(In case there aren't more things to fix.)

Thanks,
-- Marco

------ >8 ------

diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 3d282d51849b..f271ff5fbb5a 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -40,6 +40,11 @@ menuconfig KCSAN
 
 if KCSAN
 
+# Compiler capabilities that should not fail the test if they are unavailable.
+config CC_HAS_TSAN_COMPOUND_READ_BEFORE_WRITE
+	def_bool (CC_IS_CLANG && $(cc-option,-fsanitize=thread -mllvm -tsan-compound-read-before-write=1)) || \
+		 (CC_IS_GCC && $(cc-option,-fsanitize=thread --param tsan-compound-read-before-write=1))
+
 config KCSAN_VERBOSE
 	bool "Show verbose reports with more information about system state"
 	depends on PROVE_LOCKING
