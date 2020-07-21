From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/8] kcsan: Skew delay to be longer for certain access
 types
Date: Tue, 21 Jul 2020 16:05:23 +0200
Message-ID: <20200721140523.GA10769@hirez.programming.kicks-ass.net>
References: <20200721103016.3287832-1-elver@google.com>
 <20200721103016.3287832-4-elver@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgGUOFc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 10:05:32 -0400
Content-Disposition: inline
In-Reply-To: <20200721103016.3287832-4-elver@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marco Elver <elver@google.com>
Cc: paulmck@kernel.org, will@kernel.org, arnd@arndb.de, mark.rutland@arm.com, dvyukov@google.com, glider@google.com, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tue, Jul 21, 2020 at 12:30:11PM +0200, Marco Elver wrote:
> For compound instrumentation and assert accesses, skew the watchpoint
> delay to be longer. We still shouldn't exceed the maximum delays, but it
> is safe to skew the delay for these accesses.

Complete lack of actual justification.. *why* are you doing this, and
*why* is it safe etc..
