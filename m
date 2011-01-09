From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic headers: add sizes.h
Date: Sun, 9 Jan 2011 01:18:10 +0100
Message-ID: <201101090118.10420.arnd@arndb.de>
References: <023e01cbaf2c$5b8fbe80$12af3b80$@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:57274 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895Ab1AIAST (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2011 19:18:19 -0500
In-Reply-To: <023e01cbaf2c$5b8fbe80$12af3b80$@mprc.pku.edu.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday 08 January 2011, Guan Xuetao wrote:
> From: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>
> 
>  This patch adds sizes.h into asm-generic headers.
>  Only 32-bit version supported.
> 
> Signed-off-by: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>


Looks good. I can take the patch into my asm-generic tree if you like, but
it's probably easier if you add it to your series as a prerequisite, because
you can avoid dependencies on my tree that way.

Same for the ftrace header.

Acked-by: Arnd Bergmann <arnd@arndb.de>
