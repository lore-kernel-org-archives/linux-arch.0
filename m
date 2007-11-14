Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pat.uio.no ([129.240.10.15]:33875 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754170AbXKNV13 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 14 Nov 2007 16:27:29 -0500
Subject: Re: [PATCH 0/3] mmap vs NFS
From: Trond Myklebust <trond.myklebust@fys.uio.no>
In-Reply-To: <20071114200136.009242000@chello.nl>
References: <20071114200136.009242000@chello.nl>
Content-Type: text/plain
Date: Wed, 14 Nov 2007 16:27:32 -0500
Message-Id: <1195075652.7584.61.camel@heimdal.trondhjem.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@suse.de>, Hugh Dickins <hugh@veritas.com>
List-ID: <linux-arch.vger.kernel.org>


On Wed, 2007-11-14 at 21:01 +0100, Peter Zijlstra wrote:
> Currently there is an AB-BA deadlock in NFS mmap.
> 
> nfs_file_mmap() can take i_mutex, while holding mmap_sem, whereas the regular
> locking order is the other way around.
> 
> This patch-set attempts to solve this issue.

Looks good from the NFS point of view.

Acked-by: Trond Myklebust <Trond.Myklebust@netapp.com>

