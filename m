Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 28 Jan 2005 07:39:08 +0100
From: Andi Kleen <ak@suse.de>
Subject: Re: TASK_SIZE is variable.
Message-ID: <20050128063908.GA3195@wotan.suse.de>
References: <1106692012.6480.158.camel@localhost.localdomain> <20050125155239.4bc469e6.davem@davemloft.net> <20050126063627.GA7198@wotan.suse.de> <20050125224112.306cd1ea.davem@davemloft.net> <20050126071359.GD7198@wotan.suse.de> <20050126074306.GE7198@wotan.suse.de> <20050126000117.62fff2a7.akpm@osdl.org> <16889.43580.716149.901314@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16889.43580.716149.901314@cargo.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>, davem@davemloft.net, dwmw2@infradead.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, Jan 28, 2005 at 01:58:04PM +1100, Paul Mackerras wrote:
> Here is a patch that I did recently to reduce the overhead of
> clear_page_tables() when using 64k pages on ppc64.  It keeps a record
> of the maximum address that has been used in each mm_struct.  With
> this we can kill MM_VM_SIZE.
> 
> Andrew - could this go in -mm perhaps?

How does this work? The stack is always at the top of address space
and it will never change anything.

Or did you do this only to optimize 32bit processes on 64bit kernels?
If yes then the test in TASK_SIZE or MM_VM_SIZE should take care of it 
anyways.

-Andi
