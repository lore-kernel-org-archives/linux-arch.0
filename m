From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [RFC Patch v1 48/55] ARC: [plat-arfpga] BVCI Latency Unit setup
Date: Thu, 17 Jan 2013 10:38:12 +0530
Message-ID: <50F7873C.1030304@synopsys.com>
References: <1352720953-24321-1-git-send-email-vgupta@synopsys.com> <1352720953-24321-18-git-send-email-vgupta@synopsys.com> <201211121402.45019.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtp2.synopsys.com ([198.182.44.80]:47436 "EHLO
	kiruna.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753637Ab3AQFI0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 Jan 2013 00:08:26 -0500
In-Reply-To: <201211121402.45019.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 12 November 2012 07:32 PM, Arnd Bergmann wrote:
> On Monday 12 November 2012, Vineet.Gupta1@synopsys.com wrote:
>> +       /* TBD: rewrite this using I/O macros */
>> +       volatile unsigned int *base = (unsigned int *)BVCI_LAT_UNIT_BASE;
>> +       volatile unsigned int *lat_unit = (unsigned int *)base + 21;
>> +       volatile unsigned int *lat_val = (unsigned int *)base + 22;
> 
> Yes, you should do as the comment says.
> 
> 	Arnd
> 

Done.

Thx,
-Vineet
