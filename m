From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH REBASED 2/3] x86: Move fpu_counter into ARCH specific
 thread_struct
Date: Mon, 23 Sep 2013 10:33:16 +0200
Message-ID: <20130923083316.GB10891@gmail.com>
References: <1379398639-27403-1-git-send-email-vgupta@synopsys.com>
 <1379398639-27403-3-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ea0-f173.google.com ([209.85.215.173]:50824 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171Ab3IWIdU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 23 Sep 2013 04:33:20 -0400
Received: by mail-ea0-f173.google.com with SMTP id g10so1545083eak.32
        for <linux-arch@vger.kernel.org>; Mon, 23 Sep 2013 01:33:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1379398639-27403-3-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org


* Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:

> Only a couple of arches (sh/x86) use fpu_counter in task_struct so it
> can be moved out into ARCH specific thread_struct, reducing the size of
> task_struct for other arches.
> 
> Compile tested i386_defconfig + gcc 4.7.3
> 
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: Suresh Siddha <suresh.b.siddha@intel.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Vincent Palatin <vpalatin@chromium.org>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
> Cc: Pekka Riikonen <priikone@iki.fi>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dave Jones <davej@redhat.com>
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/x86/include/asm/fpu-internal.h | 10 +++++-----
>  arch/x86/include/asm/processor.h    |  9 +++++++++
>  arch/x86/kernel/i387.c              |  2 +-
>  arch/x86/kernel/process_32.c        |  4 ++--
>  arch/x86/kernel/process_64.c        |  2 +-
>  arch/x86/kernel/traps.c             |  2 +-
>  6 files changed, 19 insertions(+), 10 deletions(-)

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
