From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [patch 13/14] sh: invoke oom-killer from page fault
Date: Mon, 26 Apr 2010 15:46:16 +0900
Message-ID: <20100426064616.GD11770@linux-sh.org>
References: <20100422160613.723698029@suse.de> <20100422161224.768947406@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:59784 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586Ab0DZGqg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 26 Apr 2010 02:46:36 -0400
Content-Disposition: inline
In-Reply-To: <20100422161224.768947406@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: npiggin@suse.de
Cc: linux-arch@vger.kernel.org, David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, linux-sh@vger.kernel.org

On Fri, Apr 23, 2010 at 02:06:26AM +1000, npiggin@suse.de wrote:
> As explained in commit 1c0fe6e3bd, we want to call the architecture independent
> oom killer when getting an unexplained OOM from handle_mm_fault, rather than
> simply killing current.
> 
> Cc: linux-sh@vger.kernel.org
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Nick Piggin <npiggin@suse.de>

Applied with David's Acked-by, thanks.
