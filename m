Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38154 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729855AbfHMPC3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Aug 2019 11:02:29 -0400
Received: by mail-wr1-f65.google.com with SMTP id g17so108056151wrr.5
        for <linux-arch@vger.kernel.org>; Tue, 13 Aug 2019 08:02:27 -0700 (PDT)
Date: Tue, 13 Aug 2019 16:02:21 +0100
From: Matthias Maennich <maennich@google.com>
Subject: Re: [PATCH v2 10/10] RFC: usb-storage: export symbols in USB_STORAGE
 namespace
Message-ID: <20190813150221.GA107461@google.com>
References: <20180716122125.175792-1-maco@android.com>
 <20190813121733.52480-1-maennich@google.com>
 <20190813121733.52480-11-maennich@google.com>
 <20190813124708.GC12475@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190813124708.GC12475@kroah.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, maco@android.com, kernel-team@android.com, arnd@arndb.de, geert@linux-m68k.org, hpa@zytor.com, jeyu@kernel.org, joel@joelfernandes.org, kstewart@linuxfoundation.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-modules@vger.kernel.org, linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org, lucas.de.marchi@gmail.com, maco@google.com, michal.lkml@markovi.net, mingo@redhat.com, oneukum@suse.com, pombredanne@nexb.com, sam@ravnborg.org, sboyd@codeaurora.org, sspatil@google.com, stern@rowland.harvard.edu, tglx@linutronix.de, usb-storage@lists.one-eyed-alien.net, x86@kernel.org, yamada.masahiro@socionext.com
Message-ID: <20190813150221.kPWOgulgdJ1wURNIHTLQMLRW2g8fJSy2u3t2ukGj4Zw@z>

On Tue, Aug 13, 2019 at 02:47:08PM +0200, Greg KH wrote:
>On Tue, Aug 13, 2019 at 01:17:07PM +0100, Matthias Maennich wrote:
>> Modules using these symbols are required to explicitly import the
>> namespace. This patch was generated with the following steps and serves
>> as a reference to use the symbol namespace feature:
>>
>>  1) Define DDEFAULT_SYMBOL_NAMESPACE in the corresponding Makefile
>>  2) make  (see warnings during modpost about missing imports)
>>  3) make nsdeps
>>
>> Instead of a DEFAULT_SYMBOL_NAMESPACE definition, the EXPORT_SYMBOL_NS
>> variants can be used to explicitly specify the namespace. The advantage
>> of the method used here is that newly added symbols are automatically
>> exported and existing ones are exported without touching their
>> respective EXPORT_SYMBOL macro expansion.
>
>Ok, I can't read text, this answers my previous question.
>
>But, as an example, shouldn't we also have some code here that uses the
>EXPORT_SYMBOL_NS() macro to ensure that it actually works?
>
I will create another patch for a different subsystem where the use of
the macros is more appropriate. Then we have both use cases covered.

Cheers,
Matthias
