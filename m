Return-Path: <arun.sharma@intel.com>
Received: from fmr03.intel.com ([143.183.121.5]:4012 "EHLO hermes.sc.intel.com")
	by vger.kernel.org with ESMTP id S263019AbUDLSzT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 12 Apr 2004 14:55:19 -0400
Message-ID: <407AE610.3010907@intel.com>
Date: Mon, 12 Apr 2004 11:55:12 -0700
From: Arun Sharma <arun.sharma@intel.com>
MIME-Version: 1.0
Subject: Re: [PATCH 3/4] Consolidate sys32_select
References: <200404040204.03594.arnd@arndb.de> <200404040222.41413.arnd@arndb.de> <407468A8.5060309@intel.com> <200404081022.38720.arnd@arndb.de>
In-Reply-To: <200404081022.38720.arnd@arndb.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On 4/8/2004 1:22 AM, Arnd Bergmann wrote:

> On Wednesday 07 April 2004 22:46, you wrote:
>  > While your patches improved compatibility with respect to LSB/LTP,
>  > we saw the following regressions on LTP on ia64:
>  >
>  > recv01      PASS->BROK
>  > recvmsg01    PASS->BROK
>  > recvfrom01    PASS->BROK
>  >
>  > While we're looking into it, did others see this ?
>  > Is it fixed already ?
> 
> Did you apply the patch I sent in the followup mail? It looks
> like you ran into the problem. Here it is again in case you
> missed it.

Yes, that fixed it. Thanks!

	-Arun
