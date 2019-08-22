From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [v3 08/11] scripts: Coccinelle script for namespace dependencies
Date: Thu, 22 Aug 2019 08:09:42 +0200
Message-ID: <81cc3995-ea95-8125-bbd2-2889cc623e23@web.de>
References: <20190821114955.12788-9-maennich@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190821114955.12788-9-maennich@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Maennich <maennich@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Julia Lawall <Julia.Lawall@lip6.fr>, Martijn Coenen <maco@android.com>, Himanshu Jha <himanshujha199640@gmail.com>, cocci@systeme.lip6.fr, kernel-janitors@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-modules@vger.kernel.org, linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org, kernel-team@android.com, usb-storage@lists.one-eyed-alien.net, x86@kernel.org, Alan Stern <stern@rowland.harvard.edu>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Gilles Muller <Gilles.Muller@lip6.fr>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jessica Yu <jeyu@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Kate Stewart <kstewart@linuxfoundation.org>, Lucas De Marchi <lucas.de.marchi@gmail.com>, Martijn
List-Id: linux-arch.vger.kernel.org

> +generate_deps_for_ns() {
> +	$SPATCH --very-quiet --in-place --sp-file \
> +		$srctree/scripts/coccinelle/misc/add_namespace.cocci -D ns=$1 $2
> +}

I would appreciate more constructive answers for specific software development concerns.
https://lore.kernel.org/lkml/1c4420f4-361c-7358-49d9-87d8a51f7920@web.de/
https://lkml.org/lkml/2019/8/15/515

Regards,
Markus
