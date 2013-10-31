From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH] arch: *: remove '__init' for setup_profiling_timer()
Date: Thu, 31 Oct 2013 06:22:26 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA230751538BE@IN01WEMBXA.internal.synopsys.com>
References: <52672ECD.9010800@asianux.com>
 <C2D7FE5348E1B147BCA15975FBA23075153861@IN01WEMBXA.internal.synopsys.com>
 <5271F4A9.40804@asianux.com> <5271F54F.8070607@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtp2.synopsys.com ([198.182.44.80]:54686 "EHLO
	kiruna.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855Ab3JaGWg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 31 Oct 2013 02:22:36 -0400
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chen Gang <gang.chen@asianux.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Mike Frysinger <vapier@gentoo.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Paul Gortmaker <paul.gortmaker@windriver.com>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, realmz paranoid <realmz6@gmail.com>, James Bottomley <James.Bottomley@HansenPartnership.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, Parisc List <linux-parisc@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On 10/31/2013 11:45 AM, Chen Gang wrote:
> Hmm... if so, recommend to modify another architectures which also only
> return "-EINVAL", but without "__init" prefix.

Yes in first pass, it will only convert the arches which return EINVAL but can ask
the maintainers whether they want the alternate versions too.

So you want to take a stab at this series.

-Vineet
