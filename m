From: "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: Re: [RFC v2 7/7] kprobes: port to linker table
Date: Fri, 19 Feb 2016 15:55:28 +0100
Message-ID: <20160219145528.GQ25240@wotan.suse.de>
References: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
 <1455889559-9428-8-git-send-email-mcgrof@kernel.org>
 <20160219141511.GX19428@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44733 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1424800AbcBSOzd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 19 Feb 2016 09:55:33 -0500
Content-Disposition: inline
In-Reply-To: <20160219141511.GX19428@n2100.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, rusty@rustcorp.com.au, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, ming.lei@canonical.com, gregkh@linuxfoundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, benh@kernel.crashing.org, jbaron@akamai.com, ananth@in.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, masami.hiramatsu.pt@hitachi.com, andriy.shevchenko@linux.intel.com, dwmw2@infradead.org, xen-devel@lists.xensource.com

On Fri, Feb 19, 2016 at 02:15:11PM +0000, Russell King - ARM Linux wrote:
> On Fri, Feb 19, 2016 at 05:45:59AM -0800, Luis R. Rodriguez wrote:
> > kprobe makes use of two custom sections:
> > 
> > type       name                  begin                    end
> > init.data _kprobe_blacklist __start_kprobe_blacklist	__stop_kprobe_blacklist
> > text      .kprobes.text     __kprobes_text_start        __kprobes_text_end
> > 
> > Port these to the linker table generic solution. This lets
> > us remove all the custom kprobe section declarations on the
> > linker script.
> 
> I don't like this.  You create this "table" thing, which you use for
> tables, and then you go and use it for something else - for kprobes
> text which is not a table.  The kprobes text section is a section for
> text which is not kprobe-able.

No the thing about linker tables is its generalizing custom section solutions
we have scattered all over the place.

> So, it seems to be a complete mis-nomer to me.  Maybe you can explain
> the rationale here?

Sure, so each custom section solution requires modifying the linker script.
With linker tables we end up only with a few basic types of tables, a
read-only, text, data, init init_data, etc. A linker table belongs to one of
these. The linker table provides a means by which to describe explicitly
what type of section you are using for your solution but also allows us
to enable such custom solutions without furthering the custom linker
script.

  Luis
