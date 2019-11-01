Return-Path: <richard@nod.at>
Date: Fri, 1 Nov 2019 10:20:09 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
Message-ID: <1435962204.69872.1572600009245.JavaMail.zimbra@nod.at>
In-Reply-To: <1572597584-6390-13-git-send-email-rppt@kernel.org>
References: <1572597584-6390-1-git-send-email-rppt@kernel.org> <1572597584-6390-13-git-send-email-rppt@kernel.org>
Subject: Re: [PATCH v2 12/13] um: add support for folded p4d page tables
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, anton ivanov <anton.ivanov@cambridgegreys.com>, Arnd Bergmann <arnd@arndb.de>, davem <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Jeff Dike <jdike@addtoit.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, torvalds <torvalds@linux-foundation.org>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Michal Simek <monstr@monstr.eu>, Peter Rosin <peda@axentia.se>, Rolf Eike Beer <eike-kernel@sf-tec.de>, Russell King <linux@armlinux.org.uk>, Sam Creasey <sammy@sammy.net>, Vincent Chen <deanbo422@gmail.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, linux-alpha <linux-alpha@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-c6x-dev <linux-c6x-dev@linux-c6x.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-parisc <linux-parisc@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, sparclinux <sparclinux@vger.kernel.org>, Mike Rapoport <rppt@linux.ibm.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191101092009.y4i0kLXXE37QG3XxVzq0UvB3KMCbDnxPODFUXKpijOY@z>

----- Urspr=C3=BCngliche Mail -----
> Von: "Mike Rapoport" <rppt@kernel.org>

[...]

> #define pte_page(x) pfn_to_page(pte_pfn(x))
> diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
> index 417ff64..6fd17bc 100644
> --- a/arch/um/kernel/mem.c
> +++ b/arch/um/kernel/mem.c
> @@ -92,10 +92,26 @@ static void __init one_md_table_init(pud_t *pud)
> #endif
> }
>=20
> +static void __init one_pud_table_init(p4d_t *p4d)
> +{
> +#if CONFIG_PGTABLE_LEVELS > 3

Isn't this dead code?

For uml we have:
config PGTABLE_LEVELS
        int
        default 3 if 3_LEVEL_PGTABLES
        default 2

Thanks,
//richard
