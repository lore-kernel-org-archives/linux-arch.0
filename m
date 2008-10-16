From: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 1/4] fix scaled & unscaled cputime accounting
Date: Thu, 16 Oct 2008 15:31:30 +1100
Message-ID: <18678.50082.600136.677877@cargo.ozlabs.ibm.com>
References: <20081008161958.767142939@de.ibm.com>
	<20081008162144.167670472@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:38620 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751049AbYJPEbp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Oct 2008 00:31:45 -0400
In-Reply-To: <20081008162144.167670472@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-arch@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>, Jeremy Fitzhardinge <jeremy@xensource.com>, Chris Wright <chrisw@sous-sol.org>, Michael Neuling <mikey@neuling.org>

Martin Schwidefsky writes:

> The utimescaled / stimescaled fields in the task structure and the
> global cpustat should be set on all architectures. On s390 the calls
> to account_user_time_scaled and account_system_time_scaled never have
> been added. In addition system time that is accounted as guest time
> to the user time of a process is accounted to the scaled system time
> instead of the scaled user time. 
> To fix the bugs and to prevent future forgetfulness this patch merges
> account_system_time_scaled into account_system_time and
> account_user_time_scaled into account_user_time.
> 
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

Looks fine to me.

Acked-by: Paul Mackerras <paulus@samba.org>
