From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [patch 10/14] parisc: invoke oom-killer from page fault
Date: Mon, 26 Apr 2010 11:00:43 -0400
Message-ID: <20100426150042.GR12768@bombadil.infradead.org>
References: <20100422160613.723698029@suse.de> <20100422161224.322033236@suse.de> <alpine.DEB.2.00.1004221356150.25350@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-parisc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1004221356150.25350@chino.kir.corp.google.com>
Sender: linux-parisc-owner@vger.kernel.org
To: David Rientjes <rientjes@google.com>
Cc: npiggin@suse.de, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-parisc@vger.kernel.org, Kyle McMartin <kyle@mcmartin.ca>
List-Id: linux-arch.vger.kernel.org

On Thu, Apr 22, 2010 at 01:56:26PM -0700, David Rientjes wrote:
> On Fri, 23 Apr 2010, npiggin@suse.de wrote:
> 
> > As explained in commit 1c0fe6e3bd, we want to call the architecture independent
> > oom killer when getting an unexplained OOM from handle_mm_fault, rather than
> > simply killing current.
> > 
> > Cc: linux-parisc@vger.kernel.org
> > Cc: Kyle McMartin <kyle@mcmartin.ca>
> > Cc: linux-arch@vger.kernel.org
> > Signed-off-by: Nick Piggin <npiggin@suse.de>
> 
> Acked-by: David Rientjes <rientjes@google.com>

Thanks, applied.
