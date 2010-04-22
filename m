From: David Rientjes <rientjes@google.com>
Subject: Re: [patch 14/14] xtensa: invoke oom-killer from page fault
Date: Thu, 22 Apr 2010 13:58:38 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1004221358270.25350@chino.kir.corp.google.com>
References: <20100422160613.723698029@suse.de> <20100422161224.955039653@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.35]:32459 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758750Ab0DVU6q (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 22 Apr 2010 16:58:46 -0400
Received: from wpaz21.hot.corp.google.com (wpaz21.hot.corp.google.com [172.24.198.85])
	by smtp-out.google.com with ESMTP id o3MKwhFX029630
	for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2010 22:58:44 +0200
Received: from pvh1 (pvh1.prod.google.com [10.241.210.193])
	by wpaz21.hot.corp.google.com with ESMTP id o3MKwgC1009033
	for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2010 13:58:42 -0700
Received: by pvh1 with SMTP id 1so788463pvh.19
        for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2010 13:58:42 -0700 (PDT)
In-Reply-To: <20100422161224.955039653@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: npiggin@suse.de
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Chris Zankel <chris@zankel.net>

On Fri, 23 Apr 2010, npiggin@suse.de wrote:

> As explained in commit 1c0fe6e3bd, we want to call the architecture independent
> oom killer when getting an unexplained OOM from handle_mm_fault, rather than
> simply killing current.
> 
> Cc: Chris Zankel <chris@zankel.net>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Nick Piggin <npiggin@suse.de>

Acked-by: David Rientjes <rientjes@google.com>
