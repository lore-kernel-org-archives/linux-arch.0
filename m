Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.sr71.net ([198.145.64.142]:45129 "EHLO blackbird.sr71.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752292AbcHAPAM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 1 Aug 2016 11:00:12 -0400
Subject: Re: [PATCH 08/10] x86, pkeys: default to a restrictive init PKRU
References: <20160729163009.5EC1D38C@viggo.jf.intel.com>
 <20160729163021.F3C25D4A@viggo.jf.intel.com>
 <cd74ae8b-36e4-a397-e36f-fe3d4281d400@suse.cz>
From: Dave Hansen <dave@sr71.net>
Message-ID: <579F6380.2070600@sr71.net>
Date: Mon, 1 Aug 2016 07:58:08 -0700
MIME-Version: 1.0
In-Reply-To: <cd74ae8b-36e4-a397-e36f-fe3d4281d400@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, luto@kernel.org, mgorman@techsingularity.net, dave.hansen@linux.intel.com, arnd@arndb.de
Message-ID: <20160801145808.d2uVINTgvhkoMbEt3hFjOQMmB6xe2f2LBtm9ncr0pfc@z>

On 08/01/2016 07:42 AM, Vlastimil Babka wrote:
> On 07/29/2016 06:30 PM, Dave Hansen wrote:
>> This does not cause any practical problems with applications
>> using protection keys because we require them to specify initial
>> permissions for each key when it is allocated, which override the
>> restrictive default.
> 
> Here you mean the init_access_rights parameter of pkey_alloc()? So will
> children of fork() after that pkey_alloc() inherit the new value or go
> default?

Hi Vlastimil,

Yes, exactly, the initial permissions are provided via pkey_alloc()'s
'init_access_rights' argument.

Do you mean fork() or clone()?  In both cases, we actually copy the FPU
state from the parent, so children always inherit the state from their
parent which contains the permissions set by the parent's calls to
pkey_alloc().
