From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic headers: add ftrace.h
Date: Sun, 9 Jan 2011 01:18:26 +0100
Message-ID: <201101090118.26178.arnd@arndb.de>
References: <024001cbaf2c$cbe9cc70$63bd6550$@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:63946 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824Ab1AIASd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2011 19:18:33 -0500
In-Reply-To: <024001cbaf2c$cbe9cc70$63bd6550$@mprc.pku.edu.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday 08 January 2011, Guan Xuetao wrote:
> From: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>
> 
>  This patch adds ftrace.h into asm-generic headers.
>  The file content could be empty in most architectures.
> 
> Signed-off-by: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>
> ---
>  include/asm-generic/ftrace.h |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)

Acked-by: Arnd Bergmann <arnd@arndb.de>
