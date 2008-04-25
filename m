Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from brick.kernel.dk ([87.55.233.238]:17335 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758667AbYDYJQl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 25 Apr 2008 05:16:41 -0400
Date: Fri, 25 Apr 2008 11:16:36 +0200
From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH 10/11] sh: convert to generic helpers for IPI function calls
Message-ID: <20080425091635.GI12774@kernel.dk>
References: <1208890227-24808-1-git-send-email-jens.axboe@oracle.com> <1208890227-24808-11-git-send-email-jens.axboe@oracle.com> <20080425085637.GA30569@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080425085637.GA30569@linux-sh.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Mundt <lethal@linux-sh.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, npiggin@suse.de, torvalds@linux-foundation.org, peterz@infradead.org, sam@ravnborg.org
Message-ID: <20080425091636.UJ8I8nwnEMCfrr_283ai-FMpqBoCicSHo-fsU3SC62o@z>

On Fri, Apr 25 2008, Paul Mundt wrote:
> On Tue, Apr 22, 2008 at 08:50:26PM +0200, Jens Axboe wrote:
> > This converts sh to use the new helpers for smp_call_function() and
> > friends, and adds support for smp_call_function_single(). Not tested,
> > but it compiles.
> > 
> > Cc: Paul Mundt <lethal@linux-sh.org>
> > Signed-off-by: Jens Axboe <jens.axboe@oracle.com>
> 
> Acked-by: Paul Mundt <lethal@linux-sh.org>

Thanks Paul!

-- 
Jens Axboe

