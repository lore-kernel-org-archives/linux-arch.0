From: "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: Re: [RFC v2 3/7] firmware: port built-in section to linker table
Date: Mon, 29 Feb 2016 19:56:06 +0100
Message-ID: <20160229185606.GD25240@wotan.suse.de>
References: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
 <1455889559-9428-4-git-send-email-mcgrof@kernel.org>
 <1456740770.4666.366.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1456740770.4666.366.camel@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, rusty@rustcorp.com.au, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, ming.lei@canonical.com, gregkh@linuxfoundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, linux@arm.linux.org.uk, benh@kernel.crashing.org, jbaron@akamai.com, ananth@in.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, masami.hiramatsu.pt@hitachi.com, andriy.shevchenko@linux.intel.com, xen-devel@lists.xensource.com
List-Id: linux-arch.vger.kernel.org

On Mon, Feb 29, 2016 at 10:12:50AM +0000, David Woodhouse wrote:
> On Fri, 2016-02-19 at 05:45 -0800, Luis R. Rodriguez wrote:
> > This ports built-in firmware to use linker tables,
> > this replaces the custom section solution with a
> > generic solution.
> > 
> > This also demos the use of the .rodata (SECTION_RO)
> > linker tables.
> > 
> > Tested with 0 built-in firmware, 1 and 2 built-in
> > firmwares successfully.
> 
> I think we'd do better to rip this support out entirely. It just isn't
> needed; firmware can live in an initramfs and don't even need *any*
> actual running userspace support to load it from there these days, do
> we?

I think this is reasonable if and only if we really don't know of anyone
out there not able to use initramfs. I'm happy to rip it out.

  Luis
