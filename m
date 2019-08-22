Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38437 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731123AbfHVIcb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Aug 2019 04:32:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id g17so4556456wrr.5
        for <linux-arch@vger.kernel.org>; Thu, 22 Aug 2019 01:32:30 -0700 (PDT)
Date: Thu, 22 Aug 2019 09:32:23 +0100
From: Matthias Maennich <maennich@google.com>
Subject: Re: [PATCH v3 10/11] RFC: usb-storage: export symbols in USB_STORAGE
 namespace
Message-ID: <20190822083223.GA15709@google.com>
References: <20190813121733.52480-1-maennich@google.com>
 <20190821114955.12788-1-maennich@google.com>
 <20190821114955.12788-11-maennich@google.com>
 <20190821231329.GA369@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190821231329.GA369@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, arnd@arndb.de, geert@linux-m68k.org, gregkh@linuxfoundation.org, hpa@zytor.com, jeyu@kernel.org, joel@joelfernandes.org, kstewart@linuxfoundation.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-modules@vger.kernel.org, linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org, lucas.de.marchi@gmail.com, maco@android.com, maco@google.com, michal.lkml@markovi.net, mingo@redhat.com, oneukum@suse.com, pombredanne@nexb.com, sam@ravnborg.org, sspatil@google.com, stern@rowland.harvard.edu, tglx@linutronix.de, usb-storage@lists.one-eyed-alien.net, x86@kernel.org, yamada.masahiro@socionext.com
Message-ID: <20190822083223.R9szYbL0cvWsBo6tvOef5X4AtDGbei-jdCgMMisK5DY@z>

On Wed, Aug 21, 2019 at 04:13:29PM -0700, Christoph Hellwig wrote:
>On Wed, Aug 21, 2019 at 12:49:25PM +0100, Matthias Maennich wrote:
>> Modules using these symbols are required to explicitly import the
>> namespace. This patch was generated with the following steps and serves
>> as a reference to use the symbol namespace feature:
>>
>>  1) Define DEFAULT_SYMBOL_NAMESPACE in the corresponding Makefile
>>  2) make  (see warnings during modpost about missing imports)
>>  3) make nsdeps
>>
>> Instead of a DEFAULT_SYMBOL_NAMESPACE definition, the EXPORT_SYMBOL_NS
>> variants can be used to explicitly specify the namespace. The advantage
>> of the method used here is that newly added symbols are automatically
>> exported and existing ones are exported without touching their
>> respective EXPORT_SYMBOL macro expansion.
>
>So what is USB_STORAGE here?  It isn't a C string, so where does it
>come from?  To me using a C string would seem like the nicer interface
>vs a random cpp symbol that gets injected somewhere.

To be honest, I would also prefer an interface that uses C strings or
literals for the new EXPORT_SYMBOLS* macros:

  EXPORT_SYMBOL_NS(mysym, "USB_STORAGE");

  or

  const char USB_STORAGE_NS[] = "USB_STORAGE";
  EXPORT_SYMBOL_NS(mysym, USB_STORAGE_NS);

The DEFAULT_SYMBOL_NAMESPACE define within Makefiles would get a bit
more verbose in that case to express the literal:
  ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE="\"USB_STORAGE\""


The main reason against that, is, that in the expansion of
EXPORT_SYMBOL_NS, we define the ksymtab entry, which name is
constructed partly by the name of the namespace:

   static const struct kernel_symbol __ksymtab_##sym##__##ns  ...
                                                        ^^^^

For that we depend on a cpp symbol to construct the name. I am not sure
there is a reasonable way of getting rid of that without ending up
constructing the ksymtab entries completely in asm as it is already done
in case of PREL32_RELOCATIONS. But I am happy to be corrected.

For reference that is done in patch 03/11 of this series:
https://lore.kernel.org/lkml/20190821114955.12788-4-maennich@google.com/

Cheers,
Matthias
