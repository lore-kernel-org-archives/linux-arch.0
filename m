Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:37269 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753918AbYAVVQY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Jan 2008 16:16:24 -0500
Date: Tue, 22 Jan 2008 13:17:15 -0800
From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Use separate sections for __dev/__cpu/__mem code/data
Message-ID: <20080122211715.GA26279@kroah.com>
References: <20080120200527.GA23852@uranus.ravnborg.org> <1200859743-24037-1-git-send-email-sam@ravnborg.org> <1200859743-24037-2-git-send-email-sam@ravnborg.org> <1200859743-24037-3-git-send-email-sam@ravnborg.org> <1200859743-24037-4-git-send-email-sam@ravnborg.org> <1200859743-24037-5-git-send-email-sam@ravnborg.org> <1200859743-24037-6-git-send-email-sam@ravnborg.org> <1200859743-24037-7-git-send-email-sam@ravnborg.org> <1200859743-24037-8-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1200859743-24037-8-git-send-email-sam@ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, Randy Dunlap <randy.dunlap@oracle.com>, Adrian Bunk <bunk@kernel.org>

On Sun, Jan 20, 2008 at 09:09:03PM +0100, Sam Ravnborg wrote:
> Introducing separate sections for __dev* (HOTPLUG),
> __cpu* (HOTPLUG_CPU) and __mem* (MEMORY_HOTPLUG)
> allows us to do a much more reliable Section mismatch
> check in modpost. We are no longer dependent on the actual
> configuration of for example HOTPLUG.
> 
> This has the effect that all users see much more
> Section mismatch warnings than before because they
> were almost all hidden when HOTPLUG was enabled.
> The advantage of this is that when building a piece
> of code then it is much more likely that the Section
> mismatch errors are spotted and the warnings will be
> felt less random of nature.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Greg KH <greg@kroah.com>
> Cc: Randy Dunlap <randy.dunlap@oracle.com>
> Cc: Adrian Bunk <bunk@kernel.org>

I like this a lot.  It makes things much more understandable from a
driver developer's point of view, and would allow us to mark some things
as freeable when we do not run with a CPU hotplug system :)

Feel free to add a:
	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
to the patch, if you want to take it in your tree.

thanks,

greg k-h
