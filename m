Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.35]:31646 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758750Ab0DVU4d (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 22 Apr 2010 16:56:33 -0400
Date: Thu, 22 Apr 2010 13:56:26 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
Subject: Re: [patch 10/14] parisc: invoke oom-killer from page fault
In-Reply-To: <20100422161224.322033236@suse.de>
Message-ID: <alpine.DEB.2.00.1004221356150.25350@chino.kir.corp.google.com>
References: <20100422160613.723698029@suse.de> <20100422161224.322033236@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: npiggin@suse.de
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-parisc@vger.kernel.org, Kyle McMartin <kyle@mcmartin.ca>
Message-ID: <20100422205626.rrVV9LYNLchgn1izYgvmT2tiWm48G0qMUxcArMm_OXY@z>

On Fri, 23 Apr 2010, npiggin@suse.de wrote:

> As explained in commit 1c0fe6e3bd, we want to call the architecture independent
> oom killer when getting an unexplained OOM from handle_mm_fault, rather than
> simply killing current.
> 
> Cc: linux-parisc@vger.kernel.org
> Cc: Kyle McMartin <kyle@mcmartin.ca>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Nick Piggin <npiggin@suse.de>

Acked-by: David Rientjes <rientjes@google.com>
