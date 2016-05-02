From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC v2 3/7] firmware: port built-in section to linker table
Date: Mon, 2 May 2016 11:41:06 -0700
Message-ID: <20160502184106.GA17329@kroah.com>
References: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
 <1455889559-9428-4-git-send-email-mcgrof@kernel.org>
 <1456740770.4666.366.camel@infradead.org>
 <20160229185606.GD25240@wotan.suse.de>
 <CAGXu5jKkKvA5zWmr+U0TYKBBFgDL62xzQwWDOFGQMkmwKXMaMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:51521 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754969AbcEBSlH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 May 2016 14:41:07 -0400
Content-Disposition: inline
In-Reply-To: <CAGXu5jKkKvA5zWmr+U0TYKBBFgDL62xzQwWDOFGQMkmwKXMaMQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: "Luis R. Rodriguez" <mcgrof@suse.com>, David Woodhouse <dwmw2@infradead.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Rusty Russell <rusty@rustcorp.com.au>, David Vrabel <david.vrabel@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, mcb30@ipxe.org, jgross@suse.com, Ming Lei <ming.lei@canonical.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, jbaron@akamai.com, "ananth@in.ibm.com" <ananth@in.ibm.com>, anil.s.keshavamurthy@intel.com

On Mon, May 02, 2016 at 11:34:33AM -0700, Kees Cook wrote:
> On Mon, Feb 29, 2016 at 10:56 AM, Luis R. Rodriguez <mcgrof@suse.com> wrote:
> > On Mon, Feb 29, 2016 at 10:12:50AM +0000, David Woodhouse wrote:
> >> On Fri, 2016-02-19 at 05:45 -0800, Luis R. Rodriguez wrote:
> >> > This ports built-in firmware to use linker tables,
> >> > this replaces the custom section solution with a
> >> > generic solution.
> >> >
> >> > This also demos the use of the .rodata (SECTION_RO)
> >> > linker tables.
> >> >
> >> > Tested with 0 built-in firmware, 1 and 2 built-in
> >> > firmwares successfully.
> >>
> >> I think we'd do better to rip this support out entirely. It just isn't
> >> needed; firmware can live in an initramfs and don't even need *any*
> >> actual running userspace support to load it from there these days, do
> >> we?
> >
> > I think this is reasonable if and only if we really don't know of anyone
> > out there not able to use initramfs. I'm happy to rip it out.
> 
> The changelog for this doesn't say anything about _why_ the change is
> being made? (and what about other architectures.) Also, Chrome OS
> doesn't use an initramfs (and plenty of other things don't too). Being
> able to build monolithic kernels (e.g. Android and Brillo) with
> builtin firmware is very handy. Please don't remove built-in firmware
> support.

I second this, we can't break existing systems at all.  I thought we
were going to keep built-in firmware, right Luis?

thanks,

greg k-h
