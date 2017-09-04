Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38794 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753913AbdIDRet (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Sep 2017 13:34:49 -0400
Date: Mon, 4 Sep 2017 20:34:44 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [tip:locking/core] locking/refcount: Create unchecked atomic_t
 implementation
Message-ID: <20170904173444.GA7233@avx2>
References: <20170621200026.GA115679@beast>
 <tip-fd25d19f6b8da315332bb75936605fb45d3ea981@git.kernel.org>
 <20170904123724.5trepllnd25r4uyt@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170904123724.5trepllnd25r4uyt@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: davem@davemloft.net, arnd@arndb.de, manfred@colorfullife.com, riel@redhat.com, hpa@zytor.com, ebiggers3@gmail.com, elena.reshetova@intel.com, keescook@chromium.org, dwindsor@gmail.com, mingo@kernel.org, jannh@google.com, serge@hallyn.com, gregkh@linuxfoundation.org, ebiederm@xmission.com, ishkamiel@gmail.com, tglx@linutronix.de, hch@infradead.org, jpoimboe@redhat.com, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, dave@stgolabs.net, linux-arch@vger.kernel.org, James.Bottomley@hansenpartnership.com, linux-tip-commits@vger.kernel.org
Message-ID: <20170904173444.jICVNLfZTPgi3HH9GStbT78XAhOBEP4n3QB3kQdinn4@z>

On Mon, Sep 04, 2017 at 02:37:24PM +0200, Peter Zijlstra wrote:
> -	 once.o refcount.o usercopy.o errseq.o
> -obj-y += string_helpers.o
> +	 once.o usercopy.o errseq.o string_helpers.o hexdump.o kstrtox.o
> +
> +obj-$(CONFIG_REFCOUNT_FULL) += refcount.o
>  obj-$(CONFIG_TEST_STRING_HELPERS) += test-string_helpers.o
> -obj-y += hexdump.o
>  obj-$(CONFIG_TEST_HEXDUMP) += test_hexdump.o
> -obj-y += kstrtox.o

File per line so everything is not lumped together even if it is obj-y.
