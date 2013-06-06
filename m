Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:56239 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757475Ab3FFD5s (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jun 2013 23:57:48 -0400
Received: by mail-pb0-f53.google.com with SMTP id xb12so2639186pbc.12
        for <linux-arch@vger.kernel.org>; Wed, 05 Jun 2013 20:57:47 -0700 (PDT)
Date: Wed, 5 Jun 2013 20:57:44 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
Subject: Re: [patch 1/2] arch: invoke oom-killer from page fault
In-Reply-To: <1370488193-4747-1-git-send-email-hannes@cmpxchg.org>
Message-ID: <alpine.DEB.2.02.1306052053360.25115@chino.kir.corp.google.com>
References: <1370488193-4747-1-git-send-email-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.cz>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20130606035744.eAMw4QajkoxLb6iUpq0zv2SWiHecjZ_VfYm9vi3DNPw@z>

On Wed, 5 Jun 2013, Johannes Weiner wrote:

> Since '1c0fe6e mm: invoke oom-killer from page fault', page fault
> handlers should not directly kill faulting tasks in an out of memory
> condition.

I have no objection to the patch, but there's no explanation given here 
why exiting with a kill shouldn't be done.  Is it because of memory 
reserves and there is no guarantee that current will be able to exit?  Or 
is it just for consistency with other archs?

> Instead, they should be invoking the OOM killer to pick
> the right task.  Convert the remaining architectures.
> 

If this is a matter of memory reserves, I guess you could point people who 
want the current behavior (avoiding the expensiveness of the tasklist scan 
in the oom killer for example) to /proc/sys/vm/oom_kill_allocating_task?

This changelog is a bit cryptic in its motivation.
