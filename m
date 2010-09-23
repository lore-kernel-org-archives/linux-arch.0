From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] trivial: disable sparse' warning for "potentially
 expensive pointer subtraction".
Date: Thu, 23 Sep 2010 13:23:56 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1009231323340.26813@pobox.suse.cz>
References: <1282321333.25235.0.camel@thorin>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1282321333.25235.0.camel@thorin>
Sender: linux-kbuild-owner@vger.kernel.org
To: Bernd Petrovitsch <bernd@sysprog.at>
Cc: linux-kbuild@vger.kernel.org, Namhyung Kim <namhyung@gmail.com>, Andi Kleen <andi@firstfloor.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, MXns RullgXrd <mans@mansr.com>
List-Id: linux-arch.vger.kernel.org

On Fri, 20 Aug 2010, Bernd Petrovitsch wrote:

> Rationale: With a somewhat current gcc (or a somewhat sane peephole
> optimizer), the (expensive) "div" is converted to a "shift" or
> "mul" with the inverse.
> This warning is disabled per default in sparse but the "-Wall" in
> the kernels CFLAGS enables it.
> 
> Signed-off-by: Bernd Petrovitsch <bernd@sysprog.at>
> ---
> This patch is trivial and affects only calls to sparse (read: make C=1) and
> removes false warnings. So it should be considered for inclusion immediately.
> 
> Sorry for the long Cc: - I included everyone in the thread and added
> linux-kbuild@ (as it IMHO belongs there) and trivial@ (because of the
> complexity of the patch).
> 
>  Makefile |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index f3bdff8..851c0fa 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -330,7 +330,7 @@ PERL		= perl
>  CHECK		= sparse
>  
>  CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ \
> -		  -Wbitwise -Wno-return-void $(CF)
> +		  -Wbitwise -Wno-return-void -Wno-ptr-subtraction-blows $(CF)
>  CFLAGS_MODULE   =
>  AFLAGS_MODULE   =
>  LDFLAGS_MODULE  =

What is the status of this patch? I don't see it Nacked, but it's not in 
linux-next either.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
