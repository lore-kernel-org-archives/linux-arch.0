From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] asm-generic/io.h: Add default configuration for
 readX/writeX_relaxed
Date: Tue, 8 Apr 2014 19:50:05 +0200
Message-ID: <20140408175005.GA31890@ravnborg.org>
References: <35729b5d2bf080d3029f69af4bc638a268bf1a8f.1396941358.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from asavdk3.altibox.net ([109.247.116.14]:35893 "EHLO
	asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757751AbaDHRuK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 Apr 2014 13:50:10 -0400
Content-Disposition: inline
In-Reply-To: <35729b5d2bf080d3029f69af4bc638a268bf1a8f.1396941358.git.michal.simek@xilinx.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com, wsa@the-dreams.de, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org

On Tue, Apr 08, 2014 at 09:16:01AM +0200, Michal Simek wrote:
> Define default readX/writeX_relaxed IO helper functions
> for all archs which use asm-generic/io.h.
> Using COMPILE_TEST, moving drivers out of arch/arm and
> removing architecture dependencies in Kconfig is causing
> that more and more drivers is using _relaxed IO helper
> functions which is causing compilation failures on architectures
> which don't define them.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

There is a potential cleanup patch for several architectures.
Those that already have similar defines can have them deleted as
they are now provided by the generic version.
Can you try to look into this too?

	Sam
