From: David Rientjes <rientjes@google.com>
Subject: Re: [patch 03/14] cris: invoke oom-killer from page fault
Date: Thu, 22 Apr 2010 13:50:08 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1004221349520.25350@chino.kir.corp.google.com>
References: <20100422160613.723698029@suse.de> <20100422161223.139236262@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:41083 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754906Ab0DVUuS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 22 Apr 2010 16:50:18 -0400
Received: from wpaz33.hot.corp.google.com (wpaz33.hot.corp.google.com [172.24.198.97])
	by smtp-out.google.com with ESMTP id o3MKoCWr010388
	for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2010 13:50:17 -0700
Received: from pvg2 (pvg2.prod.google.com [10.241.210.130])
	by wpaz33.hot.corp.google.com with ESMTP id o3MKo15j021562
	for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2010 13:50:11 -0700
Received: by pvg2 with SMTP id 2so366142pvg.4
        for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2010 13:50:11 -0700 (PDT)
In-Reply-To: <20100422161223.139236262@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: npiggin@suse.de
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-cris-kernel@axis.com, Mikael Starvik <starvik@axis.com>

On Fri, 23 Apr 2010, npiggin@suse.de wrote:

> As explained in commit 1c0fe6e3bd, we want to call the architecture independent
> oom killer when getting an unexplained OOM from handle_mm_fault, rather than
> simply killing current.
> 
> Cc: linux-cris-kernel@axis.com
> Cc: Mikael Starvik <starvik@axis.com>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Nick Piggin <npiggin@suse.de>

Acked-by: David Rientjes <rientjes@google.com>
