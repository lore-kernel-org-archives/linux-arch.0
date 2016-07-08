Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.sr71.net ([198.145.64.142]:49118 "EHLO blackbird.sr71.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752537AbcGHT0T (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 8 Jul 2016 15:26:19 -0400
Subject: Re: [PATCH 6/9] x86, pkeys: add pkey set/get syscalls
References: <20160707124719.3F04C882@viggo.jf.intel.com>
 <20160707124728.C1116BB1@viggo.jf.intel.com>
 <20160707144508.GZ11498@techsingularity.net> <577E924C.6010406@sr71.net>
 <20160708071810.GA27457@gmail.com>
From: Dave Hansen <dave@sr71.net>
Message-ID: <577FFE55.7040209@sr71.net>
Date: Fri, 8 Jul 2016 12:26:13 -0700
MIME-Version: 1.0
In-Reply-To: <20160708071810.GA27457@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Mel Gorman <mgorman@techsingularity.net>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, dave.hansen@linux.intel.com, arnd@arndb.de, hughd@google.com, viro@zeniv.linux.org.uk
Message-ID: <20160708192613.icHLr6Lf8tHvKqgjDmFXvv7ZM_cuPLatzhA1yxW9H4I@z>

On 07/08/2016 12:18 AM, Ingo Molnar wrote:
> So my hope was that we'd also grow some debugging features: such as a periodic 
> watchdog timer clearing all non-allocated pkeys of a task and re-setting them to 
> their (kernel-)known values and thus forcing user-space to coordinate key 
> allocation/freeing.

I'm glad you mentioned this.  I've explicitly called out this behavior
in the manpages now, or at least called out the fact that the kernel
will not preserve PKRU contents for unallocated keys.


