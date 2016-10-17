Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:59933 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754595AbcJQPhy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Oct 2016 11:37:54 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] generic syscalls: kill cruft from removed pkey syscalls
Date: Mon, 17 Oct 2016 17:37:29 +0200
Message-ID: <5993847.hpzj164ak1@wuerfel>
In-Reply-To: <20161017151814.1CE8B6C3@viggo.jf.intel.com>
References: <20161017151814.1CE8B6C3@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave@sr71.net>
Cc: linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de, x86@kernel.org, linux-arch@vger.kernel.org, mgorman@techsingularity.net, linux-api@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org
Message-ID: <20161017153729.Uxftl8nHMcURLhPaSSnCjd_u8sAF6WmpkZ34wdAUa78@z>

On Monday, October 17, 2016 8:18:15 AM CEST Dave Hansen wrote:
> 
> pkey_set() and pkey_get() were syscalls present in older versions
> of the protection keys patches.  They were fully excised from the
> x86 code, but some cruft was left in the generic syscall code.  The
> C++ comments were intended to help to make it more glaring to me to
> fix them before actually submitting them.  That technique worked,
> but later than I would have liked.
> 
> I test-compiled this for arm64.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: x86@kernel.org
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arch@vger.kernel.org
> Cc: mgorman@techsingularity.net
> Cc: linux-api@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: luto@kernel.org
> Cc: akpm@linux-foundation.org
> Cc: torvalds@linux-foundation.org
> Fixes: a60f7b69d92c0 ("generic syscalls: Wire up memory protection keys syscalls")

Acked-by: Arnd Bergmann <arnd@arndb.de>
