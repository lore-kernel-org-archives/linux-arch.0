From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC v2 2/7] tables.h: add linker table support
Date: Fri, 19 Feb 2016 12:25:55 -0800
Message-ID: <56C77A53.6060708@zytor.com>
References: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
	<1455889559-9428-3-git-send-email-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <1455889559-9428-3-git-send-email-mcgrof@kernel.org>
List-Unsubscribe: <http://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <http://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Sender: xen-devel-bounces@lists.xen.org
Errors-To: xen-devel-bounces@lists.xen.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc: benh@kernel.crashing.org, ming.lei@canonical.com, masami.hiramatsu.pt@hitachi.com, linux-arch@vger.kernel.org, xen-devel@lists.xensource.com, linux@arm.linux.org.uk, x86@kernel.org, anil.s.keshavamurthy@intel.com, arnd@arndb.de, rusty@rustcorp.com.au, jbaron@akamai.com, boris.ostrovsky@oracle.com, andriy.shevchenko@linux.intel.com, mcb30@ipxe.org, jgross@suse.com, ananth@in.ibm.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, luto@amacapital.net, david.vrabel@citrix.com, dwmw2@infradead.org, davem@davemloft.net
List-Id: linux-arch.vger.kernel.org

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
