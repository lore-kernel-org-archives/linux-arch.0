Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.sr71.net ([198.145.64.142]:58306 "EHLO blackbird.sr71.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932383AbcFBVKi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 2 Jun 2016 17:10:38 -0400
Subject: Re: [PATCH 5/8] x86, pkeys: allocation/free syscalls
References: <20160531152814.36E0B9EE@viggo.jf.intel.com>
 <20160531152822.FE8D405E@viggo.jf.intel.com> <5864297.Wx4gj9qW7E@wuerfel>
From: Dave Hansen <dave@sr71.net>
Message-ID: <5750A0C9.7060409@sr71.net>
Date: Thu, 2 Jun 2016 14:10:33 -0700
MIME-Version: 1.0
In-Reply-To: <5864297.Wx4gj9qW7E@wuerfel>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, dave.hansen@linux.intel.com
Message-ID: <20160602211033.wtHJzX1bQI_EfXBb_KUvrth3y6Z3dEkWYAjq18LeqaY@z>

On 06/01/2016 01:48 PM, Arnd Bergmann wrote:
>> +330    common  pkey_alloc              sys_pkey_alloc
>> > +331    common  pkey_free               sys_pkey_free
>> >  
>> >  #
>> >  # x32-specific system call numbers start at 512 to avoid cache impact
>> > 
> Could you also add the system call numbers to
> include/uapi/asm-generic/unistd.h at the same time?

Yep, I can do that.  I'll add it to my next series that I post.



