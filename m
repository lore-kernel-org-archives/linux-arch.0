Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sun, 14 Aug 2005 08:48:48 -0700
From: Richard Henderson <rth@twiddle.net>
Subject: Re: [PATCH 1/2] consolidate sys_ptrace
Message-ID: <20050814154848.GA4927@twiddle.net>
References: <20050814093543.GA28557@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050814093543.GA28557@lst.de>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, Aug 14, 2005 at 11:35:43AM +0200, Christoph Hellwig wrote:
> This version has the arch_ptrace return value changes to long as
> recommended by Richard Henderson.
...
> +extern int arch_ptrace(struct task_struct *child, long request, long addr, long data);

No it doesn't.


r~
