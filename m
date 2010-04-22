From: David Rientjes <rientjes@google.com>
Subject: Re: [patch 08/14] microblaze: invoke oom-killer from page fault
Date: Thu, 22 Apr 2010 13:54:24 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1004221353360.25350@chino.kir.corp.google.com>
References: <20100422160613.723698029@suse.de> <20100422161223.984100935@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.35]:30986 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758659Ab0DVUyb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 22 Apr 2010 16:54:31 -0400
Received: from kpbe13.cbf.corp.google.com (kpbe13.cbf.corp.google.com [172.25.105.77])
	by smtp-out.google.com with ESMTP id o3MKsT4G021153
	for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2010 22:54:29 +0200
Received: from pvg6 (pvg6.prod.google.com [10.241.210.134])
	by kpbe13.cbf.corp.google.com with ESMTP id o3MKsRN6032285
	for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2010 15:54:27 -0500
Received: by pvg6 with SMTP id 6so1135372pvg.37
        for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2010 13:54:27 -0700 (PDT)
In-Reply-To: <20100422161223.984100935@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: npiggin@suse.de
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, microblaze-uclinux@itee.uq.edu.au, Michal Simek <monstr@monstr.eu>

On Fri, 23 Apr 2010, npiggin@suse.de wrote:

> As explained in commit 1c0fe6e3bd, we want to call the architecture independent
> oom killer when getting an unexplained OOM from handle_mm_fault, rather than
> simply killing current.
> 
> Cc: microblaze-uclinux@itee.uq.edu.au
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Nick Piggin <npiggin@suse.de>

Acked-by: David Rientjes <rientjes@google.com>
