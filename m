From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH trivial] include: asm-generic: Notice about 80 columns
 in pgtable-no*.h
Date: Tue, 15 Dec 2015 12:26:44 -0800
Message-ID: <1450211204.4142.30.camel@perches.com>
References: <56702088.9080605@emindsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56702088.9080605@emindsoft.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Gang <chengang@emindsoft.com.cn>, Arnd Bergmann <arnd@arndb.de>, trivial@kernel.org
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, 2015-12-15 at 22:15 +0800, Chen Gang wrote:
> It is a trivial patch.
[]
> diff --git a/include/asm-generic/pgtable-nopmd.h b/include/asm-generi=
c/pgtable-nopmd.h
[]
> @@ -38,7 +38,8 @@ static inline void pud_clear(pud_t *pud)	{ }
> =A0 * (pmds are folded into puds so this doesn't get actually called,
> =A0 * but the define is needed for a generic inline function.)
> =A0 */
> -#define set_pud(pudptr, pudval)			set_pmd((pmd_t *)(pudptr), (pmd_t)=
 { pudval })
> +#define set_pud(pudptr, pudval)			(set_pmd((pmd_t *)(pudptr), \
> +							(pmd_t) { pudval }))

Not quite so trivial.

If you _really_ want to break this up for 80 columns,
and I don't think it's necessary, it might be better
to use something like:

#define set_pud(pudptr, pudval)					\
	set_pmd((pmd_t *)(pudptr), (pmd_t) { pudval })
