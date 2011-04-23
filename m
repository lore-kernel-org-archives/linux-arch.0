From: Michael Schmitz <schmitzmic@googlemail.com>
Subject: Re: slub: fix panic with DISCONTIGMEM
Date: Sat, 23 Apr 2011 13:27:56 +1200
Message-ID: <BANLkTimw1LNmz7DA1zn=Re-gLJ8_i0znZw@mail.gmail.com>
References: <1303248576.11237.23.camel@mulgrave.site>
	<BANLkTinyvO78OnKZGW3jB_N6uao0tppnAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <BANLkTinyvO78OnKZGW3jB_N6uao0tppnAw@mail.gmail.com>
Sender: linux-m68k-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, linux-arch@vger.kernel.org, linux-mm@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>, Christoph Lameter <cl@linux.com>, Thorsten Glaser <tg@mirbsd.de>, Linux/m68k <linux-m68k@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

The problem was indeed never reported upstream but it does in fact
manifest as a null pointer dereference, and happens in a discontiguous
memory context on m68k. I'm uncertain as to whether I had tracked the
exact source of the null pointer, I need to check my notes on this.

Reverting the commit in question makes SLUB behave as though NUMA was
defined, so this all checks out.

Apologies for not escalating this beyond m68k, and thanks to Geert for
spotting the connection.

Cheers,

  Michael


On Wed, Apr 20, 2011 at 7:48 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Tue, Apr 19, 2011 at 23:29, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
>> Slub makes assumptions about page_to_nid() which are violated by
>> DISCONTIGMEM and !NUMA. =A0This violation results in a panic because
>> page_to_nid() can be non-zero for pages in the discontiguous ranges =
and
>> this leads to a null return by get_node(). =A0The assertion by the
>> maintainer is that DISCONTIGMEM should only be allowed when NUMA is =
also
>> defined. =A0However, at least six architectures: alpha, ia64, m32r, =
m68k,
>> mips, parisc violate this. =A0The panic is a regression against slab=
, so
>> just mark slub broken in the problem configuration to prevent users
>> reporting these panics.
>
> How does the problem manifest itself? We're having a problem on m68k,=
 which
> seems to go away when switching from SLUB to SLAB, or when reverting =
a commit
> in [2] (probably this was never reported upstream).
>
> References:
> [1] http://www.mail-archive.com/linux-m68k@vger.kernel.org/msg02812.h=
tml
> [2] http://www.spinics.net/lists/linux-m68k/msg03401.html
>
>> Cc: stable@kernel.org
>> Signed-off-by: James Bottomley <James.Bottomley@suse.de>
>>
>> ---
>>
>> diff --git a/init/Kconfig b/init/Kconfig
>> index 56240e7..a7ad8fb 100644
>> --- a/init/Kconfig
>> +++ b/init/Kconfig
>> @@ -1226,6 +1226,7 @@ config SLAB
>> =A0 =A0 =A0 =A0 =A0per cpu and per node queues.
>>
>> =A0config SLUB
>> + =A0 =A0 =A0 depends on BROKEN || NUMA || !DISCONTIGMEM
>> =A0 =A0 =A0 =A0bool "SLUB (Unqueued Allocator)"
>> =A0 =A0 =A0 =A0help
>> =A0 =A0 =A0 =A0 =A0 SLUB is a slab allocator that minimizes cache li=
ne usage
>
> Gr{oetje,eeting}s,
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linu=
x-m68k.org
>
> In personal conversations with technical people, I call myself a hack=
er. But
> when I'm talking to journalists I just say "programmer" or something =
like that.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0 =A0=A0 -- =
Linus Torvalds
>
