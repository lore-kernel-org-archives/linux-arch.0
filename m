From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 03/11] asm-generic: add generic dwarf definition
Date: Mon, 26 Aug 2019 09:42:15 +0200
Message-ID: <20190826074215.GL2369@hirez.programming.kicks-ass.net>
References: <20190825132330.5015-1-changbin.du@gmail.com>
 <20190825132330.5015-4-changbin.du@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190825132330.5015-4-changbin.du@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Changbin Du <changbin.du@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-parisc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-sh@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, linux-mips@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Jessica Yu <jeyu@kernel.org>, sparclinux@vger.kernel.org, linux-kbuild@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Sun, Aug 25, 2019 at 09:23:22PM +0800, Changbin Du wrote:
> Add generic DWARF constant definitions. We will use it later.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  include/asm-generic/dwarf.h | 199 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 199 insertions(+)
>  create mode 100644 include/asm-generic/dwarf.h
> 
> diff --git a/include/asm-generic/dwarf.h b/include/asm-generic/dwarf.h
> new file mode 100644
> index 000000000000..c705633c2a8f
> --- /dev/null
> +++ b/include/asm-generic/dwarf.h
> @@ -0,0 +1,199 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Architecture independent definitions of DWARF.
> + *
> + * Copyright (C) 2019 Changbin Du <changbin.du@gmail.com>

You're claiming copyright on dwarf definitions? ;-)

I'm thinking only Oracle was daft enough to think stuff like that was
copyrightable.

Also; I think it would be very good to not use/depend on DWARF for this.

You really don't need all of DWARF; I'm thikning you only need a few
types; for location we already have regs_get_kernel_argument() which
has all the logic to find the n-th argument.
