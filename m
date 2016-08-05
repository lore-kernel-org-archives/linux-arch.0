From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 3/5] kbuild: add arch specific post-module-link pass
Date: Fri, 5 Aug 2016 23:56:44 +1000
Message-ID: <20160805235644.366a68ec@roar.ozlabs.ibm.com>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
	<1470399123-8455-4-git-send-email-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35294 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161420AbcHEN4x (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 5 Aug 2016 09:56:53 -0400
In-Reply-To: <1470399123-8455-4-git-send-email-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>

On Fri,  5 Aug 2016 22:12:01 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> Add an option for architectures to pass over modules after they are
> linked. powerpc will use this to fix up alternate instruction patch
> relocations.

For that matter, now I think about it, I'd like to have this generic
postmod pass for the vmlinux as well. And it would be  to call into
the arch Makefile rather than just supply a tool.

Currently powerpc deals with it by adding dependencies on its zImage
target, but it would be really nice to be able to fix that while we're
here too. Is that going to work?

Thanks,
Nick
