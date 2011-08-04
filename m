Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59188 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532Ab1HDJwY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 4 Aug 2011 05:52:24 -0400
Date: Thu, 4 Aug 2011 11:52:18 +0200
From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 16/23] sparc: Use HAVE_MEMBLOCK_NODE_MAP
Message-ID: <20110804095218.GB2731@htj.dyndns.org>
References: <1311694534-5161-1-git-send-email-tj@kernel.org>
 <1311694534-5161-17-git-send-email-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1311694534-5161-17-git-send-email-tj@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: benh@kernel.crashing.org, yinghai@kernel.org, hpa@zytor.com, tony.luck@intel.com, ralf@linux-mips.org, schwidefsky@de.ibm.com, liqin.chen@sunplusct.com, lethal@linux-sh.org, davem@davemloft.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@redhat.com, sparclinux@vger.kernel.org
Message-ID: <20110804095218.ps8s-FzoUERGleJwhcqf5ETugcOO7tUuXBfFnjxgjkg@z>

On Tue, Jul 26, 2011 at 05:35:27PM +0200, Tejun Heo wrote:
> sparc doesn't access early_node_map[] directly and enabling
> HAVE_MEMBLOCK_NODE_MAP is trivial - replacing add_active_range() calls
> with memblock_set_node() and selecting HAVE_MEMBLOCK_NODE_MAP is
> enough.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org

David just confirmed this worked fine on sparc and was okay with this
going through tip.

Thanks.

-- 
tejun
