From: David Rientjes <rientjes@google.com>
Subject: Re: [patch 01/14] alpha: invoke oom-killer from page fault
Date: Mon, 26 Apr 2010 13:32:49 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1004221346200.25350@chino.kir.corp.google.com>
References: <20100422160613.723698029@suse.de> <20100422161222.762354051@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <20100422161222.762354051@suse.de>
Sender: linux-alpha-owner@vger.kernel.org
To: npiggin@suse.de
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-alpha@vger.kernel.org, Richard Henderson <rth@twiddle.net>
List-Id: linux-arch.vger.kernel.org

On Fri, 23 Apr 2010, npiggin@suse.de wrote:

> As explained in commit 1c0fe6e3bd, we want to call the architecture independent
> oom killer when getting an unexplained OOM from handle_mm_fault, rather than
> simply killing current.
> 
> Cc: linux-alpha@vger.kernel.org
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Nick Piggin <npiggin@suse.de>

Acked-by: David Rientjes <rientjes@google.com>
