Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33175 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753527AbcFMTpd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 13 Jun 2016 15:45:33 -0400
Date: Mon, 13 Jun 2016 12:45:23 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH] locking/qspinlock: Use atomic_sub_return_release in
 queued_spin_unlock
Message-ID: <20160613194523.GA2094@linux-80c1.suse>
References: <1464943094-3129-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1464943094-3129-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, peterz@infradead.org, waiman.long@hp.com
Message-ID: <20160613194523.JsEa4WwoyZo_MgZAmPQglP4j5DkjIakGeStFH2BxuOM@z>

On Fri, 03 Jun 2016, Pan Xinhui wrote:

>The existing version uses a heavy barrier while only release semantics
>is required. So use atomic_sub_return_release instead.
>
>Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>

I just noticed this change in -tip and, while I know that saving a barrier
in core spinlock paths is perhaps a worthy exception, I cannot help but
wonder if this is the begging of the end for smp__{before,after}_atomic().
