Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35499 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbcF3Jn5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 30 Jun 2016 05:43:57 -0400
Date: Thu, 30 Jun 2016 11:41:23 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 0/9] [v3] System Calls for Memory Protection Keys
Message-ID: <20160630094123.GA29268@gmail.com>
References: <20160609000117.71AC7623@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160609000117.71AC7623@viggo.jf.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave@sr71.net>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, arnd@arndb.de, Al Viro <viro@zeniv.linux.org.uk>, Mel Gorman <mgorman@techsingularity.net>, Hugh Dickins <hughd@google.com>
Message-ID: <20160630094123.gGjyekU2vIggeQSIgcTxbtjxc-Ymbn840jkRcAc2U8s@z>


* Dave Hansen <dave@sr71.net> wrote:

> Are there any concerns with merging these into the x86 tree so
> that they go upstream for 4.8?  The updates here are pretty
> minor.

>  include/linux/pkeys.h                         |   39 +-
>  include/uapi/asm-generic/mman-common.h        |    5 +
>  include/uapi/asm-generic/unistd.h             |   12 +-
>  mm/mprotect.c                                 |  134 +-

So I'd love to have some high level MM review & ack for these syscall ABI 
extensions.

Thanks,

	Ingo
