From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH v2 00/24] C6X: New architecture patch set
Date: Thu, 25 Aug 2011 12:00:19 -0400
Message-ID: <1314288020.2344.30.camel@deneb.redhat.com>
References: <1314043785-2880-1-git-send-email-msalter@redhat.com>
	 <1314284011.27911.29.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:8078 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752262Ab1HYQAq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 25 Aug 2011 12:00:46 -0400
In-Reply-To: <1314284011.27911.29.camel@twins>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org

On Thu, 2011-08-25 at 16:53 +0200, Peter Zijlstra wrote:
> It would be ever so nice to also point us to a binutils/gcc
> source/patch
> so that we can actually compile this muck.

Sorry. I did so in the earlier patch series.

  http://www.codesourcery.com/sgpp/lite/c6000/portal/release1882

> 
> Also, wth is c6x?

This architecture supports members of the Texas Instruments family of
C6xxx single and multicore DSPs. The multicore parts have no cache
coherency among the cores so are not really suitable for SMP. The core
architecture is a VLIW instruction set optimized for DSP operations (64
general purpose registers, fast multiply, lots of bit manipulation
instructions, no divide instruction). No MMU for now, but may be in the
future. For details see:

  http://focus.ti.com/dsp/docs/dsphome.tsp?sectionId=46&DCMP=TIHomeTracking&HQS=Other+OT+home_p_dsp

--Mark
