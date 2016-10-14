Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:13910 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756304AbcJNTRC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 Oct 2016 15:17:02 -0400
Subject: Re: pkeys: Remove easily triggered WARN
References: <20161014182624.4yzw36n4hd7x56wi@codemonkey.org.uk>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <58012F29.8040307@intel.com>
Date: Fri, 14 Oct 2016 12:16:57 -0700
MIME-Version: 1.0
In-Reply-To: <20161014182624.4yzw36n4hd7x56wi@codemonkey.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-arch@vger.kernel.org, mgorman@techsingularity.net, arnd@arndb.de, linux-api@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org
Message-ID: <20161014191657.n3V_uwqvBpENloQ1sTjgie9PkBuwiAjWoK8eoeH5UZo@z>

On 10/14/2016 11:26 AM, Dave Jones wrote:
> This easy-to-trigger warning shows up instantly when running
> Trinity on a kernel with CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS disabled.
> 
> At most this should have been a printk, but the -EINVAL alone should be more
> than adequate indicator that something isn't available.

Urg, thanks for the patch.  It's obviously correct, of course.

Acked-by: Dave Hansen <dave.hansen@intel.com>
