Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:60342 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbeGPQB4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Jul 2018 12:01:56 -0400
Date: Mon, 16 Jul 2018 17:33:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/6] Symbol namespaces
Message-ID: <20180716153356.GA8034@kroah.com>
References: <20180716122125.175792-1-maco@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716122125.175792-1-maco@android.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Martijn Coenen <maco@android.com>
Cc: linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oneukum@suse.com>, Arnd Bergmann <arnd@arndb.de>, Jessica Yu <jeyu@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, linux-scsi@vger.kernel.org, linux-arch@vger.kernel.org, maco@google.com, sspatil@google.com, malchev@google.com, joelaf@google.com
Message-ID: <20180716153356.hnjbKQpKMPN58pkk12F3rwE3L4XMOuNga8BjT3G01EE@z>

On Mon, Jul 16, 2018 at 02:21:19PM +0200, Martijn Coenen wrote:
> As of Linux 4.17, there are more than 30000 exported symbols
> in the kernel. There seems to be some consensus amongst
> kernel devs that the export surface is too large, and hard
> to reason about.
> 
> Generally, these symbols fall in one of these categories:
> 1) Symbols actually meant for drivers
> 2) Symbols that are only exported because functionality is
>    split over multiple modules, yet they really shouldn't
>    be used by modules outside of their own subsystem
> 3) Symbols really only meant for in-tree use
> 
> When module developers try to upstream their code, it
> regularly turns out that they are using exported symbols
> that they really shouldn't be using. This problem is even
> bigger for drivers that are currently out-of-tree, which
> may be using many symbols that they shouldn't be using,
> and that break when those symbols are removed or modified.
> 
> This patch allows subsystem maintainers to partition their
> exported symbols into separate namespaces, and module
> authors to import such namespaces only when needed.
> 
> This allows subsystem maintainers to more easily limit
> availability of these namespaced symbols to other parts of
> the kernel. It can also be used to partition the set of
> exported symbols for documentation purposes; for example,
> a set of symbols that is really only used for debugging
> could be in a "SUBSYSTEM_DEBUG" namespace.

To give people a bit more background here, this is something that both
Andi Kleen and I talked about over a decade ago.  Martijn based his work
on Andi's original patches and made them all work well, something that I
was unable to do :)

His addition of using the build system to automatically generate a patch
for a subsystem based on the symbol namespace changes is frickin
amazing.

Great work here, this is something that I have wanted for the kernel for
a long time.

greg k-h
