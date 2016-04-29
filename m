From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [RFC v2 3/7] firmware: port built-in section to linker table
Date: Fri, 29 Apr 2016 12:24:36 -0700
Message-ID: <CAB=NE6WRr7XtRRLW=rdQx187-K9WgNMT+BAFyw3urd_Tgsz6fg@mail.gmail.com>
References: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
 <1455889559-9428-4-git-send-email-mcgrof@kernel.org> <1456740770.4666.366.camel@infradead.org>
 <1456848624.2369.9.camel@HansenPartnership.com> <20160301175453.GE25240@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46875 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751679AbcD2TZA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 29 Apr 2016 15:25:00 -0400
In-Reply-To: <20160301175453.GE25240@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>, Kees Cook <keescook@chromium.org>
Cc: David Woodhouse <dwmw2@infradead.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Rusty Russell <rusty@rustcorp.com.au>, David Vrabel <david.vrabel@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Michael Brown <mcb30@ipxe.org>, Juergen Gross <jgross@suse.com>, Ming Lei <ming.lei@canonical.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, jbaron@akamai.com, ananth@in.ibm.com, anil.s.keshavamurthy@int

On Tue, Mar 1, 2016 at 9:54 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> On Tue, Mar 01, 2016 at 08:10:24AM -0800, James Bottomley wrote:
>> On Mon, 2016-02-29 at 10:12 +0000, David Woodhouse wrote:
>> > On Fri, 2016-02-19 at 05:45 -0800, Luis R. Rodriguez wrote:
>> > > This ports built-in firmware to use linker tables,
>> > > this replaces the custom section solution with a
>> > > generic solution.
>> > >
>> > > This also demos the use of the .rodata (SECTION_RO)
>> > > linker tables.
>> > >
>> > > Tested with 0 built-in firmware, 1 and 2 built-in
>> > > firmwares successfully.
>> >
>> > I think we'd do better to rip this support out entirely. It just
>> > isn't needed; firmware can live in an initramfs and don't even need
>> > *any* actual running userspace support to load it from there these
>> > days, do we?
>>
>> We have lots of SCSI drivers with built in firmware.  The obvious
>> examples are 53c700, aic7xxx and aic79xx.  For them, we actually have
>> the firmware compilers in tree.  The firmware model they use just isn't
>> amenable to the firmware loader: they're not monolithic blobs, it's a
>> set of firmware scripts we use to handle particular operations before
>> giving control back to the host, so the firmware and the driver are
>> very much symbiotic.
>
> I'm in the process of doing some other cleanups with the firmware_class
> stuff so that odd requirements get supported but clean interfaces are
> also not hampered by these odd requirements, so I'll take a look at
> this later. If you have other oddball firmware requirements please
> let me know so I can also keep in mind.
>
>> On the other hand, I don't think any of them uses firmware sections, so
>> it's not an argument for not ripping out this type.
>
> Thanks for confirming. I'll rip this out.

Just a heads up, I've put the removal through 0-day without issues,
I'll be folding the removal into another series of changes for the
firmware API which should help compartmentalize the user mode helper
stuff as well.

 Luis
