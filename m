Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728724AbfHUOhG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Aug 2019 10:37:06 -0400
Date: Wed, 21 Aug 2019 16:36:55 +0200
From: Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v3 10/11] RFC: usb-storage: export symbols in USB_STORAGE
 namespace
Message-ID: <20190821143655.GA13637@linux-8ccs>
References: <20190813121733.52480-1-maennich@google.com>
 <20190821114955.12788-1-maennich@google.com>
 <20190821114955.12788-11-maennich@google.com>
 <20190821123827.GB4059@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190821123827.GB4059@kroah.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Matthias Maennich <maennich@google.com>, linux-kernel@vger.kernel.org, kernel-team@android.com, arnd@arndb.de, geert@linux-m68k.org, hpa@zytor.com, joel@joelfernandes.org, kstewart@linuxfoundation.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-modules@vger.kernel.org, linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org, lucas.de.marchi@gmail.com, maco@android.com, maco@google.com, michal.lkml@markovi.net, mingo@redhat.com, oneukum@suse.com, pombredanne@nexb.com, sam@ravnborg.org, sspatil@google.com, stern@rowland.harvard.edu, tglx@linutronix.de, usb-storage@lists.one-eyed-alien.net, x86@kernel.org, yamada.masahiro@socionext.com
Message-ID: <20190821143655.5UtGDbRqSXoeI2FNhC5YwwZJf6DcvnYyltDEfnFgZ4w@z>

+++ Greg KH [21/08/19 05:38 -0700]:
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
>>
>> Signed-off-by: Matthias Maennich <maennich@google.com>
>
>This looks good to me.  This can be included with the rest of this
>series when/if it goes through the kbuild or module tree:
>
>Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
>Actually, which tree will this be going through?

I would be happy to take the patchset through the modules tree once it
collects the appropriate ack/reviewed-by's and once I get a chance to
sit down and review/test it next week :)

Thanks!

Jessica
