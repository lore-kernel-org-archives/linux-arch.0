Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933290AbeCOX6f (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Mar 2018 19:58:35 -0400
Date: Thu, 15 Mar 2018 16:46:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 16/16] ktest: remove obsolete architectures
Message-ID: <20180315164659.03de17ba@vmware.local.home>
In-Reply-To: <20180314145317.2128199-1-arnd@arndb.de>
References: <20180314143529.1456168-1-arnd@arndb.de>
        <20180314145317.2128199-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20180315204659.iKSlerYptt-FzfPUbyJOOr0qEzXm0ageVTJCk3uY6QQ@z>

On Wed, 14 Mar 2018 15:53:07 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> A number of architectures are being removed from the kernel, so
> we no longer need to test them.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>
