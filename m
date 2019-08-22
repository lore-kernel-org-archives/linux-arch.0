From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [v2 08/10] scripts: Coccinelle script for namespace dependencies
Date: Thu, 22 Aug 2019 13:00:52 +0200
Message-ID: <796bc082-7708-172e-df1e-13447ef6b577@web.de>
References: <20190813121733.52480-9-maennich@google.com>
 <1c4420f4-361c-7358-49d9-87d8a51f7920@web.de>
 <20190822091858.GA60652@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190822091858.GA60652@google.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Maennich <maennich@google.com>, cocci@systeme.lip6.fr, kernel-janitors@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Julia Lawall <Julia.Lawall@lip6.fr>, Martijn Coenen <maco@android.com>, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-modules@vger.kernel.org, linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org, kernel-team@android.com, usb-storage@lists.one-eyed-alien.net, x86@kernel.org, Alan Stern <stern@rowland.harvard.edu>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Gilles Muller <Gilles.Muller@lip6.fr>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jessica Yu <jeyu@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, Jonathan Cameron <Jonathan.Cameron@hua>
List-Id: linux-arch.vger.kernel.org

> $srctree is defined by kbuild in the toplevel Makefile.

How is this variable passed to the file =E2=80=9Cscripts/nsdeps=E2=80=9D?


>> * Would you like to support a separate build directory for desired adju=
stments?
>
> No, as the purpose of this script is to directly patch the kernel
> sources where applicable.

Will there occasionally be a need to provide a generated patch
(without in-place file modification)?


>> I suggest to assign the name for the temporary file to a variable
>> which should be used by subsequent commands.
>
> I somehow don't agree that this is an improvement to the code as the
> variable would likely be something like ${source_file_tmp}.

Would you dare to choose a shorter variable name?


> ${source_file}.tmp does express the intent of a temporary file next to
> the original source file and the reader of the code does not need to
> reason about the value of ${source_file_tmp}.

I would find a code variant with less suffix repetition nicer.

Regards,
Markus
