From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [PATCH 00/20] generic show_mem() v5
Date: Wed, 16 Jul 2008 14:51:40 -0700
Message-ID: <1216245100.8711.8.camel@nimitz>
References: <20080704160737.750988999@saeurebad.de>
	 <1216148794.25942.11.camel@nimitz>
	 <20080715132203.a9482685.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:36274 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755521AbYGPVvo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 16 Jul 2008 17:51:44 -0400
In-Reply-To: <20080715132203.a9482685.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: hannes@saeurebad.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, stable@kernel.org

On Tue, 2008-07-15 at 13:22 -0700, Andrew Morton wrote:
> 
> > The sections are 512MB, and you can see 6 valid ones
> > followed by two holes, and then two more valid ones.
> > 
> > Anyway, I believe this patch will fix the oops.
> 
> This looks like it might be suitable.  Can you please test it?

I compiled, tested, and booted on the machine that had this problem.  It
hasn't reappeared.

-- Dave
