Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 26 Jan 2005 07:36:27 +0100
From: Andi Kleen <ak@suse.de>
Subject: Re: TASK_SIZE is variable.
Message-ID: <20050126063627.GA7198@wotan.suse.de>
References: <1106692012.6480.158.camel@localhost.localdomain> <20050125155239.4bc469e6.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050125155239.4bc469e6.davem@davemloft.net>
To: "David S. Miller" <davem@davemloft.net>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Jan 25, 2005 at 03:52:39PM -0800, David S. Miller wrote:
> On Tue, 25 Jan 2005 22:26:52 +0000
> David Woodhouse <dwmw2@infradead.org> wrote:
> 
> > Bad things can happen if a 32-bit process is the last user of a 64-bit
> > mm.
> 
> I guess this is OK.

I still don't get it. When exactly can a process have memory > 32bit 
and not have the 32bit flag set that is checked by TASK_SIZE. IMHO that's 
the bug that needs addressing, because it will likely break more code.

-Andi
