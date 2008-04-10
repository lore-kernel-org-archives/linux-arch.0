Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.190]:46608 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404AbYDJUnD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Apr 2008 16:43:03 -0400
Received: by rn-out-0910.google.com with SMTP id v46so259996rnb.15
        for <linux-arch@vger.kernel.org>; Thu, 10 Apr 2008 13:43:02 -0700 (PDT)
Subject: Re: [PATCH 4/8] kernel: move arches that use the generic_le/be
	helpers
From: Harvey Harrison <harvey.harrison@gmail.com>
In-Reply-To: <20080410203708.GA28014@linux-mips.org>
References: <1207856648.22001.28.camel@brick>
	 <20080410203708.GA28014@linux-mips.org>
Content-Type: text/plain
Date: Thu, 10 Apr 2008 13:43:02 -0700
Message-ID: <1207860182.22001.40.camel@brick>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20080410204302.q72lW7EVaLEuQEp08qYaNHP98Jw8TCk9mVINrriiY24@z>

On Thu, 2008-04-10 at 21:37 +0100, Ralf Baechle wrote:
> On Thu, Apr 10, 2008 at 12:44:08PM -0700, Harvey Harrison wrote:
> 
> Btw, you may want to look at the current MIPS implementation of
> get_unaligned and put_unaligned.  It's pure C and at least on MIPS it
> produces somewhat shorter code and the source is definately much
> shorter since it exploits the compiler's cleverness.
> 
>   Ralf

Yeah, the only reason I did not is that many arches intentionally bug
during the linking process when the argument size is not 1,2,4,8 whereas
some do not...it would be nice to get a decision on what is the right
answer.

Also, I saw the mips version, what would you think of moving to the
no_builtin_memcpy version from my patchset...or just look at
h3800, xtensa, or m32r arch implementations currently in tree.

Cheers,

Harvey

