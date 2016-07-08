Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.sr71.net ([198.145.64.142]:47341 "EHLO blackbird.sr71.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755395AbcGHQcK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 8 Jul 2016 12:32:10 -0400
Subject: Re: [PATCH 6/9] x86, pkeys: add pkey set/get syscalls
References: <20160707124719.3F04C882@viggo.jf.intel.com>
 <20160707124728.C1116BB1@viggo.jf.intel.com>
 <20160707144508.GZ11498@techsingularity.net> <577E924C.6010406@sr71.net>
 <20160708071810.GA27457@gmail.com>
From: Dave Hansen <dave@sr71.net>
Message-ID: <577FD587.6050101@sr71.net>
Date: Fri, 8 Jul 2016 09:32:07 -0700
MIME-Version: 1.0
In-Reply-To: <20160708071810.GA27457@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Mel Gorman <mgorman@techsingularity.net>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, dave.hansen@linux.intel.com, arnd@arndb.de, hughd@google.com, viro@zeniv.linux.org.uk
Message-ID: <20160708163207.EllU5FFEpS9Cqw3I46ZyhIPksL9sscazHauL21YizGk@z>

On 07/08/2016 12:18 AM, Ingo Molnar wrote:
> So the question is, what is user-space going to do? Do any glibc
> patches exist? How are the user-space library side APIs going to look
> like?

My goal at the moment is to get folks enabled to the point that they can
start modifying apps to use pkeys without having to patch their kernels.
 I don't have confidence that we can design good high-level userspace
interfaces without seeing some real apps try to use the low-level ones
and seeing how they struggle.

I had some glibc code to do the pkey alloc/free operations, but those
aren't necessary if we're doing it in the kernel.  Other than getting
the syscall wrappers in place, I don't have any immediate plans to do
anything in glibc.

Was there something you were expecting to see?
