From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/5] kbuild: allow archs to select build for link dead
 code/data elimination
Date: Mon, 8 Aug 2016 13:29:03 +1000
Message-ID: <20160808132903.0e37c967@roar.ozlabs.ibm.com>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
	<1470399123-8455-3-git-send-email-npiggin@gmail.com>
	<20160806201423.GB25821@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34524 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997AbcHHD3L (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 7 Aug 2016 23:29:11 -0400
In-Reply-To: <20160806201423.GB25821@ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>

On Sat, 6 Aug 2016 22:14:23 +0200
Sam Ravnborg <sam@ravnborg.org> wrote:

> On Fri, Aug 05, 2016 at 10:12:00PM +1000, Nicholas Piggin wrote:
> > Introduce LINKER_DCE option for architectures to select if they want
> > to build with -ffunction-sections, -fdata-sections, and link with
> > --gc-sections.  
> 
> Can you please try to come up with a less cryptic name.
> "DCE" may make sense for you today.
> Bot the naive reader will benefit from the longer and
> more explcit form.

Yes that's a good idea. The name sucks.

We don't seem to consistently have a prefix for build configuration
options, but we could start? KBUILD_LD_DEAD_CODE_DATA_ELIMINATION?

Thanks,
Nick
