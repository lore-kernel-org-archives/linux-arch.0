Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sat, 29 Jan 2005 22:23:10 +1100
From: Anton Blanchard <anton@samba.org>
Subject: Re: TASK_SIZE is variable.
Message-ID: <20050129112310.GB8654@krispykreme.ozlabs.ibm.com>
References: <20050125155239.4bc469e6.davem@davemloft.net> <20050126063627.GA7198@wotan.suse.de> <20050125224112.306cd1ea.davem@davemloft.net> <20050126071359.GD7198@wotan.suse.de> <20050126074306.GE7198@wotan.suse.de> <20050126000117.62fff2a7.akpm@osdl.org> <16889.43580.716149.901314@cargo.ozlabs.ibm.com> <16889.44363.612523.453157@cargo.ozlabs.ibm.com> <20050127191738.13d65896.akpm@osdl.org> <20050128064048.GB3195@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050128064048.GB3195@wotan.suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>, davem@davemloft.net, dwmw2@infradead.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

 
> Frankly Anton's patch seems simpler and equivalent to me.

I like Pauls patch :) It speeds up teardown of processes since we only
walk as much of the pagetables as is mapped (instead of the entire
address space).

Anton
