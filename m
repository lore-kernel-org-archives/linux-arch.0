From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC v2 2/7] tables.h: add linker table support
Date: Fri, 19 Feb 2016 12:33:27 -0800
Message-ID: <56C77C17.7030208@zytor.com>
References: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
 <1455889559-9428-3-git-send-email-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455889559-9428-3-git-send-email-mcgrof@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, rusty@rustcorp.com.au, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, ming.lei@canonical.com, gregkh@linuxfoundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, linux@arm.linux.org.uk, benh@kernel.crashing.org, jbaron@akamai.com, ananth@in.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, masami.hiramatsu.pt@hitachi.com, andriy.shevchenko@linux.intel.com, dwmw2@infradead.org, xen-devel@lists.xensource.com
List-Id: linux-arch.vger.kernel.org

On 02/19/2016 05:45 AM, Luis R. Rodriguez wrote:
> +/**
> + * LINKTABLE_RUN_ERR - run each linker table entry func and return error if any
> + *
> + * @tbl: linker table
> + * @func: structure name for the function name we want to call.
> + * @args...: arguments to pass to func
> + *
> + * Example usage:
> + *
> + *   unsigned int err = LINKTABLE_RUN_ERR(frobnicator_fns, some_run,);
> + */
> +#define LINKTABLE_RUN_ERR(tbl, func, args...)				\
> +({									\
> +	size_t i;							\
> +	int err = 0;							\
> +	for (i = 0; !err && i < LINKTABLE_SIZE(tbl); i++)		\
> +		err = (tbl[i]).func (args);				\
> +		err; \
> +})

This is wrong and pointless.  As written it returns the error code of
the last instance.

What I suggested for this macro was that we ought to exit the loop on error.

Furthermore:

1. Using an advancing pointer would make more sense than a counter.
2. .func doesn't make any sense -- it ought to be "func"; otherwise you
    can't call into either a table containing pure function pointers,
    nor into a field of table *pointed to* by the table; which is
    likely to be quite common.

    So the idea is to use something like:

    /* Array of function pointers */
    LINKTABLE_RUN_ALL(frobnicator_fns, , arg1, arg2);

    /* Array of structures */
    LINKTABLE_RUN_ALL(frobnicator_fns, .some_run, arg1, arg2);

    /* Array of structure pointers */
    LINKTABLE_RUN_ALL(frobnicator_fns, ->some_run, arg1, arg2);
