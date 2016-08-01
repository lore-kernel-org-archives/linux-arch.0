Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39232 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751587AbcHAOnv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 1 Aug 2016 10:43:51 -0400
Subject: Re: [PATCH 08/10] x86, pkeys: default to a restrictive init PKRU
References: <20160729163009.5EC1D38C@viggo.jf.intel.com>
 <20160729163021.F3C25D4A@viggo.jf.intel.com>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <cd74ae8b-36e4-a397-e36f-fe3d4281d400@suse.cz>
Date: Mon, 1 Aug 2016 16:42:51 +0200
MIME-Version: 1.0
In-Reply-To: <20160729163021.F3C25D4A@viggo.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave@sr71.net>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, luto@kernel.org, mgorman@techsingularity.net, dave.hansen@linux.intel.com, arnd@arndb.de
Message-ID: <20160801144251.TB1WjTOZ2w7kPUkrggDFDGJyogwT7A0Zh9NwHNSoN-0@z>

On 07/29/2016 06:30 PM, Dave Hansen wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> PKRU is the register that lets you disallow writes or all access
> to a given protection key.
>
> The XSAVE hardware defines an "init state" of 0 for PKRU: its
> most permissive state, allowing access/writes to everything.
> Since we start off all new processes with the init state, we
> start all processes off with the most permissive possible PKRU.
>
> This is unfortunate.  If a thread is clone()'d [1] before a
> program has time to set PKRU to a restrictive value, that thread
> will be able to write to all data, no matter what pkey is set on
> it.  This weakens any integrity guarantees that we want pkeys to
> provide.
>
> To fix this, we define a very restrictive PKRU to override the
> XSAVE-provided value when we create a new FPU context.  We choose
> a value that only allows access to pkey 0, which is as
> restrictive as we can practically make it.
>
> This does not cause any practical problems with applications
> using protection keys because we require them to specify initial
> permissions for each key when it is allocated, which override the
> restrictive default.

Here you mean the init_access_rights parameter of pkey_alloc()? So will 
children of fork() after that pkey_alloc() inherit the new value or go 
default?

> In the end, this ensures that threads which do not know how to
> manage their own pkey rights can not do damage to data which is
> pkey-protected.
>
> 1. I would have thought this was a pretty contrived scenario,
>    except that I heard a bug report from an MPX user who was
>    creating threads in some very early code before main().  It
>    may be crazy, but folks evidently _do_ it.
>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>

