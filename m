Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:58553 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732426AbfHONwL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Aug 2019 09:52:11 -0400
References: <20190813121733.52480-9-maennich@google.com>
Subject: Re: [v2 08/10] scripts: Coccinelle script for namespace dependencies
From: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <1c4420f4-361c-7358-49d9-87d8a51f7920@web.de>
Date: Thu, 15 Aug 2019 15:50:38 +0200
MIME-Version: 1.0
In-Reply-To: <20190813121733.52480-9-maennich@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthias Maennich <maennich@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Julia Lawall <Julia.Lawall@lip6.fr>, Martijn Coenen <maco@android.com>, cocci@systeme.lip6.fr, kernel-janitors@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-modules@vger.kernel.org, linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org, kernel-team@android.com, usb-storage@lists.one-eyed-alien.net, x86@kernel.org, Alan Stern <stern@rowland.harvard.edu>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Gilles Muller <Gilles.Muller@lip6.fr>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jessica Yu <jeyu@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Kate Stewart <kstewart@linuxfoundation.org>, Lucas De Marchi <lucas.de.marchi@gmail.com>, Martijn Coenen <maco@google.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Michal Marek <michal.lkml@markovi.net>, Nicolas Ferre <nicolas.ferre@microchip.com>, Nicolas Palix <nicolas.palix@imag.fr>, Oliver Neukum <oneukum@suse.com>, Philippe Ombredanne <pombredanne@nexb.com>, Sam Ravnborg <sam@ravnborg.org>, Sandeep Patil <sspatil@google.com>, Stephen Boyd <sboyd@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Message-ID: <20190815135038.PL-HdQAfTh1tPqY0XpmgkD_CXMomMzeVdqpnk4LLHls@z>

> +generate_deps_for_ns() {
> +    $SPATCH --very-quiet --in-place --sp-file \
> +	    $srctree/scripts/coccinelle/misc/add_namespace.cocci -D ns=3D$1 $2
> +}

* Where will the variable =E2=80=9Csrctree=E2=80=9D be set for the file =
=E2=80=9Cscripts/nsdeps=E2=80=9D?

* Would you like to support a separate build directory for desired adjustm=
ents?

* How do you think about to check error handling around such commands?


> +generate_deps() {
=E2=80=A6
> +        for source_file in $mod_source_files; do
> +            sed '/MODULE_IMPORT_NS/Q' $source_file > ${source_file}.tmp
=E2=80=A6

I suggest to assign the name for the temporary file to a variable
which should be used by subsequent commands.

Regards,
Markus
