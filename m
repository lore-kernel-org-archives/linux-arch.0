Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:39696 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752865AbXFZW4R (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 26 Jun 2007 18:56:17 -0400
Date: Tue, 26 Jun 2007 15:55:41 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 2/3] audit: rework execve audit
Message-Id: <20070626155541.9708eded.akpm@linux-foundation.org>
In-Reply-To: <20070613100834.897301179@chello.nl>
References: <20070613100334.635756997@chello.nl>
	<20070613100834.897301179@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Ollie Wild <aaw@google.com>, Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>, linux-audit@redhat.com
List-ID: <linux-arch.vger.kernel.org>

On Wed, 13 Jun 2007 12:03:36 +0200
Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> +#ifdef CONFIG_AUDITSYSCALL
> +	{
> +		.ctl_name	= CTL_UNNUMBERED,
> +		.procname	= "audit_argv_kb",
> +		.data		= &audit_argv_kb,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= &proc_dointvec,
> +	},
> +#endif

Please document /proc entries in Documentation/filesystems/proc.txt
