Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org ([203.10.76.45]:45720 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264012AbUDVMl6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 Apr 2004 08:41:58 -0400
Date: Thu, 22 Apr 2004 22:37:03 +1000
From: Anton Blanchard <anton@samba.org>
Subject: Re: [Patch] SMP call function cleanup
Message-ID: <20040422123703.GY22027@krispykreme>
References: <1082636511.1332.34.camel@halo> <20040422122818.GR743@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040422122818.GR743@holomorphy.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Jan Glauber <glauber@gmx.de>, linux-arch@vger.kernel.org, schwidefsky@de.ibm.com
List-ID: <linux-arch.vger.kernel.org>


Hi,

> Any chance we could get an smp_call_function_cpumask()?

Unless there is a need Id prefer not to. Some arches do not support IPI
to a cpumask, whereas they should do send to all and send to single.

Anton
