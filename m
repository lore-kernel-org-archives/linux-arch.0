From: "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: Re: [RFC v2 3/7] firmware: port built-in section to linker table
Date: Tue, 3 May 2016 10:07:34 -0700
Message-ID: <CAB=NE6VC6m8N3Me4ek7jXkBi_fv6S_oYN8-sHLdPJPd2CUEZNQ@mail.gmail.com>
References: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
 <1455889559-9428-4-git-send-email-mcgrof@kernel.org> <1456740770.4666.366.camel@infradead.org>
 <20160229185606.GD25240@wotan.suse.de> <CAGXu5jKkKvA5zWmr+U0TYKBBFgDL62xzQwWDOFGQMkmwKXMaMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34357 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932270AbcECRHz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 May 2016 13:07:55 -0400
In-Reply-To: <CAGXu5jKkKvA5zWmr+U0TYKBBFgDL62xzQwWDOFGQMkmwKXMaMQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: David Woodhouse <dwmw2@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Rusty Russell <rusty@rustcorp.com.au>, David Vrabel <david.vrabel@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Michael Brown <mcb30@ipxe.org>, Juergen Gross <jgross@suse.com>, Ming Lei <ming.lei@canonical.com>, Greg KH <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, jbaron@akamai.com, "ananth@in.ibm.com" <ananth@in.ibm.com>, anil.s.keshavamurthy@intel.com, David S

On Mon, May 2, 2016 at 11:34 AM, Kees Cook <keescook@chromium.org> wrote:
> On Mon, Feb 29, 2016 at 10:56 AM, Luis R. Rodriguez <mcgrof@suse.com> wrote:
>> On Mon, Feb 29, 2016 at 10:12:50AM +0000, David Woodhouse wrote:
>>> On Fri, 2016-02-19 at 05:45 -0800, Luis R. Rodriguez wrote:
>>> > This ports built-in firmware to use linker tables,
>>> > this replaces the custom section solution with a
>>> > generic solution.
>>> >
>>> > This also demos the use of the .rodata (SECTION_RO)
>>> > linker tables.
>>> >
>>> > Tested with 0 built-in firmware, 1 and 2 built-in
>>> > firmwares successfully.
>>>
>>> I think we'd do better to rip this support out entirely. It just isn't
>>> needed; firmware can live in an initramfs and don't even need *any*
>>> actual running userspace support to load it from there these days, do
>>> we?
>>
>> I think this is reasonable if and only if we really don't know of anyone
>> out there not able to use initramfs. I'm happy to rip it out.
>
> The changelog for this doesn't say anything about _why_ the change is
> being made? (and what about other architectures.)

To be clear the RFC patch here is about linker table use and porting
custom table uses for a generic linker table solution. The topic of
conversation later changed to suggest that instead of porting built-in
firmware to linker tables we should just consider removing built-in
firmware all together. As for the reason _why_ we'd port built-in
firmware to linker tables, I'll be sure to add that in the next
iteration. The reason is that Linux has scattered strategies to both
extend and use custom linker sections, often requiring modifying the
custom linker script. The effort behind the linker script provides a
unified mechanism to do this, and also enables us to avoid having to
extend the custom linker script for this type of use.

> Also, Chrome OS
> doesn't use an initramfs (and plenty of other things don't too). Being
> able to build monolithic kernels (e.g. Android and Brillo) with
> builtin firmware is very handy. Please don't remove built-in firmware
> support.

Thanks! Can you confirm if any Android or Brillo builds are already using it?

  Luis
