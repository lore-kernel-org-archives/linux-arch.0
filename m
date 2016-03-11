Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-db5eur01on0054.outbound.protection.outlook.com ([104.47.2.54]:15569
	"EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750727AbcCKFWL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 Mar 2016 00:22:11 -0500
From: Noam Camus <noamca@mellanox.com>
Subject: Re: [PATCH] arc: use little endian accesses
Date: Fri, 11 Mar 2016 05:07:09 +0000
Message-ID: <HE1PR05MB1625869B55C8FB5657477812AAB50@HE1PR05MB1625.eurprd05.prod.outlook.com>
References: <1457544064-16167-1-git-send-email-ltrimas@synopsys.com>
	 <C2D7FE5348E1B147BCA15975FBA23075F4E8EDF9@us01wembx1.internal.synopsys.com>
	 <1457595846.2868.10.camel@synopsys.com>
	 <C2D7FE5348E1B147BCA15975FBA23075F4E8F1A0@us01wembx1.internal.synopsys.com>,<1457636268.457.34.camel@synopsys.com>
In-Reply-To: <1457636268.457.34.camel@synopsys.com>
Content-Language: en-US
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>, Lada Trimasova <Lada.Trimasova@synopsys.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Message-ID: <20160311050709.Lq0mAOAVoV015SlXV-Wc5ZkGcz5AUSdDpuvtyWJCLXc@z>

> From: Lada Trimasova <Lada.Trimasova@synopsys.com>
> Sent: Thursday, March 10, 2016 8:57 PM

> And for example, let's see what happens when we use "readl" in  function "serial8250_early_in" in driver/tty/serial/8250.

Is your DTS entry includes for serial node following entries:
reg-io-width = <4>
native-endian;

if answer is yes you should expect (in case of big endian compilation) that:
port->iotype would be equal to UPIO_MEM32BE, hence no readl() use for this case.

This is how it works for me here, it sounds like your case is similar.

Regards,
Noam