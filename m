From: David Rientjes <rientjes@google.com>
Subject: Re: [patch 07/14] m68k: invoke oom-killer from page fault
Date: Thu, 22 Apr 2010 13:53:27 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1004221353120.25350@chino.kir.corp.google.com>
References: <20100422160613.723698029@suse.de> <20100422161223.796194683@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:42436 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755516Ab0DVUxc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 22 Apr 2010 16:53:32 -0400
In-Reply-To: <20100422161223.796194683@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: npiggin@suse.de
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-m68k@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

On Fri, 23 Apr 2010, npiggin@suse.de wrote:

> As explained in commit 1c0fe6e3bd, we want to call the architecture independent
> oom killer when getting an unexplained OOM from handle_mm_fault, rather than
> simply killing current.
> 
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Nick Piggin <npiggin@suse.de>

Acked-by: David Rientjes <rientjes@google.com>
