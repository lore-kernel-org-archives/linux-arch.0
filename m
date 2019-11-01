Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728048AbfKAKOe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 1 Nov 2019 06:14:34 -0400
Date: Fri, 01 Nov 2019 11:14:28 +0100
In-Reply-To: <1435962204.69872.1572600009245.JavaMail.zimbra@nod.at>
References: <1572597584-6390-1-git-send-email-rppt@kernel.org> <1572597584-6390-13-git-send-email-rppt@kernel.org> <1435962204.69872.1572600009245.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 12/13] um: add support for folded p4d page tables
Message-ID: <20191101101432.7998A2086D@mail.kernel.org>
From: rppt@kernel.org
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, anton ivanov <anton.ivanov@cambridgegreys.com>, Arnd Bergmann <arnd@arndb.de>, davem <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Jeff Dike <jdike@addtoit.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, torvalds <torvalds@linux-foundation.org>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Michal Simek <monstr@monstr.eu>, Peter Rosin <peda@axentia.se>, Rolf Eike Beer <eike-kernel@sf-tec.de>, Russell King <linux@armlinux.org.uk>, Sam Creasey <sammy@sammy.net>, Vincent Chen <deanbo422@gmail.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, linux-alpha <linux-alpha@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-c6x-dev@vger.kernel.org
Message-ID: <20191101101428.GEjMdnMsO6UuVedaE0KzCYDuX53rDQRyjMRmAbvbURk@z>

<linux-c6x-dev@linux-c6x.org>,linux-kernel <linux-kernel@vger.kernel.org>,linux-m68k <linux-m68k@lists.linux-m68k.org>,linux-parisc <linux-parisc@vger.kernel.org>,linux-um <linux-um@lists.infradead.org>,sparclinux <sparclinux@vger.kernel.org>,Mike Rapoport <rppt@linux.ibm.com>
From: Mike Rapoport <rppt@kernel.org>
Message-ID: <E5D8BD4D-5286-427C-A347-D73AC26EC256@kernel.org>

On November 1, 2019 10:20:09 AM GMT+01:00, Richard Weinberger <richard@nod=
=2Eat> wrote:
>----- Urspr=C3=BCngliche Mail -----
>> Von: "Mike Rapoport" <rppt@kernel=2Eorg>
>
>[=2E=2E=2E]
>
>> #define pte_page(x) pfn_to_page(pte_pfn(x))
>> diff --git a/arch/um/kernel/mem=2Ec b/arch/um/kernel/mem=2Ec
>> index 417ff64=2E=2E6fd17bc 100644
>> --- a/arch/um/kernel/mem=2Ec
>> +++ b/arch/um/kernel/mem=2Ec
>> @@ -92,10 +92,26 @@ static void __init one_md_table_init(pud_t *pud)
>> #endif
>> }
>>=20
>> +static void __init one_pud_table_init(p4d_t *p4d)
>> +{
>> +#if CONFIG_PGTABLE_LEVELS > 3
>
>Isn't this dead code?
>
>For uml we have:
>config PGTABLE_LEVELS
>        int
>        default 3 if 3_LEVEL_PGTABLES
>        default 2

It's kinda a provision for 4 levels support in UML :)
I can drop this in the next respin, no problem=2E

>Thanks,
>//richard


--=20
Sincerely yours,
Mike
