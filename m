Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:38524 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbaD1JH2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 28 Apr 2014 05:07:28 -0400
Date: Mon, 28 Apr 2014 11:06:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V3 1/2] mm: move FAULT_AROUND_ORDER to arch/
Message-ID: <20140428090649.GD27561@twins.programming.kicks-ass.net>
References: <1398675690-16186-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1398675690-16186-2-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1398675690-16186-2-git-send-email-maddy@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org, benh@kernel.crashing.org, paulus@samba.org, kirill.shutemov@linux.intel.com, rusty@rustcorp.com.au, akpm@linux-foundation.org, riel@redhat.com, mgorman@suse.de, ak@linux.intel.com, mingo@kernel.org, dave.hansen@intel.com
Message-ID: <20140428090649.8KTh_ZkZoQDJYc2nos8xrHJ_dhsPVs-2F61aZDSzhSE@z>

On Mon, Apr 28, 2014 at 02:31:29PM +0530, Madhavan Srinivasan wrote:
> +unsigned int fault_around_order = CONFIG_FAULT_AROUND_ORDER;

__read_mostly?
