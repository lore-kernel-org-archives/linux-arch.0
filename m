From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH 18/19] arm64:ilp32: add vdso-ilp32 and use for signal
 return
Date: Sat, 13 Aug 2016 17:54:03 +0300
Message-ID: <20160813145403.GB24335@yury-N73SV>
References: <1466207668-10549-1-git-send-email-ynorov@caviumnetworks.com>
 <1466207668-10549-19-git-send-email-ynorov@caviumnetworks.com>
 <mvminx3ud0m.fsf@hawking.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-sn1nam02on0088.outbound.protection.outlook.com ([104.47.36.88]:6784
	"EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752384AbcHMOyR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 13 Aug 2016 10:54:17 -0400
Content-Disposition: inline
In-Reply-To: <mvminx3ud0m.fsf@hawking.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andreas Schwab <schwab@suse.de>
Cc: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, libc-alpha@sourceware.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, manuel.montezelo@gmail.com, linyongting@huawei.com, maxim.kuvyrkov@linaro.org, davem@davemloft.net

On Mon, Jun 20, 2016 at 04:54:17PM +0200, Andreas Schwab wrote:
> Yury Norov <ynorov@caviumnetworks.com> writes:
> 
> > diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> > index 2a0de6f..e48ea34 100644
> > --- a/arch/arm64/kernel/vdso.c
> > +++ b/arch/arm64/kernel/vdso.c
> > @@ -40,6 +40,12 @@ extern char vdso_start, vdso_end;
> >  static unsigned long vdso_pages;
> >  static struct page **vdso_pagelist;
> >  
> > +#ifdef CONFIG_ARM64_ILP32
> > +extern char vdso_ilp32_start, vdso_ilp32_end;
> > +static unsigned long vdso_ilp32_pages;
> > +static struct page **vdso_ilp32_pagelist;
> > +#endif
> > +
> >  /*
> >   * The vDSO data page.
> >   */
> > @@ -110,24 +116,29 @@ int aarch32_setup_vectors_page(struct linux_binprm *bprm, int uses_interp)
> >  }
> >  #endif /* CONFIG_AARCH32_EL0 */
> >  
> > -static struct vm_special_mapping vdso_spec[2];
> > -
> > -static int __init vdso_init(void)
> > +static int __init vdso_init_common(char *vdso_start, char *vdso_end,
> 
> Using the same name for the parameter as for the global variable is
> dangerous ....
> 
> > +					  unsigned long *vdso_pagesp,
> > +					  struct page ***vdso_pagelistp,
> > +					  struct vm_special_mapping* vdso_spec)
> >  {
> >  	int i;
> > +	unsigned long vdso_pages;
> > +	struct page **vdso_pagelist;
> >  
> > -	if (memcmp(&vdso_start, "\177ELF", 4)) {
> > +	if (memcmp(vdso_start, "\177ELF", 4)) {
> 
> ... because forgetting to remove & can be fatal, and your compiler may
> not even warn you.
> 
> Andreas.

Fixed. See here: https://github.com/norov/linux/tree/ilp32-4.8
Thanks.

Yury.
