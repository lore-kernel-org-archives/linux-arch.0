From: Matthias Maennich <maennich@google.com>
Subject: Re: [v2 08/10] scripts: Coccinelle script for namespace
	dependencies
Date: Wed, 14 Aug 2019 13:20:34 +0100
Message-ID: <20190814122034.GA117054@google.com>
References: <20190813121733.52480-9-maennich@google.com>
 <d3c852b2-0e41-1a7e-2f98-d8fd23cb8c1a@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <cocci-bounces@systeme.lip6.fr>
Content-Disposition: inline
In-Reply-To: <d3c852b2-0e41-1a7e-2f98-d8fd23cb8c1a@web.de>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, linux-m68k@vger.kernel.org, Oliver Neukum <oneukum@suse.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, usb-storage@lists.one-eyed-alien.net, kernel-janitors@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Joel Fernandes <joel@joelfernandes.org>, Sam Ravnborg <sam@ravnborg.org>, cocci@systeme.lip6.fr, linux-arch@vger.kernel.org, linux-scsi@vger.kernel.org, x86@kernel.org, Lucas De Marchi <lucas.de.marchi@gmail.com>, Ingo Molnar <mingo@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@android.com, Sandeep Patil <sspatil@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org, Philippe Ombredanne <pombredanne@nexb.com>, Nicolas Palix <nicolas.pa>
List-Id: linux-arch.vger.kernel.org

On Wed, Aug 14, 2019 at 02:00:23PM +0200, Markus Elfring wrote:
>+# This script requires at least spatch
>+# version 1.0.4.
>
>How do you think about to avoid the duplicate specification of this identification?
>

That is a good idea. I will reduce the patch to

+# This script requires a minimum spatch version.
+SPATCH_REQ_VERSION="1.0.4"

and use $SPATCH_REQ_VERSION when diagnosing this issue further down.

Cheers,
Matthias
