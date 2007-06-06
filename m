Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55162 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750790AbXFFIh0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 6 Jun 2007 04:37:26 -0400
Date: Wed, 6 Jun 2007 01:36:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/4] mm: variable length argument support
Message-Id: <20070606013658.20bcbe2f.akpm@linux-foundation.org>
In-Reply-To: <20070605151203.790585000@chello.nl>
References: <20070605150523.786600000@chello.nl>
	<20070605151203.790585000@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Ollie Wild <aaw@google.com>, Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>
List-ID: <linux-arch.vger.kernel.org>

On Tue, 05 Jun 2007 17:05:27 +0200 Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> From: Ollie Wild <aaw@google.com>
> 
> Remove the arg+env limit of MAX_ARG_PAGES by copying the strings directly
> from the old mm into the new mm.
> 
> We create the new mm before the binfmt code runs, and place the new stack
> at the very top of the address space. Once the binfmt code runs and figures
> out where the stack should be, we move it downwards.
> 
> It is a bit peculiar in that we have one task with two mm's, one of which is
> inactive.
> 
> ...
>
> +				flush_cache_page(bprm->vma, kpos,
> +						 page_to_pfn(kmapped_page));

Breaks SuperH:

fs/exec.c: In function `bprm_mm_init':
fs/exec.c:268: warning: unused variable `vma'
fs/exec.c: In function `copy_strings':
fs/exec.c:431: error: structure has no member named `vma'

