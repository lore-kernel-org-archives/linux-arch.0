From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/8] kcsan: Compound read-write instrumentation
Date: Fri, 24 Jul 2020 10:39:20 +0200
Message-ID: <20200724083920.GV10769@hirez.programming.kicks-ass.net>
References: <20200724070008.1389205-1-elver@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgGXIjd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jul 2020 04:39:33 -0400
Content-Disposition: inline
In-Reply-To: <20200724070008.1389205-1-elver@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marco Elver <elver@google.com>
Cc: paulmck@kernel.org, will@kernel.org, arnd@arndb.de, mark.rutland@arm.com, dvyukov@google.com, glider@google.com, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Fri, Jul 24, 2020 at 09:00:00AM +0200, Marco Elver wrote:

> Marco Elver (8):
>   kcsan: Support compounded read-write instrumentation
>   objtool, kcsan: Add __tsan_read_write to uaccess whitelist
>   kcsan: Skew delay to be longer for certain access types
>   kcsan: Add missing CONFIG_KCSAN_IGNORE_ATOMICS checks
>   kcsan: Test support for compound instrumentation
>   instrumented.h: Introduce read-write instrumentation hooks
>   asm-generic/bitops: Use instrument_read_write() where appropriate
>   locking/atomics: Use read-write instrumentation for atomic RMWs

Looks good to me,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
