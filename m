Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from asavdk4.altibox.net ([109.247.116.15]:33563 "EHLO
	asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbcHFUQd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 6 Aug 2016 16:16:33 -0400
Date: Sat, 6 Aug 2016 22:16:29 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 3/5] kbuild: add arch specific post-module-link pass
Message-ID: <20160806201629.GC25821@ravnborg.org>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
 <1470399123-8455-4-git-send-email-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1470399123-8455-4-git-send-email-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>
Message-ID: <20160806201629.TCXdcotxKrCK7ES-RZScCcABF2ilwYfTZHrEfyJ4wFU@z>

On Fri, Aug 05, 2016 at 10:12:01PM +1000, Nicholas Piggin wrote:
> Add an option for architectures to pass over modules after they are
> linked. powerpc will use this to fix up alternate instruction patch
> relocations.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  Documentation/kbuild/makefiles.txt | 6 ++++++
>  Makefile                           | 1 +
>  scripts/Makefile.modpost           | 8 ++++++++
>  3 files changed, 15 insertions(+)
> 
> diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
> index 13f888a..f6c065b 100644
> --- a/Documentation/kbuild/makefiles.txt
> +++ b/Documentation/kbuild/makefiles.txt
> @@ -952,6 +952,12 @@ When kbuild executes, the following steps are followed (roughly):
>  	$(KBUILD_ARFLAGS) set by the top level Makefile to "D" (deterministic
>  	mode) if this option is supported by $(AR).
>  
> +    KBUILD_MODPOST_TOOL   Arch-specific command to run after module link
> +
> +        $(KBUILD_MODPOST_TOOL) is used to add an arch-specific pass over
> +        modules after their final link. E.g., powerpc uses this to adjust
> +        relative branches of "alternate code patching" sections.
> +

This needs documentation in kbuild.txt, where there is a
nearly full lst of KBUILD_ variables.

	Sam
