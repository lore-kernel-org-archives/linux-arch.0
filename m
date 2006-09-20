Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:63959 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750858AbWITGS6
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 Sep 2006 02:18:58 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8K6IuDC007367
	for <linux-arch@vger.kernel.org>; Wed, 20 Sep 2006 02:18:56 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k8K6Itfo121792
	for <linux-arch@vger.kernel.org>; Wed, 20 Sep 2006 00:18:55 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k8K6IqiC023323
	for <linux-arch@vger.kernel.org>; Wed, 20 Sep 2006 00:18:55 -0600
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: Re: All arch maintainers: 'make headers_check' fails on most architectures.
Date: Wed, 20 Sep 2006 08:18:50 +0200
References: <1158079495.9189.125.camel@hades.cambridge.redhat.com> <1158680369.24527.443.camel@pmac.infradead.org> <20060919220338.GB7435@ccure.user-mode-linux.org>
In-Reply-To: <20060919220338.GB7435@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609200818.51572.arnd.bergmann@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
To: Jeff Dike <jdike@addtoit.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-arch@vger.kernel.org, spyro@f2s.com, starvik@axis.com, ysato@users.sourceforge.jp, takata@linux-m32r.org, geert@linux-m68k.org, lethal@linux-sh.org, davem@davemloft.net, wli@holomorphy.com, uclinux-v850@lsi.nec.co.jp, chris@zankel.net, rmk@arm.linux.org.uk, dhowells <dhowells@redhat.com>, ralf@linux-mips.org, kyle@parisc-linux.org
List-ID: <linux-arch.vger.kernel.org>

On Wednesday 20 September 2006 00:03, Jeff Dike wrote:
> 
> > Er, yes. I don't think it makes any sense to export headers specifically
> > for UM. I wonder why my shadow git tree has them...
> 
> Well, my question was, is it OK for make to explode when headers_check is
> done for UML, or should it do nothing silently?

headers_check should check whatever files are installed by headers_install.
I think the most sensible two choices there are:

1. install the headers for the actual underlying architecture (SUBARCH)
instead of the um headers.

2. if ARCH=um, don't provide headers_install or headers_check targets.

	Arnd <><
