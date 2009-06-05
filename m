From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: "N" symbols and System.map
Date: Sat, 6 Jun 2009 00:26:50 +0200
Message-ID: <20090605222650.GM29008@uranus.ravnborg.org>
References: <49FB7692.2000508@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pfepa.post.tele.dk ([195.41.46.235]:37604 "EHLO
	pfepa.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbZFEWYe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 5 Jun 2009 18:24:34 -0400
Content-Disposition: inline
In-Reply-To: <49FB7692.2000508@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org

On Fri, May 01, 2009 at 03:24:18PM -0700, H. Peter Anvin wrote:
> Hi all,
> 
> right now, we filter out symbols that nm tag N, meaning "debugging 
> symbols", from System.map.  However, at least on x86, the 
> linker-generated symbol _end is tagged N, and in fact is the only N in 
> the entire image.
> 
> Are there other architectures which would suffer if N were included in 
> System.map, or would that be a reasonable thing to do?

Peter - what is status here?

Do you see _end tagged N with -tip?
We landed a lot of changes to vmlinux.lds there.

Needless to say I have not included N symbols for now.

	Sam
