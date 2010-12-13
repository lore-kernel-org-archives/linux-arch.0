From: Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCHv1 000/211] unicore32 architecture support
Date: Mon, 13 Dec 2010 10:51:20 +0100 (CET)
Message-ID: <alpine.LFD.2.00.1012131049350.2653@localhost6.localdomain6>
References: <01ca01cb9783$7818c3f0$684a4bd0$@mprc.pku.edu.cn>  <1291917037.3002.257.camel@mulgrave.site>  <028701cb9919$df3b7900$9db26b00$@mprc.pku.edu.cn> <1292078266.4722.2.camel@mulgrave.site> <004c01cb9a93$1e17b010$5a471030$@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:53774 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751568Ab0LMJve (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 13 Dec 2010 04:51:34 -0500
In-Reply-To: <004c01cb9a93$1e17b010$5a471030$@mprc.pku.edu.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>
Cc: 'James Bottomley' <James.Bottomley@HansenPartnership.com>, linux-arch@vger.kernel.org

On Mon, 13 Dec 2010, Guan Xuetao wrote:

> > > > > These patches add support for UniCore-32 ISA in linux kernel.
> > > > > UniCore ISA is defined and developed by Micro-Processor R&D Center of
> > > > > Peking University, and over the years, the CPUs and SoCs using UniCore ISA
> > > > > have been successfully applied in a variety of products in China.
> > > >
> > > > Could we at least have these 212 emails threaded at least below this
> > > > email ... for those of us who may be tempted to skip a full review with
> > > > a thread delete?
> > 
> > Please don't drop cc's ... someone else may be wondering the same thing
> > so keeping the archive preserves the searchable knowledge.
> Ok, I see.
> 
> > > What's meaning for '212 email threaded below this email'?
> > 
> > Your subject [PATCHv1 000/211] means there are 211 patches plus a
> > description in the set ... that means 212 emails.  If you thread them
> > all below the 000/211 email, it's far easier to handle.
> The rule in Documentations/SubmittingPatches:
>   Do not send more than 15 patches at once to the vger mailing lists!
> So, I suppose I could post 15 patches every two or three days.

As Arnd and myself said before, having less but larger patches which
group the files into topics is a far better solution than sending 200+
patches which touch single files.

Thanks,

	tglx
