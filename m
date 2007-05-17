Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:53391 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756271AbXEQOvt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 May 2007 10:51:49 -0400
Subject: Re: [RFC] Explicitly mark global functions with vmlinux with
	__global
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1179339053.2859.328.camel@shinybook.infradead.org>
References: <1179333273.2859.282.camel@shinybook.infradead.org>
	 <20070516095027.f5d463ff.akpm@linux-foundation.org>
	 <1179339053.2859.328.camel@shinybook.infradead.org>
Content-Type: text/plain
Date: Thu, 17 May 2007 22:51:46 +0800
Message-Id: <1179413506.2859.504.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: torvalds@linux-foundation.org, sam@ravnborg.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 2007-05-17 at 02:10 +0800, David Woodhouse wrote:
> The reason I say 'maybe a little less' is because I concentrated on
> modules at the time because the Kbuild stuff was relatively easy for
> those -- and I have a vague recollection that the built-in stuff didn't
> show as big a difference. Searching for 'built-in.o' in the above-linked
> CSV file seems to confirm that recollection. 

Actually I'm full of crap. The reason we don't see much improvement in
built-in.o in that list because I didn't _do_ it for built-in.o yet --
it's still only happening for the few multi-obj .o files which get
linked into built-on.o (e.g. mounts-y in init/, etc.).

I lack the wit to make that one work right now. It might look something
like this...

Actually, built-in.o probably ought to be just another case of
$(multi-obj-y). And I need to filter out the non-C sources of those too,
to fix md and crypto stuff (which uses .S files) so I don't need to add
'CONFIG_COMBINED_COMPILE=' to their makefiles.



ifdef CONFIG_COMBINED_COMPILEx
builtin-cfiles-y := $(wildcard $(obj-y:.o=.c))

multi-objs-y += $(obj)/builtin-cfiles.o
multi-used-y += $(obj)/builtin-cfiles.o

$(builtin-target): $(filter-out $(builtin-cfiles-y:.c=.o),$(obj-y))
$(obj)/builtin-cfiles.o FORCE
	$(call if_changed,link_o_target)
else
$(builtin-target): $(obj-y) FORCE
	$(call if_changed,link_o_target)
endif # CONFIG_COMBINED_COMPILE




-- 
dwmw2

