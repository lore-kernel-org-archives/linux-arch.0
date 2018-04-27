From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3 2/7] kprobes: Show blacklist addresses as same as
 kallsyms does
Date: Fri, 27 Apr 2018 09:14:17 +0200
Message-ID: <20180427071417.lq4swylywht7mdy7@gmail.com>
References: <152481117776.22588.1210388093668905564.stgit@devbox>
 <152481123945.22588.459569704440210836.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <152481123945.22588.459569704440210836.stgit@devbox>
Sender: stable-owner@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, Jon Medhurst <tixy@linaro.org>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Tobin C . Harding" <me@tobin.cc>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Richter <tmricht@linux.ibm.com>, akpm@linux-foundation.org, acme@kernel.org, rostedt@goodmis.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, stable@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


* Masami Hiramatsu <mhiramat@kernel.org> wrote:

> +	/*
> +	 * As long as kallsyms shows the address, kprobes blacklist also
> +	 * show it, Or, it shows null address and symbol.
> +	 */

Please _read_ the comments you write!

In which universe does a capitalized 'Or' make sense, even if we ignore the 
various other spelling mistakes?

Also, that sentence is unnecessarily complex, just say this:

> +	/*
> +	 * If /proc/kallsyms is not showing kernel addresses then we won't show 
> +      * them here either:
> +	 */

But I'm unhappy about the messy typing and the messy code flow:

+       void *start = (void *)ent->start_addr, *end = (void *)ent->end_addr;

+       /*
+        * As long as kallsyms shows the address, kprobes blacklist also
+        * show it, Or, it shows null address and symbol.
+        */
+       if (!kallsyms_show_value())
+               start = end = NULL;
+
+       seq_printf(m, "0x%px-0x%px\t%ps\n", start, end,
+                  (void *)ent->start_addr);


All three 'void *' type casts here are due to the bad type choices here:

struct kprobe_blacklist_entry {
        struct list_head list;
        unsigned long start_addr;
        unsigned long end_addr;
};

The natural type of ->start_addr and ->end_addr is 'void *', AFAICS this would 
remove some other type casts from the kprobes code as well, such as from the 
arch_deref_entry_point()...

But the whole code flow introduced by this patch is messy as hell as well.
Why cannot this do the obvious thing:

	if (!kallsyms_show_value())
		seq_printf(m, "0x%px-0x%px\t%ps\n", NULL, NULL, ent->start_addr);
	else
		seq_printf(m, "0x%px-0x%px\t%ps\n", ent->start_addr, ent->end_addr, ent->start_addr);

?

This variant eliminates the unnecessary complication over local variables and 
makes it abundantly clear what gets printed and how.

( Note that the kprobe_blacklist_entry type cleanup should still be done, 
  regardless of code flow choices. )

Thanks,

	Ingo
