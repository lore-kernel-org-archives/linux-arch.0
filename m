Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726705AbfHMP01 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Aug 2019 11:26:27 -0400
Date: Tue, 13 Aug 2019 17:26:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 03/10] module: add support for symbol namespaces.
Message-ID: <20190813152624.GB26138@kroah.com>
References: <20180716122125.175792-1-maco@android.com>
 <20190813121733.52480-1-maennich@google.com>
 <20190813121733.52480-4-maennich@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813121733.52480-4-maennich@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthias Maennich <maennich@google.com>
Cc: linux-kernel@vger.kernel.org, maco@android.com, kernel-team@android.com, arnd@arndb.de, geert@linux-m68k.org, hpa@zytor.com, jeyu@kernel.org, joel@joelfernandes.org, kstewart@linuxfoundation.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-modules@vger.kernel.org, linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org, lucas.de.marchi@gmail.com, maco@google.com, michal.lkml@markovi.net, mingo@redhat.com, oneukum@suse.com, pombredanne@nexb.com, sam@ravnborg.org, sboyd@codeaurora.org, sspatil@google.com, stern@rowland.harvard.edu, tglx@linutronix.de, usb-storage@lists.one-eyed-alien.net, x86@kernel.org, yamada.masahiro@socionext.com, Andrew Morton <akpm@linux-foundation.org>, Michael Ellerman <mpe@ellerman.id.au>, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Message-ID: <20190813152624.EGiXbVMvN-fM-tuDyKOGYXc-va5w3fdC19k0Eah6b6U@z>

On Tue, Aug 13, 2019 at 01:17:00PM +0100, Matthias Maennich wrote:
> The EXPORT_SYMBOL_NS() and EXPORT_SYMBOL_NS_GPL() macros can be used to
> export a symbol to a specific namespace.  There are no _GPL_FUTURE and
> _UNUSED variants because these are currently unused, and I'm not sure
> they are necessary.
> 
> I didn't add EXPORT_SYMBOL_NS() for ASM exports; this patch sets the
> namespace of ASM exports to NULL by default. In case of relative
> references, it will be relocatable to NULL. If there's a need, this
> should be pretty easy to add.
> 
> A module that wants to use a symbol exported to a namespace must add a
> MODULE_IMPORT_NS() statement to their module code; otherwise, modpost
> will complain when building the module, and the kernel module loader
> will emit an error and fail when loading the module.
> 
> MODULE_IMPORT_NS() adds a modinfo tag 'import_ns' to the module. That
> tag can be observed by the modinfo command, modpost and kernel/module.c
> at the time of loading the module.
> 
> The ELF symbols are renamed to include the namespace with an asm label;
> for example, symbol 'usb_stor_suspend' in namespace USB_STORAGE becomes
> 'usb_stor_suspend.USB_STORAGE'.  This allows modpost to do namespace
> checking, without having to go through all the effort of parsing ELF and
> relocation records just to get to the struct kernel_symbols.
> 
> On x86_64 I saw no difference in binary size (compression), but at
> runtime this will require a word of memory per export to hold the
> namespace. An alternative could be to store namespaced symbols in their
> own section and use a separate 'struct namespaced_kernel_symbol' for
> that section, at the cost of making the module loader more complex.
> 
> Co-developed-by: Martijn Coenen <maco@android.com>
> Signed-off-by: Martijn Coenen <maco@android.com>
> Signed-off-by: Matthias Maennich <maennich@google.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
