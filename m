From: Tony Luck <tony.luck@intel.com>
Subject: Re: ia64 broken by transparent huge pages - other arches too?
Date: Fri, 14 Jan 2011 10:50:26 -0800
Message-ID: <AANLkTinpg9pWWas8+UngC=sRruxM6KASDPZtE6MmV=xp@mail.gmail.com>
References: <4d308cf5394566ccc@agluck-desktop.sc.intel.com>
	<20110114183058.GN9506@random.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52872 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540Ab1ANSu2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 14 Jan 2011 13:50:28 -0500
In-Reply-To: <20110114183058.GN9506@random.random>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrea Arcangeli <aarcange@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org

On Fri, Jan 14, 2011 at 10:30 AM, Andrea Arcangeli <aarcange@redhat.com=
> wrote:
> Would you be willing to implement __pmd for ia64 to fix this? Can you
> check if this works?
>
> Thanks a lot,
> Andrea
>
> =3D=3D=3D=3D=3D=3D=3D=3D
> Subject: fix ia64 build failure in pmdp_get_and_clear
>
> From: Andrea Arcangeli <aarcange@redhat.com>
>
> Implement __pmd macro for ia64 too.
>
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> ---
>
> diff --git a/arch/ia64/include/asm/page.h b/arch/ia64/include/asm/pag=
e.h
> index 41b6d31..961a16f 100644
> --- a/arch/ia64/include/asm/page.h
> +++ b/arch/ia64/include/asm/page.h
> @@ -189,6 +189,7 @@ get_order (unsigned long size)
> =A0# define pgprot_val(x) ((x).pgprot)
>
> =A0# define __pte(x) =A0 =A0 =A0((pte_t) { (x) } )
> +# define __pmd(x) =A0 =A0 =A0((pmd_t) { (x) } )
> =A0# define __pgprot(x) =A0 ((pgprot_t) { (x) } )
>
> =A0#else /* !STRICT_MM_TYPECHECKS */

Yes that works. Thanks.  I'll apply to my ia64 tree and ask Linus to pu=
ll it.

-Tony
