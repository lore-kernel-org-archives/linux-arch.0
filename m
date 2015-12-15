Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay0022.hostedemail.com ([216.40.44.22]:50645 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932286AbbLOUfB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 15 Dec 2015 15:35:01 -0500
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
	by smtpgrave05.hostedemail.com (Postfix) with ESMTP id 90862183DF0
	for <linux-arch@vger.kernel.org>; Tue, 15 Dec 2015 20:26:48 +0000 (UTC)
Message-ID: <1450211204.4142.30.camel@perches.com>
Subject: Re: [PATCH trivial] include: asm-generic: Notice about 80 columns
 in pgtable-no*.h
From: Joe Perches <joe@perches.com>
Date: Tue, 15 Dec 2015 12:26:44 -0800
In-Reply-To: <56702088.9080605@emindsoft.com.cn>
References: <56702088.9080605@emindsoft.com.cn>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chen Gang <chengang@emindsoft.com.cn>, Arnd Bergmann <arnd@arndb.de>, trivial@kernel.org
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <20151215202644.VBiwLyHvFKBgwnLRaZZZQHxgmQNwrRbSTVxwPAzNPDU@z>

On Tue, 2015-12-15 at 22:15 +0800, Chen Gang wrote:
> It is a trivial patch.
[]
> diff --git a/include/asm-generic/pgtable-nopmd.h b/include/asm-generic/pgtable-nopmd.h
[]
> @@ -38,7 +38,8 @@ static inline void pud_clear(pud_t *pud)	{ }
>   * (pmds are folded into puds so this doesn't get actually called,
>   * but the define is needed for a generic inline function.)
>   */
> -#define set_pud(pudptr, pudval)			set_pmd((pmd_t *)(pudptr), (pmd_t) { pudval })
> +#define set_pud(pudptr, pudval)			(set_pmd((pmd_t *)(pudptr), \
> +							(pmd_t) { pudval }))

Not quite so trivial.

If you _really_ want to break this up for 80 columns,
and I don't think it's necessary, it might be better
to use something like:

#define set_pud(pudptr, pudval)					\
	set_pmd((pmd_t *)(pudptr), (pmd_t) { pudval })

