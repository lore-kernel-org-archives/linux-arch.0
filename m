Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 21 Jun 2005 17:58:10 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: sparsemem patches in -mm
Message-ID: <20050621155809.GB14251@wotan.suse.de>
References: <20050621021352.46fc3b81.akpm@osdl.org> <20050621095039.GC4171@wotan.suse.de> <42B836F7.7060106@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B836F7.7060106@shadowen.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>, Matt Tolentino <matthew.e.tolentino@intel.com>, Bob Picco <bob.picco@hp.com>
List-ID: <linux-arch.vger.kernel.org>

> I've not been able to get much or a realistic test on amd64 box, I seem
> to be struggling with combinations of scsi problems on the machine from
> other changes in -mm.   The good news is that it gets far enough to
> break with scsi problems and problems in sparsemem generally lead to
> death much earlier than this.

That was probably the memory map trips on some machines issue
That should be fixed now.

-Andi
