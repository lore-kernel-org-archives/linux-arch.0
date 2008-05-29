From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 0/2] Kill unused parameter to smp_call_function and friends
Date: Thu, 29 May 2008 11:09:40 +0100
Message-ID: <483E80E4.6030403@goop.org>
References: <1212051661-12733-1-git-send-email-jens.axboe@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gw.goop.org ([64.81.55.164]:56121 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750994AbYE2KKR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 29 May 2008 06:10:17 -0400
In-Reply-To: <1212051661-12733-1-git-send-email-jens.axboe@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, npiggin@suse.de, linux-arch@vger.kernel.org, mingo@elte.hu, paulmck@linux.vnet.ibm.com

Jens Axboe wrote:
> It bothers me how the smp call functions accept a 'nonatomic' or 'retry'
> parameter (depending on who you ask), but don't do anything with it.
> So kill that silly thing.
>
> Two patches here, one for smp_call_function*() and one for on_each_cpu().
> This patchset applies on top of the generic-ipi patchset just sent out.
>   

Yay!

Acked++-by: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>

    J
