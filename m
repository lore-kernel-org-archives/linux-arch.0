From: Michal Marek <mmarek@suse.com>
Subject: Re: [PATCH] kbuild: modversions for EXPORT_SYMBOL() for asm
Date: Tue, 1 Nov 2016 16:49:29 +0100
Message-ID: <a14a4f93-698f-88f6-8094-c2646e6f9c58@suse.com>
References: <20161101014619.1245-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52170 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750749AbcKAPtb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Nov 2016 11:49:31 -0400
In-Reply-To: <20161101014619.1245-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>

On 2016-11-01 02:46, Nicholas Piggin wrote:
> Allow architectures to create asm/asm-prototypes.h file that
> provides C prototypes for exported asm functions, which enables
> proper CRC versions to be generated for them.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

I applied the patch to kbuild.git#rc-fixes.

Michal
