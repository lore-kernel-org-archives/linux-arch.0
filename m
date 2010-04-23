From: David Howells <dhowells@redhat.com>
Subject: Re: [patch 09/14] mn10300: invoke oom-killer from page fault
Date: Fri, 23 Apr 2010 17:46:59 +0100
Message-ID: <3369.1272041219@redhat.com>
References: <20100422161224.174904436@suse.de> <20100422160613.723698029@suse.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42689 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758450Ab0DWRQF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 23 Apr 2010 13:16:05 -0400
In-Reply-To: <20100422161224.174904436@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: npiggin@suse.de
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, linux-am33-list@redhat.com

npiggin@suse.de wrote:

> As explained in commit 1c0fe6e3bd, we want to call the architecture
> independent oom killer when getting an unexplained OOM from handle_mm_fault,
> rather than simply killing current.
> 
> Cc: linux-am33-list@redhat.com
> Cc: David Howells <dhowells@redhat.com>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Nick Piggin <npiggin@suse.de>

Acked-by: David Howells <dhowells@redhat.com>
