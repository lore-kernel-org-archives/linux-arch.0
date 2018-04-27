From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3 5/7] kprobes/x86: Fix %p uses in error messages
Date: Fri, 27 Apr 2018 08:58:17 +0200
Message-ID: <20180427065817.tedhin5sy7brgq7m@gmail.com>
References: <152481117776.22588.1210388093668905564.stgit@devbox>
 <152481133105.22588.10668983189195179761.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <152481133105.22588.10668983189195179761.stgit@devbox>
Sender: linux-kernel-owner@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, Jon Medhurst <tixy@linaro.org>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Tobin C . Harding" <me@tobin.cc>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Richter <tmricht@linux.ibm.com>, akpm@linux-foundation.org, acme@kernel.org, rostedt@goodmis.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, stable@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


* Masami Hiramatsu <mhiramat@kernel.org> wrote:

>  	    (addr < (u8 *) jprobe_return_end)) {
>  		if (stack_addr(regs) != saved_sp) {
>  			struct pt_regs *saved_regs = &kcb->jprobe_saved_regs;
> -			printk(KERN_ERR
> -			       "current sp %p does not match saved sp %p\n",
> +			pr_err("current sp %pS does not match saved sp %pS\n",
>  			       stack_addr(regs), saved_sp);

Why does this use %pS? Stack pointers are typically pointing into general kernel 
RAM, which is totally pointless to display 'symbolically'.

Thanks,

	Ingo
