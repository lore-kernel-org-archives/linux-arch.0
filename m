Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbfDDO05 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 Apr 2019 10:26:57 -0400
Date: Thu, 4 Apr 2019 10:26:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3/6 v3] riscv: Fix syscall_get_arguments() and
 syscall_set_arguments()
Message-ID: <20190404102653.705456df@gandalf.local.home>
In-Reply-To: <20190404140210.GC4962@altlinux.org>
References: <20190401134104.676620247@goodmis.org>
        <20190401134420.958530155@goodmis.org>
        <20190404140210.GC4962@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@amacapital.net>, Roland McGrath <roland@hack.frob.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>, Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Palmer Dabbelt <palmer@sifive.com>, Will Drewry <wad@chromium.org>, Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org
Message-ID: <20190404142653.SPkb-eLqcC3nwqZ0RgdVu6VDtLelYH8_oh4cXcvxtMs@z>

On Thu, 4 Apr 2019 17:02:10 +0300
"Dmitry V. Levin" <ldv@altlinux.org> wrote:

> On Mon, Apr 01, 2019 at 09:41:07AM -0400, Steven Rostedt wrote:
> > From: "Dmitry V. Levin" <ldv@altlinux.org>
> > 
> > RISC-V syscall arguments are located in orig_a0,a1..a5 fields
> > of struct pt_regs.
> > 
> > Due to an off-by-one bug and a bug in pointer arithmetic
> > syscall_get_arguments() was reading s3..s7 fields instead of a1..a5.
> > Likewise, syscall_set_arguments() was writing s3..s7 fields
> > instead of a1..a5.
> > 
> > Link: http://lkml.kernel.org/r/20190329171221.GA32456@altlinux.org
> > 
> > Fixes: e2c0cdfba7f69 ("RISC-V: User-facing API")
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Andy Lutomirski <luto@amacapital.net>
> > Cc: Will Drewry <wad@chromium.org>
> > Cc: Palmer Dabbelt <palmer@sifive.com>
> > Cc: Albert Ou <aou@eecs.berkeley.edu>
> > Cc: linux-riscv@lists.infradead.org
> > Cc: stable@vger.kernel.org # v4.15+
> > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>  
> 
> According to
> https://lore.kernel.org/lkml/mhng-8e9b547b-7fe3-43d2-9dea-b217de923605@palmer-si-x1c4/
> the following tag could be added to this patch:
>  
> Acked-by: Palmer Dabbelt <palmer@sifive.com>

That link isn't actually an ack. Palmer, you OK if I add it?

-- Steve
