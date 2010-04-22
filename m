From: David Rientjes <rientjes@google.com>
Subject: Re: [patch 04/14] frv: invoke oom-killer from page fault
Date: Thu, 22 Apr 2010 13:50:38 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1004221350270.25350@chino.kir.corp.google.com>
References: <20100422160613.723698029@suse.de> <20100422161223.295571760@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.35]:29692 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754958Ab0DVUuo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 22 Apr 2010 16:50:44 -0400
Received: from kpbe17.cbf.corp.google.com (kpbe17.cbf.corp.google.com [172.25.105.81])
	by smtp-out.google.com with ESMTP id o3MKog3Y012696
	for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2010 22:50:42 +0200
Received: from pvb32 (pvb32.prod.google.com [10.241.209.96])
	by kpbe17.cbf.corp.google.com with ESMTP id o3MKoZHK031144
	for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2010 13:50:41 -0700
Received: by pvb32 with SMTP id 32so5470175pvb.6
        for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2010 13:50:41 -0700 (PDT)
In-Reply-To: <20100422161223.295571760@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: npiggin@suse.de
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>

On Fri, 23 Apr 2010, npiggin@suse.de wrote:

> As explained in commit 1c0fe6e3bd, we want to call the architecture independent
> oom killer when getting an unexplained OOM from handle_mm_fault, rather than
> simply killing current.
> 
> Cc: David Howells <dhowells@redhat.com>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Nick Piggin <npiggin@suse.de>

Acked-by: David Rientjes <rientjes@google.com>
