From: Kees Cook <keescook@chromium.org>
Subject: Re: [RFC v2 3/7] firmware: port built-in section to linker table
Date: Mon, 2 May 2016 11:34:33 -0700
Message-ID: <CAGXu5jKkKvA5zWmr+U0TYKBBFgDL62xzQwWDOFGQMkmwKXMaMQ@mail.gmail.com>
References: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
	<1455889559-9428-4-git-send-email-mcgrof@kernel.org>
	<1456740770.4666.366.camel@infradead.org>
	<20160229185606.GD25240@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36744 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754761AbcEBSef (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 May 2016 14:34:35 -0400
Received: by mail-wm0-f50.google.com with SMTP id n129so118347440wmn.1
        for <linux-arch@vger.kernel.org>; Mon, 02 May 2016 11:34:35 -0700 (PDT)
In-Reply-To: <20160229185606.GD25240@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: David Woodhouse <dwmw2@infradead.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Rusty Russell <rusty@rustcorp.com.au>, David Vrabel <david.vrabel@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, mcb30@ipxe.org, jgross@suse.com, Ming Lei <ming.lei@canonical.com>, Greg KH <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, jbaron@akamai.com, "ananth@in.ibm.com" <ananth@in.ibm.com>, anil.s.keshavamurthy@intel.com

On Mon, Feb 29, 2016 at 10:56 AM, Luis R. Rodriguez <mcgrof@suse.com> wrote:
> On Mon, Feb 29, 2016 at 10:12:50AM +0000, David Woodhouse wrote:
>> On Fri, 2016-02-19 at 05:45 -0800, Luis R. Rodriguez wrote:
>> > This ports built-in firmware to use linker tables,
>> > this replaces the custom section solution with a
>> > generic solution.
>> >
>> > This also demos the use of the .rodata (SECTION_RO)
>> > linker tables.
>> >
>> > Tested with 0 built-in firmware, 1 and 2 built-in
>> > firmwares successfully.
>>
>> I think we'd do better to rip this support out entirely. It just isn't
>> needed; firmware can live in an initramfs and don't even need *any*
>> actual running userspace support to load it from there these days, do
>> we?
>
> I think this is reasonable if and only if we really don't know of anyone
> out there not able to use initramfs. I'm happy to rip it out.

The changelog for this doesn't say anything about _why_ the change is
being made? (and what about other architectures.) Also, Chrome OS
doesn't use an initramfs (and plenty of other things don't too). Being
able to build monolithic kernels (e.g. Android and Brillo) with
builtin firmware is very handy. Please don't remove built-in firmware
support.

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
