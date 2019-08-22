Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f48.google.com ([209.85.221.48]:43543 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733155AbfHVJTF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Aug 2019 05:19:05 -0400
Received: by mail-wr1-f48.google.com with SMTP id y8so4668009wrn.10
        for <linux-arch@vger.kernel.org>; Thu, 22 Aug 2019 02:19:04 -0700 (PDT)
Date: Thu, 22 Aug 2019 10:18:58 +0100
From: Matthias Maennich <maennich@google.com>
Subject: Re: [v2 08/10] scripts: Coccinelle script for namespace dependencies
Message-ID: <20190822091858.GA60652@google.com>
References: <20190813121733.52480-9-maennich@google.com>
 <1c4420f4-361c-7358-49d9-87d8a51f7920@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c4420f4-361c-7358-49d9-87d8a51f7920@web.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Julia Lawall <Julia.Lawall@lip6.fr>, Martijn Coenen <maco@android.com>, cocci@systeme.lip6.fr, kernel-janitors@vger.kernel.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-modules@vger.kernel.org, linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org, kernel-team@android.com, usb-storage@lists.one-eyed-alien.net, x86@kernel.org, Alan Stern <stern@rowland.harvard.edu>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Gilles Muller <Gilles.Muller@lip6.fr>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jessica Yu <jeyu@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Kate Stewart <kstewart@linuxfoundation.org>, Lucas De Marchi <lucas.de.marchi@gmail.com>, Martijn Coenen <maco@google.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Michal Marek <michal.lkml@markovi.net>, Nicolas Ferre <nicolas.ferre@microchip.com>, Nicolas Palix <nicolas.palix@imag.fr>, Oliver Neukum <oneukum@suse.com>, Philippe Ombredanne <pombredanne@nexb.com>, Sam Ravnborg <sam@ravnborg.org>, Sandeep Patil <sspatil@google.com>, Stephen Boyd <sboyd@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Message-ID: <20190822091858.reFF7SEcaB06r_w4-ZBREZrIpG5bYxH-E0THJKseyYo@z>

On Thu, Aug 15, 2019 at 03:50:38PM +0200, Markus Elfring wrote:
>> +generate_deps_for_ns() {
>> +    $SPATCH --very-quiet --in-place --sp-file \
>> +	    $srctree/scripts/coccinelle/misc/add_namespace.cocci -D ns=$1 $2
>> +}
>
>* Where will the variable “srctree” be set for the file “scripts/nsdeps”?
>

$srctree is defined by kbuild in the toplevel Makefile.

>* Would you like to support a separate build directory for desired adjustments?
>

No, as the purpose of this script is to directly patch the kernel
sources where applicable.

>* How do you think about to check error handling around such commands?
>
>

spatch emits a descriptive message on error. I will add a 'set
-e' to the script so that it aborts on errors.

>> +generate_deps() {
>…
>> +        for source_file in $mod_source_files; do
>> +            sed '/MODULE_IMPORT_NS/Q' $source_file > ${source_file}.tmp
>…
>
>I suggest to assign the name for the temporary file to a variable
>which should be used by subsequent commands.

I somehow don't agree that this is an improvement to the code as the
variable would likely be something like ${source_file_tmp}. Sticking to
${source_file}.tmp does express the intent of a temporary file next to
the original source file and the reader of the code does not need to
reason about the value of ${source_file_tmp}.

Cheers,
Matthias
