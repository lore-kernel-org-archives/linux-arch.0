Return-Path: <arun.sharma@intel.com>
Received: from fmr04.intel.com ([143.183.121.6]:31649 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S264193AbUDGUql (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 7 Apr 2004 16:46:41 -0400
Message-ID: <407468A8.5060309@intel.com>
Date: Wed, 07 Apr 2004 13:46:32 -0700
From: Arun Sharma <arun.sharma@intel.com>
MIME-Version: 1.0
Subject: Re: [PATCH 3/4] Consolidate sys32_select
References: <200404040204.03594.arnd@arndb.de> <200404040222.41413.arnd@arndb.de>
In-Reply-To: <200404040222.41413.arnd@arndb.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On 4/3/2004 4:22 PM, Arnd Bergmann wrote:

> sys32_select has seven mostly but not exactly identical versions,
> so consolidate them as compat_sys_select. Based on the ppc64
> implementation, which most closely resembles sys_select.
> 
> Passes relevant LTP test cases on x86_64.
> 

While your patches improved compatibility with respect to LSB/LTP, we saw the following regressions on LTP on ia64:

recv01      PASS->BROK
recvmsg01    PASS->BROK
recvfrom01    PASS->BROK

While we're looking into it, did others see this ? Is it fixed already ?

	-Arun
