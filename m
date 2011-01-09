Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:55918 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800Ab1AIQNN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jan 2011 11:13:13 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] kbuild: asm-generic support
Date: Sun, 9 Jan 2011 17:13:01 +0100
References: <20110108130302.GA21698@merkur.ravnborg.org> <201101091503.34783.arnd@arndb.de> <20110109151041.GA17237@merkur.ravnborg.org>
In-Reply-To: <20110109151041.GA17237@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <201101091713.02243.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, linux arch <linux-arch@vger.kernel.org>, Guan Xuetao <guanxuetao@mprc.pku.edu.cn>, Michal Marek <mmarek@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <20110109161301.VvYSPr-bYhKJzDeJ-ctphtnuuzjkVBrjsSKbym9giZg@z>

On Sunday 09 January 2011, Sam Ravnborg wrote:
> @@ -31,10 +31,10 @@ check-file    := $(install)/.check
>  # generic-export-y list all generic headers to be exported
>  # generic-y list all files an architecture uses from asm-generic
>  # Use this to build a list of headers which require a wrapper
> -wrapper-files := $(filter $(generic-export-y), $(generic-y))
> +wrapper-files := $(filter $(header-y), $(generic-y))
>  
>  # all headers files for this dir
> -header-y      := $(filter-out $(wrapper-files), $(header-y))
> +header-y      := $(filter-out $(generic-y), $(header-y))
>  all-files     := $(header-y) $(objhdr-y) $(generic-y)
>  input-files   := $(addprefix $(_src)/,$(header-y)) \
>                   $(addprefix $(objtree)/$(obj)/,$(objhdr-y))
> 
> And then reverting the changes to Kbuild.asm.
> Yes this works - and is much simpler. Good!

Ok, excellent!

	Arnd
