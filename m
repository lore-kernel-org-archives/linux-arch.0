Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:53559 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166AbbBWV4u (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 23 Feb 2015 16:56:50 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YQ0zh-000Vuh-Pb
	for linux-arch@vger.kernel.org; Mon, 23 Feb 2015 21:56:49 +0000
Date: Mon, 23 Feb 2015 13:56:34 -0800
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: fs: dax: do not build on ARC or SH
Message-ID: <20150223215634.GA23928@roeck-us.net>
References: <5778538.KJ98x3yxkB@wuerfel>
 <20150223184025.GD2780@wil.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150223184025.GD2780@wil.cx>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <willy@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-sh@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>
Message-ID: <20150223215634.CXR5FCfYFa0muQN7Z_d3soQe7jIjeE6kmrjflLMcB5k@z>

On Mon, Feb 23, 2015 at 01:40:25PM -0500, Matthew Wilcox wrote:
> On Mon, Feb 23, 2015 at 12:29:45PM +0100, Arnd Bergmann wrote:
> > The DAX implementation relies on the architecture to provide a working
> > copy_user_page() function, as reported by Michael Ellerman's kisskb
> > build bot:
> > 
> > fs/dax.c: error: implicit declaration of function 'copy_user_page' [-Werror=implicit-function-declaration]:  => 266:2
> > 
> > We already have a list of architectures that are known to be incompatible,
> > but the list is missing ARC and SH at the moment. Further, blackfin and
> > c6x also lack support for this function, but are already excluded because
> > they do not support MMU-based kernels.
> 
> I've got a short list of patches for DAX; I'll add this one to the list.
> 
> Have the maintainers of these architectures been notified that they're
> missing a core piece of kernel functionality?
> 

Guess there a philosophical difference in opinion if the architecture code
should (have to) provide copy_user_page() or not outside the architecture
code itself. After all, fs/dax.c _is_ the only user of this function outside
the architecture code.

Guenter
