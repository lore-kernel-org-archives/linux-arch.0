From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [RFC v2 3/7] firmware: port built-in section to linker table
Date: Tue, 3 May 2016 10:11:33 -0700
Message-ID: <CAB=NE6Wug=K3pnUmB4Z3xZ-RTD8PwiwLZBkMCZb=fi=nBiboHA@mail.gmail.com>
References: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
 <1455889559-9428-4-git-send-email-mcgrof@kernel.org> <1456740770.4666.366.camel@infradead.org>
 <20160229185606.GD25240@wotan.suse.de> <CAGXu5jKkKvA5zWmr+U0TYKBBFgDL62xzQwWDOFGQMkmwKXMaMQ@mail.gmail.com>
 <CAB=NE6VC6m8N3Me4ek7jXkBi_fv6S_oYN8-sHLdPJPd2CUEZNQ@mail.gmail.com> <CAB=NE6WnA-VDPPX7YfkrRZC=vMtpbq41wn9pkSy7OHBdGhgwFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43663 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932593AbcECRL6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 3 May 2016 13:11:58 -0400
In-Reply-To: <CAB=NE6WnA-VDPPX7YfkrRZC=vMtpbq41wn9pkSy7OHBdGhgwFQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: David Woodhouse <dwmw2@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Rusty Russell <rusty@rustcorp.com.au>, David Vrabel <david.vrabel@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Michael Brown <mcb30@ipxe.org>, Juergen Gross <jgross@suse.com>, Ming Lei <ming.lei@canonical.com>, Greg KH <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, jbaron@akamai.com, "ananth@in.ibm.com" <ananth@in.ibm.com>, anil.s.keshavamurthy@intel.com, David S

On Tue, May 3, 2016 at 10:10 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> or it was decided

Sorry I meant to say: 'or _why_ it was decided to not use initramfs on
these systems?'

  Luis
