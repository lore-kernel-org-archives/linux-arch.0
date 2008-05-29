From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 2/10] x86: convert to generic helpers for IPI function
  calls
Date: Thu, 29 May 2008 14:47:09 +0100
Message-ID: <483EB3DD.2090908@goop.org>
References: <1212051504-12561-1-git-send-email-jens.axboe@oracle.com> <1212051504-12561-3-git-send-email-jens.axboe@oracle.com> <483E9D9B.9030202@goop.org> <20080529121704.GD25504@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gw.goop.org ([64.81.55.164]:41550 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755631AbYE2Nrp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 29 May 2008 09:47:45 -0400
In-Reply-To: <20080529121704.GD25504@kernel.dk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, npiggin@suse.de, linux-arch@vger.kernel.org, mingo@elte.hu, paulmck@linux.vnet.ibm.com

Jens Axboe wrote:
> If you don't mind, I'd like to keep it as-is. Then the patch should
> not have a functional change (there, at least), which I think is
> important. I can add a later patch removing this stolen bit, it would
> be even better if you send me such a patch :-)
>   

Sure. BTW, I got it to mush on top of x86.git, and it seems OK.  There 
were lots of fairly trivial conflicts with things moving between unified 
files, and a few missing smp_call_function and on_each_cpu calls.

    J
