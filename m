From: Kees Cook <keescook@chromium.org>
Subject: Re: [RFC v2 3/7] firmware: port built-in section to linker table
Date: Tue, 3 May 2016 10:21:37 -0700
Message-ID: <CAGXu5jL9i38=yahifwC1GWeo4E3y66-eojBe6AmXWj6UvmK2sg@mail.gmail.com>
References: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
	<1455889559-9428-4-git-send-email-mcgrof@kernel.org>
	<1456740770.4666.366.camel@infradead.org>
	<20160229185606.GD25240@wotan.suse.de>
	<CAGXu5jKkKvA5zWmr+U0TYKBBFgDL62xzQwWDOFGQMkmwKXMaMQ@mail.gmail.com>
	<CAB=NE6VC6m8N3Me4ek7jXkBi_fv6S_oYN8-sHLdPJPd2CUEZNQ@mail.gmail.com>
	<CAB=NE6WnA-VDPPX7YfkrRZC=vMtpbq41wn9pkSy7OHBdGhgwFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37419 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756177AbcECRVj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 May 2016 13:21:39 -0400
Received: by mail-wm0-f45.google.com with SMTP id a17so51696461wme.0
        for <linux-arch@vger.kernel.org>; Tue, 03 May 2016 10:21:38 -0700 (PDT)
In-Reply-To: <CAB=NE6WnA-VDPPX7YfkrRZC=vMtpbq41wn9pkSy7OHBdGhgwFQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Rusty Russell <rusty@rustcorp.com.au>, David Vrabel <david.vrabel@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Michael Brown <mcb30@ipxe.org>, Juergen Gross <jgross@suse.com>, Ming Lei <ming.lei@canonical.com>, Greg KH <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, jbaron@akamai.com, "ananth@in.ibm.com" <ananth@in.ibm.com>, anil.s.keshavamurthy@intel.com, David S

On Tue, May 3, 2016 at 10:10 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> On Tue, May 3, 2016 at 10:07 AM, Luis R. Rodriguez <mcgrof@suse.com> wrote:
>> Thanks! Can you confirm if any Android or Brillo builds are already using it?
>
> Also more importantly, any chance you can provide any technical
> reasons why initramfs cannot be used, or it was decided to not use it
> on these systems? It should help others in the future as well.

In Chrome OS, the kernels are built specifically for the hardware
they're going to be on, so an initramfs was seen as a needless
additional boot step. Since Chrome OS was heavily optimized for boot
speed, it was designed to not need the initramfs at all. This is
actually enforced by the read-only boot firmware, so there's no
trivial way to _start_ using an initramfs on (existing) Chrome OS
devices either.

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
