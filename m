From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC v2 0/7] linux: add linker tables
Date: Fri, 19 Feb 2016 12:16:29 -0800
Message-ID: <56C7781D.3040603@zytor.com>
References: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:59217 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946795AbcBSUUi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 19 Feb 2016 15:20:38 -0500
In-Reply-To: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, rusty@rustcorp.com.au, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, ming.lei@canonical.com, gregkh@linuxfoundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, linux@arm.linux.org.uk, benh@kernel.crashing.org, jbaron@akamai.com, ananth@in.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, masami.hiramatsu.pt@hitachi.com, andriy.shevchenko@linux.intel.com, dwmw2@infradead.org, xen-devel@lists.xensource.com

On 02/19/2016 05:45 AM, Luis R. Rodriguez wrote:
> This is my v2 of the original linker table work [0], now with
> six proof of concepts ports of existing code using custom section
> with custom linker script modifications:
> 
>   * DEFINE_LINKTABLE_TEXT(char, kprobes);
>   * DEFINE_LINKTABLE_DATA(struct jump_entry, __jump_table);
>   * DEFINE_LINKTABLE_DATA(struct _ddebug, __verbose);
>   * DEFINE_LINKTABLE_RO(struct builtin_fw, builtin_fw);
>   * DEFINE_LINKTABLE_INIT(struct x86_init_fn, x86_init_fns);
>   * DEFINE_LINKTABLE_INIT_DATA(unsigned long, _kprobe_blacklist);
> 
> I've tested all except jump tables, I'd appreaciate some help with that.
> 

We should add support for read-mostly, probably.  In fact, some of these
probably *are* read-mostly.

	-hpa
