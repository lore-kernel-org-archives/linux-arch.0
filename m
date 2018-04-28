From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v3 4/7] kprobes: Replace %p with other pointer types
Date: Sat, 28 Apr 2018 13:43:33 +0900
Message-ID: <20180428134333.6e1b878fc9748dac67387476@kernel.org>
References: <152481117776.22588.1210388093668905564.stgit@devbox>
        <152481130062.22588.10747314456340608852.stgit@devbox>
        <20180427065636.ells635z7cw4b4oz@gmail.com>
        <20180428004202.4297e781304b5eda53100f67@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180428004202.4297e781304b5eda53100f67@kernel.org>
Sender: stable-owner@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, Jon Medhurst <tixy@linaro.org>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Tobin C . Harding" <me@tobin.cc>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Richter <tmricht@linux.ibm.com>, akpm@linux-foundation.org, acme@kernel.org, rostedt@goodmis.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, stable@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sat, 28 Apr 2018 00:42:02 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > > +/* Caller must NOT call this in usual path. This is only for critical case */
> > >  void dump_kprobe(struct kprobe *kp)
> > >  {
> > > -	printk(KERN_WARNING "Dumping kprobe:\n");
> > > -	printk(KERN_WARNING "Name: %s\nAddress: %p\nOffset: %x\n",
> > > -	       kp->symbol_name, kp->addr, kp->offset);
> > > +	pr_err("Dumping kprobe:\n");
> > > +	pr_err("Name: %s\nOffset: %x\nAddress: %pS\n",
> > > +	       kp->symbol_name, kp->offset, kp->addr);
> > 
> > No, this function should just go away and be replaced by a WARN() in 
> > reenter_kprobe().
> 
> Would you consider to use pr_err() here? If so, I'll move this
> dump as you suggested.

So, this is actually called right before BUG(), which means we found
a non-recoverable error while recovering from reentrant kprobes.
Since the BUG() dumps all registers and stack as same as WARN(),
I think we should keep it.
(I would like to dump all kprobes fields like flags, etc. so that
 we can find it is broken or not.)

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
