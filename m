From: David Rientjes <rientjes@google.com>
Subject: Re: [patch 10/14] parisc: invoke oom-killer from page fault
Date: Thu, 22 Apr 2010 13:56:26 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1004221356150.25350@chino.kir.corp.google.com>
References: <20100422160613.723698029@suse.de> <20100422161224.322033236@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <20100422161224.322033236@suse.de>
Sender: linux-parisc-owner@vger.kernel.org
To: npiggin@suse.de
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-parisc@vger.kernel.org, Kyle McMartin <kyle@mcmartin.ca>
List-Id: linux-arch.vger.kernel.org

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
