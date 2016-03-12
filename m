Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:54149 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220AbcCLEUS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 Mar 2016 23:20:18 -0500
Subject: Re: [PATCH] arc: use little endian accesses
References: <1457544064-16167-1-git-send-email-ltrimas@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075F4E8F1A0@us01wembx1.internal.synopsys.com>
 <1457636268.457.34.camel@synopsys.com> <201603102023.59425.arnd@arndb.de>
 <C2D7FE5348E1B147BCA15975FBA23075F4E8F790@us01wembx1.internal.synopsys.com>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <56E398F1.7090500@synopsys.com>
Date: Sat, 12 Mar 2016 09:50:01 +0530
MIME-Version: 1.0
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075F4E8F790@us01wembx1.internal.synopsys.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Lada Trimasova <Lada.Trimasova@synopsys.com>, "noamc@ezchip.com" <noamc@ezchip.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Message-ID: <20160312042001.vCaemdIQ61mphPZoCg8v8nCNm6IzprXEiAiovKByQ60@z>

On Friday 11 March 2016 06:14 PM, Vineet Gupta wrote:
> @Lada I will fix up the changelog to add some of the background behind this
> change, and mark this for stable backport as well.

This is what I'm planning to add.
Noam please give this a spin - you might have to revert those native-endian DT
bindings from UART DT.

----->
