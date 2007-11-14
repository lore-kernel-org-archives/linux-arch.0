Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:45828 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753525AbXKNUUH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 14 Nov 2007 15:20:07 -0500
Subject: Re: [PATCH 0/3] mmap vs NFS
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <20071114200136.009242000@chello.nl>
References: <20071114200136.009242000@chello.nl>
Content-Type: text/plain
Date: Wed, 14 Nov 2007 21:19:22 +0100
Message-Id: <1195071564.22457.0.camel@lappy>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Trond Myklebust <trond.myklebust@fys.uio.no>, Nick Piggin <npiggin@suse.de>, Hugh Dickins <hugh@veritas.com>
List-ID: <linux-arch.vger.kernel.org>


Seems I forgot to mention this is an RFC :-)

On Wed, 2007-11-14 at 21:01 +0100, Peter Zijlstra wrote:
> Currently there is an AB-BA deadlock in NFS mmap.
> 
> nfs_file_mmap() can take i_mutex, while holding mmap_sem, whereas the regular
> locking order is the other way around.
> 
> This patch-set attempts to solve this issue.
> 

