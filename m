From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [RFC v2 0/7] linux: add linker tables
Date: Fri, 19 Feb 2016 22:19:48 +0100
Message-ID: <20160219211948.GW25240@wotan.suse.de>
References: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
 <56C7781D.3040603@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56C7781D.3040603@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, rusty@rustcorp.com.au, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, ming.lei@canonical.com, gregkh@linuxfoundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, linux@arm.linux.org.uk, benh@kernel.crashing.org, jbaron@akamai.com, ananth@in.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, masami.hiramatsu.pt@hitachi.com, andriy.shevchenko@linux.intel.com, dwmw2@infradead.org, xen-devel@lists.xensource.com
List-Id: linux-arch.vger.kernel.org

On Fri, Feb 19, 2016 at 12:16:29PM -0800, H. Peter Anvin wrote:
> On 02/19/2016 05:45 AM, Luis R. Rodriguez wrote:
> > This is my v2 of the original linker table work [0], now with
> > six proof of concepts ports of existing code using custom section
> > with custom linker script modifications:
> > 
> >   * DEFINE_LINKTABLE_TEXT(char, kprobes);
> >   * DEFINE_LINKTABLE_DATA(struct jump_entry, __jump_table);
> >   * DEFINE_LINKTABLE_DATA(struct _ddebug, __verbose);
> >   * DEFINE_LINKTABLE_RO(struct builtin_fw, builtin_fw);
> >   * DEFINE_LINKTABLE_INIT(struct x86_init_fn, x86_init_fns);
> >   * DEFINE_LINKTABLE_INIT_DATA(unsigned long, _kprobe_blacklist);
> > 
> > I've tested all except jump tables, I'd appreaciate some help with that.
> > 
> 
> We should add support for read-mostly, probably. 

Sure, any candidate in mind? I actually don't see any hacks built
on top of READ_MOSTLY_DATA include/asm-generic/vmlinux.lds.h so
pointers appreciated for a case I could try.

> In fact, some of these probably *are* read-mostly.

To avoid regressions I made sure to use the same exact section that
these original solutions came from, do we want to move some? If so
I think perhaps that's best done as a separate atomic patch and
it may be easier to read and review once ported on linker tables?

 Luis
