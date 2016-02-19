Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:59429 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422953AbcBSUal (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 19 Feb 2016 15:30:41 -0500
Subject: Re: [RFC v2 2/7] tables.h: add linker table support
References: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
 <1455889559-9428-3-git-send-email-mcgrof@kernel.org>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <56C77A53.6060708@zytor.com>
Date: Fri, 19 Feb 2016 12:25:55 -0800
MIME-Version: 1.0
In-Reply-To: <1455889559-9428-3-git-send-email-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, rusty@rustcorp.com.au, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, ming.lei@canonical.com, gregkh@linuxfoundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, linux@arm.linux.org.uk, benh@kernel.crashing.org, jbaron@akamai.com, ananth@in.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, masami.hiramatsu.pt@hitachi.com, andriy.shevchenko@linux.intel.com, dwmw2@infradead.org, xen-devel@lists.xensource.com
Message-ID: <20160219202555.izqLmZTpvcK0j__Fkv-_8WrH_r9z7bpsvBb9wL9M4JY@z>

On 02/19/2016 05:45 AM, Luis R. Rodriguez wrote:
> +
> +/**
> + * DOC: Regular linker linker table constructors
> + *
> + * Regular constructors are expected to be used for valid linker table entries.
> + * Valid uses of weak entries other than the beginning and is currently
> + * untested but should in theory work.
> + */
> +
> +/**
> + * LINKTABLE_TEXT - Declares a linker table entry for execution
> + *
> + * @name: linker table name
> + * @level: order level
> + *
> + * Declares a linker table to be used for execution.
> + */
> +#define LINKTABLE_TEXT(name, level)					\
> +	      __typeof__(name[0])					\
> +	      __attribute__((used,					\
> +			     __aligned__(LINKTABLE_ALIGNMENT(name)),	\
> +			     section(SECTION_TBL(SECTION_TEXT, name, level))))

I'm really confused by this.  Text should obviously be readonly, but I'm
not at all clear how this works here.

The issue with linktables for text is kind of confusing if nothing else;
Russel is right about that.  It doesn't prevent us from doing something
similar, but perhaps it ought to have a different name.

For one thing, priority level is meaningless for text, since it is not a
table that can be indexed into.

	-hpa

