Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 28 Jan 2005 07:40:48 +0100
From: Andi Kleen <ak@suse.de>
Subject: Re: TASK_SIZE is variable.
Message-ID: <20050128064048.GB3195@wotan.suse.de>
References: <1106692012.6480.158.camel@localhost.localdomain> <20050125155239.4bc469e6.davem@davemloft.net> <20050126063627.GA7198@wotan.suse.de> <20050125224112.306cd1ea.davem@davemloft.net> <20050126071359.GD7198@wotan.suse.de> <20050126074306.GE7198@wotan.suse.de> <20050126000117.62fff2a7.akpm@osdl.org> <16889.43580.716149.901314@cargo.ozlabs.ibm.com> <16889.44363.612523.453157@cargo.ozlabs.ibm.com> <20050127191738.13d65896.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127191738.13d65896.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, ak@suse.de, davem@davemloft.net, dwmw2@infradead.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Jan 27, 2005 at 07:17:38PM -0800, Andrew Morton wrote:
> Paul Mackerras <paulus@samba.org> wrote:
> >
> > > Here is a patch that I did recently to reduce the overhead of
> >  > clear_page_tables() when using 64k pages on ppc64.  It keeps a record
> >  > of the maximum address that has been used in each mm_struct.  With
> >  > this we can kill MM_VM_SIZE.
> > 
> >  And I sent the 2.6.10 version of the patch, unfortunately.  Here is a
> >  patch against current BK.
> 
> OK..  I'll drop Anton's patch:

Frankly Anton's patch seems simpler and equivalent to me.

-Andi
