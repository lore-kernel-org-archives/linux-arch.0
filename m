Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from h5.dl5rb.org.uk ([81.2.74.5]:43956 "EHLO linux-mips.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751790Ab1LHQYf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 8 Dec 2011 11:24:35 -0500
Date: Thu, 8 Dec 2011 16:19:31 +0000
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 19/23] mips: Use HAVE_MEMBLOCK_NODE_MAP
Message-ID: <20111208161931.GA17864@linux-mips.org>
References: <1322508685-32532-1-git-send-email-tj@kernel.org>
 <1322508685-32532-20-git-send-email-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1322508685-32532-20-git-send-email-tj@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: benh@kernel.crashing.org, yinghai@kernel.org, hpa@zytor.com, tony.luck@intel.com, schwidefsky@de.ibm.com, liqin.chen@sunplusct.com, lethal@linux-sh.org, davem@davemloft.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, jonas@southpole.se, lennox.wu@gmail.com, linux-mips@linux-mips.org
Message-ID: <20111208161931.lInDQkDRawJ4AwTEIftk_D64bIy1uWXfkvFdk8gg200@z>

On Mon, Nov 28, 2011 at 11:31:21AM -0800, Tejun Heo wrote:

> mips used early_node_map[] just to prime free_area_init_nodes().  Now
> memblock can be used for the same purpose and early_node_map[] is
> scheduled to be dropped.  Use memblock instead.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Thanks,

  Ralf
