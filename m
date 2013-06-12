Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:54061 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157Ab3FLUMN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 12 Jun 2013 16:12:13 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl14so3907366pab.20
        for <linux-arch@vger.kernel.org>; Wed, 12 Jun 2013 13:12:12 -0700 (PDT)
Date: Wed, 12 Jun 2013 13:12:09 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
Subject: Re: [patch 2/2] memcg: do not sleep on OOM waitqueue with full charge
 context
In-Reply-To: <20130612082817.GA6706@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.02.1306121309500.23348@chino.kir.corp.google.com>
References: <1370488193-4747-1-git-send-email-hannes@cmpxchg.org> <1370488193-4747-2-git-send-email-hannes@cmpxchg.org> <alpine.DEB.2.02.1306052058340.25115@chino.kir.corp.google.com> <20130606053315.GB9406@cmpxchg.org> <20130606173355.GB27226@cmpxchg.org>
 <alpine.DEB.2.02.1306061308320.9493@chino.kir.corp.google.com> <20130606215425.GM15721@cmpxchg.org> <alpine.DEB.2.02.1306061507330.15503@chino.kir.corp.google.com> <20130607000222.GT15576@cmpxchg.org> <alpine.DEB.2.02.1306111454030.4803@chino.kir.corp.google.com>
 <20130612082817.GA6706@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@suse.cz>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20130612201209.-MvTnYK0AxBRIpQZWfoU_SeCg_jM224gKSYmw9qCcMs@z>

On Wed, 12 Jun 2013, Michal Hocko wrote:

> > > > > > > Reported-by: Reported-by: azurIt <azurit@pobox.sk>
> > 
> > Ok, so the key here is that azurIt was able to reliably reproduce this 
> > issue and now it has been resurrected after seven months of silence since 
> > that thread.  I also notice that azurIt isn't cc'd on this thread.  Do we 
> > know if this is still a problem?
> 
> I have backported the patch for his 3.2 and waiting for his feedback.
> 

Ok, thanks.  I thought this was only going seven months back when it was 
reported, I missed that the issue this patch is trying to address goes 
back a 1 1/2 years to 3.2 and nobody else has reported it.  I think his 
feedback would be the key, specifically if he can upgrade to a later 
kernel first.
