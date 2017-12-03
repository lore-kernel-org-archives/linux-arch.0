From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] frv: fix build failure
Date: Sun, 3 Dec 2017 22:32:26 +0000
Message-ID: <20171203223226.GA3741@sudip-laptop>
References: <1511302233-5008-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1511457437.32422.6.camel@synopsys.com>
 <3a6fe86e-7a66-56df-3b1d-e2e8cd3e6eae@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f176.google.com ([209.85.128.176]:43777 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751885AbdLCWca (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 Dec 2017 17:32:30 -0500
Content-Disposition: inline
In-Reply-To: <3a6fe86e-7a66-56df-3b1d-e2e8cd3e6eae@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>

On Mon, Nov 27, 2017 at 10:25:16AM -0800, Vineet Gupta wrote:
> +CC linux-arch, Arnd
> 
> On 11/23/2017 09:17 AM, Alexey Brodkin wrote:
> >Hi Sudip,
> >
> >On Tue, 2017-11-21 at 22:10 +0000, Sudip Mukherjee wrote:

<snip>

> I understand the case/need for adding a weak/common abort() as a
> quick fix for handling such cases, but perhaps we should not and
> instead fix the rootcause. In this specific case, Claudiu mentioned
> that gcc was generating abort due to something like this (flagging a
> possible divide by zero due to
> -fno-isolate-erroneous-paths-dereference.
> 
> a;
> 
> fn1() {
>   switch (a)
>   case 0:
>   return 1 / a;
> }
> 
> Sudeep can you confirm that removing this hacking FRV build to not
> have this toggle fixes the abort issue.
> 
> So the offending code needs to be fixed as in the end when that code
> path is taken system is hosed.

The above case that you mentioned is indeed the case here.
mpihelp_divrem() in lib/mpi/mpih-div.c has this same divide by zero case.

So, what should be the actual fix here?
