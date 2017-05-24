From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 2/2] kernel.h: handle pointers to arrays better in
 container_of()
Date: Wed, 24 May 2017 11:59:16 -0700
Message-ID: <20170524115916.4c7abeab29ddd73adc59f762@linux-foundation.org>
References: <201705240824.8lrwsHKo%fengguang.wu@intel.com>
        <7dbdfa72-e168-3b50-90dc-bca8239e8081@mev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:57250 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754524AbdEXS7S (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 May 2017 14:59:18 -0400
In-Reply-To: <7dbdfa72-e168-3b50-90dc-bca8239e8081@mev.co.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ian Abbott <abbotti@mev.co.uk>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Michal Nazarewicz <mina86@mina86.com>, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, Borislav Petkov <bp@suse.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Johannes Berg <johannes.berg@intel.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Potapenko <glider@google.com>

On Wed, 24 May 2017 11:46:17 +0100 Ian Abbott <abbotti@mev.co.uk> wrote:

> This breakage occurs when <asm-generic/bug.h> is included before 
> <include/linux.h> due to a circular dependancy I introduced with this 
> commit.
> 
> It can be fixed by replacing the `#include <linux/kernel.h>` with 
> `#include <linux/types.h>` in "include/asm-generic/bug.h".  I can send a 
> patch to fix that, but ideally, it should be committed before this 
> commit to avoid breakage during git bisect builds.  So my question is, 
> should I send a single patch to fix this breakage, or resend the series 
> of patches to incorporate this fix before the current commit?

I expect a full resend would be best - that way the test robot should
be able to parse and retest it in the usual fashion.
