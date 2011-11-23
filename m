From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v2 1/2] kernel.h: Add BUILD_BUG() macro.
Date: Tue, 22 Nov 2011 17:34:25 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1111221734120.18644@chino.kir.corp.google.com>
References: <1321985686-798-1-git-send-email-ddaney.cavm@gmail.com> <1321985686-798-2-git-send-email-ddaney.cavm@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:59288 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796Ab1KWBe2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Nov 2011 20:34:28 -0500
Received: by yenq3 with SMTP id q3so864673yen.19
        for <linux-arch@vger.kernel.org>; Tue, 22 Nov 2011 17:34:28 -0800 (PST)
In-Reply-To: <1321985686-798-2-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Daney <ddaney.cavm@gmail.com>
Cc: ralf@linux-mips.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, DM <dm.n9107@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, David Daney <david.daney@cavium.com>

On Tue, 22 Nov 2011, David Daney wrote:

> From: David Daney <david.daney@cavium.com>
> 
> We can place this in definitions that we expect the compiler to remove
> by dead code elimination.  If this assertion fails, we get a nice
> error message at build time.
> 
> The GCC function attribute error("message") was added in version 4.3,
> so we define a new macro __linktime_error(message) to expand to this
> for GCC-4.3 and later.  This will give us an error diagnostic from the
> compiler on the line that fails.  For other compilers
> __linktime_error(message) expands to nothing, and we have to be
> content with a link time error, but at least we will still get a build
> error.
> 
> BUILD_BUG() expands to the undefined function __build_bug_failed() and
> will fail at link time if the compiler ever emits code for it.  On
> GCC-4.3 and later, attribute((error())) is used so that the failure
> will be noted at compile time instead.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>

Acked-by: David Rientjes <rientjes@google.com>
