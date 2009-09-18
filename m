Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:61952 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758001AbZIRUMy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2009 16:12:54 -0400
Date: Fri, 18 Sep 2009 13:08:22 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 2/7] Add MAP_HUGETLB for mmaping pseudo-anonymous huge
 page regions
In-Reply-To: <08251014d2eb30e9016bab16404133f5c13beacf.1253272709.git.ebmunson@us.ibm.com>
Message-ID: <alpine.DEB.1.00.0909181308110.27556@chino.kir.corp.google.com>
References: <cover.1253272709.git.ebmunson@us.ibm.com> <653aa659fd7970f7428f4eb41fa10693064e4daf.1253272709.git.ebmunson@us.ibm.com> <08251014d2eb30e9016bab16404133f5c13beacf.1253272709.git.ebmunson@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric B Munson <ebmunson@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, rdunlap@xenotime.net, michael@ellerman.id.au, ralf@linux-mips.org, wli@holomorphy.com, mel@csn.ul.ie, dhowells@redhat.com, arnd@arndb.de, fengguang.wu@intel.com, shuber2@gmail.com, hugh.dickins@tiscali.co.uk, zohar@us.ibm.com, hugh@veritas.com, mtk.manpages@gmail.com, chris@zankel.net, linux-man@vger.kernel.org, linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20090918200822.ohzwCqeuSdGUBTUAF78fZENmg4u4nQxk-ouQ_SPpJMU@z>

On Fri, 18 Sep 2009, Eric B Munson wrote:

> This patch adds a flag for mmap that will be used to request a huge
> page region that will look like anonymous memory to user space.  This
> is accomplished by using a file on the internal vfsmount.  MAP_HUGETLB
> is a modifier of MAP_ANONYMOUS and so must be specified with it.  The
> region will behave the same as a MAP_ANONYMOUS region using small pages.
> 
> Signed-off-by: Eric B Munson <ebmunson@us.ibm.com>

Acked-by: David Rientjes <rientjes@google.com>
