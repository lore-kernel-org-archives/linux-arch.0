Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28875 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932898AbaDIPv4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 9 Apr 2014 11:51:56 -0400
Message-ID: <53456BE2.90905@intel.com>
Date: Wed, 09 Apr 2014 08:48:50 -0700
From: Dave Hansen <dave.hansen@intel.com>
MIME-Version: 1.0
Subject: Re: [PATCH V2 1/2] mm: move FAULT_AROUND_ORDER to arch/
References: <1396592835-24767-1-git-send-email-maddy@linux.vnet.ibm.com> <1396592835-24767-2-git-send-email-maddy@linux.vnet.ibm.com> <533EDB63.8090909@intel.com> <5344A312.80802@linux.vnet.ibm.com> <20140409082008.GA10526@twins.programming.kicks-ass.net>
In-Reply-To: <20140409082008.GA10526@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org, benh@kernel.crashing.org, paulus@samba.org, kirill.shutemov@linux.intel.com, rusty@rustcorp.com.au, akpm@linux-foundation.org, riel@redhat.com, mgorman@suse.de, ak@linux.intel.com, mingo@kernel.org
Message-ID: <20140409154850.50YSqi3bUNxikUlEZGq7LZCbsfN2jlcz_hrgq4WjXtQ@z>

On 04/09/2014 01:20 AM, Peter Zijlstra wrote:
> This still misses out on Ben's objection that its impossible to get this
> right at compile time for many kernels, since they can boot and run on
> many different subarchs.

Completely agree.  The Kconfig-time stuff should probably just be a knob
to turn it off completely, if anything.
