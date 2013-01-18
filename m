Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:53864 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322Ab3ARO7Q (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jan 2013 09:59:16 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 67/76] ARC: [Review] Multi-platform image #1: Kconfig enablement
Date: Fri, 18 Jan 2013 14:59:11 +0000
References: <1358511930-7424-1-git-send-email-vgupta@synopsys.com> <1358511930-7424-68-git-send-email-vgupta@synopsys.com>
In-Reply-To: <1358511930-7424-68-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-ID: <201301181459.11758.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20130118145911.sECpIg8T4c_PsV_jfep6F2BEVtTO0cxlPQxrqt4hbRE@z>

On Friday 18 January 2013, Vineet Gupta wrote:
> This mini patchseries addresses the lack of multi-platform-image support
> in ARC port.
> 
> Older build system only supported one platform(soc) to build at a time
> and further only one board of that platform could be built. There was no
> technical reason for that - we just didn't have the need.
> 
> So the first step towards multi-platform (and multi-board) builds it to
> allow build system to do that.
> 
> So as applicable, <choice .. endchoice> => <menu .. endmenu>
> 
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>
