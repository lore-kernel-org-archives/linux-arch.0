From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 74/76] ARC: [Review] Multi-platform image #7: SMP common code to use callbacks
Date: Fri, 18 Jan 2013 15:08:05 +0000
Message-ID: <201301181508.05723.arnd@arndb.de>
References: <1358511930-7424-1-git-send-email-vgupta@synopsys.com> <1358512827-7694-1-git-send-email-vgupta@synopsys.com> <1358512827-7694-3-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:61241 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116Ab3ARPIJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jan 2013 10:08:09 -0500
In-Reply-To: <1358512827-7694-3-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 18 January 2013, Vineet Gupta wrote:
> This again is for switch from singleton platform SMP API to
> multi-platform paradigm
> 
> Platform code is not yet setup to populate the callbacks, that happens
> in next commit
> 
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>
