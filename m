From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC v2 3/7] firmware: port built-in section to linker table
Date: Tue, 3 May 2016 11:12:21 -0700
Message-ID: <20160503181221.GA7315@kroah.com>
References: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
 <1455889559-9428-4-git-send-email-mcgrof@kernel.org>
 <1456740770.4666.366.camel@infradead.org>
 <20160229185606.GD25240@wotan.suse.de>
 <CAGXu5jKkKvA5zWmr+U0TYKBBFgDL62xzQwWDOFGQMkmwKXMaMQ@mail.gmail.com>
 <CAB=NE6VC6m8N3Me4ek7jXkBi_fv6S_oYN8-sHLdPJPd2CUEZNQ@mail.gmail.com>
 <CAB=NE6WnA-VDPPX7YfkrRZC=vMtpbq41wn9pkSy7OHBdGhgwFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:56444 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964824AbcECSMX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 May 2016 14:12:23 -0400
Content-Disposition: inline
In-Reply-To: <CAB=NE6WnA-VDPPX7YfkrRZC=vMtpbq41wn9pkSy7OHBdGhgwFQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, David Woodhouse <dwmw2@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Rusty Russell <rusty@rustcorp.com.au>, David Vrabel <david.vrabel@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Michael Brown <mcb30@ipxe.org>, Juergen Gross <jgross@suse.com>, Ming Lei <ming.lei@canonical.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, jbaron@akamai.com, "ananth@in.ibm.com" <ananth@in.ibm.com>, anil.s.keshavamurthy@intel.com, David S. M

On Tue, May 03, 2016 at 10:10:24AM -0700, Luis R. Rodriguez wrote:
> On Tue, May 3, 2016 at 10:07 AM, Luis R. Rodriguez <mcgrof@suse.com> wrote:
> > Thanks! Can you confirm if any Android or Brillo builds are already using it?
> 
> Also more importantly, any chance you can provide any technical
> reasons why initramfs cannot be used, or it was decided to not use it
> on these systems? It should help others in the future as well.

Some systems just don't need it, nor want it.  We can't break working
systems, so this is not something we can remove, sorry.

thanks,

greg k-h
